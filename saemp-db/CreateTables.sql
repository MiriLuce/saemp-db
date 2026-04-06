USE [master]
GO

CREATE DATABASE [DBMpams]
GO

USE [DBMpams]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

BEGIN TRY

    BEGIN TRANSACTION

    IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'dbo')
        EXEC('CREATE SCHEMA [dbo]')


    /************************************************************************************************************************
     * PREFIX  : PM
     * MODULE  : Person Management
     * DESC    : Manages person identity and contact data. Includes geographic reference tables (country, department,
     *           province, district) used for address resolution throughout the system.
     * TABLES  : pmCountry, pmDepartment, pmProvince, pmDistrict, pmTypeDocumentIdentity,
     *           pmPerson, pmPhoneType, pmPhone
     ************************************************************************************************************************/


    /************* COUNTRY *************/

    CREATE TABLE [dbo].[pmCountry]
    (
        [idCountry]     [int]          NOT NULL IDENTITY(1,1),
        [name]          [nvarchar](50) NOT NULL,
        [letterCode]    [nchar](3)     NOT NULL,
        [numericCode]   [nchar](3)     NOT NULL,
        [isDefault]     [bit]          NOT NULL DEFAULT 0,
        [isActive]      [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([idCountry] ASC)
    )


    /************* DEPARTMENT *************/

    CREATE TABLE [dbo].[pmDepartment]
    (
        [idDepartment]  [int]          NOT NULL,
        [name]          [nvarchar](50) NOT NULL,
        [code]          [char](2)      NOT NULL,
        [isDefault]     [bit]          NOT NULL DEFAULT 0,
        [isActive]      [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([idDepartment] ASC)
    )


    /************* PROVINCE *************/

    CREATE TABLE [dbo].[pmProvince]
    (
        [idDepartment]  [int]          NOT NULL,
        [idProvince]    [int]          NOT NULL,
        [name]          [nvarchar](50) NOT NULL,
        [code]          [char](4)      NOT NULL,
        [isDefault]     [bit]          NOT NULL DEFAULT 0,
        [isActive]      [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED ([idDepartment] ASC, [idProvince] ASC)
    )

    ALTER TABLE [dbo].[pmProvince] WITH CHECK ADD CONSTRAINT [FK_Province_Department]
        FOREIGN KEY([idDepartment]) REFERENCES [dbo].[pmDepartment] ([idDepartment])

    ALTER TABLE [dbo].[pmProvince] CHECK CONSTRAINT [FK_Province_Department]


    /************* DISTRICT *************/

    CREATE TABLE [dbo].[pmDistrict]
    (
        [idDepartment]  [int]          NOT NULL,
        [idProvince]    [int]          NOT NULL,
        [idDistrict]    [int]          NOT NULL,
        [name]          [nvarchar](50) NOT NULL,
        [ubigeo]        [char](6)      NOT NULL UNIQUE,
        [isDefault]     [bit]          NOT NULL DEFAULT 0,
        [isActive]      [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED ([idDepartment] ASC, [idProvince] ASC, [idDistrict] ASC)
    )

    ALTER TABLE [dbo].[pmDistrict] WITH CHECK ADD CONSTRAINT [FK_District_Department_Province]
        FOREIGN KEY([idDepartment], [idProvince]) REFERENCES [dbo].[pmProvince] ([idDepartment], [idProvince])

    ALTER TABLE [dbo].[pmDistrict] CHECK CONSTRAINT [FK_District_Department_Province]


    /************* TYPE DOCUMENT IDENTITY *************/

    CREATE TABLE [dbo].[pmTypeDocumentIdentity]
    (
        [idTypeDocumentIdentity]    [int]           NOT NULL IDENTITY(1,1),
        [name]                      [nvarchar](50)  NOT NULL,
        [abbreviation]              [nvarchar](15)  NOT NULL,
        [length]                    [smallint]      NOT NULL,
        [lengthType]                [char](1)       NULL, -- E: exact, M: maximum
        [characterType]             [char](1)       NULL, -- A: alphanumeric, N: numeric
        [nationalityType]           [char](1)       NULL, -- N: national, E: foreign, A: both
        [isDefault]                 [bit]           NOT NULL DEFAULT 0,
        [isActive]                  [bit]           NOT NULL DEFAULT 1,
        CONSTRAINT [PK_TypeDocumentIdentity] PRIMARY KEY CLUSTERED ([idTypeDocumentIdentity] ASC)
    )


    /************* PERSON *************/

    CREATE TABLE [dbo].[pmPerson]
    (
        [idPerson]                  [bigint]        NOT NULL IDENTITY(1,1),
        [idTypeDocumentIdentity]    [int]           NOT NULL,
        [documentIdentity]          [nvarchar](20)  NOT NULL,
        [firstName]                 [nvarchar](100) NOT NULL,
        [middleName]                [nvarchar](100) NULL,
        [fatherLastName]            [nvarchar](150) NOT NULL,
        [motherLastName]            [nvarchar](150) NULL,
        [gender]                    [char](1)       NULL, -- M: Male, F: Female
        [birthDate]                 [date]          NULL,
        [idBirthCountry]            [int]           NOT NULL,
        [registrationDate]          [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]          [int]           NOT NULL DEFAULT 0,
        [modifiedDate]              [datetime]      NULL,
        [modifiedUser]              [int]           NULL,
        CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED ([idPerson] ASC)
    )

    ALTER TABLE [dbo].[pmPerson] WITH CHECK ADD CONSTRAINT [FK_Person_TypeDocumentIdentity]
        FOREIGN KEY([idTypeDocumentIdentity]) REFERENCES [dbo].[pmTypeDocumentIdentity] ([idTypeDocumentIdentity])

    ALTER TABLE [dbo].[pmPerson] CHECK CONSTRAINT [FK_Person_TypeDocumentIdentity]

    ALTER TABLE [dbo].[pmPerson] ADD CONSTRAINT [UQ_Person_DocumentIdentity]
        UNIQUE ([idTypeDocumentIdentity], [documentIdentity])

    ALTER TABLE [dbo].[pmPerson] WITH CHECK ADD CONSTRAINT [FK_Person_Country]
        FOREIGN KEY([idBirthCountry]) REFERENCES [dbo].[pmCountry] ([idCountry])

    ALTER TABLE [dbo].[pmPerson] CHECK CONSTRAINT [FK_Person_Country]


    /************* PHONE TYPE *************/

    CREATE TABLE [dbo].[pmPhoneType]
    (
        [idPhoneType]   [smallint]     NOT NULL IDENTITY(1,1),
        [name]          [nvarchar](25) NOT NULL,
        [isActive]      [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_PhoneType] PRIMARY KEY CLUSTERED ([idPhoneType] ASC)
    )


    /************* PHONE *************/

    CREATE TABLE [dbo].[pmPhone]
    (
        [idPhone]           [bigint]        NOT NULL IDENTITY(1,1),
        [idPerson]          [bigint]        NOT NULL,
        [idPhoneType]       [smallint]      NULL,
        [number]            [nvarchar](25)  NOT NULL,
        [isForEmergency]    [bit]           NOT NULL DEFAULT 0,
        [description]       [nvarchar](200) NULL,
        [isActive]          [bit]           NOT NULL DEFAULT 1,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        [deletedDate]       [datetime]      NULL,
        [deletedUser]       [int]           NULL,
        CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED ([idPhone] ASC)
    )

    ALTER TABLE [dbo].[pmPhone] WITH CHECK ADD CONSTRAINT [FK_Phone_Person]
        FOREIGN KEY([idPerson]) REFERENCES [dbo].[pmPerson] ([idPerson])

    ALTER TABLE [dbo].[pmPhone] CHECK CONSTRAINT [FK_Phone_Person]


    /************************************************************************************************************************
     * PREFIX  : HR
     * MODULE  : Human Resources
     * DESC    : Manages employee records, job titles, and employment contracts.
     * TABLES  : hrJobTitle, hrEmployee, hrEmploymentContract
     ************************************************************************************************************************/


    /************* JOB TITLE *************/

    CREATE TABLE [dbo].[hrJobTitle]
    (
        [idJobTitle]    [int]           NOT NULL IDENTITY(1,1),
        [name]          [nvarchar](50)  NOT NULL,
        [abbreviation]  [nvarchar](10)  NOT NULL,
        [isActive]      [bit]           NOT NULL DEFAULT 1,
        CONSTRAINT [PK_JobTitle] PRIMARY KEY CLUSTERED ([idJobTitle] ASC)
    )


    /************* EMPLOYEE *************/

    CREATE TABLE [dbo].[hrEmployee]
    (
        [idEmployee]            [bigint]        NOT NULL,
        [email]                 [nvarchar](150) NULL,
        [idResidentDepartment]  [int]           NULL,
        [idResidentProvince]    [int]           NULL,
        [idResidentDistrict]    [int]           NULL,
        [address]               [nvarchar](200) NULL,
        [addressReference]      [nvarchar](200) NULL,
        [isActive]              [bit]           NOT NULL DEFAULT 1,
        [registrationDate]      [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]      [int]           NOT NULL DEFAULT 0,
        [modifiedDate]          [datetime]      NULL,
        [modifiedUser]          [int]           NULL,
        [deletedDate]           [datetime]      NULL,
        [deletedUser]           [int]           NULL,
        CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([idEmployee] ASC)
    )

    ALTER TABLE [dbo].[hrEmployee] WITH CHECK ADD CONSTRAINT [FK_Employee_Person]
        FOREIGN KEY([idEmployee]) REFERENCES [dbo].[pmPerson] ([idPerson])

    ALTER TABLE [dbo].[hrEmployee] CHECK CONSTRAINT [FK_Employee_Person]

    ALTER TABLE [dbo].[hrEmployee] WITH CHECK ADD CONSTRAINT [FK_Employee_Department_Province_District]
        FOREIGN KEY([idResidentDepartment],[idResidentProvince],[idResidentDistrict])
        REFERENCES [dbo].[pmDistrict] ([idDepartment],[idProvince],[idDistrict])

    ALTER TABLE [dbo].[hrEmployee] CHECK CONSTRAINT [FK_Employee_Department_Province_District]


    /************* EMPLOYMENT CONTRACT *************/

    CREATE TABLE [dbo].[hrEmploymentContract]
    (
        [idEmploymentContract]  [bigint]        NOT NULL IDENTITY(1,1),
        [idEmployee]            [bigint]        NOT NULL,
        [idJobTitle]            [int]           NOT NULL,
        [salary]                [decimal](12,2) NULL,
        [isPerHour]             [bit]           NOT NULL DEFAULT 0,
        [admissionDate]         [datetime]      NOT NULL,
        [cessationDate]         [datetime]      NULL,
        [registrationDate]      [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]      [int]           NOT NULL DEFAULT 0,
        [modifiedDate]          [datetime]      NULL,
        [modifiedUser]          [int]           NULL,
        CONSTRAINT [PK_EmploymentContract] PRIMARY KEY CLUSTERED ([idEmploymentContract] ASC)
    )

    ALTER TABLE [dbo].[hrEmploymentContract] WITH CHECK ADD CONSTRAINT [FK_EmploymentContract_Employee]
        FOREIGN KEY([idEmployee]) REFERENCES [dbo].[hrEmployee] ([idEmployee])

    ALTER TABLE [dbo].[hrEmploymentContract] CHECK CONSTRAINT [FK_EmploymentContract_Employee]

    ALTER TABLE [dbo].[hrEmploymentContract] WITH CHECK ADD CONSTRAINT [FK_EmploymentContract_JobTitle]
        FOREIGN KEY([idJobTitle]) REFERENCES [dbo].[hrJobTitle] ([idJobTitle])

    ALTER TABLE [dbo].[hrEmploymentContract] CHECK CONSTRAINT [FK_EmploymentContract_JobTitle]


    /************************************************************************************************************************
     * PREFIX  : IN
     * MODULE  : Institution
     * DESC    : Manages the physical structure of the institution, including campuses and rooms.
     *           Defined before Finance because fnPaymentAccount references inCampus.
     * TABLES  : inInstitution, inCampus, inRoom
     ************************************************************************************************************************/


    /************* INSTITUTION *************/

    CREATE TABLE [dbo].[inInstitution]
    (
        [idInstitution] [int]           NOT NULL IDENTITY(1,1),
        [name]          [nvarchar](50)  NOT NULL,
        [abbreviation]  [nvarchar](15)  NOT NULL,
        [isActive]      [bit]           NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Institution] PRIMARY KEY CLUSTERED ([idInstitution] ASC)
    )


    /************* CAMPUS *************/

    CREATE TABLE [dbo].[inCampus]
    (
        [idCampus]      [int]           NOT NULL IDENTITY(1,1),
        [idInstitution] [int]           NOT NULL,
        [name]          [nvarchar](50)  NOT NULL,
        [abbreviation]  [nvarchar](15)  NOT NULL,
        [isActive]      [bit]           NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Campus] PRIMARY KEY CLUSTERED ([idCampus] ASC)
    )

    ALTER TABLE [dbo].[inCampus] WITH CHECK ADD CONSTRAINT [FK_Campus_Institution]
        FOREIGN KEY([idInstitution]) REFERENCES [dbo].[inInstitution] ([idInstitution])

    ALTER TABLE [dbo].[inCampus] CHECK CONSTRAINT [FK_Campus_Institution]


    /************* ROOM *************/

    CREATE TABLE [dbo].[inRoom]
    (
        [idRoom]            [int]           NOT NULL IDENTITY(1,1),
        [idCampus]          [int]           NOT NULL,
        [name]              [nvarchar](50)  NOT NULL,
        [capacity]          [int]           NOT NULL,
        [isActive]          [bit]           NOT NULL DEFAULT 1,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED ([idRoom] ASC)
    )

    ALTER TABLE [dbo].[inRoom] WITH CHECK ADD CONSTRAINT [FK_Room_Campus]
        FOREIGN KEY([idCampus]) REFERENCES [dbo].[inCampus] ([idCampus])

    ALTER TABLE [dbo].[inRoom] CHECK CONSTRAINT [FK_Room_Campus]


    /************************************************************************************************************************
     * PREFIX  : FN
     * MODULE  : Finance
     * DESC    : Manages payment concepts, methods, and accounts; tracks discounts, expenses, payment receipts,
     *           and daily/monthly balance summaries.
     *           Defined before Enrollment Management because EM tables reference fnPaymentConcept,
     *           fnPaymentStatus, and fnDiscountVersion.
     * TABLES  : fnPaymentConcept, fnPaymentStatus, fnPaymentMethod, fnPaymentAccount, fnDiscount,
     *           fnDiscountVersion, fnExpenseConcept, fnExpense, fnPaymentReceipt, fnPaymentReceiptDetail,
     *           fnDailyBalance, fnMonthlyBalance
     * NOTE    : FK_PaymentReceiptDetail_StudentFeeInstallment is deferred to the end of the script
     *           because fnPaymentReceiptDetail references emStudentFeeInstallment (EM → FN cycle).
     ************************************************************************************************************************/


    /************* PAYMENT CONCEPT *************/

    CREATE TABLE [dbo].[fnPaymentConcept]
    (
        [idPaymentConcept]  [smallint]     NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](50) NOT NULL,
        [isActive]          [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_PaymentConcept] PRIMARY KEY CLUSTERED ([idPaymentConcept] ASC)
    )


    /************* PAYMENT STATUS *************/

    CREATE TABLE [dbo].[fnPaymentStatus]
    (
        [idPaymentStatus]   [smallint]     NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](50) NOT NULL,
        [abbreviation]      [nchar](10)    NOT NULL,
        [isActive]          [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_PaymentStatus] PRIMARY KEY CLUSTERED ([idPaymentStatus] ASC)
    )


    /************* PAYMENT METHOD *************/

    CREATE TABLE [dbo].[fnPaymentMethod]
    (
        [idPaymentMethod]   [smallint]     NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](50) NOT NULL,
        [abbreviation]      [nchar](10)    NOT NULL,
        [isActive]          [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_PaymentMethod] PRIMARY KEY CLUSTERED ([idPaymentMethod] ASC)
    )


    /************* PAYMENT ACCOUNT *************/

    CREATE TABLE [dbo].[fnPaymentAccount]
    (
        [idPaymentAccount]  [int]           NOT NULL IDENTITY(1,1),
        [idPaymentMethod]   [smallint]      NOT NULL,
        [idCampus]          [int]           NULL, -- NULL for online/bank accounts, NOT NULL for cash registers
        [name]              [nvarchar](100) NOT NULL,
        [accountNumber]     [nvarchar](50)  NULL, -- for bank accounts
        [alias]             [nvarchar](100) NULL, -- phone number or alias for Yape, Plin
        [isActive]          [bit]           NOT NULL DEFAULT 1,
        CONSTRAINT [PK_PaymentAccount] PRIMARY KEY CLUSTERED ([idPaymentAccount] ASC)
    )

    ALTER TABLE [dbo].[fnPaymentAccount] WITH CHECK ADD CONSTRAINT [FK_PaymentAccount_PaymentMethod]
        FOREIGN KEY([idPaymentMethod]) REFERENCES [dbo].[fnPaymentMethod] ([idPaymentMethod])

    ALTER TABLE [dbo].[fnPaymentAccount] CHECK CONSTRAINT [FK_PaymentAccount_PaymentMethod]

    ALTER TABLE [dbo].[fnPaymentAccount] WITH CHECK ADD CONSTRAINT [FK_PaymentAccount_Campus]
        FOREIGN KEY([idCampus]) REFERENCES [dbo].[inCampus] ([idCampus])

    ALTER TABLE [dbo].[fnPaymentAccount] CHECK CONSTRAINT [FK_PaymentAccount_Campus]


    /************* DISCOUNT *************/

    CREATE TABLE [dbo].[fnDiscount]
    (
        [idDiscount]    [int]           NOT NULL IDENTITY(1,1),
        [name]          [nvarchar](50)  NOT NULL,
        [description]   [nvarchar](250) NULL,
        [isActive]      [bit]           NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED ([idDiscount] ASC)
    )


    /************* DISCOUNT VERSION *************/

    CREATE TABLE [dbo].[fnDiscountVersion]
    (
        [idDiscountVersion] [int]           NOT NULL IDENTITY(1,1),
        [idDiscount]        [int]           NOT NULL,
        [name]              [nvarchar](50)  NOT NULL,
        [discountAmount]    [decimal](12,2) NULL,
        [discountRate]      [decimal](12,2) NULL,
        [startDate]         [datetime]      NOT NULL,
        [endDate]           [datetime]      NULL,
        [isRate]            [bit]           NOT NULL DEFAULT 0,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        CONSTRAINT [PK_DiscountVersion] PRIMARY KEY CLUSTERED ([idDiscountVersion] ASC)
    )

    ALTER TABLE [dbo].[fnDiscountVersion] WITH CHECK ADD CONSTRAINT [FK_DiscountVersion_Discount]
        FOREIGN KEY([idDiscount]) REFERENCES [dbo].[fnDiscount] ([idDiscount])

    ALTER TABLE [dbo].[fnDiscountVersion] CHECK CONSTRAINT [FK_DiscountVersion_Discount]

    ALTER TABLE [dbo].[fnDiscountVersion] ADD CONSTRAINT [CK_DiscountVersion_AmountOrRate]
        CHECK (
            (isRate = 1 AND discountRate IS NOT NULL AND discountRate >= 0 AND discountRate <= 100 AND discountAmount IS NULL)
            OR
            (isRate = 0 AND discountAmount IS NOT NULL AND discountAmount >= 0 AND discountRate IS NULL)
        )


    /************* EXPENSE CONCEPT *************/

    CREATE TABLE [dbo].[fnExpenseConcept]
    (
        [idExpenseConcept]  [smallint]     NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](50) NOT NULL,
        [isActive]          [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_ExpenseConcept] PRIMARY KEY CLUSTERED ([idExpenseConcept] ASC)
    )


    /************* EXPENSE *************/

    CREATE TABLE [dbo].[fnExpense]
    (
        [idExpense]         [bigint]        NOT NULL IDENTITY(1,1),
        [idPaymentAccount]  [int]           NOT NULL,
        [idExpenseConcept]  [smallint]      NOT NULL,
        [amount]            [decimal](12,2) NOT NULL,
        [description]       [nvarchar](250) NULL,
        [expenseDate]       [date]          NOT NULL,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        [deletedDate]       [datetime]      NULL,
        [deletedUser]       [int]           NULL,
        CONSTRAINT [PK_Expense] PRIMARY KEY CLUSTERED ([idExpense] ASC)
    )

    ALTER TABLE [dbo].[fnExpense] WITH CHECK ADD CONSTRAINT [FK_Expense_PaymentAccount]
        FOREIGN KEY([idPaymentAccount]) REFERENCES [dbo].[fnPaymentAccount] ([idPaymentAccount])

    ALTER TABLE [dbo].[fnExpense] CHECK CONSTRAINT [FK_Expense_PaymentAccount]

    ALTER TABLE [dbo].[fnExpense] WITH CHECK ADD CONSTRAINT [FK_Expense_ExpenseConcept]
        FOREIGN KEY([idExpenseConcept]) REFERENCES [dbo].[fnExpenseConcept] ([idExpenseConcept])

    ALTER TABLE [dbo].[fnExpense] CHECK CONSTRAINT [FK_Expense_ExpenseConcept]


    /************* PAYMENT RECEIPT *************/

    CREATE TABLE [dbo].[fnPaymentReceipt]
    (
        [idPaymentReceipt]      [bigint]        NOT NULL IDENTITY(1,1),
        [idEmployee]            [bigint]        NULL, -- cashier who processed the payment
        [idPaymentAccount]      [int]           NOT NULL,
        [operationNumber]       [nvarchar](100) NULL, -- operation number for Yape, Plin, bank transfers
        [totalAmount]           [decimal](12,2) NOT NULL,
        [paymentDate]           [datetime]      NOT NULL,
        [receiptType]           [char](1)       NOT NULL DEFAULT 'B', -- B: boleta, F: factura
        [seriesNumber]          [varchar](5)    NOT NULL,
        [receiptNumber]         [varchar](10)   NOT NULL,
        [payerName]             [nvarchar](200) NULL,
        [idPayerTypeDocument]   [int]           NULL,
        [payerDocument]         [nvarchar](20)  NULL, -- DNI/RUC for electronic receipts
        [comment]               [nvarchar](250) NULL,
        [registrationDate]      [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]      [int]           NOT NULL DEFAULT 0,
        [modifiedDate]          [datetime]      NULL,
        [modifiedUser]          [int]           NULL,
        CONSTRAINT [PK_PaymentReceipt] PRIMARY KEY CLUSTERED ([idPaymentReceipt] ASC)
    )

    ALTER TABLE [dbo].[fnPaymentReceipt] ADD CONSTRAINT [UQ_PaymentReceipt_Series]
        UNIQUE ([idPaymentAccount], [seriesNumber], [receiptNumber])

    ALTER TABLE [dbo].[fnPaymentReceipt] WITH CHECK ADD CONSTRAINT [FK_PaymentReceipt_Employee]
        FOREIGN KEY([idEmployee]) REFERENCES [dbo].[hrEmployee] ([idEmployee])

    ALTER TABLE [dbo].[fnPaymentReceipt] CHECK CONSTRAINT [FK_PaymentReceipt_Employee]

    ALTER TABLE [dbo].[fnPaymentReceipt] WITH CHECK ADD CONSTRAINT [FK_PaymentReceipt_PaymentAccount]
        FOREIGN KEY([idPaymentAccount]) REFERENCES [dbo].[fnPaymentAccount] ([idPaymentAccount])

    ALTER TABLE [dbo].[fnPaymentReceipt] CHECK CONSTRAINT [FK_PaymentReceipt_PaymentAccount]

    ALTER TABLE [dbo].[fnPaymentReceipt] WITH CHECK ADD CONSTRAINT [FK_PaymentReceipt_PayerTypeDocument]
        FOREIGN KEY([idPayerTypeDocument]) REFERENCES [dbo].[pmTypeDocumentIdentity] ([idTypeDocumentIdentity])

    ALTER TABLE [dbo].[fnPaymentReceipt] CHECK CONSTRAINT [FK_PaymentReceipt_PayerTypeDocument]


    /************* PAYMENT RECEIPT DETAIL *************/

    CREATE TABLE [dbo].[fnPaymentReceiptDetail]
    (
        [idPaymentReceiptDetail]    [bigint]        NOT NULL IDENTITY(1,1),
        [idPaymentReceipt]          [bigint]        NOT NULL,
        [idStudentFeeInstallment]   [bigint]        NOT NULL,
        [amountPaid]                [decimal](12,2) NOT NULL,
        [description]               [nvarchar](250) NULL,
        [registrationDate]          [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]          [int]           NOT NULL DEFAULT 0,
        CONSTRAINT [PK_PaymentReceiptDetail] PRIMARY KEY CLUSTERED ([idPaymentReceiptDetail] ASC)
    )

    ALTER TABLE [dbo].[fnPaymentReceiptDetail] WITH CHECK ADD CONSTRAINT [FK_PaymentReceiptDetail_PaymentReceipt]
        FOREIGN KEY([idPaymentReceipt]) REFERENCES [dbo].[fnPaymentReceipt] ([idPaymentReceipt])

    ALTER TABLE [dbo].[fnPaymentReceiptDetail] CHECK CONSTRAINT [FK_PaymentReceiptDetail_PaymentReceipt]

    -- FK_PaymentReceiptDetail_StudentFeeInstallment is deferred below (FN → EM cycle)


    /************* DAILY BALANCE *************/

    CREATE TABLE [dbo].[fnDailyBalance]
    (
        [idDailyBalance]    [int]           NOT NULL IDENTITY(1,1),
        [idPaymentAccount]  [int]           NOT NULL,
        [idEmployee]        [bigint]        NOT NULL,
        [balanceDate]       [date]          NOT NULL,
        [openingAmount]     [decimal](12,2) NOT NULL DEFAULT 0,
        [incomeAmount]      [decimal](12,2) NOT NULL DEFAULT 0,
        [expenseAmount]     [decimal](12,2) NOT NULL DEFAULT 0,
        [closingAmount]     AS ([openingAmount] + [incomeAmount] - [expenseAmount]),
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        CONSTRAINT [PK_DailyBalance] PRIMARY KEY CLUSTERED ([idDailyBalance] ASC)
    )

    ALTER TABLE [dbo].[fnDailyBalance] ADD CONSTRAINT [UQ_DailyBalance_AccountDate]
        UNIQUE ([idPaymentAccount], [balanceDate])

    ALTER TABLE [dbo].[fnDailyBalance] WITH CHECK ADD CONSTRAINT [FK_DailyBalance_PaymentAccount]
        FOREIGN KEY([idPaymentAccount]) REFERENCES [dbo].[fnPaymentAccount] ([idPaymentAccount])

    ALTER TABLE [dbo].[fnDailyBalance] CHECK CONSTRAINT [FK_DailyBalance_PaymentAccount]

    ALTER TABLE [dbo].[fnDailyBalance] WITH CHECK ADD CONSTRAINT [FK_DailyBalance_Employee]
        FOREIGN KEY([idEmployee]) REFERENCES [dbo].[hrEmployee] ([idEmployee])

    ALTER TABLE [dbo].[fnDailyBalance] CHECK CONSTRAINT [FK_DailyBalance_Employee]


    /************* MONTHLY BALANCE *************/

    CREATE TABLE [dbo].[fnMonthlyBalance]
    (
        [idMonthlyBalance]  [int]           NOT NULL IDENTITY(1,1),
        [idPaymentAccount]  [int]           NOT NULL,
        [idEmployee]        [bigint]        NOT NULL,
        [year]              [smallint]      NOT NULL,
        [month]             [tinyint]       NOT NULL,
        [openingAmount]     [decimal](12,2) NOT NULL DEFAULT 0,
        [incomeAmount]      [decimal](12,2) NOT NULL DEFAULT 0,
        [expenseAmount]     [decimal](12,2) NOT NULL DEFAULT 0,
        [closingAmount]     AS ([openingAmount] + [incomeAmount] - [expenseAmount]),
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        CONSTRAINT [PK_MonthlyBalance] PRIMARY KEY CLUSTERED ([idMonthlyBalance] ASC)
    )

    ALTER TABLE [dbo].[fnMonthlyBalance] ADD CONSTRAINT [UQ_MonthlyBalance_AccountYearMonth]
        UNIQUE ([idPaymentAccount], [year], [month])

    ALTER TABLE [dbo].[fnMonthlyBalance] WITH CHECK ADD CONSTRAINT [FK_MonthlyBalance_PaymentAccount]
        FOREIGN KEY([idPaymentAccount]) REFERENCES [dbo].[fnPaymentAccount] ([idPaymentAccount])

    ALTER TABLE [dbo].[fnMonthlyBalance] CHECK CONSTRAINT [FK_MonthlyBalance_PaymentAccount]

    ALTER TABLE [dbo].[fnMonthlyBalance] WITH CHECK ADD CONSTRAINT [FK_MonthlyBalance_Employee]
        FOREIGN KEY([idEmployee]) REFERENCES [dbo].[hrEmployee] ([idEmployee])

    ALTER TABLE [dbo].[fnMonthlyBalance] CHECK CONSTRAINT [FK_MonthlyBalance_Employee]


    /************************************************************************************************************************
     * PREFIX  : SM
     * MODULE  : Student Management
     * DESC    : Manages student profiles, family relationships, academic background from prior schools,
     *           and enrollment documentation.
     * TABLES  : smStudent, smRelationship, smRelative, smStudentDocumentType, smStudentDocument,
     *           smScholarStatus, smExternalSchool, smAcademicBackground
     * NOTE    : FK_AcademicBackground_SchoolLevel is deferred to the end of the script
     *           because smAcademicBackground references emSchoolLevel (SM → EM cycle).
     ************************************************************************************************************************/


    /************* STUDENT *************/

    CREATE TABLE [dbo].[smStudent]
    (
        [idStudent]             [char](8)       NOT NULL,
        [idPerson]              [bigint]        NOT NULL,
        [email]                 [nvarchar](150) NULL,
        [idResidentDepartment]  [int]           NULL,
        [idResidentProvince]    [int]           NULL,
        [idResidentDistrict]    [int]           NULL,
        [address]               [nvarchar](200) NULL,
        [addressReference]      [nvarchar](200) NULL,
        [allergies]             [nvarchar](200) NULL,
        [disease]               [nvarchar](250) NULL,
        [otherHealthProblem]    [nvarchar](250) NULL,
        [isActive]              [bit]           NOT NULL DEFAULT 1,
        [registrationDate]      [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]      [int]           NOT NULL DEFAULT 0,
        [modifiedDate]          [datetime]      NULL,
        [modifiedUser]          [int]           NULL,
        CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([idStudent] ASC)
    )

    ALTER TABLE [dbo].[smStudent] WITH CHECK ADD CONSTRAINT [FK_Student_Person]
        FOREIGN KEY([idPerson]) REFERENCES [dbo].[pmPerson] ([idPerson])

    ALTER TABLE [dbo].[smStudent] CHECK CONSTRAINT [FK_Student_Person]

    ALTER TABLE [dbo].[smStudent] WITH CHECK ADD CONSTRAINT [FK_Student_Department_Province_District]
        FOREIGN KEY([idResidentDepartment],[idResidentProvince],[idResidentDistrict])
        REFERENCES [dbo].[pmDistrict] ([idDepartment],[idProvince],[idDistrict])

    ALTER TABLE [dbo].[smStudent] CHECK CONSTRAINT [FK_Student_Department_Province_District]

    ALTER TABLE [dbo].[smStudent] ADD CONSTRAINT [UQ_Student_Person] UNIQUE ([idPerson])


    /************* RELATIONSHIP *************/

    CREATE TABLE [dbo].[smRelationship]
    (
        [idRelationship]    [int]          NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](50) NOT NULL,
        [isDefault]         [bit]          NOT NULL DEFAULT 0,
        [isActive]          [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Relationship] PRIMARY KEY CLUSTERED ([idRelationship] ASC)
    )


    /************* RELATIVE *************/

    CREATE TABLE [dbo].[smRelative]
    (
        [idRelative]            [bigint]        NOT NULL,
        [idStudent]             [char](8)       NOT NULL,
        [idRelationship]        [int]           NOT NULL,
        [liveWithStudent]       [bit]           NOT NULL,
        [isGuardian]            [bit]           NOT NULL DEFAULT 0,
        [email]                 [nvarchar](150) NULL,
        [idResidentDepartment]  [int]           NULL,
        [idResidentProvince]    [int]           NULL,
        [idResidentDistrict]    [int]           NULL,
        [address]               [nvarchar](200) NULL,
        [addressReference]      [nvarchar](200) NULL,
        [isActive]              [bit]           NOT NULL DEFAULT 1,
        [registrationDate]      [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]      [int]           NOT NULL DEFAULT 0,
        [modifiedDate]          [datetime]      NULL,
        [modifiedUser]          [int]           NULL,
        [deletedDate]           [datetime]      NULL,
        [deletedUser]           [int]           NULL,
        CONSTRAINT [PK_Relative] PRIMARY KEY CLUSTERED ([idRelative], [idStudent] ASC)
    )

    ALTER TABLE [dbo].[smRelative] WITH CHECK ADD CONSTRAINT [FK_Relative_Person]
        FOREIGN KEY([idRelative]) REFERENCES [dbo].[pmPerson] ([idPerson])

    ALTER TABLE [dbo].[smRelative] CHECK CONSTRAINT [FK_Relative_Person]

    ALTER TABLE [dbo].[smRelative] WITH CHECK ADD CONSTRAINT [FK_Relative_Student]
        FOREIGN KEY([idStudent]) REFERENCES [dbo].[smStudent] ([idStudent])

    ALTER TABLE [dbo].[smRelative] CHECK CONSTRAINT [FK_Relative_Student]

    ALTER TABLE [dbo].[smRelative] WITH CHECK ADD CONSTRAINT [FK_Relative_Relationship]
        FOREIGN KEY([idRelationship]) REFERENCES [dbo].[smRelationship] ([idRelationship])

    ALTER TABLE [dbo].[smRelative] CHECK CONSTRAINT [FK_Relative_Relationship]

    ALTER TABLE [dbo].[smRelative] WITH CHECK ADD CONSTRAINT [FK_Relative_Department_Province_District]
        FOREIGN KEY([idResidentDepartment],[idResidentProvince],[idResidentDistrict])
        REFERENCES [dbo].[pmDistrict] ([idDepartment],[idProvince],[idDistrict])

    ALTER TABLE [dbo].[smRelative] CHECK CONSTRAINT [FK_Relative_Department_Province_District]


    /************* STUDENT DOCUMENT TYPE *************/

    CREATE TABLE [dbo].[smStudentDocumentType]
    (
        [idStudentDocumentType] [int]           NOT NULL IDENTITY(1,1),
        [name]                  [nvarchar](50)  NOT NULL,
        [abbreviation]          [nvarchar](15)  NOT NULL,
        [isActive]              [bit]           NOT NULL DEFAULT 1,
        CONSTRAINT [PK_StudentDocumentType] PRIMARY KEY CLUSTERED ([idStudentDocumentType] ASC)
    )


    /************* STUDENT DOCUMENT *************/

    CREATE TABLE [dbo].[smStudentDocument]
    (
        [idStudentDocument]     [bigint]        NOT NULL IDENTITY(1,1),
        [idStudentDocumentType] [int]           NOT NULL,
        [idStudent]             [char](8)       NOT NULL,
        [idCoordinator]         [bigint]        NOT NULL,
        [receptionDate]         [datetime]      NULL,
        [estimatedDate]         [datetime]      NULL,
        [description]           [nvarchar](200) NULL,
        [registrationDate]      [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]      [int]           NOT NULL DEFAULT 0,
        [modifiedDate]          [datetime]      NULL,
        [modifiedUser]          [int]           NULL,
        CONSTRAINT [PK_StudentDocument] PRIMARY KEY CLUSTERED ([idStudentDocument] ASC)
    )

    ALTER TABLE [dbo].[smStudentDocument] WITH CHECK ADD CONSTRAINT [FK_StudentDocument_StudentDocumentType]
        FOREIGN KEY([idStudentDocumentType]) REFERENCES [dbo].[smStudentDocumentType] ([idStudentDocumentType])

    ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_StudentDocumentType]

    ALTER TABLE [dbo].[smStudentDocument] WITH CHECK ADD CONSTRAINT [FK_StudentDocument_Student]
        FOREIGN KEY([idStudent]) REFERENCES [dbo].[smStudent] ([idStudent])

    ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_Student]

    ALTER TABLE [dbo].[smStudentDocument] WITH CHECK ADD CONSTRAINT [FK_StudentDocument_Coordinator]
        FOREIGN KEY([idCoordinator]) REFERENCES [dbo].[hrEmployee] ([idEmployee])

    ALTER TABLE [dbo].[smStudentDocument] CHECK CONSTRAINT [FK_StudentDocument_Coordinator]


    /************* SCHOLAR STATUS *************/

    CREATE TABLE [dbo].[smScholarStatus]
    (
        [idScholarStatus]   [smallint]     NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](50) NOT NULL,
        [abbreviation]      [nvarchar](5)  NOT NULL,
        [isActive]          [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_ScholarStatus] PRIMARY KEY CLUSTERED ([idScholarStatus] ASC)
    )


    /************* EXTERNAL SCHOOL *************/

    CREATE TABLE [dbo].[smExternalSchool]
    (
        [idExternalSchool]  [bigint]        NOT NULL IDENTITY(1,1),
        [idDepartment]      [int]           NULL,
        [idProvince]        [int]           NULL,
        [idDistrict]        [int]           NULL,
        [name]              [nvarchar](200) NOT NULL,
        [description]       [nvarchar](200) NULL,
        [isPrivate]         [bit]           NOT NULL DEFAULT 0,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        [deletedDate]       [datetime]      NULL,
        [deletedUser]       [int]           NULL,
        CONSTRAINT [PK_ExternalSchool] PRIMARY KEY CLUSTERED ([idExternalSchool] ASC)
    )

    ALTER TABLE [dbo].[smExternalSchool] WITH CHECK ADD CONSTRAINT [FK_ExternalSchool_District]
        FOREIGN KEY([idDepartment],[idProvince],[idDistrict])
        REFERENCES [dbo].[pmDistrict] ([idDepartment],[idProvince],[idDistrict])

    ALTER TABLE [dbo].[smExternalSchool] CHECK CONSTRAINT [FK_ExternalSchool_District]


    /************* ACADEMIC BACKGROUND *************/

    CREATE TABLE [dbo].[smAcademicBackground]
    (
        [idAcademicBackground]  [bigint]        NOT NULL IDENTITY(1,1),
        [idExternalSchool]      [bigint]        NOT NULL,
        [idStudent]             [char](8)       NOT NULL,
        [idSchoolLevel]         [smallint]      NOT NULL,
        [idScholarStatus]       [smallint]      NOT NULL,
        [schoolYear]            [smallint]      NOT NULL,
        [observation]           [nvarchar](200) NULL,
        [registrationDate]      [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]      [int]           NOT NULL DEFAULT 0,
        [modifiedDate]          [datetime]      NULL,
        [modifiedUser]          [int]           NULL,
        CONSTRAINT [PK_AcademicBackground] PRIMARY KEY CLUSTERED ([idAcademicBackground] ASC)
    )

    ALTER TABLE [dbo].[smAcademicBackground] WITH CHECK ADD CONSTRAINT [FK_AcademicBackground_SchoolOrigin]
        FOREIGN KEY([idExternalSchool]) REFERENCES [dbo].[smExternalSchool] ([idExternalSchool])

    ALTER TABLE [dbo].[smAcademicBackground] CHECK CONSTRAINT [FK_AcademicBackground_SchoolOrigin]

    ALTER TABLE [dbo].[smAcademicBackground] WITH CHECK ADD CONSTRAINT [FK_AcademicBackground_Student]
        FOREIGN KEY([idStudent]) REFERENCES [dbo].[smStudent] ([idStudent])

    ALTER TABLE [dbo].[smAcademicBackground] CHECK CONSTRAINT [FK_AcademicBackground_Student]

    ALTER TABLE [dbo].[smAcademicBackground] WITH CHECK ADD CONSTRAINT [FK_AcademicBackground_ScholarStatus]
        FOREIGN KEY([idScholarStatus]) REFERENCES [dbo].[smScholarStatus] ([idScholarStatus])

    ALTER TABLE [dbo].[smAcademicBackground] CHECK CONSTRAINT [FK_AcademicBackground_ScholarStatus]

    -- FK_AcademicBackground_SchoolLevel is deferred below (SM → EM cycle)


    /************************************************************************************************************************
     * PREFIX  : EM
     * MODULE  : Enrollment Management
     * DESC    : Defines the academic structure (levels and grades), manages school years, enrollments,
     *           fee schedules, installment tracking, and enrollment-related notes.
     * TABLES  : emAcademicLevel, emSchoolLevel, emSchoolYear, emSchoolYearLevel, emSchoolYearFeeSchedule,
     *           emEnrollment, emStudentFeeInstallment, emStudentNote, emPaymentNote
     ************************************************************************************************************************/


    /************* ACADEMIC LEVEL *************/

    CREATE TABLE [dbo].[emAcademicLevel]
    (
        [idAcademicLevel]   [smallint]     NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](50) NOT NULL,
        [abbreviation]      [nchar](3)     NOT NULL,
        [isActive]          [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_AcademicLevel] PRIMARY KEY CLUSTERED ([idAcademicLevel] ASC)
    )


    /************* SCHOOL LEVEL *************/

    CREATE TABLE [dbo].[emSchoolLevel]
    (
        [idSchoolLevel]     [smallint]     NOT NULL IDENTITY(1,1),
        [idAcademicLevel]   [smallint]     NOT NULL,
        [name]              [nvarchar](50) NOT NULL,
        [abbreviation]      [nvarchar](5)  NOT NULL,
        [isActive]          [bit]          NOT NULL DEFAULT 1,
        CONSTRAINT [PK_SchoolLevel] PRIMARY KEY CLUSTERED ([idSchoolLevel] ASC)
    )

    ALTER TABLE [dbo].[emSchoolLevel] WITH CHECK ADD CONSTRAINT [FK_SchoolLevel_AcademicLevel]
        FOREIGN KEY([idAcademicLevel]) REFERENCES [dbo].[emAcademicLevel] ([idAcademicLevel])

    ALTER TABLE [dbo].[emSchoolLevel] CHECK CONSTRAINT [FK_SchoolLevel_AcademicLevel]


    /************* SCHOOL YEAR *************/

    CREATE TABLE [dbo].[emSchoolYear]
    (
        [idSchoolYear]      [bigint]        NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](100) NOT NULL,
        [year]              [int]           NOT NULL,
        [dueDay]            [smallint]      NOT NULL,
        [classStartDate]    [date]          NOT NULL,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        CONSTRAINT [PK_SchoolYear] PRIMARY KEY CLUSTERED ([idSchoolYear] ASC)
    )


    /************* SCHOOL YEAR LEVEL *************/

    CREATE TABLE [dbo].[emSchoolYearLevel]
    (
        [idSchoolYearLevel]             [bigint]    NOT NULL IDENTITY(1,1),
        [idSchoolYear]                  [bigint]    NOT NULL,
        [idSchoolLevel]                 [smallint]  NOT NULL,
        [vacancyAmount]                 [int]       NOT NULL,
        [totalStudentEnrolledAmount]    [int]       NOT NULL DEFAULT 0,
        [newStudentEnrolledAmount]      [int]       NOT NULL DEFAULT 0,
        [registrationDate]              [datetime]  NOT NULL DEFAULT GETDATE(),
        [registrationUser]              [int]       NOT NULL DEFAULT 0,
        [modifiedDate]                  [datetime]  NULL,
        [modifiedUser]                  [int]       NULL,
        CONSTRAINT [PK_SchoolYearLevel] PRIMARY KEY CLUSTERED ([idSchoolYearLevel] ASC)
    )

    ALTER TABLE [dbo].[emSchoolYearLevel] WITH CHECK ADD CONSTRAINT [FK_SchoolYearLevel_SchoolYear]
        FOREIGN KEY([idSchoolYear]) REFERENCES [dbo].[emSchoolYear] ([idSchoolYear])

    ALTER TABLE [dbo].[emSchoolYearLevel] CHECK CONSTRAINT [FK_SchoolYearLevel_SchoolYear]

    ALTER TABLE [dbo].[emSchoolYearLevel] WITH CHECK ADD CONSTRAINT [FK_SchoolYearLevel_SchoolLevel]
        FOREIGN KEY([idSchoolLevel]) REFERENCES [dbo].[emSchoolLevel] ([idSchoolLevel])

    ALTER TABLE [dbo].[emSchoolYearLevel] CHECK CONSTRAINT [FK_SchoolYearLevel_SchoolLevel]


    /************* SCHOOL YEAR FEE SCHEDULE *************/

    CREATE TABLE [dbo].[emSchoolYearFeeSchedule]
    (
        [idSchoolYearFeeSchedule]   [bigint]        NOT NULL IDENTITY(1,1),
        [idSchoolYearLevel]         [bigint]        NOT NULL,
        [idPaymentConcept]          [smallint]      NOT NULL,
        [amount]                    [decimal](12,2) NOT NULL,
        [installmentCount]          [smallint]      NOT NULL,
        [registrationDate]          [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]          [int]           NOT NULL DEFAULT 0,
        [modifiedDate]              [datetime]      NULL,
        [modifiedUser]              [int]           NULL,
        CONSTRAINT [PK_SchoolYearFeeSchedule] PRIMARY KEY CLUSTERED ([idSchoolYearFeeSchedule] ASC)
    )

    ALTER TABLE [dbo].[emSchoolYearFeeSchedule] WITH CHECK ADD CONSTRAINT [FK_SchoolYearFeeSchedule_SchoolYearLevel]
        FOREIGN KEY([idSchoolYearLevel]) REFERENCES [dbo].[emSchoolYearLevel] ([idSchoolYearLevel])

    ALTER TABLE [dbo].[emSchoolYearFeeSchedule] CHECK CONSTRAINT [FK_SchoolYearFeeSchedule_SchoolYearLevel]

    ALTER TABLE [dbo].[emSchoolYearFeeSchedule] WITH CHECK ADD CONSTRAINT [FK_SchoolYearFeeSchedule_PaymentConcept]
        FOREIGN KEY([idPaymentConcept]) REFERENCES [dbo].[fnPaymentConcept] ([idPaymentConcept])

    ALTER TABLE [dbo].[emSchoolYearFeeSchedule] CHECK CONSTRAINT [FK_SchoolYearFeeSchedule_PaymentConcept]


    /************* ENROLLMENT *************/

    CREATE TABLE [dbo].[emEnrollment]
    (
        [idEnrollment]          [bigint]        NOT NULL IDENTITY(1,1),
        [idStudent]             [char](8)       NOT NULL,
        [idSchoolYearLevel]     [bigint]        NOT NULL,
        [idEmployee]            [bigint]        NULL, -- staff member who processed the enrollment
        [idDiscountVersion]     [int]           NULL,
        [status]                [char](1)       NOT NULL DEFAULT 'A', -- A: Active, W: Withdrawn, C: Cancelled
        [enrollmentDate]        [datetime]      NOT NULL,
        [admissionDate]         [datetime]      NOT NULL,
        [description]           [nvarchar](250) NULL,
        [registrationDate]      [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]      [int]           NOT NULL DEFAULT 0,
        [modifiedDate]          [datetime]      NULL,
        [modifiedUser]          [int]           NULL,
        CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED ([idEnrollment] ASC)
    )

    ALTER TABLE [dbo].[emEnrollment] WITH CHECK ADD CONSTRAINT [FK_Enrollment_Employee]
        FOREIGN KEY([idEmployee]) REFERENCES [dbo].[hrEmployee] ([idEmployee])

    ALTER TABLE [dbo].[emEnrollment] CHECK CONSTRAINT [FK_Enrollment_Employee]

    ALTER TABLE [dbo].[emEnrollment] WITH CHECK ADD CONSTRAINT [FK_Enrollment_Student]
        FOREIGN KEY([idStudent]) REFERENCES [dbo].[smStudent] ([idStudent])

    ALTER TABLE [dbo].[emEnrollment] CHECK CONSTRAINT [FK_Enrollment_Student]

    ALTER TABLE [dbo].[emEnrollment] WITH CHECK ADD CONSTRAINT [FK_Enrollment_DiscountVersion]
        FOREIGN KEY([idDiscountVersion]) REFERENCES [dbo].[fnDiscountVersion] ([idDiscountVersion])

    ALTER TABLE [dbo].[emEnrollment] CHECK CONSTRAINT [FK_Enrollment_DiscountVersion]

    ALTER TABLE [dbo].[emEnrollment] WITH CHECK ADD CONSTRAINT [FK_Enrollment_SchoolYearLevel]
        FOREIGN KEY([idSchoolYearLevel]) REFERENCES [dbo].[emSchoolYearLevel] ([idSchoolYearLevel])

    ALTER TABLE [dbo].[emEnrollment] CHECK CONSTRAINT [FK_Enrollment_SchoolYearLevel]

    ALTER TABLE [dbo].[emEnrollment] ADD CONSTRAINT [UQ_Enrollment_StudentSchoolYearLevel]
        UNIQUE ([idStudent], [idSchoolYearLevel])

    ALTER TABLE [dbo].[emEnrollment] ADD CONSTRAINT [CK_Enrollment_Status]
        CHECK ([status] IN ('A', 'W', 'C'))


    /************* STUDENT FEE INSTALLMENT *************/

    CREATE TABLE [dbo].[emStudentFeeInstallment]
    (
        [idStudentFeeInstallment]   [bigint]        NOT NULL IDENTITY(1,1),
        [idEnrollment]              [bigint]        NOT NULL,
        [idSchoolYearFeeSchedule]   [bigint]        NOT NULL,
        [installmentNumber]         [smallint]      NOT NULL,
        [idPaymentStatus]           [smallint]      NOT NULL,
        [idDiscountVersion]         [int]           NULL,
        [amountSubTotal]            [decimal](12,2) NOT NULL,
        [amountDiscount]            [decimal](12,2) NOT NULL,
        [amountTotal]               [decimal](12,2) NOT NULL,
        [amountPaid]                [decimal](12,2) NOT NULL,
        [amountRemainder]           AS ([amountTotal] - [amountPaid]),
        [dueDate]                   [datetime]      NOT NULL,
        [registrationDate]          [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]          [int]           NOT NULL DEFAULT 0,
        [modifiedDate]              [datetime]      NULL,
        [modifiedUser]              [int]           NULL,
        CONSTRAINT [PK_StudentFeeInstallment] PRIMARY KEY CLUSTERED ([idStudentFeeInstallment] ASC)
    )

    ALTER TABLE [dbo].[emStudentFeeInstallment] WITH CHECK ADD CONSTRAINT [FK_StudentFeeInstallment_Enrollment]
        FOREIGN KEY([idEnrollment]) REFERENCES [dbo].[emEnrollment] ([idEnrollment])

    ALTER TABLE [dbo].[emStudentFeeInstallment] CHECK CONSTRAINT [FK_StudentFeeInstallment_Enrollment]

    ALTER TABLE [dbo].[emStudentFeeInstallment] WITH CHECK ADD CONSTRAINT [FK_StudentFeeInstallment_SchoolYearFeeSchedule]
        FOREIGN KEY([idSchoolYearFeeSchedule]) REFERENCES [dbo].[emSchoolYearFeeSchedule] ([idSchoolYearFeeSchedule])

    ALTER TABLE [dbo].[emStudentFeeInstallment] CHECK CONSTRAINT [FK_StudentFeeInstallment_SchoolYearFeeSchedule]

    ALTER TABLE [dbo].[emStudentFeeInstallment] WITH CHECK ADD CONSTRAINT [FK_StudentFeeInstallment_PaymentStatus]
        FOREIGN KEY([idPaymentStatus]) REFERENCES [dbo].[fnPaymentStatus] ([idPaymentStatus])

    ALTER TABLE [dbo].[emStudentFeeInstallment] CHECK CONSTRAINT [FK_StudentFeeInstallment_PaymentStatus]

    ALTER TABLE [dbo].[emStudentFeeInstallment] WITH CHECK ADD CONSTRAINT [FK_StudentFeeInstallment_DiscountVersion]
        FOREIGN KEY([idDiscountVersion]) REFERENCES [dbo].[fnDiscountVersion] ([idDiscountVersion])

    ALTER TABLE [dbo].[emStudentFeeInstallment] CHECK CONSTRAINT [FK_StudentFeeInstallment_DiscountVersion]


    /************* STUDENT NOTE *************/

    CREATE TABLE [dbo].[emStudentNote]
    (
        [idStudentNote]     [bigint]        NOT NULL IDENTITY(1,1),
        [idEnrollment]      [bigint]        NOT NULL,
        [description]       [nvarchar](MAX) NOT NULL,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        [deletedDate]       [datetime]      NULL,
        [deletedUser]       [int]           NULL,
        CONSTRAINT [PK_StudentNote] PRIMARY KEY CLUSTERED ([idStudentNote] ASC)
    )

    ALTER TABLE [dbo].[emStudentNote] WITH CHECK ADD CONSTRAINT [FK_StudentNote_Enrollment]
        FOREIGN KEY([idEnrollment]) REFERENCES [dbo].[emEnrollment] ([idEnrollment])

    ALTER TABLE [dbo].[emStudentNote] CHECK CONSTRAINT [FK_StudentNote_Enrollment]


    /************* PAYMENT NOTE *************/

    CREATE TABLE [dbo].[emPaymentNote]
    (
        [idPaymentNote]     [bigint]        NOT NULL IDENTITY(1,1),
        [idEnrollment]      [bigint]        NOT NULL,
        [description]       [nvarchar](MAX) NOT NULL,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        [deletedDate]       [datetime]      NULL,
        [deletedUser]       [int]           NULL,
        CONSTRAINT [PK_PaymentNote] PRIMARY KEY CLUSTERED ([idPaymentNote] ASC)
    )

    ALTER TABLE [dbo].[emPaymentNote] WITH CHECK ADD CONSTRAINT [FK_PaymentNote_Enrollment]
        FOREIGN KEY([idEnrollment]) REFERENCES [dbo].[emEnrollment] ([idEnrollment])

    ALTER TABLE [dbo].[emPaymentNote] CHECK CONSTRAINT [FK_PaymentNote_Enrollment]


    /************************************************************************************************************************
     * PREFIX  : SY
     * MODULE  : System
     * DESC    : Manages application users, roles, and permissions for access control across all modules.
     * TABLES  : syRole, syPermission, syRolePermission, syUser, syUserRole
     ************************************************************************************************************************/


    /************* ROLE *************/

    CREATE TABLE [dbo].[syRole]
    (
        [idRole]            [int]           NOT NULL IDENTITY(1,1),
        [name]              [nvarchar](50)  NOT NULL,
        [description]       [nvarchar](200) NULL,
        [isActive]          [bit]           NOT NULL DEFAULT 1,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([idRole] ASC)
    )

    ALTER TABLE [dbo].[syRole] ADD CONSTRAINT [UQ_Role_Name] UNIQUE ([name])


    /************* PERMISSION *************/

    CREATE TABLE [dbo].[syPermission]
    (
        [idPermission]  [int]           NOT NULL IDENTITY(1,1),
        [module]        [char](2)       NOT NULL, -- PM, HR, IN, FN, SM, EM, SY
        [name]          [nvarchar](50)  NOT NULL, -- e.g. STUDENT_VIEW, PAYMENT_PROCESS
        [description]   [nvarchar](200) NULL,
        [isActive]      [bit]           NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED ([idPermission] ASC)
    )

    ALTER TABLE [dbo].[syPermission] ADD CONSTRAINT [UQ_Permission_ModuleName] UNIQUE ([module], [name])


    /************* ROLE PERMISSION *************/

    CREATE TABLE [dbo].[syRolePermission]
    (
        [idRole]            [int]       NOT NULL,
        [idPermission]      [int]       NOT NULL,
        [registrationDate]  [datetime]  NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]       NOT NULL DEFAULT 0,
        CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED ([idRole] ASC, [idPermission] ASC)
    )

    ALTER TABLE [dbo].[syRolePermission] WITH CHECK ADD CONSTRAINT [FK_RolePermission_Role]
        FOREIGN KEY([idRole]) REFERENCES [dbo].[syRole] ([idRole])

    ALTER TABLE [dbo].[syRolePermission] CHECK CONSTRAINT [FK_RolePermission_Role]

    ALTER TABLE [dbo].[syRolePermission] WITH CHECK ADD CONSTRAINT [FK_RolePermission_Permission]
        FOREIGN KEY([idPermission]) REFERENCES [dbo].[syPermission] ([idPermission])

    ALTER TABLE [dbo].[syRolePermission] CHECK CONSTRAINT [FK_RolePermission_Permission]


    /************* USER *************/

    CREATE TABLE [dbo].[syUser]
    (
        [idUser]            [int]           NOT NULL IDENTITY(1,1),
        [idEmployee]        [bigint]        NOT NULL,
        [userName]          [nvarchar](50)  NOT NULL,
        [passwordHash]      [nvarchar](256) NOT NULL, -- store bcrypt/SHA-256 hash, never plain text
        [inactivityTime]    [smallint]      NOT NULL DEFAULT 30,
        [isActive]          [bit]           NOT NULL DEFAULT 1,
        [lastLoginDate]     [datetime]      NULL,
        [registrationDate]  [datetime]      NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]           NOT NULL DEFAULT 0,
        [modifiedDate]      [datetime]      NULL,
        [modifiedUser]      [int]           NULL,
        [deletedDate]       [datetime]      NULL,
        [deletedUser]       [int]           NULL,
        CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([idUser] ASC)
    )

    ALTER TABLE [dbo].[syUser] ADD CONSTRAINT [UQ_User_Employee] UNIQUE ([idEmployee])

    ALTER TABLE [dbo].[syUser] ADD CONSTRAINT [UQ_User_UserName] UNIQUE ([userName])

    ALTER TABLE [dbo].[syUser] WITH CHECK ADD CONSTRAINT [FK_User_Employee]
        FOREIGN KEY([idEmployee]) REFERENCES [dbo].[hrEmployee] ([idEmployee])

    ALTER TABLE [dbo].[syUser] CHECK CONSTRAINT [FK_User_Employee]


    /************* USER ROLE *************/

    CREATE TABLE [dbo].[syUserRole]
    (
        [idUser]            [int]       NOT NULL,
        [idRole]            [int]       NOT NULL,
        [registrationDate]  [datetime]  NOT NULL DEFAULT GETDATE(),
        [registrationUser]  [int]       NOT NULL DEFAULT 0,
        CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED ([idUser] ASC, [idRole] ASC)
    )

    ALTER TABLE [dbo].[syUserRole] WITH CHECK ADD CONSTRAINT [FK_UserRole_User]
        FOREIGN KEY([idUser]) REFERENCES [dbo].[syUser] ([idUser])

    ALTER TABLE [dbo].[syUserRole] CHECK CONSTRAINT [FK_UserRole_User]

    ALTER TABLE [dbo].[syUserRole] WITH CHECK ADD CONSTRAINT [FK_UserRole_Role]
        FOREIGN KEY([idRole]) REFERENCES [dbo].[syRole] ([idRole])

    ALTER TABLE [dbo].[syUserRole] CHECK CONSTRAINT [FK_UserRole_Role]


    /************************************************************************************************************************
     * DEFERRED CONSTRAINTS
     * These foreign keys are added last to resolve circular dependencies between modules:
     *   - SM → EM : smAcademicBackground references emSchoolLevel
     *   - FN → EM : fnPaymentReceiptDetail references emStudentFeeInstallment
     ************************************************************************************************************************/

    ALTER TABLE [dbo].[smAcademicBackground] WITH CHECK ADD CONSTRAINT [FK_AcademicBackground_SchoolLevel]
        FOREIGN KEY([idSchoolLevel]) REFERENCES [dbo].[emSchoolLevel] ([idSchoolLevel])

    ALTER TABLE [dbo].[smAcademicBackground] CHECK CONSTRAINT [FK_AcademicBackground_SchoolLevel]

    ALTER TABLE [dbo].[fnPaymentReceiptDetail] WITH CHECK ADD CONSTRAINT [FK_PaymentReceiptDetail_StudentFeeInstallment]
        FOREIGN KEY([idStudentFeeInstallment]) REFERENCES [dbo].[emStudentFeeInstallment] ([idStudentFeeInstallment])

    ALTER TABLE [dbo].[fnPaymentReceiptDetail] CHECK CONSTRAINT [FK_PaymentReceiptDetail_StudentFeeInstallment]


    /************************************************************************************************************************
     * APPLICATION USER PERMISSIONS
     * Catalog/settings tables are read-only for mpams_app — managed exclusively via seed scripts.
     ************************************************************************************************************************/

    CREATE LOGIN mpams_app WITH PASSWORD = 'Consultant#Temp01!'; -- TODO: change before deploying to production
    CREATE USER mpams_app FOR LOGIN mpams_app;

    -- Read all tables
    GRANT SELECT ON SCHEMA::dbo TO mpams_app;

    -- Write all tables (catalog tables will be restricted below)
    GRANT INSERT, UPDATE ON SCHEMA::dbo TO mpams_app;

    -- Execute all stored procedures
    GRANT EXECUTE ON SCHEMA::dbo TO mpams_app;

    -- No hard deletes — soft delete pattern enforced at DB level
    DENY DELETE ON SCHEMA::dbo TO mpams_app;

    -- Catalog tables: read-only for mpams_app
    DENY INSERT, UPDATE ON [dbo].[pmTypeDocumentIdentity] TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[pmCountry]              TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[pmDepartment]           TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[pmProvince]             TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[pmDistrict]             TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[pmPhoneType]            TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[hrJobTitle]             TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[inInstitution]          TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[inCampus]               TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[inRoom]                 TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[fnPaymentConcept]       TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[fnPaymentStatus]        TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[fnPaymentMethod]        TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[fnExpenseConcept]       TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[fnDiscount]             TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[fnPaymentAccount]       TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[smRelationship]         TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[smScholarStatus]        TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[smStudentDocumentType]  TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[emAcademicLevel]        TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[emSchoolLevel]          TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[syPermission]           TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[syRolePermission]       TO mpams_app;
    DENY INSERT, UPDATE ON [dbo].[syRole]                 TO mpams_app;


    COMMIT TRANSACTION
    PRINT 'DBMpams setup completed successfully.'

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE()
    DECLARE @ErrorSeverity INT            = ERROR_SEVERITY()
    DECLARE @ErrorState    INT            = ERROR_STATE()

    PRINT 'Setup failed. Transaction rolled back.'
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH
