USE [DBSaemp]
GO

DROP LOGIN Consultant;
DROP USER Consultant;

DROP TABLE IF EXISTS [dbo].[amPaymentReceiptDetail]
DROP TABLE IF EXISTS [dbo].[amPaymentReceipt]

DROP TABLE IF EXISTS [dbo].[amDailyBalance]
DROP TABLE IF EXISTS [dbo].[amMonthlyBalance]
DROP TABLE IF EXISTS [dbo].[amExpense]
DROP TABLE IF EXISTS [dbo].[amExpenseConcept]
DROP TABLE IF EXISTS [dbo].[amPaymentAccount]

DROP TABLE IF EXISTS [dbo].[amPaymentNote]
DROP TABLE IF EXISTS [dbo].[emStudentNote]
DROP TABLE IF EXISTS [dbo].[emStudentFeeInstallment]
DROP TABLE IF EXISTS [dbo].[emSchoolYearFeeSchedule]
DROP TABLE IF EXISTS [dbo].[emEnrollment]

DROP TABLE IF EXISTS [dbo].[amPaymentConcept]
DROP TABLE IF EXISTS [dbo].[amDiscountVersion]
DROP TABLE IF EXISTS [dbo].[amDiscount]
DROP TABLE IF EXISTS [dbo].[amPaymentStatus]
DROP TABLE IF EXISTS [dbo].[amPaymentMethod]

DROP TABLE IF EXISTS [dbo].[emSchoolYearLevel]
DROP TABLE IF EXISTS [dbo].[emSchoolYear]

DROP TABLE IF EXISTS [dbo].[smRelative]
DROP TABLE IF EXISTS [dbo].[smRelationship]
DROP TABLE IF EXISTS [dbo].[smStudentDocument]
DROP TABLE IF EXISTS [dbo].[smAcademicBackground]
DROP TABLE IF EXISTS [dbo].[smStudent]

DROP TABLE IF EXISTS [dbo].[syUserRole]
DROP TABLE IF EXISTS [dbo].[syUser]
DROP TABLE IF EXISTS [dbo].[syRolePermission]
DROP TABLE IF EXISTS [dbo].[syPermission]
DROP TABLE IF EXISTS [dbo].[syRole]
DROP TABLE IF EXISTS [dbo].[hrEmploymentContract]
DROP TABLE IF EXISTS [dbo].[hrEmployee]
DROP TABLE IF EXISTS [dbo].[hrJobTitle]

DROP TABLE IF EXISTS [dbo].[inRoom]
DROP TABLE IF EXISTS [dbo].[inCampus]
DROP TABLE IF EXISTS [dbo].[inInstitution]
DROP TABLE IF EXISTS [dbo].[smExternalSchool]
DROP TABLE IF EXISTS [dbo].[smScholarStatus]
DROP TABLE IF EXISTS [dbo].[epSchoolLevel]
DROP TABLE IF EXISTS [dbo].[smStudentDocumentType]
DROP TABLE IF EXISTS [dbo].[epAcademicLevel]

DROP TABLE IF EXISTS [dbo].[pmPhone]
DROP TABLE IF EXISTS [dbo].[pmPerson]
DROP TABLE IF EXISTS [dbo].[pmPhoneType]
DROP TABLE IF EXISTS [dbo].[pmTypeDocumentIdentity]
DROP TABLE IF EXISTS [dbo].[pmDistrict]
DROP TABLE IF EXISTS [dbo].[pmProvince]
DROP TABLE IF EXISTS [dbo].[pmDepartment]
DROP TABLE IF EXISTS [dbo].[pmCountry]
