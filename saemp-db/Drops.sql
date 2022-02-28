USE [DBSaemp]
GO

DROP LOGIN Consultant;
DROP USER Consultant;

DROP TABLE IF EXISTS [dbo].[amPaymentTransactionDetail]
DROP TABLE IF EXISTS [dbo].[amPaymentTransaction]
DROP TABLE IF EXISTS [dbo].[amPaymentReceiptDetail]
DROP TABLE IF EXISTS [dbo].[amPaymentReceipt]

DROP TABLE IF EXISTS [dbo].[amBinnaclePayment]
DROP TABLE IF EXISTS [dbo].[amStudentInstallment]
DROP TABLE IF EXISTS [dbo].[amSchoolYearPayment]
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
DROP TABLE IF EXISTS [dbo].[smStudentSchoolOrigin]
DROP TABLE IF EXISTS [dbo].[smStudent]

DROP TABLE IF EXISTS [dbo].[hrEmploymentContract]
DROP TABLE IF EXISTS [dbo].[hrEmployee]
DROP TABLE IF EXISTS [dbo].[hrJobTitle]

DROP TABLE IF EXISTS [dbo].[inRoom]
DROP TABLE IF EXISTS [dbo].[inCampus]
DROP TABLE IF EXISTS [dbo].[inInstitution]
DROP TABLE IF EXISTS [dbo].[epSchoolOrigin]
DROP TABLE IF EXISTS [dbo].[epScholarStatus]
DROP TABLE IF EXISTS [dbo].[epSchoolLevel]
DROP TABLE IF EXISTS [dbo].[epStudentDocumentType]
DROP TABLE IF EXISTS [dbo].[epAcademicLevel]

DROP TABLE IF EXISTS [dbo].[pmPhone]
DROP TABLE IF EXISTS [dbo].[pmPerson]
DROP TABLE IF EXISTS [dbo].[pmPhoneCompany]
DROP TABLE IF EXISTS [dbo].[pmPhoneType]
DROP TABLE IF EXISTS [dbo].[pmTypeDocumentIdentity]
DROP TABLE IF EXISTS [dbo].[pmDistrict]
DROP TABLE IF EXISTS [dbo].[pmProvince]
DROP TABLE IF EXISTS [dbo].[pmDepartment]
DROP TABLE IF EXISTS [dbo].[pmCountry]
