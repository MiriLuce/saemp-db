USE [DBMpams]
GO

BEGIN TRY

    BEGIN TRANSACTION
        
    IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'mpams_app')
        DROP USER mpams_app;

    IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'mpams_app')
        DROP LOGIN mpams_app;

    -- MODULE  : System

    DROP TABLE IF EXISTS [dbo].[syUserRole]
    DROP TABLE IF EXISTS [dbo].[syUser]
    DROP TABLE IF EXISTS [dbo].[syRolePermission]
    DROP TABLE IF EXISTS [dbo].[syPermission]
    DROP TABLE IF EXISTS [dbo].[syRole]

    -- MODULE  : Enrollment Management
    -- Note: fnPaymentReceiptDetail (FN) is dropped here due to deferred FK → emStudentFeeInstallment
    --       smAcademicBackground (SM) is dropped here due to deferred FK → emSchoolLevel

    DROP TABLE IF EXISTS [dbo].[emPaymentNote]
    DROP TABLE IF EXISTS [dbo].[emStudentNote]
    DROP TABLE IF EXISTS [dbo].[fnPaymentReceiptDetail]
    DROP TABLE IF EXISTS [dbo].[emStudentFeeInstallment]
    DROP TABLE IF EXISTS [dbo].[emEnrollment]
    DROP TABLE IF EXISTS [dbo].[emSchoolYearFeeSchedule]
    DROP TABLE IF EXISTS [dbo].[emSchoolYearLevel]
    DROP TABLE IF EXISTS [dbo].[emSchoolYear]
    DROP TABLE IF EXISTS [dbo].[smAcademicBackground]
    DROP TABLE IF EXISTS [dbo].[emSchoolLevel]
    DROP TABLE IF EXISTS [dbo].[emAcademicLevel]

    -- MODULE  : Student Management

    DROP TABLE IF EXISTS [dbo].[smExternalSchool]
    DROP TABLE IF EXISTS [dbo].[smScholarStatus]
    DROP TABLE IF EXISTS [dbo].[smStudentDocument]
    DROP TABLE IF EXISTS [dbo].[smStudentDocumentType]
    DROP TABLE IF EXISTS [dbo].[smRelative]
    DROP TABLE IF EXISTS [dbo].[smRelationship]
    DROP TABLE IF EXISTS [dbo].[smStudent]

    -- MODULE  : Finance

    DROP TABLE IF EXISTS [dbo].[fnMonthlyBalance]
    DROP TABLE IF EXISTS [dbo].[fnDailyBalance]
    DROP TABLE IF EXISTS [dbo].[fnPaymentReceipt]
    DROP TABLE IF EXISTS [dbo].[fnExpense]
    DROP TABLE IF EXISTS [dbo].[fnExpenseConcept]
    DROP TABLE IF EXISTS [dbo].[fnDiscountVersion]
    DROP TABLE IF EXISTS [dbo].[fnDiscount]
    DROP TABLE IF EXISTS [dbo].[fnPaymentAccount]
    DROP TABLE IF EXISTS [dbo].[fnPaymentMethod]
    DROP TABLE IF EXISTS [dbo].[fnPaymentStatus]
    DROP TABLE IF EXISTS [dbo].[fnPaymentConcept]

    -- MODULE  : Institution

    DROP TABLE IF EXISTS [dbo].[inRoom]
    DROP TABLE IF EXISTS [dbo].[inCampus]
    DROP TABLE IF EXISTS [dbo].[inInstitution]

    -- MODULE  : Human Resources

    DROP TABLE IF EXISTS [dbo].[hrEmploymentContract]
    DROP TABLE IF EXISTS [dbo].[hrEmployee]
    DROP TABLE IF EXISTS [dbo].[hrJobTitle]

    -- MODULE  : Person Management

    DROP TABLE IF EXISTS [dbo].[pmPhone]
    DROP TABLE IF EXISTS [dbo].[pmPhoneType]
    DROP TABLE IF EXISTS [dbo].[pmPerson]
    DROP TABLE IF EXISTS [dbo].[pmTypeDocumentIdentity]
    DROP TABLE IF EXISTS [dbo].[pmDistrict]
    DROP TABLE IF EXISTS [dbo].[pmProvince]
    DROP TABLE IF EXISTS [dbo].[pmDepartment]
    DROP TABLE IF EXISTS [dbo].[pmCountry]

    COMMIT TRANSACTION
    PRINT 'DBMpams drop setup completed successfully.'

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE()
    DECLARE @ErrorSeverity INT            = ERROR_SEVERITY()
    DECLARE @ErrorState    INT            = ERROR_STATE()

    PRINT 'Drop setup failed. Transaction rolled back.'
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH
