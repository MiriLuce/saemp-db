USE DBSaemp
GO

-- Scaffold-DbContext 'Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DBSaemp' Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models


DROP PROCEDURE IF EXISTS dbo.pmTypeDocumentIdentityList
GO
CREATE PROCEDURE dbo.pmTypeDocumentIdentityList
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
		isActive,
		isDefault
	FROM dbo.pmTypeDocumentIdentity
	WHERE dbo.pmTypeDocumentIdentity.isActive = 1		
END
REVOKE EXECUTE ON dbo.pmTypeDocumentIdentityList TO PUBLIC
GO
GRANT EXECUTE ON dbo.pmTypeDocumentIdentityList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.pmCountryList
GO
CREATE PROCEDURE dbo.pmCountryList
AS
BEGIN
	SELECT
		idCountry,
		name,
		letterCode,
		numericCode,
		isDefault
	FROM dbo.pmCountry
	ORDER BY isDefault DESC, name ASC
END
REVOKE EXECUTE ON dbo.pmCountryList TO PUBLIC
GO
GRANT EXECUTE ON dbo.pmCountryList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.pmDepartmentList
GO
CREATE PROCEDURE dbo.pmDepartmentList
AS
BEGIN
	SELECT
		idDepartment,
		name,
		code,
		isDefault
	FROM dbo.pmDepartment
	ORDER BY isDefault DESC, name ASC
END
REVOKE EXECUTE ON dbo.pmDepartmentList TO PUBLIC
GO
GRANT EXECUTE ON dbo.pmDepartmentList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.pmProvinceList
GO
CREATE PROCEDURE dbo.pmProvinceList (
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
	WHERE (ISNULL(@pIdDepartment,0) = 0 OR idDepartment = @pIdDepartment)
	ORDER BY isDefault DESC, name ASC
END
REVOKE EXECUTE ON dbo.pmProvinceList TO PUBLIC
GO
GRANT EXECUTE ON dbo.pmProvinceList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.pmDistrictList
GO
CREATE PROCEDURE dbo.pmDistrictList (
	@pIdDepartment int = 0,
	@pIdProvince int = 0
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
	WHERE (ISNULL(@pIdDepartment,0) = 0 OR idDepartment = @pIdDepartment)
	AND	  (ISNULL(@pIdProvince,0) = 0 OR idProvince = @pIdProvince)
	ORDER BY isDefault DESC, name ASC
END
REVOKE EXECUTE ON dbo.pmDistrictList TO PUBLIC
GO
GRANT EXECUTE ON dbo.pmDistrictList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.smRelationshipList
GO
CREATE PROCEDURE dbo.smRelationshipList 
AS
BEGIN
	SELECT
		idRelationship,
		name,
		isDefault
	FROM dbo.smRelationship
	ORDER BY isDefault DESC, name ASC
END
REVOKE EXECUTE ON dbo.smRelationshipList TO PUBLIC
GO
GRANT EXECUTE ON dbo.smRelationshipList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.pmPhoneTypeList
GO
CREATE PROCEDURE dbo.pmPhoneTypeList 
AS
BEGIN
	SELECT
		idPhoneType,
		name
	FROM dbo.pmPhoneType
	ORDER BY name ASC
END
REVOKE EXECUTE ON dbo.pmPhoneTypeList TO PUBLIC
GO
GRANT EXECUTE ON dbo.pmPhoneTypeList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.epAcademicLevelList
GO
CREATE PROCEDURE dbo.epAcademicLevelList 
AS
BEGIN
	SELECT
		idAcademicLevel,
		name,
		abbreviation
	FROM dbo.epAcademicLevel
	ORDER BY idAcademicLevel ASC
END
REVOKE EXECUTE ON dbo.epAcademicLevelList TO PUBLIC
GO
GRANT EXECUTE ON dbo.epAcademicLevelList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.epSchoolLevelList
GO
CREATE PROCEDURE dbo.epSchoolLevelList (
	@pIdAcademicLevel int = 0
) AS
BEGIN
	SELECT
		idSchoolLevel,
		idAcademicLevel,
		name,
		abbreviation
	FROM dbo.epSchoolLevel
	WHERE (ISNULL(@pIdAcademicLevel,0) = 0 OR idAcademicLevel = @pIdAcademicLevel)
	ORDER BY idSchoolLevel ASC
END
REVOKE EXECUTE ON dbo.epSchoolLevelList TO PUBLIC
GO
GRANT EXECUTE ON dbo.epSchoolLevelList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.smScholarStatusList
GO
CREATE PROCEDURE dbo.smScholarStatusList 
AS
BEGIN
	SELECT
		idScholarStatus,
		name,
		abbreviation
	FROM dbo.smScholarStatus
	ORDER BY name ASC
END
REVOKE EXECUTE ON dbo.smScholarStatusList TO PUBLIC
GO
GRANT EXECUTE ON dbo.smScholarStatusList TO Consultant
GO