USE DBMpams
GO

/************************************************************************************************************************
 * MODULE  : MP-AMS - Store Person Management
 * DESC    : Procedures for managing person records, including creation, update, and phone management.
 ************************************************************************************************************************/

DROP TYPE IF EXISTS dbo.tp_pm_SavePhoneType
GO
CREATE TYPE dbo.tp_pm_SavePhoneType AS TABLE
(
    IdPhone         BIGINT,         -- matches pmPhone.idPhone (bigint)
    IdPhoneType     INT,
    Number          NVARCHAR(25),
    IsForEmergency  BIT,
    Description     NVARCHAR(200),  -- matches pmPhone.description (nvarchar 200)
    isActive        BIT
);
GO

DROP PROCEDURE IF EXISTS dbo.usp_pm_CreatePerson
GO
CREATE PROCEDURE dbo.usp_pm_CreatePerson (
    @pFirstName              nvarchar(100),          -- matches pmPerson.firstName
    @pMiddleName             nvarchar(100) = NULL,   -- matches pmPerson.middleName
    @pFatherLastName         nvarchar(150),          -- matches pmPerson.fatherLastName
    @pMotherLastName         nvarchar(150) = NULL,   -- matches pmPerson.motherLastName (nullable)
    @pIdTypeDocumentIdentity INT,
    @pDocumentIdentity       nvarchar(20),
    @pGender                 CHAR(1),
    @pBirthDate              DATE,
    @pBirthCountry           INT,
    @pIdUserActing           INT = NULL,
    @pIdPerson               BIGINT OUTPUT           -- matches pmPerson.idPerson (bigint)
)
AS
BEGIN

    EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

    INSERT INTO dbo.pmPerson (firstName, middleName, fatherLastName, motherLastName,
        idTypeDocumentIdentity, documentIdentity, gender, birthDate, idBirthCountry)
    VALUES (@pFirstName, @pMiddleName, @pFatherLastName, @pMotherLastName,
        @pIdTypeDocumentIdentity, @pDocumentIdentity, @pGender, @pBirthDate, @pBirthCountry)

    SET @pIdPerson = SCOPE_IDENTITY()

END
GO

DROP PROCEDURE IF EXISTS dbo.usp_pm_UpdatePerson
GO
CREATE PROCEDURE dbo.usp_pm_UpdatePerson (
    @pIdPerson               BIGINT,                -- matches pmPerson.idPerson (bigint)
    @pFirstName              nvarchar(100),          -- matches pmPerson.firstName
    @pMiddleName             nvarchar(100) = NULL,   -- matches pmPerson.middleName
    @pFatherLastName         nvarchar(150),          -- matches pmPerson.fatherLastName
    @pMotherLastName         nvarchar(150) = NULL,   -- matches pmPerson.motherLastName (nullable)
    @pIdTypeDocumentIdentity INT,
    @pDocumentIdentity       nvarchar(20),
    @pGender                 CHAR(1),
    @pBirthDate              DATE,
    @pBirthCountry           INT,
    @pIdUserActing           INT = NULL
)
AS
BEGIN

    EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

    UPDATE dbo.pmPerson
    SET firstName                = @pFirstName,
        middleName               = @pMiddleName,
        fatherLastName           = @pFatherLastName,
        motherLastName           = @pMotherLastName,
        idTypeDocumentIdentity   = @pIdTypeDocumentIdentity,
        documentIdentity         = @pDocumentIdentity,
        gender                   = @pGender,
        birthDate                = @pBirthDate,
        idBirthCountry           = @pBirthCountry
    WHERE idPerson = @pIdPerson

END
GO

DROP PROCEDURE IF EXISTS dbo.usp_pm_SavePhones
GO
CREATE PROCEDURE dbo.usp_pm_SavePhones (
    @pIdPerson     BIGINT,                              -- matches pmPerson.idPerson (bigint)
    @pPhones       dbo.tp_pm_SavePhoneType READONLY,
    @pIdUserActing INT = NULL
)
AS
BEGIN

    EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

    MERGE dbo.pmPhone AS target
    USING @pPhones AS source
    ON target.idPhone = source.IdPhone AND target.idPerson = @pIdPerson
    WHEN MATCHED AND target.idPerson = @pIdPerson THEN
        UPDATE SET
            idPhoneType    = source.IdPhoneType,
            number         = source.Number,
            isForEmergency = source.IsForEmergency,
            description    = source.Description,
            isActive       = source.isActive
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (idPerson, idPhoneType, number, isForEmergency, description, isActive)
        VALUES (@pIdPerson, source.IdPhoneType, source.Number, source.IsForEmergency, source.Description, source.isActive);

END
GO

/************************************************************************************************************************
 * MODULE  : MP-AMS - Store Employee Management
 * DESC    : Procedures for managing employees
 ************************************************************************************************************************/

DROP PROCEDURE IF EXISTS dbo.usp_hr_GetEmployees
GO
CREATE PROCEDURE dbo.usp_hr_GetEmployees (
    @pSearchTerm nvarchar(100) = NULL
)
AS
BEGIN

    SELECT
        e.idEmployee,
        p.fatherLastName,
        p.motherLastName,
        p.firstName,
        p.middleName,
        p.idTypeDocumentIdentity,
        ( SELECT TOP 1 td.abbreviation FROM dbo.pmTypeDocumentIdentity td WHERE td.idTypeDocumentIdentity = p.idTypeDocumentIdentity ) AS typeDocumentAbbreviation,
        p.documentIdentity,
        (
            SELECT TOP 1 j.idJobTitle
            FROM dbo.hrJobTitle j
            JOIN dbo.hrEmploymentContract c ON j.idJobTitle = c.idJobTitle
            WHERE c.idEmployee = e.idEmployee AND c.isActive = 1
        ) AS idJobTitle,
        (
            SELECT TOP 1 j.name
            FROM dbo.hrJobTitle j
            JOIN dbo.hrEmploymentContract c ON j.idJobTitle = c.idJobTitle
            WHERE c.idEmployee = e.idEmployee AND c.isActive = 1
        ) AS jobTitle,
        (
            SELECT TOP 1 ph.number
            FROM dbo.pmPhone ph
            WHERE ph.idPerson = e.idEmployee AND ph.isActive = 1 AND ph.idPhoneType = 2 AND ph.isForEmergency = 0
        ) AS mobilePhone,
        (
            SELECT TOP 1 ph.number
            FROM dbo.pmPhone ph
            WHERE ph.idPerson = e.idEmployee AND ph.isActive = 1 AND ph.isForEmergency = 1
        ) AS emergencyPhone,
        CASE WHEN EXISTS (SELECT 1 FROM dbo.syUser u WHERE u.idEmployee = e.idEmployee AND u.isActive = 1)
        THEN 1 ELSE 0 END AS hasUser
    FROM dbo.hrEmployee e
    JOIN dbo.pmPerson p ON e.idEmployee = p.idPerson
    WHERE e.isActive = 1
    AND (
        NULLIF(LTRIM(RTRIM(@pSearchTerm)), '') IS NULL
        OR CONCAT(p.firstName, ' ', p.middleName, ' ', p.fatherLastName, ' ', p.motherLastName) LIKE '%' + @pSearchTerm + '%' COLLATE Latin1_General_CS_AS
        OR p.documentIdentity LIKE '%' + @pSearchTerm + '%' COLLATE Latin1_General_CS_AS
    )
    ORDER BY p.fatherLastName, p.motherLastName, p.firstName

END
GO

DROP PROCEDURE IF EXISTS dbo.usp_hr_GetEmployeeById
GO
CREATE PROCEDURE dbo.usp_hr_GetEmployeeById (
    @pIdEmployee BIGINT     -- matches hrEmployee.idEmployee (bigint)
)
AS
BEGIN

    SELECT
        e.idEmployee,
        p.firstName,
        p.middleName,
        p.fatherLastName,
        p.motherLastName,
        p.idTypeDocumentIdentity,
        p.documentIdentity,
        p.gender,
        p.birthDate,
        p.idBirthCountry,
        e.email,
        e.idResidentDepartment,
        e.idResidentProvince,
        e.idResidentDistrict,
        e.address,
        e.addressReference,
        e.isActive
    FROM dbo.hrEmployee e
    JOIN dbo.pmPerson p ON e.idEmployee = p.idPerson
    WHERE e.idEmployee = @pIdEmployee

    SELECT
        c.idEmploymentContract,     -- included so callers can target a specific contract
        j.idJobTitle,
        j.name AS jobTitleName,
        j.abbreviation AS jobTitleAbbreviation,
        c.salary,
        c.isPerHour,
        c.admissionDate,
        c.cessationDate,
        c.isActive AS contractIsActive
    FROM dbo.hrJobTitle j
    JOIN dbo.hrEmploymentContract c ON j.idJobTitle = c.idJobTitle
    WHERE c.idEmployee = @pIdEmployee

    SELECT
        p.idPhone,
        p.idPhoneType,
        pt.name AS typePhoneName,
        p.number,
        p.isForEmergency,
        p.description,
        p.isActive AS phoneIsActive
    FROM dbo.pmPhone p
    JOIN dbo.pmPhoneType pt ON p.idPhoneType = pt.idPhoneType
    WHERE p.idPerson = @pIdEmployee

END
GO

DROP PROCEDURE IF EXISTS dbo.usp_hr_CreateEmployee
GO
CREATE PROCEDURE dbo.usp_hr_CreateEmployee (
    @pIdPerson               BIGINT = NULL,          -- matches pmPerson.idPerson (bigint)
    @pFirstName              nvarchar(100),           -- matches pmPerson.firstName
    @pMiddleName             nvarchar(100) = NULL,    -- matches pmPerson.middleName
    @pFatherLastName         nvarchar(150),           -- matches pmPerson.fatherLastName
    @pMotherLastName         nvarchar(150) = NULL,    -- matches pmPerson.motherLastName (nullable)
    @pIdTypeDocumentIdentity INT,
    @pDocumentIdentity       nvarchar(20),
    @pGender                 CHAR(1),
    @pBirthDate              DATE,
    @pBirthCountry           INT,
    @pEmail                  nvarchar(150),           -- matches hrEmployee.email
    @pResidentDepartment     INT,
    @pResidentProvince       INT,
    @pResidentDistrict       INT,
    @pAddress                nvarchar(255),
    @pAddressReference       nvarchar(255) = NULL,
    @pPhones                 dbo.tp_pm_SavePhoneType READONLY,
    @pIdUserActing           INT = NULL,
    @pIdEmployee             BIGINT OUTPUT            -- matches hrEmployee.idEmployee (bigint)
)
AS
BEGIN

    BEGIN TRY
        BEGIN TRANSACTION

        EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

        IF @pIdPerson IS NULL AND NOT EXISTS (SELECT 1 FROM dbo.pmPerson WHERE documentIdentity = @pDocumentIdentity AND idTypeDocumentIdentity = @pIdTypeDocumentIdentity)
        BEGIN
            EXEC dbo.usp_pm_CreatePerson
                @pFirstName, @pMiddleName, @pFatherLastName, @pMotherLastName,
                @pIdTypeDocumentIdentity, @pDocumentIdentity, @pGender, @pBirthDate, @pBirthCountry,
                @pIdUserActing, @pIdPerson = @pIdEmployee OUTPUT
        END
        ELSE
        BEGIN
            -- Resolve idPerson when caller didn't provide it but person already exists
            IF @pIdPerson IS NULL
            BEGIN
                SELECT @pIdPerson = idPerson
                FROM dbo.pmPerson
                WHERE documentIdentity = @pDocumentIdentity AND idTypeDocumentIdentity = @pIdTypeDocumentIdentity
            END

            EXEC dbo.usp_pm_UpdatePerson
                @pIdPerson, @pFirstName, @pMiddleName, @pFatherLastName, @pMotherLastName,
                @pIdTypeDocumentIdentity, @pDocumentIdentity, @pGender, @pBirthDate, @pBirthCountry,
                @pIdUserActing

            SET @pIdEmployee = @pIdPerson
        END

        INSERT INTO dbo.hrEmployee (idEmployee, email, idResidentDepartment, idResidentProvince, idResidentDistrict, address, addressReference)
        VALUES (@pIdEmployee, @pEmail, @pResidentDepartment, @pResidentProvince, @pResidentDistrict, @pAddress, @pAddressReference)

        EXEC dbo.usp_pm_SavePhones @pIdEmployee, @pPhones, @pIdUserActing

        COMMIT TRANSACTION
        PRINT 'Employee created successfully.'

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT            = ERROR_SEVERITY()
        DECLARE @ErrorState    INT            = ERROR_STATE()

        PRINT 'Error occurred while creating employee: ' + @ErrorMessage
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

    END CATCH

END
GO

DROP PROCEDURE IF EXISTS dbo.usp_hr_UpdateEmployee
GO
CREATE PROCEDURE dbo.usp_hr_UpdateEmployee (
    @pIdEmployee             BIGINT,                 -- matches hrEmployee.idEmployee (bigint)
    @pFirstName              nvarchar(100),           -- matches pmPerson.firstName
    @pMiddleName             nvarchar(100) = NULL,    -- matches pmPerson.middleName
    @pFatherLastName         nvarchar(150),           -- matches pmPerson.fatherLastName
    @pMotherLastName         nvarchar(150) = NULL,    -- matches pmPerson.motherLastName (nullable)
    @pIdTypeDocumentIdentity INT,
    @pDocumentIdentity       nvarchar(20),
    @pGender                 CHAR(1),
    @pBirthDate              DATE,
    @pBirthCountry           INT,
    @pEmail                  nvarchar(150),           -- matches hrEmployee.email
    @pResidentDepartment     INT,
    @pResidentProvince       INT,
    @pResidentDistrict       INT,
    @pAddress                nvarchar(255),
    @pAddressReference       nvarchar(255) = NULL,
    @pPhones                 dbo.tp_pm_SavePhoneType READONLY,
    @pisActive               BIT,
    @pIdUserActing           INT = NULL
) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

        IF NOT EXISTS (SELECT 1 FROM dbo.hrEmployee WHERE idEmployee = @pIdEmployee)
        BEGIN
            RAISERROR('Employee not found.', 16, 1)
        END

        IF EXISTS (
            SELECT 1 FROM dbo.pmPerson
            WHERE documentIdentity = @pDocumentIdentity AND idTypeDocumentIdentity = @pIdTypeDocumentIdentity
                AND idPerson <> @pIdEmployee)
        BEGIN
            RAISERROR('Another person with the same document identity already exists.', 16, 1)
        END

        EXEC dbo.usp_pm_UpdatePerson
            @pIdEmployee, @pFirstName, @pMiddleName, @pFatherLastName, @pMotherLastName,
            @pIdTypeDocumentIdentity, @pDocumentIdentity, @pGender, @pBirthDate, @pBirthCountry,
            @pIdUserActing

        UPDATE dbo.hrEmployee
        SET email                = @pEmail,
            idResidentDepartment = @pResidentDepartment,
            idResidentProvince   = @pResidentProvince,
            idResidentDistrict   = @pResidentDistrict,
            address              = @pAddress,
            addressReference     = @pAddressReference,
            isActive             = @pisActive
        WHERE idEmployee = @pIdEmployee

        EXEC dbo.usp_pm_SavePhones @pIdEmployee, @pPhones, @pIdUserActing

        IF (@pisActive = 0)
        BEGIN
            UPDATE dbo.syUser
            SET isActive = 0
            WHERE idEmployee = @pIdEmployee
        END

        COMMIT TRANSACTION
        PRINT 'Employee updated successfully.'

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT            = ERROR_SEVERITY()
        DECLARE @ErrorState    INT            = ERROR_STATE()

        PRINT 'Error occurred while updating employee: ' + @ErrorMessage
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

    END CATCH

END
GO

DROP PROCEDURE IF EXISTS dbo.usp_hr_GetEmploymentContractsByEmployeeId
GO
CREATE PROCEDURE dbo.usp_hr_GetEmploymentContractsByEmployeeId (
    @pIdEmployee BIGINT     -- matches hrEmployee.idEmployee (bigint)
) AS
BEGIN
    SELECT
        c.idEmploymentContract,
        c.idJobTitle,
        j.name AS jobTitleName,
        j.abbreviation AS jobTitleAbbreviation,
        c.salary,
        c.isPerHour,
        c.admissionDate,
        c.cessationDate,
        c.isActive AS contractIsActive
    FROM dbo.hrEmploymentContract c
    JOIN dbo.hrJobTitle j ON c.idJobTitle = j.idJobTitle
    WHERE c.idEmployee = @pIdEmployee
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_hr_CreateEmploymentContract
GO
CREATE PROCEDURE dbo.usp_hr_CreateEmploymentContract (
    @pIdEmployee    BIGINT,             -- matches hrEmployee.idEmployee (bigint)
    @pIdJobTitle    INT,
    @pSalary        DECIMAL(12,2),      -- matches hrEmploymentContract.salary
    @pIsPerHour     BIT,
    @pAdmissionDate DATETIME,           -- matches hrEmploymentContract.admissionDate (datetime)
    @pCessationDate DATETIME = NULL,
    @pIsActive      BIT,
    @pIdUserActing  INT = NULL
) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

        IF NOT EXISTS (SELECT 1 FROM dbo.hrEmployee WHERE idEmployee = @pIdEmployee AND isActive = 1)
        BEGIN
            RAISERROR('Employee not found or is not active.', 16, 1)
        END

        INSERT INTO dbo.hrEmploymentContract (idEmployee, idJobTitle, salary, isPerHour, admissionDate, cessationDate, isActive)
        VALUES (@pIdEmployee, @pIdJobTitle, @pSalary, @pIsPerHour, @pAdmissionDate, @pCessationDate, @pIsActive)

        COMMIT TRANSACTION
        PRINT 'Employment contract created successfully.'

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT            = ERROR_SEVERITY()
        DECLARE @ErrorState    INT            = ERROR_STATE()

        PRINT 'Error occurred while creating employment contract: ' + @ErrorMessage
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

    END CATCH

END
GO

/************************************************************************************************************************
 * MODULE  : MP-AMS - Store Authentication
 * DESC    : Procedures for user login, password change, and password reset.
 ************************************************************************************************************************/

DROP PROCEDURE IF EXISTS dbo.usp_sy_GetUsers
GO
CREATE PROCEDURE dbo.usp_sy_GetUsers (
    @pSearchTerm nvarchar(100) = NULL
)
AS
BEGIN
    SELECT
        u.idUser,
        u.idEmployee,
        p.firstName,
        p.middleName,
        p.fatherLastName,
        p.motherLastName,
        e.email,
        j.idJobTitle,
        j.name AS jobTitle,
        u.isActive,
        u.lastLoginDate,
        STRING_AGG(r.name, ', ') WITHIN GROUP (ORDER BY r.name) AS roleNames
    FROM dbo.syUser u
    JOIN dbo.hrEmployee e ON u.idEmployee = e.idEmployee
    JOIN dbo.pmPerson p ON e.idEmployee = p.idPerson
    LEFT JOIN dbo.hrEmploymentContract c ON e.idEmployee = c.idEmployee AND c.isActive = 1
    LEFT JOIN dbo.hrJobTitle j ON c.idJobTitle = j.idJobTitle
    LEFT JOIN dbo.syUserRole ur ON u.idUser = ur.idUser
    LEFT JOIN dbo.syRole r ON ur.idRole = r.idRole AND r.isActive = 1
    WHERE (
        NULLIF(LTRIM(RTRIM(@pSearchTerm)), '') IS NULL
        OR CONCAT(p.firstName, ' ', p.middleName, ' ', p.fatherLastName, ' ', p.motherLastName) LIKE '%' + @pSearchTerm + '%' COLLATE Latin1_General_CS_AS
        OR p.documentIdentity LIKE '%' + @pSearchTerm + '%' COLLATE Latin1_General_CS_AS
        OR u.userName LIKE '%' + @pSearchTerm + '%' COLLATE Latin1_General_CS_AS
    )
    GROUP BY u.idUser, u.idEmployee, p.firstName, p.middleName, p.fatherLastName, p.motherLastName,
             e.email, j.idJobTitle, j.name, u.isActive, u.lastLoginDate
    ORDER BY p.fatherLastName, p.motherLastName, p.firstName
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_sy_GetUserById
GO
CREATE PROCEDURE dbo.usp_sy_GetUserById (
    @pIdUser INT
) AS
BEGIN
    SELECT
        u.idUser,
        u.idEmployee,
        u.userName,
        u.isActive,
        u.lastLoginDate,
        p.firstName,
        p.middleName,
        p.fatherLastName,
        p.motherLastName,
        e.email,
        j.idJobTitle,
        j.name AS jobTitle
    FROM dbo.syUser u
    JOIN dbo.hrEmployee e ON u.idEmployee = e.idEmployee
    JOIN dbo.pmPerson p ON e.idEmployee = p.idPerson
    LEFT JOIN dbo.hrEmploymentContract c ON e.idEmployee = c.idEmployee AND c.isActive = 1
    LEFT JOIN dbo.hrJobTitle j ON c.idJobTitle = j.idJobTitle
    WHERE u.idUser = @pIdUser

    SELECT
        r.idRole,
        r.name AS roleName
    FROM dbo.syUserRole ur
    JOIN dbo.syRole r ON ur.idRole = r.idRole
    WHERE ur.idUser = @pIdUser AND r.isActive = 1
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_sy_CreateUser
GO
CREATE PROCEDURE dbo.usp_sy_CreateUser (
    @pIdEmployee   BIGINT,          -- matches hrEmployee.idEmployee (bigint)
    @pUserName     nvarchar(50),
    @pPassword     nvarchar(256),   -- matches syUser.passwordHash (nvarchar 256)
    @pIdRoles      dbo.IdListType READONLY,
    @pIdUserActing INT = NULL
) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        DECLARE @pUserId INT

        EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

        IF NOT EXISTS (SELECT 1 FROM dbo.hrEmployee WHERE idEmployee = @pIdEmployee AND isActive = 1)
        BEGIN
            RAISERROR('Employee does not exist or is not active.', 16, 1)
            RETURN
        END

        IF EXISTS (SELECT 1 FROM dbo.syUser WHERE userName = @pUserName AND isActive = 1)
        BEGIN
            RAISERROR('Username already exists.', 16, 1)
            RETURN
        END

        INSERT INTO dbo.syUser (idEmployee, userName, passwordHash)
        VALUES (@pIdEmployee, @pUserName, @pPassword)

        SET @pUserId = SCOPE_IDENTITY()

        INSERT INTO dbo.syUserRole (idUser, idRole)
        SELECT @pUserId, idRole FROM @pIdRoles

        COMMIT TRANSACTION
        PRINT 'User created successfully.'

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT            = ERROR_SEVERITY()
        DECLARE @ErrorState    INT            = ERROR_STATE()

        PRINT 'Error occurred while creating user: ' + @ErrorMessage
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

    END CATCH
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_sy_UpdateUser
GO
CREATE PROCEDURE dbo.usp_sy_UpdateUser (
    @pIdUser       INT,
    @pIdEmployee   BIGINT,      -- matches hrEmployee.idEmployee (bigint)
    @pIdRoles      dbo.IdListType READONLY,
    @pIsActive     BIT,
    @pIdUserActing INT = NULL
) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

        IF NOT EXISTS (SELECT 1 FROM dbo.hrEmployee WHERE idEmployee = @pIdEmployee AND isActive = 1)
        BEGIN
            RAISERROR('Employee does not exist or is not active.', 16, 1)
            RETURN
        END

        IF NOT EXISTS (SELECT 1 FROM dbo.syUser WHERE idUser = @pIdUser AND idEmployee = @pIdEmployee)
        BEGIN
            RAISERROR('User does not exist or is not associated with the specified employee.', 16, 1)
            RETURN
        END

        UPDATE dbo.syUser
        SET isActive = @pIsActive
        WHERE idUser = @pIdUser

        MERGE dbo.syUserRole AS target
        USING @pIdRoles AS source ON target.idUser = @pIdUser AND target.idRole = source.idRole
        WHEN NOT MATCHED BY TARGET THEN
            INSERT (idUser, idRole) VALUES (@pIdUser, source.idRole)
        WHEN NOT MATCHED BY SOURCE AND target.idUser = @pIdUser THEN
            DELETE;

        COMMIT TRANSACTION
        PRINT 'User updated successfully.'

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT            = ERROR_SEVERITY()
        DECLARE @ErrorState    INT            = ERROR_STATE()

        PRINT 'Error occurred while updating user: ' + @ErrorMessage
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

    END CATCH
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_sy_Login
GO
CREATE PROCEDURE dbo.usp_sy_Login (
    @pUserName nvarchar(50),
    @pPassword nvarchar(256) = ''   -- matches syUser.passwordHash (nvarchar 256)
) AS
BEGIN
    DECLARE @pUserId INT

    SELECT TOP 1
        @pUserId = u.idUser
    FROM dbo.syUser u
    WHERE u.userName = @pUserName AND u.passwordHash = @pPassword AND u.isActive = 1

    IF @pUserId IS NOT NULL
    BEGIN
        UPDATE dbo.syUser
        SET lastLoginDate = GETDATE()
        WHERE idUser = @pUserId

        SELECT
            u.idUser,
            u.idEmployee,
            p.firstName,
            p.middleName,
            p.fatherLastName,
            p.motherLastName,
            e.email
        FROM dbo.syUser u
        JOIN dbo.hrEmployee e ON u.idEmployee = e.idEmployee
        JOIN dbo.pmPerson p ON e.idEmployee = p.idPerson
        WHERE u.idUser = @pUserId

        SELECT
            r.idRole,
            r.name AS roleName
        FROM dbo.syUserRole ur
        JOIN dbo.syRole r ON ur.idRole = r.idRole
        WHERE ur.idUser = @pUserId AND r.isActive = 1
    END
    ELSE
    BEGIN
        RAISERROR('Invalid username or password.', 16, 1)
    END
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_sy_ChangePassword
GO
CREATE PROCEDURE dbo.usp_sy_ChangePassword (
    @pIdUser       INT,
    @pUserName    nvarchar(50),
    @pOldPassword nvarchar(256),    -- matches syUser.passwordHash (nvarchar 256)
    @pNewPassword nvarchar(256)
) AS
BEGIN
    -- Verify identity before updating; session context set after so audit captures correct user
    
    IF NOT EXISTS (SELECT 1 FROM dbo.syUser WHERE idUser = @pIdUser AND u.passwordHash = @pOldPassword AND isActive = 1)
    BEGIN
        RAISERROR('Invalid username or old password.', 16, 1)
        RETURN
    END
    ELSE
    BEGIN
        EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUser;

        UPDATE dbo.syUser
        SET passwordHash = @pNewPassword
        WHERE idUser = @pIdUser
    END

END
GO

DROP PROCEDURE IF EXISTS dbo.usp_sy_ResetPassword
GO
CREATE PROCEDURE dbo.usp_sy_ResetPassword (
    @pIdUser       INT,
    @pNewPassword  nvarchar(256),   -- matches syUser.passwordHash (nvarchar 256)
    @pIdUserActing INT = NULL
) AS
BEGIN

    IF NOT EXISTS (SELECT 1 FROM dbo.syUser WHERE idUser = @pIdUser AND isActive = 1)
    BEGIN
        RAISERROR('User not found or is not active.', 16, 1)
        RETURN
    END

    EXEC sp_set_session_context @key = N'IdUser', @value = @pIdUserActing;

    UPDATE dbo.syUser
    SET passwordHash = @pNewPassword
    WHERE idUser = @pIdUser
END
GO
