-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

-- Extended Properties [myextension].[InstitutionControlDescriptor] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The type of control for an institution (e.g., public or private).', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'InstitutionControlDescriptor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier used as Primary Key, not derived from business logic, when acting as Foreign Key, references the parent table.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'InstitutionControlDescriptor', @level2type=N'COLUMN', @level2name=N'InstitutionControlDescriptorId'
GO

-- Extended Properties [myextension].[InstitutionLevelDescriptor] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The typical level of postsecondary degree offered by the institute.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'InstitutionLevelDescriptor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier used as Primary Key, not derived from business logic, when acting as Foreign Key, references the parent table.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'InstitutionLevelDescriptor', @level2type=N'COLUMN', @level2name=N'InstitutionLevelDescriptorId'
GO

-- Extended Properties [myextension].[PostSecondaryOrganization] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PostSecondaryOrganization', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'PostSecondaryOrganization'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the institution.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'PostSecondaryOrganization', @level2type=N'COLUMN', @level2name=N'NameOfInstitution'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'An indication of acceptance.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'PostSecondaryOrganization', @level2type=N'COLUMN', @level2name=N'AcceptanceIndicator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The type of control of the institution (i.e., public or private).', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'PostSecondaryOrganization', @level2type=N'COLUMN', @level2name=N'InstitutionControlDescriptorId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The level of the institution.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'PostSecondaryOrganization', @level2type=N'COLUMN', @level2name=N'InstitutionLevelDescriptorId'
GO

-- Extended Properties [myextension].[SpecialEducationGraduationStatusDescriptor] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The graduation status for special education.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'SpecialEducationGraduationStatusDescriptor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier used as Primary Key, not derived from business logic, when acting as Foreign Key, references the parent table.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'SpecialEducationGraduationStatusDescriptor', @level2type=N'COLUMN', @level2name=N'SpecialEducationGraduationStatusDescriptorId'
GO

-- Extended Properties [myextension].[StudentAcademicRecordClassRankingExtension] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Class Ranking Extension', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordClassRankingExtension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The identifier assigned to an education organization.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordClassRankingExtension', @level2type=N'COLUMN', @level2name=N'EducationOrganizationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The identifier for the school year.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordClassRankingExtension', @level2type=N'COLUMN', @level2name=N'SchoolYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique alphanumeric code assigned to a student.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordClassRankingExtension', @level2type=N'COLUMN', @level2name=N'StudentUSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The term for the session during the school year.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordClassRankingExtension', @level2type=N'COLUMN', @level2name=N'TermDescriptorId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The graduation status for special education.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordClassRankingExtension', @level2type=N'COLUMN', @level2name=N'SpecialEducationGraduationStatusDescriptorId'
GO

-- Extended Properties [myextension].[StudentAcademicRecordExtension] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordExtension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The identifier assigned to an education organization.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordExtension', @level2type=N'COLUMN', @level2name=N'EducationOrganizationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The identifier for the school year.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordExtension', @level2type=N'COLUMN', @level2name=N'SchoolYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique alphanumeric code assigned to a student.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordExtension', @level2type=N'COLUMN', @level2name=N'StudentUSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The term for the session during the school year.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordExtension', @level2type=N'COLUMN', @level2name=N'TermDescriptorId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the institution.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordExtension', @level2type=N'COLUMN', @level2name=N'NameOfInstitution'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The type of submission certification.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordExtension', @level2type=N'COLUMN', @level2name=N'SubmissionCertificationDescriptorId'
GO

-- Extended Properties [myextension].[StudentAcademicRecordStudentCensusBlockGroup] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Student Census Block Group', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The identifier assigned to an education organization.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroup', @level2type=N'COLUMN', @level2name=N'EducationOrganizationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The identifier for the school year.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroup', @level2type=N'COLUMN', @level2name=N'SchoolYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique alphanumeric code assigned to a student.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroup', @level2type=N'COLUMN', @level2name=N'StudentUSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The term for the session during the school year.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroup', @level2type=N'COLUMN', @level2name=N'TermDescriptorId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'StudentCensusBlockGroup indicates the census block in which the student resides. TESTAJH', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroup', @level2type=N'COLUMN', @level2name=N'StudentCensusBlockGroup'
GO

-- Extended Properties [myextension].[StudentAcademicRecordStudentCensusBlockGroupPeriod] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The time periods for which the StudentCensusBlockGroup is valid.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroupPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The identifier assigned to an education organization.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroupPeriod', @level2type=N'COLUMN', @level2name=N'EducationOrganizationId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The identifier for the school year.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroupPeriod', @level2type=N'COLUMN', @level2name=N'SchoolYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique alphanumeric code assigned to a student.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroupPeriod', @level2type=N'COLUMN', @level2name=N'StudentUSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The term for the session during the school year.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroupPeriod', @level2type=N'COLUMN', @level2name=N'TermDescriptorId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The month, day, and year for the start of the period.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroupPeriod', @level2type=N'COLUMN', @level2name=N'BeginDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The month, day, and year for the end of the period.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'StudentAcademicRecordStudentCensusBlockGroupPeriod', @level2type=N'COLUMN', @level2name=N'EndDate'
GO

-- Extended Properties [myextension].[SubmissionCertificationDescriptor] --
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The type of submission certification.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'SubmissionCertificationDescriptor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier used as Primary Key, not derived from business logic, when acting as Foreign Key, references the parent table.', @level0type=N'SCHEMA', @level0name=N'myextension', @level1type=N'TABLE', @level1name=N'SubmissionCertificationDescriptor', @level2type=N'COLUMN', @level2name=N'SubmissionCertificationDescriptorId'
GO

