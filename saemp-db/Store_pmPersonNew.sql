
-- Scaffold-DbContext 'Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=DBSaemp' Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models

DROP PROCEDURE [pmTypeDocumentIdentityList]
CREATE PROCEDURE [dbo].[pmTypeDocumentIdentityList]
AS
BEGIN
	SELECT
		[idTypeDocumentIdentity],
		[name],
		[abbreviation],
		[length],
		[lengthType],
		[characterType],
		[nationalityType],
		[isActive]
	FROM [dbo].[pmTypeDocumentIdentity]
	WHERE [dbo].[pmTypeDocumentIdentity].[isActive] = 1		
END
GRANT EXECUTE ON [dbo].[pmTypeDocumentIdentityList] TO PUBLIC
GO

DROP PROCEDURE [pmCountryList]
CREATE PROCEDURE [dbo].[pmCountryList]
AS
BEGIN
	SELECT
		[idCountry],
		[name],
		[letterCode],
		[numericCode],
		[isDefault]
	FROM [dbo].[pmCountry]
	ORDER BY [isDefault] DESC, [name] ASC
END
GRANT EXECUTE ON [dbo].[pmCountryList] TO PUBLIC
GO

DROP PROCEDURE [pmDepartmentList]
CREATE PROCEDURE [dbo].[pmDepartmentList]
AS
BEGIN
	SELECT
		[idDepartment],
		[name],
		[isDefault]
	FROM [dbo].[pmDepartment]
	ORDER BY [isDefault] DESC, [name] ASC
END
GRANT EXECUTE ON [dbo].[pmDepartmentList] TO PUBLIC
GO

DROP PROCEDURE [pmDistrictList]
CREATE PROCEDURE [dbo].[pmDistrictList]
AS
BEGIN
	SELECT
		[idDistrict],
		[idDepartment],
		[name],
		[isDefault]
	FROM [dbo].[pmDistrict]
	ORDER BY [isDefault] DESC, [name] ASC
END
GRANT EXECUTE ON [dbo].[pmDistrictList] TO PUBLIC
GO

CREATE PROCEDURE [dbo].[pmPersonNew]
	@inIdTypeDocumentIdentity	[int],
	[@isDocumentIdentity]		[nvarchar](20),
	[firstName]					[nvarchar](100),
	[middleName]				[nvarchar](100),
	[fatherlastName]			[nvarchar](150),
	[motherlastName]			[nvarchar](150),
	[email]						[nvarchar](150),
	[birthday]					[date],
	[idBirthCountry]			[int],
	[idResidentDepartment]		[int],
	[idResidentDistrict]		[int],
	[address]					[nvarchar](200),
	[addressReference]			[nvarchar](200)
AS
BEGIN
	IF EXISTS(SELECT COUNT(1) FROM [dbo].[pmPerson]) WHERE idTypeDocumentIdentity = [idTypeDocumentIdentity]
	
	INSERT INTO [dbo].[epPerson]
	(
		[idTypeDocumentIdentity]	[int],
		[documentIdentity]			[nvarchar](20),
		[firstName]					[nvarchar](100),
		[middleName]				[nvarchar](100),
		[fatherlastName]			[nvarchar](150),
		[motherlastName]			[nvarchar](150),
		[email]						[nvarchar](150),
		[birthday]					[date],
		[idBirthCountry]			[int],
		[idResidentDepartment]		[int],
		[idResidentDistrict]		[int],
		[address]					[nvarchar](200),
		[addressReference]			[nvarchar](200)
	
	)
END