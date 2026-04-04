USE DBSaemp
GO

DROP PROCEDURE IF EXISTS dbo.smExternalSchoolList
GO
CREATE PROCEDURE dbo.smExternalSchoolList
AS
BEGIN
	SELECT
		so.idExternalSchool,
		so.name,
		so.description,
		so.isPrivate,
		ISNULL(dp.name, '')
		+ CASE WHEN so.idProvince IS NOT NULL THEN ' - ' + ISNULL(pr.name, '') ELSE '' END
		+ CASE WHEN so.idDistrict IS NOT NULL THEN ' - ' + ISNULL(ds.name, '') ELSE '' END AS location
	FROM dbo.smExternalSchool so
	LEFT JOIN dbo.pmDepartment dp ON so.idDepartment = dp.idDepartment
	LEFT JOIN dbo.pmProvince pr ON so.idDepartment = pr.idDepartment AND so.idProvince = pr.idProvince
	LEFT JOIN dbo.pmDistrict ds ON so.idDepartment = ds.idDepartment AND so.idProvince = ds.idProvince AND so.idDistrict = ds.idDistrict
	ORDER BY so.name ASC	
END
REVOKE EXECUTE ON dbo.smExternalSchoolList TO PUBLIC
GO
GRANT EXECUTE ON dbo.smExternalSchoolList TO Consultant
GO

DROP PROCEDURE IF EXISTS dbo.smExternalSchoolNew
GO
CREATE PROCEDURE dbo.smExternalSchoolNew
	@inIdDepartment		int,
	@inIdProvince		int,
	@inIdDistrict		int,
	@isName				nvarchar(200),
	@isDescription		nvarchar(200),
	@ibIsPrivate		bit
AS
BEGIN
	DECLARE @ouIdSchoolOrigin int

	INSERT INTO dbo.smExternalSchool (idDepartment, idProvince, idDistrict, name, description, isPrivate)
	VALUES (@inIdDepartment, @inIdProvince, @inIdDistrict, @isName, @isDescription, @ibIsPrivate);

	SET @ouIdSchoolOrigin = SCOPE_IDENTITY();
	SELECT @ouIdSchoolOrigin AS IdSchoolOrigin;
END
REVOKE EXECUTE ON dbo.smExternalSchoolNew TO PUBLIC
GO
GRANT EXECUTE ON dbo.smExternalSchoolNew TO Consultant
GO

/*
DROP PROCEDURE IF EXISTS dbo.pmPersonNew
GO
CREATE PROCEDURE dbo.pmPersonNew
	@inIdTypeDocumentIdentity	int,
	@isDocumentIdentity		nvarchar(20),
	firstName					nvarchar(100),
	middleName				nvarchar(100),
	fatherLastName			nvarchar(150),
	motherLastName			nvarchar(150),
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
		fatherLastName			nvarchar(150),
		motherLastName			nvarchar(150),
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