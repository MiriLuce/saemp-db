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
		isActive
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
REVOKE EXECUTE ON dbo.pmDepartmentList TO PUBLIC
GO
GRANT EXECUTE ON dbo.pmDepartmentList TO Consultant
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
		code,
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
/*
DROP PROCEDURE IF EXISTS dbo.pmPersonNew
GO
CREATE PROCEDURE dbo.pmPersonNew
	@inIdTypeDocumentIdentity	int,
	@isDocumentIdentity		nvarchar(20),
	firstName					nvarchar(100),
	middleName				nvarchar(100),
	fatherlastName			nvarchar(150),
	motherlastName			nvarchar(150),
	email						nvarchar(150),
	birthday					date,
	idBirthCountry			int,
	idResidentDepartment		int,
	idResidentDistrict		int,
	address					nvarchar(200),
	addressReference			nvarchar(200)
AS
BEGIN
	IF EXISTS(SELECT COUNT(1) FROM dbo.pmPerson) WHERE idTypeDocumentIdentity = idTypeDocumentIdentity
	
	INSERT INTO dbo.epPerson
	(
		idTypeDocumentIdentity	int,
		documentIdentity			nvarchar(20),
		firstName					nvarchar(100),
		middleName				nvarchar(100),
		fatherlastName			nvarchar(150),
		motherlastName			nvarchar(150),
		email						nvarchar(150),
		birthday					date,
		idBirthCountry			int,
		idResidentDepartment		int,
		idResidentDistrict		int,
		address					nvarchar(200),
		addressReference			nvarchar(200)
	
	)
END
REVOKE EXECUTE ON dbo.pmPersonNew TO PUBLIC
GO
GRANT EXECUTE ON dbo.pmPersonNew TO Consultant
GO
*/