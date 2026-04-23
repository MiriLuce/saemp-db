USE [DBMpams]
GO

BEGIN TRY

    BEGIN TRANSACTION

    /******************** FIRST USER ****************************/
    -- Temporary password  : Admin#Temp01!
    -- IMPORTANT: change the password immediately after the first login.

    DECLARE @idFirstPerson  bigint
    DECLARE @idDefaultCountry int
    DECLARE @idDefaultTypeDocumentIdentity int

    SELECT TOP 1 @idDefaultCountry = idCountry FROM [dbo].[pmCountry] WHERE isDefault = 1
    SELECT TOP 1 @idDefaultTypeDocumentIdentity = idTypeDocumentIdentity FROM [dbo].[pmTypeDocumentIdentity] WHERE isDefault = 1

    INSERT INTO [dbo].[pmPerson]
        ([idTypeDocumentIdentity],[documentIdentity],[firstName],[middleName],[fatherLastName],[motherLastName],
        [gender],[birthDate],[idBirthCountry],[registrationUser])
    VALUES
        (@idDefaultTypeDocumentIdentity, '72782793', 'Miriam', 'Lucero', 'Encarnacion', 'Mendoza',
        'F', '1993-10-01', @idDefaultCountry, 0)

    SET @idFirstPerson = SCOPE_IDENTITY()

    INSERT INTO [dbo].[hrEmployee] ([idEmployee],[isActive],[registrationUser])
    VALUES (@idFirstPerson, 1, 0)

    -- Replace the hash below with the output of BCrypt.HashPassword("Admin#Temp01!", workFactor: 12)
    INSERT INTO [dbo].[syUser] ([idEmployee],[userName],[passwordHash],[registrationUser])
    VALUES (@idFirstPerson, 'admin', 'Admin#Temp01!', 0)

    -- Assign all existing roles to the first user (admin)
    DECLARE @idFirstUser int = SCOPE_IDENTITY()

    INSERT INTO [dbo].[syUserRole] ([idUser],[idRole])
    SELECT @idFirstUser, idRole FROM [dbo].[syRole]

    SELECT u.idUser, u.userName, r.name AS role
    FROM [dbo].[syUser] u
    JOIN [dbo].[syUserRole] ur ON u.idUser = ur.idUser
    JOIN [dbo].[syRole] r ON ur.idRole = r.idRole
    ORDER BY r.name
    
    COMMIT TRANSACTION
    PRINT 'DBMpams seed data completed successfully.'

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE()
    DECLARE @ErrorSeverity INT            = ERROR_SEVERITY()
    DECLARE @ErrorState    INT            = ERROR_STATE()

    PRINT 'Seed data failed. Transaction rolled back.'
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH
