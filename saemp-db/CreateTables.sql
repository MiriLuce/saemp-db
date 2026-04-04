-- CREATE DATABASE [DBSaemp]

CREATE LOGIN Consultant WITH PASSWORD = 'Consultant#Temp01!'; -- TODO: change before deploying to production
CREATE USER Consultant FOR LOGIN Consultant;

USE [DBSaemp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/******************************************************************************************************************************/
/**********************************************   MODULE : PM - PERSON MANAGEMENT   **********************************************/
/******************************************************************************************************************************/


/************* COUNTRY *************/

CREATE TABLE [dbo].[pmCountry]
(
	[idCountry] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[letterCode] [nchar](3) NOT NULL,
	[numericCode] [nchar](3) NOT NULL,
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[idCountry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/************* DEPARTMENT *************/

CREATE TABLE [dbo].[pmDepartment]
(
	[idDepartment] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[code] [char](2) NOT NULL,
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[idDepartment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



/************* PROVINCE *************/

CREATE TABLE [dbo].[pmProvince]
(
	[idDepartment] [int] NOT NULL,
	[idProvince] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[code] [char](4) NOT NULL,
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED 
(
	[idDepartment] ASC, [idProvince] ASC 
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pmProvince]  WITH CHECK ADD  CONSTRAINT [FK_Province_Department] FOREIGN KEY([idDepartment])
REFERENCES [dbo].[pmDepartment] ([idDepartment])
GO

ALTER TABLE [dbo].[pmProvince] CHECK CONSTRAINT [FK_Province_Department]
GO

/************* DISTRICT *************/

CREATE TABLE [dbo].[pmDistrict]
(
	[idDepartment] [int] NOT NULL,
	[idProvince] [int] NOT NULL,
	[idDistrict] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[ubigeo] [char](6) NOT NULL UNIQUE,
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[idDepartment] ASC, [idProvince] ASC, [idDistrict] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pmDistrict]  WITH CHECK ADD  CONSTRAINT [FK_District_Department_Province] FOREIGN KEY([idDepartment], [idProvince])
REFERENCES [dbo].[pmProvince] ([idDepartment], [idProvince])
GO

ALTER TABLE [dbo].[pmDistrict] CHECK CONSTRAINT [FK_District_Department_Province]
GO


/************* TYPE DOCUMENT IDENTITY *************/

CREATE TABLE [dbo].[pmTypeDocumentIdentity]
(
	[idTypeDocumentIdentity] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nvarchar](15) NOT NULL,
	[length] [smallint] NOT NULL,
	[lengthType] [char](1) NULL, -- E: exact, M: maximum
	[characterType] [char](1) NULL, -- A: alphanumeric, N: numeric
	[nationalityType] [char](1) NULL, -- N: national, E: foreign, A: both
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_TypeDocumentIdentity] PRIMARY KEY CLUSTERED 
(
	[idTypeDocumentIdentity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/******************** PERSON ****************************/

CREATE TABLE [dbo].[pmPerson](
	[idPerson] [bigint] NOT NULL IDENTITY(1,1),
	[idTypeDocumentIdentity] [int] NOT NULL,
	[documentIdentity] [nvarchar](20) NOT NULL,
	[firstName] [nvarchar](100) NOT NULL,
	[middleName] [nvarchar](100) NULL,
	[fatherLastName] [nvarchar](150) NOT NULL,
	[motherLastName] [nvarchar](150) NULL,
	[gender] [char](1) NULL, -- M: Male, F: Female
	[birthDate] [date] NULL,
	[idBirthCountry] [int] NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[idPerson] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pmPerson]  WITH CHECK ADD  CONSTRAINT [FK_Person_TypeDocumentIdentity] FOREIGN KEY([idTypeDocumentIdentity])
REFERENCES [dbo].[pmTypeDocumentIdentity] ([idTypeDocumentIdentity])
GO

ALTER TABLE [dbo].[pmPerson] CHECK CONSTRAINT [FK_Person_TypeDocumentIdentity]
GO

ALTER TABLE [dbo].[pmPerson] ADD CONSTRAINT [UQ_Person_DocumentIdentity] UNIQUE ([idTypeDocumentIdentity], [documentIdentity])
GO

ALTER TABLE [dbo].[pmPerson]  WITH CHECK ADD  CONSTRAINT [FK_Person_Country] FOREIGN KEY([idBirthCountry])
REFERENCES [dbo].[pmCountry] ([idCountry])
GO

ALTER TABLE [dbo].[pmPerson] CHECK CONSTRAINT [FK_Person_Country]
GO


/******************** PHONE TYPE ****************************/

CREATE TABLE [dbo].[pmPhoneType](
	[idPhoneType] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](25) NOT NULL
 CONSTRAINT [PK_PhoneType] PRIMARY KEY CLUSTERED 
(
	[idPhoneType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/******************** PHONE ****************************/

CREATE TABLE [dbo].[pmPhone](
	[idPhone] [bigint] NOT NULL IDENTITY(1,1),
	[idPerson] [bigint] NOT NULL,
	[idPhoneType] [smallint] NULL,
	[number] [nvarchar](25) NOT NULL,
	[isForEmergency] [bit] NOT NULL DEFAULT 0,
	[description] [nvarchar](200) NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
	[deletedDate] [datetime] NULL,
	[deletedUser] [int] NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[idPhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pmPhone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Person] FOREIGN KEY([idPerson])
REFERENCES [dbo].[pmPerson] ([idPerson])
GO

ALTER TABLE [dbo].[pmPhone] CHECK CONSTRAINT [FK_Phone_Person]
GO

ALTER TABLE [dbo].[pmPhone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_PhoneType] FOREIGN KEY([idPhoneType])
REFERENCES [dbo].[pmPhoneType] ([idPhoneType])
GO

ALTER TABLE [dbo].[pmPhone] CHECK CONSTRAINT [FK_Phone_PhoneType]
GO




/******************************************************************************************************************************/
/**********************************************   MODULE : HR - HUMAN RESOURCES   ***************************************************/
/******************************************************************************************************************************/


/******************** JOB TITLE ****************************/

CREATE TABLE [dbo].[hrJobTitle](
	[idJobTitle] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_JobTitle] PRIMARY KEY CLUSTERED 
(
	[idJobTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** EMPLOYEE ****************************/

CREATE TABLE [dbo].[hrEmployee](
	[idEmployee] [bigint] NOT NULL,
	[email] [nvarchar](150) NULL,
	[idResidentDepartment] [int] NULL,
	[idResidentProvince] [int] NULL,
	[idResidentDistrict] [int] NULL,
	[address] [nvarchar](200) NULL,
	[addressReference] [nvarchar](200) NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
	[deletedDate] [datetime] NULL,
	[deletedUser] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[idEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[hrEmployee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Person] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[pmPerson] ([idPerson])
GO

ALTER TABLE [dbo].[hrEmployee] CHECK CONSTRAINT [FK_Employee_Person]
GO

ALTER TABLE [dbo].[hrEmployee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department_Province_District] FOREIGN KEY([idResidentDepartment],[idResidentProvince],[idResidentDistrict])
REFERENCES [dbo].[pmDistrict] ([idDepartment],[idProvince],[idDistrict])
GO

ALTER TABLE [dbo].[hrEmployee] CHECK CONSTRAINT [FK_Employee_Department_Province_District]
GO


/******************** EMPLOYMENT CONTRACT  ****************************/

CREATE TABLE [dbo].[hrEmploymentContract](
	[idEmploymentContract] [bigint] NOT NULL IDENTITY(1,1),
	[idEmployee] [bigint] NOT NULL,
	[idJobTitle] [int] NOT NULL,
	[salary] [decimal](12,2) NULL,
	[isPerHour] [bit] NOT NULL DEFAULT 0,
	[admissionDate] [datetime] NOT NULL,
	[cessationDate] [datetime] NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_EmploymentContract] PRIMARY KEY CLUSTERED 
(
	[idEmploymentContract] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[hrEmploymentContract]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentContract_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[hrEmploymentContract] CHECK CONSTRAINT [FK_EmploymentContract_Employee]
GO

ALTER TABLE [dbo].[hrEmploymentContract]  WITH CHECK ADD  CONSTRAINT [FK_EmploymentContract_JobTitle] FOREIGN KEY([idJobTitle])
REFERENCES [dbo].[hrJobTitle] ([idJobTitle])
GO

ALTER TABLE [dbo].[hrEmploymentContract] CHECK CONSTRAINT [FK_EmploymentContract_JobTitle]
GO


/********************************************************************************************************/
/*******************************   MODULE : EP - EDUCATIONAL PLANNING   **************************************/
/********************************************************************************************************/


/******************** ACADEMIC LEVEL ****************************/

CREATE TABLE [dbo].[epAcademicLevel](
	[idAcademicLevel] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nchar](3) NOT NULL,
 CONSTRAINT [PK_AcademicLevel] PRIMARY KEY CLUSTERED 
(
	[idAcademicLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** SCHOOL LEVEL ****************************/

CREATE TABLE [dbo].[epSchoolLevel](
	[idSchoolLevel] [smallint] NOT NULL IDENTITY(1,1),
	[idAcademicLevel] [smallint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_SchoolLevel] PRIMARY KEY CLUSTERED 
(
	[idSchoolLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[epSchoolLevel]  WITH CHECK ADD  CONSTRAINT [FK_SchoolLevel_AcademicLevel] FOREIGN KEY([idAcademicLevel])
REFERENCES [dbo].[epAcademicLevel] ([idAcademicLevel])
GO

ALTER TABLE [dbo].[epSchoolLevel] CHECK CONSTRAINT [FK_SchoolLevel_AcademicLevel]
GO


/********************************************************************************************************/
/*********************************   MODULE : SM - STUDENT MANAGEMENT   **************************************/
/********************************************************************************************************/


/******************** STUDENT ****************************/

CREATE TABLE [dbo].[smStudent](
	[idStudent] [char](8) NOT NULL,
	[idPerson] [bigint] NOT NULL,
	[email] [nvarchar](150) NULL,
	[idResidentDepartment] [int] NULL,
	[idResidentProvince] [int] NULL,
	[idResidentDistrict] [int] NULL,
	[address] [nvarchar](200) NULL,
	[addressReference] [nvarchar](200) NULL,
	[allergies] [nvarchar](200) NULL,
	[disease] [nvarchar](250) NULL,
	[otherHealthProblem] [nvarchar](250) NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[idStudent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[smStudent]  WITH CHECK ADD  CONSTRAINT [FK_Student_Person] FOREIGN KEY([idPerson])
REFERENCES [dbo].[pmPerson] ([idPerson])
GO

ALTER TABLE [dbo].[smStudent] CHECK CONSTRAINT [FK_Student_Person]
GO

ALTER TABLE [dbo].[smStudent]  WITH CHECK ADD  CONSTRAINT [FK_Student_Department_Province_District] FOREIGN KEY([idResidentDepartment],[idResidentProvince],[idResidentDistrict])
REFERENCES [dbo].[pmDistrict] ([idDepartment],[idProvince],[idDistrict])
GO

ALTER TABLE [dbo].[smStudent] CHECK CONSTRAINT [FK_Student_Department_Province_District]
GO

ALTER TABLE [dbo].[smStudent] ADD CONSTRAINT [UQ_Student_Person] UNIQUE ([idPerson])
GO


/******************** RELATIONSHIP ****************************/

CREATE TABLE [dbo].[smRelationship](
	[idRelationship] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_Relationship] PRIMARY KEY CLUSTERED 
(
	[idRelationship] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** RELATIVE ****************************/

CREATE TABLE [dbo].[smRelative](
	[idRelative] [bigint] NOT NULL,
	[idStudent] [char](8) NOT NULL,
	[idRelationship] [int] NOT NULL,
	[liveWithStudent] [bit] NOT NULL,
	[isGuardian] [bit] NOT NULL DEFAULT 0,
	[email] [nvarchar](150) NULL,
	[idResidentDepartment] [int] NULL,
	[idResidentProvince] [int] NULL,
	[idResidentDistrict] [int] NULL,
	[address] [nvarchar](200) NULL,
	[addressReference] [nvarchar](200) NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
	[deletedDate] [datetime] NULL,
	[deletedUser] [int] NULL,
 CONSTRAINT [PK_Relative] PRIMARY KEY CLUSTERED 
(
	[idRelative], [idStudent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[smRelative]  WITH CHECK ADD  CONSTRAINT [FK_Relative_Person] FOREIGN KEY([idRelative])
REFERENCES [dbo].[pmPerson] ([idPerson])
GO

ALTER TABLE [dbo].[smRelative] CHECK CONSTRAINT [FK_Relative_Person]
GO

ALTER TABLE [dbo].[smRelative]  WITH CHECK ADD  CONSTRAINT [FK_Relative_Student] FOREIGN KEY([idStudent])
REFERENCES [dbo].[smStudent] ([idStudent])
GO

ALTER TABLE [dbo].[smRelative] CHECK CONSTRAINT [FK_Relative_Student]
GO

ALTER TABLE [dbo].[smRelative]  WITH CHECK ADD  CONSTRAINT [FK_Relative_Relationship] FOREIGN KEY([idRelationship])
REFERENCES [dbo].[smRelationship] ([idRelationship])
GO

ALTER TABLE [dbo].[smRelative] CHECK CONSTRAINT [FK_Relative_Relationship]
GO

ALTER TABLE [dbo].[smRelative]  WITH CHECK ADD  CONSTRAINT [FK_Relative_Department_Province_District] FOREIGN KEY([idResidentDepartment],[idResidentProvince],[idResidentDistrict])
REFERENCES [dbo].[pmDistrict] ([idDepartment],[idProvince],[idDistrict])
GO

ALTER TABLE [dbo].[smRelative] CHECK CONSTRAINT [FK_Relative_Department_Province_District]
GO


/************* STUDENT DOCUMENT TYPE *************/

CREATE TABLE [dbo].[smStudentDocumentType]
(
	[idStudentDocumentType] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nvarchar](15) NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_StudentDocumentType] PRIMARY KEY CLUSTERED 
(
	[idStudentDocumentType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/************* STUDENT DOCUMENT *************/

CREATE TABLE [dbo].[smStudentDocument]
(
	[idStudentDocument] [bigint] NOT NULL IDENTITY(1,1),
	[idStudentDocumentType] [int] NOT NULL,
	[idStudent] [char](8) NOT NULL,
	[idCoordinator] [bigint] NOT NULL,
	[receptionDate] [datetime] NULL,
	[estimatedDate] [datetime] NULL,
	[description] [nvarchar](200) NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_StudentDocument] PRIMARY KEY CLUSTERED 
(
	[idStudentDocument] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[smStudentDocument]  WITH CHECK ADD  CONSTRAINT [FK_StudentDocument_StudentDocumentType] FOREIGN KEY([idStudentDocumentType])
REFERENCES [dbo].[smStudentDocumentType] ([idStudentDocumentType])
GO

ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_StudentDocumentType]
GO

ALTER TABLE [dbo].[smStudentDocument]  WITH CHECK ADD  CONSTRAINT [FK_StudentDocument_Student] FOREIGN KEY([idStudent])
REFERENCES [dbo].[smStudent] ([idStudent])
GO

ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_Student]
GO

ALTER TABLE [dbo].[smStudentDocument]  WITH CHECK ADD  CONSTRAINT [FK_StudentDocument_Coordinator] FOREIGN KEY([idCoordinator])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_Coordinator]
GO


/******************** SCHOLAR STATUS ****************************/

CREATE TABLE [dbo].[smScholarStatus](
	[idScholarStatus] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nvarchar](5) NOT NULL,
 CONSTRAINT [PK_ScholarStatus] PRIMARY KEY CLUSTERED 
(
	[idScholarStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** EXTERNAL SCHOOL ****************************/

CREATE TABLE [dbo].[smExternalSchool](
	[idExternalSchool] [bigint] NOT NULL IDENTITY(1,1),
	[idDepartment] [int] NULL,
	[idProvince] [int] NULL,
	[idDistrict] [int] NULL,
	[name] [nvarchar](200) NOT NULL,
	[description] [nvarchar](200) NULL,
	[isPrivate] [bit] NOT NULL DEFAULT 0,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
	[deletedDate] [datetime] NULL,
	[deletedUser] [int] NULL,
 CONSTRAINT [PK_ExternalSchool] PRIMARY KEY CLUSTERED 
(
	[idExternalSchool] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[smExternalSchool]  WITH CHECK ADD  CONSTRAINT [FK_ExternalSchool_District] 
FOREIGN KEY([idDepartment], [idProvince], [idDistrict])
REFERENCES [dbo].[pmDistrict] ([idDepartment], [idProvince], [idDistrict])
GO

ALTER TABLE [dbo].[smExternalSchool] CHECK CONSTRAINT [FK_ExternalSchool_District]
GO

/******************** ACADEMIC BACKGROUND ****************************/

CREATE TABLE [dbo].[smAcademicBackground](
	[idAcademicBackground] [bigint] NOT NULL IDENTITY(1,1),
	[idExternalSchool] [bigint] NOT NULL,
	[idStudent] [char](8) NOT NULL,
	[idSchoolLevel] [smallint] NOT NULL,
	[idScholarStatus] [smallint] NOT NULL,
	[schoolYear] [smallint] NOT NULL,
	[observation] [nvarchar](200) NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_AcademicBackground] PRIMARY KEY CLUSTERED 
(
	[idAcademicBackground] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[smAcademicBackground]  WITH CHECK ADD  CONSTRAINT [FK_AcademicBackground_SchoolOrigin] FOREIGN KEY([idExternalSchool])
REFERENCES [dbo].[smExternalSchool] ([idExternalSchool])
GO

ALTER TABLE [dbo].[smAcademicBackground] CHECK CONSTRAINT [FK_AcademicBackground_SchoolOrigin]
GO

ALTER TABLE [dbo].[smAcademicBackground]  WITH CHECK ADD  CONSTRAINT [FK_AcademicBackground_Student] FOREIGN KEY([idStudent])
REFERENCES [dbo].[smStudent] ([idStudent])
GO

ALTER TABLE [dbo].[smAcademicBackground] CHECK CONSTRAINT [FK_AcademicBackground_Student]
GO

ALTER TABLE [dbo].[smAcademicBackground]  WITH CHECK ADD  CONSTRAINT [FK_AcademicBackground_SchoolLevel] FOREIGN KEY([idSchoolLevel])
REFERENCES [dbo].[epSchoolLevel] ([idSchoolLevel])
GO

ALTER TABLE [dbo].[smAcademicBackground] CHECK CONSTRAINT [FK_AcademicBackground_SchoolLevel]
GO

ALTER TABLE [dbo].[smAcademicBackground]  WITH CHECK ADD  CONSTRAINT [FK_AcademicBackground_ScholarStatus] FOREIGN KEY([idScholarStatus])
REFERENCES [dbo].[smScholarStatus] ([idScholarStatus])
GO

ALTER TABLE [dbo].[smAcademicBackground] CHECK CONSTRAINT [FK_AcademicBackground_ScholarStatus]
GO



/********************************************************************************************************/
/***********************************   MODULE : EM - EDUCATIONAL MANAGEMENT   ***************************/
/********************************************************************************************************/


/******************** SCHOOL YEAR ****************************/

CREATE TABLE [dbo].[emSchoolYear](
	[idSchoolYear] [bigint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](100) NOT NULL,
	[year] int NOT NULL,
	[dueDay] [smallint] NOT NULL,
	[classStartDate] [date] NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_SchoolYear] PRIMARY KEY CLUSTERED 
(
	[idSchoolYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** SCHOOL YEAR LEVEL ****************************/

CREATE TABLE [dbo].[emSchoolYearLevel](
	[idSchoolYearLevel] [bigint] NOT NULL IDENTITY(1,1),
	[idSchoolYear] [bigint] NOT NULL,
	[idSchoolLevel] [smallint] NOT NULL,
	[vacancyAmount] int NOT NULL,
	[totalStudentEnrolledAmount] int NOT NULL DEFAULT 0,
	[newStudentEnrolledAmount] [int] NOT NULL DEFAULT 0,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_SchoolYearLevel] PRIMARY KEY CLUSTERED 
(
	[idSchoolYearLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[emSchoolYearLevel]  WITH CHECK ADD  CONSTRAINT [FK_SchoolYearLevel_SchoolYear] FOREIGN KEY([idSchoolYear])
REFERENCES [dbo].[emSchoolYear] ([idSchoolYear])
GO

ALTER TABLE [dbo].[emSchoolYearLevel] CHECK CONSTRAINT [FK_SchoolYearLevel_SchoolYear]
GO

ALTER TABLE [dbo].[emSchoolYearLevel]  WITH CHECK ADD  CONSTRAINT [FK_SchoolYearLevel_SchoolLevel] FOREIGN KEY([idSchoolLevel])
REFERENCES [dbo].[epSchoolLevel] ([idSchoolLevel])
GO

ALTER TABLE [dbo].[emSchoolYearLevel] CHECK CONSTRAINT [FK_SchoolYearLevel_SchoolLevel]
GO


/******************** SCHOOL YEAR FEE SCHECULE ****************************/

CREATE TABLE [dbo].[emSchoolYearFeeSchedule](
	[idSchoolYearFeeSchedule] [bigint] NOT NULL IDENTITY(1,1),
	[idSchoolYearLevel] [bigint] NOT NULL,
	[idPaymentConcept] [smallint] NOT NULL,
	[amount] [decimal](12,2) NOT NULL,
	[installmentCount] [smallint] NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_SchoolYearFeeSchedule] PRIMARY KEY CLUSTERED 
(
	[idSchoolYearFeeSchedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[emSchoolYearFeeSchedule]  WITH CHECK ADD  CONSTRAINT [FK_SchoolYearFeeSchedule_SchoolYearLevel] FOREIGN KEY([idSchoolYearLevel])
REFERENCES [dbo].[emSchoolYearLevel] ([idSchoolYearLevel])
GO

ALTER TABLE [dbo].[emSchoolYearFeeSchedule] CHECK CONSTRAINT [FK_SchoolYearFeeSchedule_SchoolYearLevel]
GO

ALTER TABLE [dbo].[emSchoolYearFeeSchedule]  WITH CHECK ADD  CONSTRAINT [FK_SchoolYearFeeSchedule_PaymentConcept] FOREIGN KEY([idPaymentConcept])
REFERENCES [dbo].[amPaymentConcept] ([idPaymentConcept])
GO

ALTER TABLE [dbo].[emSchoolYearFeeSchedule] CHECK CONSTRAINT [FK_SchoolYearFeeSchedule_PaymentConcept]
GO



/******************** ENROLLMENT ****************************/

CREATE TABLE [dbo].[emEnrollment](
	[idEnrollment] [bigint] NOT NULL IDENTITY(1,1),
	[idStudent] [char](8) NOT NULL,
	[idSchoolYearLevel] [bigint] NOT NULL,
	[idEmployee] [bigint] NULL,                    -- staff member who processed the enrollment
	[idDiscountVersion] [int] NULL,
	[status] [char](1) NOT NULL DEFAULT 'A', -- A: Active, W: Withdrawn, C: Cancelled
	[enrollmentDate] [datetime] NOT NULL,
	[admissionDate] [datetime] NOT NULL,
	[description] [nvarchar](250) NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED 
(
	[idEnrollment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[emEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[emEnrollment] CHECK CONSTRAINT [FK_Enrollment_Employee]
GO

ALTER TABLE [dbo].[emEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Student] FOREIGN KEY([idStudent])
REFERENCES [dbo].[smStudent] ([idStudent])
GO

ALTER TABLE [dbo].[emEnrollment] CHECK CONSTRAINT [FK_Enrollment_Student]
GO


ALTER TABLE [dbo].[emEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_DiscountVersion] FOREIGN KEY([idDiscountVersion])
REFERENCES [dbo].[amDiscountVersion] ([idDiscountVersion])
GO

ALTER TABLE [dbo].[emEnrollment] CHECK CONSTRAINT [FK_Enrollment_DiscountVersion]
GO

ALTER TABLE [dbo].[emEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_SchoolYearLevel] FOREIGN KEY([idSchoolYearLevel])
REFERENCES [dbo].[emSchoolYearLevel] ([idSchoolYearLevel])
GO

ALTER TABLE [dbo].[emEnrollment] CHECK CONSTRAINT [FK_Enrollment_SchoolYearLevel]
GO

ALTER TABLE [dbo].[emEnrollment] ADD CONSTRAINT [UQ_Enrollment_StudentSchoolYearLevel]
UNIQUE ([idStudent], [idSchoolYearLevel])
GO

ALTER TABLE [dbo].[emEnrollment] ADD CONSTRAINT [CK_Enrollment_Status]
CHECK ([status] IN ('A', 'W', 'C'))
GO


/******************** STUDENT FEE INSTALLMENT ****************************/

CREATE TABLE [dbo].[emStudentFeeInstallment](
	[idStudentFeeInstallment] [bigint] NOT NULL IDENTITY(1,1),
	[idEnrollment] [bigint] NOT NULL,
	[idSchoolYearFeeSchedule] [bigint] NOT NULL,
	[installmentNumber] [smallint] NOT NULL,
	[idPaymentStatus] [smallint] NOT NULL,
	[idDiscountVersion] [int] NULL,
	[amountSubTotal] [decimal](12,2) NOT NULL,
	[amountDiscount] [decimal](12,2) NOT NULL,
	[amountTotal] [decimal](12,2) NOT NULL,
	[amountPaid] [decimal](12,2) NOT NULL,
	[amountRemainder] AS ([amountTotal] - [amountPaid]),
	[dueDate] [datetime] NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_StudentFeeInstallment] PRIMARY KEY CLUSTERED 
(
	[idStudentFeeInstallment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[emStudentFeeInstallment]  WITH CHECK ADD  CONSTRAINT [FK_StudentFeeInstallment_Enrollment] FOREIGN KEY([idEnrollment])
REFERENCES [dbo].[emEnrollment] ([idEnrollment])
GO

ALTER TABLE [dbo].[emStudentFeeInstallment] CHECK CONSTRAINT [FK_StudentFeeInstallment_Enrollment]
GO

ALTER TABLE [dbo].[emStudentFeeInstallment]  WITH CHECK ADD  CONSTRAINT [FK_StudentFeeInstallment_SchoolYearFeeSchedule] FOREIGN KEY([idSchoolYearFeeSchedule])
REFERENCES [dbo].[emSchoolYearFeeSchedule] ([idSchoolYearFeeSchedule])
GO

ALTER TABLE [dbo].[emStudentFeeInstallment] CHECK CONSTRAINT [FK_StudentFeeInstallment_SchoolYearFeeSchedule]
GO

ALTER TABLE [dbo].[emStudentFeeInstallment]  WITH CHECK ADD  CONSTRAINT [FK_StudentFeeInstallment_PaymentStatus] FOREIGN KEY([idPaymentStatus])
REFERENCES [dbo].[amPaymentStatus] ([idPaymentStatus])
GO

ALTER TABLE [dbo].[emStudentFeeInstallment] CHECK CONSTRAINT [FK_StudentFeeInstallment_PaymentStatus]
GO

ALTER TABLE [dbo].[emStudentFeeInstallment]  WITH CHECK ADD  CONSTRAINT [FK_StudentFeeInstallment_DiscountVersion] FOREIGN KEY([idDiscountVersion])
REFERENCES [dbo].[amDiscountVersion] ([idDiscountVersion])
GO

ALTER TABLE [dbo].[emStudentFeeInstallment] CHECK CONSTRAINT [FK_StudentFeeInstallment_DiscountVersion]
GO


/******************** STUDENT NOTE ****************************/

CREATE TABLE [dbo].[emStudentNote](
	[idStudentNote] [bigint] NOT NULL IDENTITY(1,1),
	[idEnrollment] [bigint] NOT NULL,
	[description] [nvarchar](MAX) NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
	[deletedDate] [datetime] NULL,
	[deletedUser] [int] NULL,
 CONSTRAINT [PK_StudentNote] PRIMARY KEY CLUSTERED
(
	[idStudentNote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[emStudentNote]  WITH CHECK ADD  CONSTRAINT [FK_StudentNote_Enrollment] FOREIGN KEY([idEnrollment])
REFERENCES [dbo].[emEnrollment] ([idEnrollment])
GO

ALTER TABLE [dbo].[emStudentNote] CHECK CONSTRAINT [FK_StudentNote_Enrollment]
GO


/********************************************************************************************************/
/*************************************   MODULE : AM - ACCOUNTING   *************************************/
/********************************************************************************************************/


/******************** PAYMENT CONCEPT ****************************/

CREATE TABLE [dbo].[amPaymentConcept](
	[idPaymentConcept] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_PaymentConcept] PRIMARY KEY CLUSTERED 
(
	[idPaymentConcept] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** PAYMENT STATUS ****************************/

CREATE TABLE [dbo].[amPaymentStatus](
	[idPaymentStatus] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nchar](10) NOT NULL,
 CONSTRAINT [PK_PaymentStatus] PRIMARY KEY CLUSTERED 
(
	[idPaymentStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** PAYMENT METHOD ****************************/

CREATE TABLE [dbo].[amPaymentMethod](
	[idPaymentMethod] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nchar](10) NOT NULL,
 CONSTRAINT [PK_PaymentMethod] PRIMARY KEY CLUSTERED 
(
	[idPaymentMethod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** PAYMENT ACCOUNT ****************************/

CREATE TABLE [dbo].[amPaymentAccount](
	[idPaymentAccount] [int] NOT NULL IDENTITY(1,1),
	[idPaymentMethod] [smallint] NOT NULL,
	[idCampus] [int] NULL,                     -- NULL for online/bank accounts, NOT NULL for cash registers
	[name] [nvarchar](100) NOT NULL,
	[accountNumber] [nvarchar](50) NULL,       -- for bank accounts
	[alias] [nvarchar](100) NULL,              -- phone number or alias for Yape, Plin
	[isActive] [bit] NOT NULL DEFAULT 1,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_PaymentAccount] PRIMARY KEY CLUSTERED
(
	[idPaymentAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amPaymentAccount] WITH CHECK ADD CONSTRAINT [FK_PaymentAccount_PaymentMethod] FOREIGN KEY([idPaymentMethod])
REFERENCES [dbo].[amPaymentMethod] ([idPaymentMethod])
GO

ALTER TABLE [dbo].[amPaymentAccount] CHECK CONSTRAINT [FK_PaymentAccount_PaymentMethod]
GO

ALTER TABLE [dbo].[amPaymentAccount] WITH CHECK ADD CONSTRAINT [FK_PaymentAccount_Campus] FOREIGN KEY([idCampus])
REFERENCES [dbo].[inCampus] ([idCampus])
GO

ALTER TABLE [dbo].[amPaymentAccount] CHECK CONSTRAINT [FK_PaymentAccount_Campus]
GO


/******************** DISCOUNT ****************************/

CREATE TABLE [dbo].[amDiscount](
	[idDiscount] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](250) NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[idDiscount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/*************** DISCOUNT VERSION *************************/

CREATE TABLE [dbo].[amDiscountVersion](
	[idDiscountVersion] [int] NOT NULL IDENTITY(1,1),
	[idDiscount] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[discountAmount] [decimal](12,2) NULL,
	[discountRate] [decimal](12,2) NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NULL,
	[isRate] [bit] NOT NULL DEFAULT 0,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_DiscountVersion] PRIMARY KEY CLUSTERED 
(
	[idDiscountVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amDiscountVersion]  WITH CHECK ADD  CONSTRAINT [FK_DiscountVersion_Discount] FOREIGN KEY([idDiscount])
REFERENCES [dbo].[amDiscount] ([idDiscount])
GO

ALTER TABLE [dbo].[amDiscountVersion] CHECK CONSTRAINT [FK_DiscountVersion_Discount]
GO

ALTER TABLE [dbo].[amDiscountVersion] ADD CONSTRAINT [CK_DiscountVersion_AmountOrRate]
CHECK (
	(isRate = 1 AND discountRate IS NOT NULL AND discountRate >= 0 AND discountRate <= 100 AND discountAmount IS NULL)
	OR
	(isRate = 0 AND discountAmount IS NOT NULL AND discountAmount >= 0 AND discountRate IS NULL)
)
GO


/******************** EXPENSE CONCEPT ****************************/

CREATE TABLE [dbo].[amExpenseConcept](
	[idExpenseConcept] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_ExpenseConcept] PRIMARY KEY CLUSTERED
(
	[idExpenseConcept] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** EXPENSE ****************************/

CREATE TABLE [dbo].[amExpense](
	[idExpense] [bigint] NOT NULL IDENTITY(1,1),
	[idPaymentAccount] [int] NOT NULL,
	[idExpenseConcept] [smallint] NOT NULL,
	[amount] [decimal](12,2) NOT NULL,
	[description] [nvarchar](250) NULL,
	[expenseDate] [date] NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
	[deletedDate] [datetime] NULL,
	[deletedUser] [int] NULL,
 CONSTRAINT [PK_Expense] PRIMARY KEY CLUSTERED
(
	[idExpense] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amExpense] WITH CHECK ADD CONSTRAINT [FK_Expense_PaymentAccount] FOREIGN KEY([idPaymentAccount])
REFERENCES [dbo].[amPaymentAccount] ([idPaymentAccount])
GO

ALTER TABLE [dbo].[amExpense] CHECK CONSTRAINT [FK_Expense_PaymentAccount]
GO

ALTER TABLE [dbo].[amExpense] WITH CHECK ADD CONSTRAINT [FK_Expense_ExpenseConcept] FOREIGN KEY([idExpenseConcept])
REFERENCES [dbo].[amExpenseConcept] ([idExpenseConcept])
GO

ALTER TABLE [dbo].[amExpense] CHECK CONSTRAINT [FK_Expense_ExpenseConcept]
GO


/******************** PAYMENT RECEIPT ****************************/

CREATE TABLE [dbo].[amPaymentReceipt](
	[idPaymentReceipt] [bigint] NOT NULL IDENTITY(1,1),
	[idEmployee] [bigint] NULL,                    -- cashier who processed the payment
	[idPaymentAccount] [int] NOT NULL,
	[operationNumber] [nvarchar](100) NULL,             -- operation number for Yape, Plin, bank transfers
	[totalAmount] [decimal](12,2) NOT NULL,
	[paymentDate] [datetime] NOT NULL,
	[receiptType] [char](1) NOT NULL DEFAULT 'B',      -- B: boleta, F: factura
	[seriesNumber] [varchar](5) NOT NULL,
	[receiptNumber] [varchar](10) NOT NULL,
	[payerName] [nvarchar](200) NULL,
	[idPayerTypeDocument] [int] NULL,
	[payerDocument] [nvarchar](20) NULL,               -- DNI/RUC for electronic receipts
	[comment] [nvarchar](250) NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_PaymentReceipt] PRIMARY KEY CLUSTERED
(
	[idPaymentReceipt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amPaymentReceipt] ADD CONSTRAINT [UQ_PaymentReceipt_Series] UNIQUE ([idPaymentAccount], [seriesNumber], [receiptNumber])
GO

ALTER TABLE [dbo].[amPaymentReceipt] WITH CHECK ADD CONSTRAINT [FK_PaymentReceipt_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[amPaymentReceipt] CHECK CONSTRAINT [FK_PaymentReceipt_Employee]
GO

ALTER TABLE [dbo].[amPaymentReceipt] WITH CHECK ADD CONSTRAINT [FK_PaymentReceipt_PaymentAccount] FOREIGN KEY([idPaymentAccount])
REFERENCES [dbo].[amPaymentAccount] ([idPaymentAccount])
GO

ALTER TABLE [dbo].[amPaymentReceipt] CHECK CONSTRAINT [FK_PaymentReceipt_PaymentAccount]
GO

ALTER TABLE [dbo].[amPaymentReceipt] WITH CHECK ADD CONSTRAINT [FK_PaymentReceipt_PayerTypeDocument] FOREIGN KEY([idPayerTypeDocument])
REFERENCES [dbo].[pmTypeDocumentIdentity] ([idTypeDocumentIdentity])
GO

ALTER TABLE [dbo].[amPaymentReceipt] CHECK CONSTRAINT [FK_PaymentReceipt_PayerTypeDocument]
GO


/******************** PAYMENT RECEIPT DETAIL ****************************/

CREATE TABLE [dbo].[amPaymentReceiptDetail](
	[idPaymentReceiptDetail] [bigint] NOT NULL IDENTITY(1,1),
	[idPaymentReceipt] [bigint] NOT NULL,
	[idStudentFeeInstallment] [bigint] NOT NULL,
	[amountPaid] [decimal](12,2) NOT NULL,
	[description] [nvarchar](250) NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_PaymentReceiptDetail] PRIMARY KEY CLUSTERED 
(
	[idPaymentReceiptDetail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amPaymentReceiptDetail]  WITH CHECK ADD  CONSTRAINT [FK_PaymentReceiptDetail_PaymentReceipt] FOREIGN KEY([idPaymentReceipt])
REFERENCES [dbo].[amPaymentReceipt] ([idPaymentReceipt])
GO

ALTER TABLE [dbo].[amPaymentReceiptDetail] CHECK CONSTRAINT [FK_PaymentReceiptDetail_PaymentReceipt]
GO

ALTER TABLE [dbo].[amPaymentReceiptDetail]  WITH CHECK ADD  CONSTRAINT [FK_PaymentReceiptDetail_StudentFeeInstallment] FOREIGN KEY([idStudentFeeInstallment])
REFERENCES [dbo].[emStudentFeeInstallment] ([idStudentFeeInstallment])
GO

ALTER TABLE [dbo].[amPaymentReceiptDetail] CHECK CONSTRAINT [FK_PaymentReceiptDetail_StudentFeeInstallment]
GO


/******************** DAILY BALANCE ****************************/

CREATE TABLE [dbo].[amDailyBalance](
	[idDailyBalance] [int] NOT NULL IDENTITY(1,1),
	[idPaymentAccount] [int] NOT NULL,
	[idEmployee] [bigint] NOT NULL,
	[balanceDate] [date] NOT NULL,
	[openingAmount] [decimal](12,2) NOT NULL DEFAULT 0,
	[incomeAmount] [decimal](12,2) NOT NULL DEFAULT 0,
	[expenseAmount] [decimal](12,2) NOT NULL DEFAULT 0,
	[closingAmount] AS ([openingAmount] + [incomeAmount] - [expenseAmount]),
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_DailyBalance] PRIMARY KEY CLUSTERED
(
	[idDailyBalance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amDailyBalance] ADD CONSTRAINT [UQ_DailyBalance_AccountDate]
UNIQUE ([idPaymentAccount], [balanceDate])
GO

ALTER TABLE [dbo].[amDailyBalance] WITH CHECK ADD CONSTRAINT [FK_DailyBalance_PaymentAccount] FOREIGN KEY([idPaymentAccount])
REFERENCES [dbo].[amPaymentAccount] ([idPaymentAccount])
GO

ALTER TABLE [dbo].[amDailyBalance] CHECK CONSTRAINT [FK_DailyBalance_PaymentAccount]
GO

ALTER TABLE [dbo].[amDailyBalance] WITH CHECK ADD CONSTRAINT [FK_DailyBalance_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[amDailyBalance] CHECK CONSTRAINT [FK_DailyBalance_Employee]
GO


/******************** MONTHLY BALANCE ****************************/

CREATE TABLE [dbo].[amMonthlyBalance](
	[idMonthlyBalance] [int] NOT NULL IDENTITY(1,1),
	[idPaymentAccount] [int] NOT NULL,
	[idEmployee] [bigint] NOT NULL,
	[year] [smallint] NOT NULL,
	[month] [tinyint] NOT NULL,
	[openingAmount] [decimal](12,2) NOT NULL DEFAULT 0,
	[incomeAmount] [decimal](12,2) NOT NULL DEFAULT 0,
	[expenseAmount] [decimal](12,2) NOT NULL DEFAULT 0,
	[closingAmount] AS ([openingAmount] + [incomeAmount] - [expenseAmount]),
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_MonthlyBalance] PRIMARY KEY CLUSTERED
(
	[idMonthlyBalance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amMonthlyBalance] ADD CONSTRAINT [UQ_MonthlyBalance_AccountYearMonth]
UNIQUE ([idPaymentAccount], [year], [month])
GO

ALTER TABLE [dbo].[amMonthlyBalance] WITH CHECK ADD CONSTRAINT [FK_MonthlyBalance_PaymentAccount] FOREIGN KEY([idPaymentAccount])
REFERENCES [dbo].[amPaymentAccount] ([idPaymentAccount])
GO

ALTER TABLE [dbo].[amMonthlyBalance] CHECK CONSTRAINT [FK_MonthlyBalance_PaymentAccount]
GO

ALTER TABLE [dbo].[amMonthlyBalance] WITH CHECK ADD CONSTRAINT [FK_MonthlyBalance_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[amMonthlyBalance] CHECK CONSTRAINT [FK_MonthlyBalance_Employee]
GO


/******************** PAYMENT NOTE ****************************/

CREATE TABLE [dbo].[amPaymentNote](
	[idPaymentNote] [bigint] NOT NULL IDENTITY(1,1),
	[idEnrollment] [bigint] NOT NULL,
	[description] [nvarchar](MAX) NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
	[deletedDate] [datetime] NULL,
	[deletedUser] [int] NULL,
 CONSTRAINT [PK_PaymentNote] PRIMARY KEY CLUSTERED
(
	[idPaymentNote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amPaymentNote]  WITH CHECK ADD  CONSTRAINT [FK_PaymentNote_Enrollment] FOREIGN KEY([idEnrollment])
REFERENCES [dbo].[emEnrollment] ([idEnrollment])
GO

ALTER TABLE [dbo].[amPaymentNote] CHECK CONSTRAINT [FK_PaymentNote_Enrollment]
GO



/********************************************************************************************************/
/*********************************   MODULE : IN - INFRASTRUCTURE   ******************************************/
/********************************************************************************************************/


/************* INSTITUTION *************/

CREATE TABLE [dbo].[inInstitution]
(
	[idInstitution] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Institution] PRIMARY KEY CLUSTERED 
(
	[idInstitution] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/************* CAMPUS *************/

CREATE TABLE [dbo].[inCampus]
(
	[idCampus] [int] NOT NULL IDENTITY(1,1),
	[idInstitution] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Campus] PRIMARY KEY CLUSTERED 
(
	[idCampus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[inCampus]  WITH CHECK ADD  CONSTRAINT [FK_Campus_Institution] FOREIGN KEY([idInstitution])
REFERENCES [dbo].[inInstitution] ([idInstitution])
GO

ALTER TABLE [dbo].[inCampus] CHECK CONSTRAINT [FK_Campus_Institution]
GO

/************* ROOM *************/

CREATE TABLE [dbo].[inRoom]
(
	[idRoom] [int] NOT NULL IDENTITY(1,1),
	[idCampus] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[capacity] [int] NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[idRoom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[inRoom]  WITH CHECK ADD  CONSTRAINT [FK_Room_Campus] FOREIGN KEY([idCampus])
REFERENCES [dbo].[inCampus] ([idCampus])
GO

ALTER TABLE [dbo].[inRoom] CHECK CONSTRAINT [FK_Room_Campus]
GO


/********************************************************************************************************/
/*************************************   MODULE : SY - SYSTEM   *****************************************/
/********************************************************************************************************/


/******************** ROLE ****************************/

CREATE TABLE [dbo].[syRole](
	[idRole] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](200) NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED
(
	[idRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[syRole] ADD CONSTRAINT [UQ_Role_Name] UNIQUE ([name])
GO


/******************** PERMISSION ****************************/

CREATE TABLE [dbo].[syPermission](
	[idPermission] [int] NOT NULL IDENTITY(1,1),
	[module] [char](2) NOT NULL,     -- PM, HR, SY, EP, IN, SM, EM, AM
	[name] [nvarchar](50) NOT NULL,  -- e.g. STUDENT_VIEW, PAYMENT_PROCESS
	[description] [nvarchar](200) NULL,
	[isActive] [bit] NOT NULL DEFAULT 1,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED
(
	[idPermission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[syPermission] ADD CONSTRAINT [UQ_Permission_ModuleName] UNIQUE ([module], [name])
GO


/******************** ROLE PERMISSION ****************************/

CREATE TABLE [dbo].[syRolePermission](
	[idRole] [int] NOT NULL,
	[idPermission] [int] NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED
(
	[idRole] ASC, [idPermission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[syRolePermission] WITH CHECK ADD CONSTRAINT [FK_RolePermission_Role] FOREIGN KEY([idRole])
REFERENCES [dbo].[syRole] ([idRole])
GO

ALTER TABLE [dbo].[syRolePermission] CHECK CONSTRAINT [FK_RolePermission_Role]
GO

ALTER TABLE [dbo].[syRolePermission] WITH CHECK ADD CONSTRAINT [FK_RolePermission_Permission] FOREIGN KEY([idPermission])
REFERENCES [dbo].[syPermission] ([idPermission])
GO

ALTER TABLE [dbo].[syRolePermission] CHECK CONSTRAINT [FK_RolePermission_Permission]
GO


/******************** USER ****************************/

CREATE TABLE [dbo].[syUser](
	[idUser] [int] NOT NULL IDENTITY(1,1),
	[idEmployee] [bigint] NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[passwordHash] [nvarchar](256) NOT NULL, -- store bcrypt/SHA-256 hash, never plain text
	[inactivityTime] [smallint] NOT NULL DEFAULT 30,
	[isActive] [bit] NOT NULL DEFAULT 1,
	[lastLoginDate] [datetime] NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
	[modifiedDate] [datetime] NULL,
	[modifiedUser] [int] NULL,
	[deletedDate] [datetime] NULL,
	[deletedUser] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[syUser] WITH CHECK ADD CONSTRAINT [UQ_User_Employee] UNIQUE ([idEmployee])
GO

ALTER TABLE [dbo].[syUser] WITH CHECK ADD CONSTRAINT [UQ_User_UserName] UNIQUE ([userName])
GO

ALTER TABLE [dbo].[syUser] WITH CHECK ADD CONSTRAINT [FK_User_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[syUser] CHECK CONSTRAINT [FK_User_Employee]
GO


/******************** USER ROLE ****************************/

CREATE TABLE [dbo].[syUserRole](
	[idUser] [int] NOT NULL,
	[idRole] [int] NOT NULL,
	[registrationDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[registrationUser] [int] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED
(
	[idUser] ASC, [idRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[syUserRole] WITH CHECK ADD CONSTRAINT [FK_UserRole_User] FOREIGN KEY([idUser])
REFERENCES [dbo].[syUser] ([idUser])
GO

ALTER TABLE [dbo].[syUserRole] CHECK CONSTRAINT [FK_UserRole_User]
GO

ALTER TABLE [dbo].[syUserRole] WITH CHECK ADD CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([idRole])
REFERENCES [dbo].[syRole] ([idRole])
GO

ALTER TABLE [dbo].[syUserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
