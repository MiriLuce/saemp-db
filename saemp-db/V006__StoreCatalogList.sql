USE DBMpams
GO


/************************************************************************************************************************
 * MODULE  : PM - Person Management
 * DESC    : Catalog list procedures for identity documents, geographic reference tables, and phone types.
 ************************************************************************************************************************/


DROP PROCEDURE IF EXISTS dbo.usp_pm_GetDocumentIdentityTypes
GO
CREATE PROCEDURE dbo.usp_pm_GetDocumentIdentityTypes
AS
BEGIN
	SELECT
		idTypeDocumentIdentity,
		name,
		abbreviation,
		length,
		lengthType,
		characterType,
		nationalityType,
		isDefault
	FROM dbo.pmTypeDocumentIdentity
	WHERE isActive = 1
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_pm_GetCountries
GO
CREATE PROCEDURE dbo.usp_pm_GetCountries
AS
BEGIN
	SELECT
		idCountry,
		name,
		letterCode,
		numericCode,
		isDefault
	FROM dbo.pmCountry
	WHERE isActive = 1
	ORDER BY isDefault DESC, name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_pm_GetDepartments
GO
CREATE PROCEDURE dbo.usp_pm_GetDepartments
AS
BEGIN
	SELECT
		idDepartment,
		name,
		code,
		isDefault
	FROM dbo.pmDepartment
	WHERE isActive = 1
	ORDER BY isDefault DESC, name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_pm_GetProvinces
GO
CREATE PROCEDURE dbo.usp_pm_GetProvinces (
	@pIdDepartment int = 0
) AS
BEGIN
	SELECT
		idProvince,
		idDepartment,
		name,
		code,
		isDefault
	FROM dbo.pmProvince
	WHERE isActive = 1
	AND   (ISNULL(@pIdDepartment,0) = 0 OR idDepartment = @pIdDepartment)
	ORDER BY isDefault DESC, name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_pm_GetDistricts
GO
CREATE PROCEDURE dbo.usp_pm_GetDistricts (
	@pIdDepartment int = 0,
	@pIdProvince   int = 0
) AS
BEGIN
	SELECT
		idDistrict,
		idProvince,
		idDepartment,
		name,
		ubigeo,
		isDefault
	FROM dbo.pmDistrict
	WHERE isActive = 1
	AND   (ISNULL(@pIdDepartment,0) = 0 OR idDepartment = @pIdDepartment)
	AND   (ISNULL(@pIdProvince,0)   = 0 OR idProvince   = @pIdProvince)
	ORDER BY isDefault DESC, name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_pm_GetPhoneTypes
GO
CREATE PROCEDURE dbo.usp_pm_GetPhoneTypes
AS
BEGIN
	SELECT
		idPhoneType,
		name
	FROM dbo.pmPhoneType
	WHERE isActive = 1
	ORDER BY name ASC
END
GO


/************************************************************************************************************************
 * MODULE  : HR - Human Resources
 * DESC    : Catalog list procedures for job titles.
 ************************************************************************************************************************/


DROP PROCEDURE IF EXISTS dbo.usp_hr_GetJobTitles
GO
CREATE PROCEDURE dbo.usp_hr_GetJobTitles
AS
BEGIN
	SELECT
		idJobTitle,
		name,
		abbreviation
	FROM dbo.hrJobTitle
	WHERE isActive = 1
	ORDER BY name ASC
END
GO


/************************************************************************************************************************
 * MODULE  : IN - Institution
 * DESC    : Catalog list procedures for institutions, campuses, and rooms.
 ************************************************************************************************************************/


DROP PROCEDURE IF EXISTS dbo.usp_in_GetInstitutions
GO
CREATE PROCEDURE dbo.usp_in_GetInstitutions
AS
BEGIN
	SELECT
		idInstitution,
		name,
		abbreviation
	FROM dbo.inInstitution
	WHERE isActive = 1
	ORDER BY name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_in_GetCampuses
GO
CREATE PROCEDURE dbo.usp_in_GetCampuses (
	@pIdInstitution int = 0
) AS
BEGIN
	SELECT
		idCampus,
		idInstitution,
		name,
		abbreviation
	FROM dbo.inCampus
	WHERE isActive = 1
	AND   (ISNULL(@pIdInstitution,0) = 0 OR idInstitution = @pIdInstitution)
	ORDER BY name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_in_GetRooms
GO
CREATE PROCEDURE dbo.usp_in_GetRooms (
	@pIdCampus int = 0
) AS
BEGIN
	SELECT
		idRoom,
		idCampus,
		name,
		capacity,
		isActive
	FROM dbo.inRoom
	WHERE isActive = 1
	AND   (ISNULL(@pIdCampus,0) = 0 OR idCampus = @pIdCampus)
	ORDER BY name ASC
END
GO


/************************************************************************************************************************
 * MODULE  : FN - Finance
 * DESC    : Catalog list procedures for payment concepts, statuses, methods, accounts,
 *           expense concepts, and discounts.
 ************************************************************************************************************************/


DROP PROCEDURE IF EXISTS dbo.usp_fn_GetPaymentConcepts
GO
CREATE PROCEDURE dbo.usp_fn_GetPaymentConcepts
AS
BEGIN
	SELECT
		idPaymentConcept,
		name,
		isActive
	FROM dbo.fnPaymentConcept
	WHERE isActive = 1
	ORDER BY name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_fn_GetPaymentStatuses
GO
CREATE PROCEDURE dbo.usp_fn_GetPaymentStatuses
AS
BEGIN
	SELECT
		idPaymentStatus,
		name,
		abbreviation
	FROM dbo.fnPaymentStatus
	WHERE isActive = 1
	ORDER BY name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_fn_GetPaymentMethods
GO
CREATE PROCEDURE dbo.usp_fn_GetPaymentMethods
AS
BEGIN
	SELECT
		idPaymentMethod,
		name,
		abbreviation
	FROM dbo.fnPaymentMethod
	WHERE isActive = 1
	ORDER BY name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_fn_GetPaymentAccounts
GO
CREATE PROCEDURE dbo.usp_fn_GetPaymentAccounts (
	@pIdPaymentMethod int = 0,
	@pIdCampus        int = 0
) AS
BEGIN
	SELECT
		idPaymentAccount,
		idPaymentMethod,
		idCampus,
		name,
		accountNumber,
		alias,
		isActive
	FROM dbo.fnPaymentAccount
	WHERE isActive = 1
	AND   (ISNULL(@pIdPaymentMethod,0) = 0 OR idPaymentMethod = @pIdPaymentMethod)
	AND   (ISNULL(@pIdCampus,0)        = 0 OR idCampus        = @pIdCampus)
	ORDER BY name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_fn_GetExpenseConcepts
GO
CREATE PROCEDURE dbo.usp_fn_GetExpenseConcepts
AS
BEGIN
	SELECT
		idExpenseConcept,
		name,
		isActive
	FROM dbo.fnExpenseConcept
	WHERE isActive = 1
	ORDER BY name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_fn_GetDiscounts
GO
CREATE PROCEDURE dbo.usp_fn_GetDiscounts
AS
BEGIN
	SELECT
		idDiscount,
		name,
		description,
		isActive
	FROM dbo.fnDiscount
	WHERE isActive = 1
	ORDER BY name ASC
END
GO


/************************************************************************************************************************
 * MODULE  : SM - Student Management
 * DESC    : Catalog list procedures for student document types, relationships, and scholar statuses.
 ************************************************************************************************************************/


DROP PROCEDURE IF EXISTS dbo.usp_sm_GetStudentDocumentTypes
GO
CREATE PROCEDURE dbo.usp_sm_GetStudentDocumentTypes
AS
BEGIN
	SELECT
		idStudentDocumentType,
		name,
		abbreviation,
		isActive
	FROM dbo.smStudentDocumentType
	WHERE isActive = 1
	ORDER BY name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_sm_GetRelationships
GO
CREATE PROCEDURE dbo.usp_sm_GetRelationships
AS
BEGIN
	SELECT
		idRelationship,
		name,
		isDefault
	FROM dbo.smRelationship
	WHERE isActive = 1
	ORDER BY isDefault DESC, name ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_sm_GetScholarStatuses
GO
CREATE PROCEDURE dbo.usp_sm_GetScholarStatuses
AS
BEGIN
	SELECT
		idScholarStatus,
		name,
		abbreviation
	FROM dbo.smScholarStatus
	WHERE isActive = 1
	ORDER BY name ASC
END
GO


/************************************************************************************************************************
 * MODULE  : EM - Enrollment Management
 * DESC    : Catalog list procedures for academic levels and school levels.
 ************************************************************************************************************************/


DROP PROCEDURE IF EXISTS dbo.usp_em_GetAcademicLevels
GO
CREATE PROCEDURE dbo.usp_em_GetAcademicLevels
AS
BEGIN
	SELECT
		idAcademicLevel,
		name,
		abbreviation
	FROM dbo.emAcademicLevel
	WHERE isActive = 1
	ORDER BY idAcademicLevel ASC
END
GO

DROP PROCEDURE IF EXISTS dbo.usp_em_GetSchoolLevels
GO
CREATE PROCEDURE dbo.usp_em_GetSchoolLevels (
	@pIdAcademicLevel int = 0
) AS
BEGIN
	SELECT
		idSchoolLevel,
		idAcademicLevel,
		name,
		abbreviation
	FROM dbo.emSchoolLevel
	WHERE isActive = 1
	AND   (ISNULL(@pIdAcademicLevel,0) = 0 OR idAcademicLevel = @pIdAcademicLevel)
	ORDER BY idSchoolLevel ASC
END
GO


/************************************************************************************************************************
 * MODULE  : SY - System
 * DESC    : Catalog list procedures for application roles.
 ************************************************************************************************************************/


DROP PROCEDURE IF EXISTS dbo.usp_sy_GetRoles
GO
CREATE PROCEDURE dbo.usp_sy_GetRoles
AS
BEGIN
	SELECT
		idRole,
		name,
		description,
		isActive
	FROM dbo.syRole
	WHERE isActive = 1
	ORDER BY name ASC
END
GO
