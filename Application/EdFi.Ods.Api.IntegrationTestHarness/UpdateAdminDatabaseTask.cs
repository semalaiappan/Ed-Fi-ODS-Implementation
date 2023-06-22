﻿using EdFi.Admin.DataAccess.Models;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.IO;
using System.Linq;
using EdFi.Admin.DataAccess.Repositories;
using EdFi.Admin.DataAccess.Utils;
using EdFi.Ods.Api.ExternalTasks;
using EdFi.Ods.Common.Configuration;
using EdFi.Ods.Common.Constants;
using System.Xml;
using Formatting = Newtonsoft.Json.Formatting;
using System.Collections.Generic;
using EdFi.Ods.Common.Database;

namespace EdFi.Ods.Api.IntegrationTestHarness
{
    public class UpdateAdminDatabaseTask : IExternalTask
    {
        private readonly IClientAppRepo _clientAppRepo;
        private readonly IDefaultApplicationCreator _defaultApplicationCreator;
        private readonly IConfiguration _configuration;
        private readonly ApiSettings _apiSettings;
        private readonly TestHarnessConfiguration _testHarnessConfiguration;

        public UpdateAdminDatabaseTask(IClientAppRepo clientAppRepo,
            IDefaultApplicationCreator defaultApplicationCreator,
            IConfiguration configuration,
            ApiSettings apiSettings,
            TestHarnessConfigurationProvider testHarnessConfigurationProvider)
        {
            _clientAppRepo = clientAppRepo;
            _defaultApplicationCreator = defaultApplicationCreator;
            _configuration = configuration;
            _apiSettings = apiSettings;
            _testHarnessConfiguration = testHarnessConfigurationProvider.GetTestHarnessConfiguration();
        }

        public void Execute()
        {
            var postmanEnvironment = new PostmanEnvironment();

            _clientAppRepo.Reset();

            // Add ODS instance
            string odsConnectionString = _configuration.GetConnectionString("EdFi_Ods");

            var dbConnectionStringBuilderAdapterFactory =
                new DbConnectionStringBuilderAdapterFactory(_apiSettings.GetDatabaseEngine());

            var connectionStringBuilderAdapter = dbConnectionStringBuilderAdapterFactory.Get();
            connectionStringBuilderAdapter.ConnectionString = odsConnectionString;
            string odsDatabaseName = connectionStringBuilderAdapter.DatabaseName;

            var odsInstance = _clientAppRepo.CreateOdsInstance(
                new OdsInstance()
                {
                    Name = odsDatabaseName,
                    InstanceType = "ODS",
                    ConnectionString = odsConnectionString,
                });
            
            // Add Profiles
            var _allDocs = new XmlDocument();
            string profilesPath = Path.Combine(Directory.GetParent(AppContext.BaseDirectory).FullName, "Profiles.xml");
            _allDocs.Load(profilesPath);

            var profiles = new List<Profile>();
            var profileDefinitions = _allDocs.SelectNodes("/Profiles/Profile");
            foreach (XmlNode profileName in profileDefinitions)
            {
                 profiles.Add(new Profile()
                              { ProfileDefinition = profileName.OuterXml, ProfileName = profileName.Attributes["name"].Value  });
            }
            _clientAppRepo.CreateProfilesWithProfileDefinition(profiles);

            foreach (var vendor in _testHarnessConfiguration.Vendors)
            {
                var user = _clientAppRepo.GetUser(vendor.Email) ??
                           _clientAppRepo.CreateUser(
                               new User
                               {
                                   FullName = vendor.VendorName,
                                   Email = vendor.Email,
                                   Vendor = _clientAppRepo.CreateOrGetVendor(
                                       vendor.Email, vendor.VendorName, vendor.NamespacePrefixes)
                               });

                foreach (var app in vendor.Applications)
                {
                    var application = _clientAppRepo.CreateApplicationForVendor(
                        user.Vendor.VendorId, app.ApplicationName, app.ClaimSetName);

                    var edOrgIds = app.ApiClients.SelectMany(s => s.LocalEducationOrganizations).Distinct().ToList();

                    _defaultApplicationCreator.AddEdOrgIdsToApplication(edOrgIds, application.ApplicationId);

                    foreach (var client in app.ApiClients)
                    {
                        var key = !string.IsNullOrEmpty(client.Key)
                            ? client.Key
                            : GetGuid();

                        var secret = !string.IsNullOrEmpty(client.Secret)
                            ? client.Secret
                            : GetGuid();

                        var apiClient = _clientAppRepo.CreateApiClient(user.UserId, client.ApiClientName, key, secret);

                        postmanEnvironment.Values.Add(
                            new ValueItem
                            {
                                Enabled = true,
                                Value = key,
                                Key = "ApiKey_" + client.ApiClientName
                            });

                        postmanEnvironment.Values.Add(
                            new ValueItem
                            {
                                Enabled = true,
                                Value = secret,
                                Key = "ApiSecret_" + client.ApiClientName
                            });

                        _clientAppRepo.AddEdOrgIdsToApiClient(
                            user.UserId, apiClient.ApiClientId, client.LocalEducationOrganizations,
                            application.ApplicationId);

                        _clientAppRepo.AddOdsInstanceToApiClient(apiClient.ApiClientId, odsInstance.OdsInstanceId);

                        postmanEnvironment.Values.Add(
                            new ValueItem
                            {
                                Enabled = true,
                                Value = client.LocalEducationOrganizations,
                                Key = client.ApiClientName + "LeaId"
                            });

                        if (client.OwnershipToken != null)
                        {
                            _clientAppRepo.AddOwnershipTokensToApiClient(client.OwnershipToken, apiClient.ApiClientId);
                        }
                        
                        if (client.ApiClientOwnershipTokens != null)
                        {
                             _clientAppRepo.AddApiClientOwnershipTokens(client.ApiClientOwnershipTokens, apiClient.ApiClientId);
                        }

                    }

                    if (app.Profiles != null)
                    {
                        var _profiles = new List<Profile>();
                        foreach (var profileName in app.Profiles)
                        {
                            var profileDefinition = _allDocs.SelectNodes(String.Format("/Profiles/Profile[@name='{0}']", profileName))[0].OuterXml;
                            _profiles.Add(new Profile() {  ProfileDefinition = profileDefinition, ProfileName = profileName });
                        }
                        _clientAppRepo.AddProfilesToApplication(_profiles,application.ApplicationId);
                    }
                }
            }

            CreateEnvironmentFile();

            void CreateEnvironmentFile()
            {
                var environmentFilePath = _configuration.GetValue<string>("environmentFilePath");

                if (!string.IsNullOrEmpty(environmentFilePath) && new DirectoryInfo(environmentFilePath).Exists)
                {
                    postmanEnvironment.Values.Add(
                        new ValueItem
                        {
                            Enabled = true,
                            Value = _configuration.GetValue<string>("Urls") ?? "http://localhost:8765/",
                            Key = "ApiBaseUrl"
                        });

                    postmanEnvironment.Values.Add(
                        new ValueItem
                        {
                            Enabled = true,
                            Value = _apiSettings.IsFeatureEnabled(ApiFeature.Composites.ToString()),
                            Key = "CompositesFeatureIsEnabled"
                        });

                    postmanEnvironment.Values.Add(
                        new ValueItem
                        {
                            Enabled = true,
                            Value = _apiSettings.IsFeatureEnabled(ApiFeature.Profiles.ToString()),
                            Key = "ProfilesFeatureIsEnabled"
                        });

                    var jsonString = JsonConvert.SerializeObject(
                        postmanEnvironment,
                        Formatting.Indented,
                        new JsonSerializerSettings {ContractResolver = new CamelCasePropertyNamesContractResolver()});

                    var fileName = Path.Combine(environmentFilePath, "environment.json");

                    File.WriteAllText(fileName, jsonString);
                }
            }

            string GetGuid()
            {
                return Guid.NewGuid().ToString("N").Substring(0, 20);
            }
        }
    }
}
