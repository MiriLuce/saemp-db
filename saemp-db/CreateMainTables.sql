--CREATE DATABASE [DBSaemp]

CREATE LOGIN Consultant WITH PASSWORD = '123';
CREATE USER Consultant FOR LOGIN Consultant;

USE [DBSaemp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/******************************************************************************************************************************/
/**********************************************   MODULO : GESTIÓN DE PERSONAS   **********************************************/
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
	[idDepartment] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[idDepartment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/************* DISTRICT *************/

CREATE TABLE [dbo].[pmDistrict]
(
	[idDistrict] [int] NOT NULL IDENTITY(1,1),
	[idDepartment] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[idDistrict] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pmDistrict]  WITH CHECK ADD  CONSTRAINT [FK_District_Department] FOREIGN KEY([idDepartment])
REFERENCES [dbo].[pmDepartment] ([idDepartment])
GO

ALTER TABLE [dbo].[pmDistrict] CHECK CONSTRAINT [FK_District_Department]
GO


/******************** PHONE COMPANY ****************************/

CREATE TABLE [dbo].[pmPhoneCompany](
	[idPhoneCompany] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](25) NOT NULL
 CONSTRAINT [PK_PhoneCompany] PRIMARY KEY CLUSTERED 
(
	[idPhoneCompany] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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

/************* TYPE DOCUMENT IDENTITY *************/

CREATE TABLE [dbo].[pmTypeDocumentIdentity]
(
	[idTypeDocumentIdentity] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nvarchar](15) NOT NULL,
	[length] [smallint] NOT NULL,
	[lengthType] [char](1) NULL, -- E: exacta, M: máxima
	[characterType] [char](1) NULL, -- A: alfanumerico, N: numerico
	[nationalityType] [char](1) NULL, -- N: nacionales, E: extranjeros, A: ambos
	[isActive] [bit] NOT NULL DEFAULT 1,
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
	[fatherlastName] [nvarchar](150) NOT NULL,
	[motherlastName] [nvarchar](150) NULL,
	[email] [nvarchar](150) NULL,
	[birthdate] [date] NULL,
	[idBirthCountry] [int] NOT NULL,
	[idResidentDepartment] [int] NULL,
	[idResidentDistrict] [int] NULL,
	[address] [nvarchar](200) NULL,
	[addressReference] [nvarchar](200) NULL,
	[registrationDate] [date] NOT NULL,
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

ALTER TABLE [dbo].[pmPerson]  WITH CHECK ADD  CONSTRAINT [FK_Person_Country] FOREIGN KEY([idBirthCountry])
REFERENCES [dbo].[pmCountry] ([idCountry])
GO

ALTER TABLE [dbo].[pmPerson] CHECK CONSTRAINT [FK_Person_Country]
GO

ALTER TABLE [dbo].[pmPerson]  WITH CHECK ADD  CONSTRAINT [FK_Person_Department] FOREIGN KEY([idResidentDepartment])
REFERENCES [dbo].[pmDepartment] ([idDepartment])
GO

ALTER TABLE [dbo].[pmPerson] CHECK CONSTRAINT [FK_Person_Department]
GO

ALTER TABLE [dbo].[pmPerson]  WITH CHECK ADD  CONSTRAINT [FK_Person_District] FOREIGN KEY([idResidentDistrict])
REFERENCES [dbo].[pmDistrict] ([idDistrict])
GO

ALTER TABLE [dbo].[pmPerson] CHECK CONSTRAINT [FK_Person_District]
GO


/******************** PHONE ****************************/

CREATE TABLE [dbo].[pmPhone](
	[idPhone] [bigint] NOT NULL IDENTITY(1,1),
	[idPerson] [bigint] NOT NULL,
	[idPhoneCompany] [smallint] NULL,
	[idPhoneType] [smallint] NULL,
	[number] [nvarchar](25) NOT NULL,
	[isForEmergency] [bit] NOT NULL,
	[description] [nvarchar](200) NULL,
	[isActive] [bit] NOT NULL DEFAULT 0,
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

ALTER TABLE [dbo].[pmPhone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_PhoneCompany] FOREIGN KEY([idPhoneCompany])
REFERENCES [dbo].[pmPhoneCompany] ([idPhoneCompany])
GO

ALTER TABLE [dbo].[pmPhone] CHECK CONSTRAINT [FK_Phone_PhoneCompany]
GO

ALTER TABLE [dbo].[pmPhone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_PhoneType] FOREIGN KEY([idPhoneType])
REFERENCES [dbo].[pmPhoneType] ([idPhoneType])
GO

ALTER TABLE [dbo].[pmPhone] CHECK CONSTRAINT [FK_Phone_PhoneType]
GO





/******************************************************************************************************************************/
/**********************************************   MODULO : RECURSOS HUMANOS  **************************************************/
/******************************************************************************************************************************/


/******************** JOB TITLE ****************************/

CREATE TABLE [dbo].[hrJobTitle](
	[idJobTitle] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NULL,
	[abbreviation] [nchar](10) NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_JobTitle] PRIMARY KEY CLUSTERED 
(
	[idJobTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** EMPLOYEE ****************************/

CREATE TABLE [dbo].[hrEmployee](
	[idEmployee] [bigint] NOT NULL,
	[userName] [nvarchar](50) NULL,
	[userPassword] [nvarchar](50) NULL,
	[inactivityTime] [smallint] NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT 0,
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


/******************** EMPLOYMENT CONTRACT  ****************************/

CREATE TABLE [dbo].[hrEmploymentContract](
	[idEmploymentContract] [bigint] NOT NULL IDENTITY(1,1),
	[idEmployee] [bigint] NOT NULL,
	[idJobTitle] [int] NOT NULL,
	[salary] [decimal](4,2) NULL,
	[isPerHour] [bit] NOT NULL DEFAULT 0,
	[admissionDate] [datetime] NOT NULL,
	[cessationDate] [datetime] NOT NULL,
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
/*******************************   MODULO : PLANIFICACIÓN EDUCATIVA   ***********************************/
/********************************************************************************************************/


/******************** ACADEMIC LEVEL ****************************/

CREATE TABLE [dbo].[epAcademicLevel](
	[idAcademicLevel] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nchar](10) NOT NULL,
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
	[abbreviation] [nchar](10) NOT NULL,
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


/******************** SCHOLAR STATUS ****************************/

CREATE TABLE [dbo].[epScholarStatus](
	[idScholarStatus] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NULL,
	[abbreviation] [nchar](10) NOT NULL,
 CONSTRAINT [PK_SchoolStatus] PRIMARY KEY CLUSTERED 
(
	[idScholarStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/************* STUDENT DOCUMENT TYPE *************/

CREATE TABLE [dbo].[epStudentDocumentType]
(
	[idStudentDocumentType] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nchar](15) NOT NULL,
	[effectiveDate] [date] NOT NULL,
	[expirationDate] [date] NULL,
	[inEffect] [bit] NOT NULL,
 CONSTRAINT [PK_StudentDocumentType] PRIMARY KEY CLUSTERED 
(
	[idStudentDocumentType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



/******************** ORIGIN SCHOOL ****************************/

CREATE TABLE [dbo].[epSchoolOrigin](
	[idSchoolOrigin] [bigint] NOT NULL IDENTITY(1,1),
	[idDepartment] [int] NOT NULL,
	[idDistrict] [int] NULL,
	[name] [nvarchar](200) NULL,
	[description] [nvarchar](200) NULL,
	[isPrivate] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_SchoolOrigin] PRIMARY KEY CLUSTERED 
(
	[idSchoolOrigin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[epSchoolOrigin]  WITH CHECK ADD  CONSTRAINT [FK_SchoolOrigin_Department] FOREIGN KEY([idDepartment])
REFERENCES [dbo].[pmDepartment] ([idDepartment])
GO

ALTER TABLE [dbo].[epSchoolOrigin] CHECK CONSTRAINT [FK_SchoolOrigin_Department]
GO


/********************************************************************************************************/
/*********************************   MODULO : INFRAESTRUTURA   ******************************************/
/********************************************************************************************************/


/************* CAMPUS *************/

CREATE TABLE [dbo].[inCampus]
(
	[idCampus] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[abbreviation] [nchar](15) NOT NULL,
	[address] [nvarchar](200) NULL,
	[addressReference] [nvarchar](200) NULL,
 CONSTRAINT [PK_Campus] PRIMARY KEY CLUSTERED 
(
	[idCampus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/************* ROOM *************/

CREATE TABLE [dbo].[inRoom]
(
	[idRoom] [int] NOT NULL IDENTITY(1,1),
	[idCampus] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[capacity] [int] NOT NULL,
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
/*********************************   MODULO : GESTIÓN DEL ALUMNADO   ************************************/
/********************************************************************************************************/


/******************** RELATIONSHIP ****************************/

CREATE TABLE [dbo].[smRelationship](
	[idRelationship] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NULL,
	[isDefault] [bit] NOT NULL DEFAULT 0,
 CONSTRAINT [PK_Relationship] PRIMARY KEY CLUSTERED 
(
	[idRelationship] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/******************** STUDENT ****************************/

CREATE TABLE [dbo].[smStudent](
	[idStudent] [char](8) NOT NULL,
	[idPerson] [bigint] NOT NULL,
	[allergies] [nvarchar](200) NULL,
	[disease] [nvarchar](250) NULL,
	[otherHealthProblem] [nvarchar](250) NULL,
	[isActive] [bit] NOT NULL DEFAULT 0,
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


/******************** RELATIVE ****************************/

CREATE TABLE [dbo].[smRelative](
	[idRelative] [bigint] NOT NULL,
	[idStudent] [char](8) NOT NULL,
	[idRelationship] [int] NOT NULL,
	[liveWithStudent] [bit] NOT NULL,
	[isGuardian] [bit] NOT NULL DEFAULT 0,
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


/************* STUDENT DOCUMENT *************/

CREATE TABLE [dbo].[smStudentDocument]
(
	[idStudentDocument] [bigint] NOT NULL IDENTITY(1,1),
	[idStudentDocumentType] [int] NOT NULL,
	[idStudent] [char](8) NOT NULL,
	[idReceptionCoordinator] [bigint] NOT NULL,
	[receptionDate] [datetime] NULL,
	[estimatedDate] [datetime] NULL,
	[description] [nvarchar](200) NULL,
 CONSTRAINT [PK_StudentDocument] PRIMARY KEY CLUSTERED 
(
	[idStudentDocument] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[smStudentDocument]  WITH CHECK ADD  CONSTRAINT [FK_StudentDocument_StudentDocumentType] FOREIGN KEY([idStudentDocumentType])
REFERENCES [dbo].[epStudentDocumentType] ([idStudentDocumentType])
GO

ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_StudentDocumentType]
GO

ALTER TABLE [dbo].[smStudentDocument]  WITH CHECK ADD  CONSTRAINT [FK_StudentDocument_Student] FOREIGN KEY([idStudent])
REFERENCES [dbo].[smStudent] ([idStudent])
GO

ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_Student]
GO

ALTER TABLE [dbo].[smStudentDocument]  WITH CHECK ADD  CONSTRAINT [FK_StudentDocument_Coordinator] FOREIGN KEY([idReceptionCoordinator])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_Coordinator]
GO


/******************** STUDENT ORIGIN SCHOOL ****************************/

CREATE TABLE [dbo].[smStudentSchoolOrigin](
	[idStudentSchoolOrigin] [bigint] NOT NULL IDENTITY(1,1),
	[idSchoolOrigin] [bigint] NOT NULL,
	[idStudent] [char](8) NOT NULL,
	[idSchoolLevel] [smallint] NOT NULL,
	[idScholarStatus] [smallint] NOT NULL,
	[observation] [nvarchar](200) NULL,
 CONSTRAINT [PK_StudentSchoolOrigin] PRIMARY KEY CLUSTERED 
(
	[idStudentSchoolOrigin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[smStudentSchoolOrigin]  WITH CHECK ADD  CONSTRAINT [FK_StudentSchoolOrigin_SchoolOrigin] FOREIGN KEY([idSchoolOrigin])
REFERENCES [dbo].[epSchoolOrigin] ([idSchoolOrigin])
GO

ALTER TABLE [dbo].[smStudentSchoolOrigin] CHECK CONSTRAINT [FK_StudentSchoolOrigin_SchoolOrigin]
GO

ALTER TABLE [dbo].[smStudentSchoolOrigin]  WITH CHECK ADD  CONSTRAINT [FK_StudentSchoolOrigin_Student] FOREIGN KEY([idStudent])
REFERENCES [dbo].[smStudent] ([idStudent])
GO

ALTER TABLE [dbo].[smStudentSchoolOrigin] CHECK CONSTRAINT [FK_StudentSchoolOrigin_Student]
GO

ALTER TABLE [dbo].[smStudentSchoolOrigin]  WITH CHECK ADD  CONSTRAINT [FK_StudentSchoolOrigin_SchoolLevel] FOREIGN KEY([idSchoolLevel])
REFERENCES [dbo].[epSchoolLevel] ([idSchoolLevel])
GO

ALTER TABLE [dbo].[smStudentSchoolOrigin] CHECK CONSTRAINT [FK_StudentSchoolOrigin_SchoolLevel]
GO

ALTER TABLE [dbo].[smStudentSchoolOrigin]  WITH CHECK ADD  CONSTRAINT [FK_StudentSchoolOrigin_ScholarStatus] FOREIGN KEY([idScholarStatus])
REFERENCES [dbo].[epScholarStatus] ([idScholarStatus])
GO

ALTER TABLE [dbo].[smStudentSchoolOrigin] CHECK CONSTRAINT [FK_StudentSchoolOrigin_ScholarStatus]
GO


