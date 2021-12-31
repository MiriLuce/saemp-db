USE [DBSaemp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/********************************************************************************************************/
/*************************************   MODULO : CONTABILIDAD   ****************************************/
/********************************************************************************************************/


/******************** PAYMENT CONCEPT ****************************/

CREATE TABLE [dbo].[amPaymentConcept](
	[idPaymentConcept] [smallint] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT 0,
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



/******************** DISCOUNT ****************************/

CREATE TABLE [dbo].[amDiscount](
	[idDiscount] [int] NOT NULL IDENTITY(1,1),
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](250) NULL,
	[needValidation] [bit] NOT NULL DEFAULT 0,
	[registrationDate] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL DEFAULT 0,
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
	[discountAmount] [decimal](4,2) NULL,
	[discountRate] [decimal](4,2) NULL,
	[startDate] [datetime] NOT NULL,
	[finalDate] [datetime] NULL,
	[isRate] [bit] NOT NULL DEFAULT 0,
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




/********************************************************************************************************/
/***********************************   MODULO : GESTION EDUCATIVA   *************************************/
/********************************************************************************************************/


/******************** SCHOOL YEAR ****************************/

CREATE TABLE [dbo].[emSchoolYear](
	[idSchoolYear] [bigint] NOT NULL IDENTITY(1,1),
	[idAcademicLevel] [smallint] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[year] int NOT NULL,
	[dueDay] [smallint] NOT NULL,
	[newStudent] [int] NOT NULL,
	[classStartDate] [date] NOT NULL,
 CONSTRAINT [PK_SchoolYear] PRIMARY KEY CLUSTERED 
(
	[idSchoolYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[emSchoolYear]  WITH CHECK ADD  CONSTRAINT [FK_SchoolYear_AcademicLevel] FOREIGN KEY([idAcademicLevel])
REFERENCES [dbo].[epAcademicLevel] ([idAcademicLevel])
GO

ALTER TABLE [dbo].[emSchoolYear] CHECK CONSTRAINT [FK_SchoolYear_AcademicLevel]
GO


/******************** SCHOOL YEAR LEVEL ****************************/

CREATE TABLE [dbo].[emSchoolYearLevel](
	[idSchoolYearLevel] [bigint] NOT NULL IDENTITY(1,1),
	[idSchoolYear] [bigint] NOT NULL,
	[idSchoolLevel] [smallint] NOT NULL,
	[vacancyAmount] int NOT NULL,
	[totalStudentEnrolledAmount] int NOT NULL DEFAULT 0,
	[newStudentEnrolledAmount] [int] NOT NULL DEFAULT 0,
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


/******************** ENROLLMENT ****************************/

CREATE TABLE [dbo].[emEnrollment](
	[idEnrollment] [bigint] NOT NULL IDENTITY(1,1),
	[idEmployee] [bigint] NOT NULL,
	[idStudent] [char](8) NOT NULL,
	[idDiscountVersion] [int] NULL,
	[enrollmentDate] [datetime] NOT NULL,
	[startDate] [datetime] NOT NULL,
	[admissionDate] [datetime] NOT NULL,
	[description] [nvarchar](250) NULL,
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





/********************************************************************************************************/
/*************************************   MODULO : CONTABILIDAD   ****************************************/
/********************************************************************************************************/

/******************** SCHOOL YEAR PAYMENT ****************************/

CREATE TABLE [dbo].[amSchoolYearPayment](
	[idSchoolYearPayment] [bigint] NOT NULL IDENTITY(1,1),
	[idSchoolYearLevel] [bigint] NOT NULL,
	[idPaymentConcept] [smallint] NOT NULL,
	[amount] [decimal](4,2) NOT NULL,
	[quantity] [smallint] NOT NULL,
 CONSTRAINT [PK_SchoolYearPayment] PRIMARY KEY CLUSTERED 
(
	[idSchoolYearPayment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amSchoolYearPayment]  WITH CHECK ADD  CONSTRAINT [FK_SchoolYearPayment_SchoolYearLevel] FOREIGN KEY([idSchoolYearLevel])
REFERENCES [dbo].[emSchoolYearLevel] ([idSchoolYearLevel])
GO

ALTER TABLE [dbo].[amSchoolYearPayment] CHECK CONSTRAINT [FK_SchoolYearPayment_SchoolYearLevel]
GO

ALTER TABLE [dbo].[amSchoolYearPayment]  WITH CHECK ADD  CONSTRAINT [FK_SchoolYearPayment_PaymentConcept] FOREIGN KEY([idPaymentConcept])
REFERENCES [dbo].[amPaymentConcept] ([idPaymentConcept])
GO

ALTER TABLE [dbo].[amSchoolYearPayment] CHECK CONSTRAINT [FK_SchoolYearPayment_PaymentConcept]
GO


/******************** STUDENT INSTALLMENT ****************************/

CREATE TABLE [dbo].[amStudentInstallment](
	[idStudentInstallment] [bigint] NOT NULL IDENTITY(1,1),
	[idEnrollment] [bigint] NOT NULL,
	[idSchoolYearPayment] [bigint] NOT NULL,
	[idPaymentStatus] [smallint] NOT NULL,
	[idDiscountVersion] [int] NULL,
	[amountSubTotal] [decimal](4,2) NOT NULL,
	[amountDiscount] [decimal](4,2) NOT NULL,
	[amountTotal] [decimal](4,2) NOT NULL,
	[amountPaid] [decimal](4,2) NOT NULL,
	[amountRemainder] [decimal](4,2) NOT NULL,
	[totalPaymentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_StudentInstallment] PRIMARY KEY CLUSTERED 
(
	[idStudentInstallment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amStudentInstallment]  WITH CHECK ADD  CONSTRAINT [FK_StudentInstallment_Enrollment] FOREIGN KEY([idEnrollment])
REFERENCES [dbo].[emEnrollment] ([idEnrollment])
GO

ALTER TABLE [dbo].[amStudentInstallment] CHECK CONSTRAINT [FK_StudentInstallment_Enrollment]
GO

ALTER TABLE [dbo].[amStudentInstallment]  WITH CHECK ADD  CONSTRAINT [FK_StudentInstallment_SchoolYearPayment] FOREIGN KEY([idSchoolYearPayment])
REFERENCES [dbo].[amSchoolYearPayment] ([idSchoolYearPayment])
GO

ALTER TABLE [dbo].[amStudentInstallment] CHECK CONSTRAINT [FK_StudentInstallment_SchoolYearPayment]
GO

ALTER TABLE [dbo].[amStudentInstallment]  WITH CHECK ADD  CONSTRAINT [FK_StudentInstallment_PaymentStatus] FOREIGN KEY([idPaymentStatus])
REFERENCES [dbo].[amPaymentStatus] ([idPaymentStatus])
GO

ALTER TABLE [dbo].[amStudentInstallment] CHECK CONSTRAINT [FK_StudentInstallment_PaymentStatus]
GO

ALTER TABLE [dbo].[amStudentInstallment]  WITH CHECK ADD  CONSTRAINT [FK_StudentInstallment_DiscountVersion] FOREIGN KEY([idDiscountVersion])
REFERENCES [dbo].[amDiscountVersion] ([idDiscountVersion])
GO

ALTER TABLE [dbo].[amStudentInstallment] CHECK CONSTRAINT [FK_StudentInstallment_DiscountVersion]
GO


/******************** PAYMENT RECEIPT ****************************/

CREATE TABLE [dbo].[amPaymentReceipt](
	[idPaymentReceipt] [bigint] NOT NULL IDENTITY(1,1),
	[idEmployee] [bigint] NOT NULL,
	[idCampus] [int] NOT NULL,
	[serieNumber] [varchar](5) NOT NULL,
	[receiptNumber] [varchar](10) NOT NULL,
	[totalAmount] [decimal](4,2) NOT NULL,
	[comment] [nvarchar](250) NULL,
	[paymentDate] [datetime] NOT NULL,
	[registrationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PaymentReceipt] PRIMARY KEY CLUSTERED 
(
	[idPaymentReceipt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amPaymentReceipt]  WITH CHECK ADD  CONSTRAINT [FK_PaymentReceipt_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[amPaymentReceipt] CHECK CONSTRAINT [FK_PaymentReceipt_Employee]
GO

ALTER TABLE [dbo].[amPaymentReceipt]  WITH CHECK ADD  CONSTRAINT [FK_PaymentReceipt_Campus] FOREIGN KEY([idCampus])
REFERENCES [dbo].[inCampus] ([idCampus])
GO

ALTER TABLE [dbo].[amPaymentReceipt] CHECK CONSTRAINT [FK_PaymentReceipt_Campus]
GO


/******************** PAYMENT RECEIPT DETAIL ****************************/

CREATE TABLE [dbo].[amPaymentReceiptDetail](
	[idPaymentReceiptDetail] [bigint] NOT NULL IDENTITY(1,1),
	[idPaymentReceipt] [bigint] NOT NULL,
	[idStudentInstallment] [bigint] NOT NULL,
	[totalAmount] [decimal](4,2) NOT NULL,
	[description] [nvarchar](250) NULL,
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

ALTER TABLE [dbo].[amPaymentReceiptDetail]  WITH CHECK ADD  CONSTRAINT [FK_PaymentReceiptDetail_StudentInstallment] FOREIGN KEY([idStudentInstallment])
REFERENCES [dbo].[amStudentInstallment] ([idStudentInstallment])
GO

ALTER TABLE [dbo].[amPaymentReceiptDetail] CHECK CONSTRAINT [FK_PaymentReceiptDetail_StudentInstallment]
GO


/******************** PAYMENT TRANSACTION ****************************/

CREATE TABLE [dbo].[amPaymentTransaction](
	[idPaymentTransaction] [bigint] NOT NULL IDENTITY(1,1),
	[idPaymentMethod] [smallint] NOT NULL,
	[idEmployee] [bigint] NOT NULL,
	[numberTransaction] [varchar](15) NOT NULL,
	[totalAmount] [decimal](4,2) NOT NULL,
	[paymentDate] [datetime] NOT NULL,
	[registrationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PaymentTransaction] PRIMARY KEY CLUSTERED 
(
	[idPaymentTransaction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amPaymentTransaction]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransaction_PaymentMethod] FOREIGN KEY([idPaymentMethod])
REFERENCES [dbo].[amPaymentMethod] ([idPaymentMethod])
GO

ALTER TABLE [dbo].[amPaymentTransaction] CHECK CONSTRAINT [FK_PaymentTransaction_PaymentMethod]
GO

ALTER TABLE [dbo].[amPaymentTransaction]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransaction_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[amPaymentTransaction] CHECK CONSTRAINT [FK_PaymentTransaction_Employee]
GO


/******************** PAYMENT TRANSACTION DETAIL ****************************/

CREATE TABLE [dbo].[amPaymentTransactionDetail](
	[idPaymentTransactionDetail] [bigint] NOT NULL IDENTITY(1,1),
	[idPaymentTransaction] [bigint] NOT NULL,
	[idPaymentReceiptDetail] [bigint] NOT NULL,
	[totalAmount] [decimal](4,2) NOT NULL,
 CONSTRAINT [PK_PaymentTransactionDetail] PRIMARY KEY CLUSTERED 
(
	[idPaymentTransaction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amPaymentTransactionDetail]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactionDetail_PaymentTransaction] FOREIGN KEY([idPaymentTransaction])
REFERENCES [dbo].[amPaymentTransaction] ([idPaymentTransaction])
GO

ALTER TABLE [dbo].[amPaymentTransactionDetail] CHECK CONSTRAINT [FK_PaymentTransactionDetail_PaymentTransaction]
GO

ALTER TABLE [dbo].[amPaymentTransactionDetail]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactionDetail_PaymentReceiptDetail] FOREIGN KEY([idPaymentReceiptDetail])
REFERENCES [dbo].[amPaymentReceiptDetail] ([idPaymentReceiptDetail])
GO

ALTER TABLE [dbo].[amPaymentTransactionDetail] CHECK CONSTRAINT [FK_PaymentTransactionDetail_PaymentReceiptDetail]
GO


/******************** BINNACLE PAYMENT ****************************/

CREATE TABLE [dbo].[amBinnaclePayment](
	[idBinnaclePayment] [bigint] NOT NULL IDENTITY(1,1),
	[idEnrollment] [bigint] NOT NULL,
	[idEmployee] [bigint] NOT NULL,
	[registrationDate] [datetime] NOT NULL,
	[description] [text] NOT NULL,
 CONSTRAINT [PK_BinnaclePayment] PRIMARY KEY CLUSTERED 
(
	[idBinnaclePayment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[amBinnaclePayment]  WITH CHECK ADD  CONSTRAINT [FK_BinnaclePayment_Enrollment] FOREIGN KEY([idEnrollment])
REFERENCES [dbo].[emEnrollment] ([idEnrollment])
GO

ALTER TABLE [dbo].[amBinnaclePayment] CHECK CONSTRAINT [FK_BinnaclePayment_Enrollment]
GO

ALTER TABLE [dbo].[amBinnaclePayment]  WITH CHECK ADD  CONSTRAINT [FK_BinnaclePayment_Employee] FOREIGN KEY([idEmployee])
REFERENCES [dbo].[hrEmployee] ([idEmployee])
GO

ALTER TABLE [dbo].[amBinnaclePayment] CHECK CONSTRAINT [FK_BinnaclePayment_Employee]
GO






