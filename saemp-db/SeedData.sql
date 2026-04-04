USE [DBSaemp]
GO


/************* TYPE DOCUMENT IDENTITY *************/

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType],[isDefault])
VALUES ('DOCUMENTO DE IDENTIDAD NACIONAL','DNI',8,'E','N','N',1);

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType])
VALUES ('CARNET DE EXTRANJERÍA','CARNET EXT.',12,'M','A','A')

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType])
VALUES ('PASAPORTE','PASAPORTE',12,'M','A','A')

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType])
VALUES ('PERMISO TEMPORAL DE PERMANENCIA','PTP',15,'M','A','E')

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType])
VALUES ('REGISTRO ÚNICO DE CONTRIBUYENTES','RUC',11,'E','N','N')

SELECT * FROM [dbo].[pmTypeDocumentIdentity]


/******************** PHONE TYPE ****************************/

INSERT INTO [dbo].[pmPhoneType] ([name]) VALUES ('FIJO');
INSERT INTO [dbo].[pmPhoneType] ([name]) VALUES ('CELULAR');
INSERT INTO [dbo].[pmPhoneType] ([name]) VALUES ('TRBAJO');
INSERT INTO [dbo].[pmPhoneType] ([name]) VALUES ('OTRO');

SELECT * FROM [dbo].[pmPhoneType]


/******************** ACADEMIC LEVEL ****************************/

INSERT INTO [dbo].[epAcademicLevel] ([name],[abbreviation]) VALUES ('INICIAL','INI');
INSERT INTO [dbo].[epAcademicLevel] ([name],[abbreviation]) VALUES ('PRIMARIA','PRI');
INSERT INTO [dbo].[epAcademicLevel] ([name],[abbreviation]) VALUES ('SECUNDARIA','SEC');
INSERT INTO [dbo].[epAcademicLevel] ([name],[abbreviation]) VALUES ('PRE UNIVERSITARIO','PRE');

SELECT * FROM [dbo].[epAcademicLevel]


/******************** SCHOOL LEVEL ****************************/

INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (1,'CUNA','C');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (1,'3 AÑOS','3');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (1,'4 AÑOS','4');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (1,'5 AÑOS','5');

INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (2,'PRIMERO','1ERO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (2,'SEGUNDO','2DO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (2,'TERCERO','3ERO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (2,'CUARTO','4TO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (2,'QUINTO','5TO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (2,'SEXTO','6TO');

INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (3,'PRIMERO','1ERO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (3,'SEGUNDO','2DO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (3,'TERCERO','3ERO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (3,'CUARTO','4TO');
INSERT INTO [dbo].[epSchoolLevel] ([idAcademicLevel],[name],[abbreviation]) VALUES (3,'QUINTO','5TO');

SELECT * FROM [dbo].[epSchoolLevel]


/******************** STUDENT DOCUMENT TYPE ****************************/

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('COPIA DE DNI DEL ALUMNO','DNI ALUM');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('COPIA DE DNI DEL PADRE','DNI PADRE');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('COPIA DE DNI DE LA MADRE','DNI MADRE');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('LIBRETA DE NOTAS','LIBRETA');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('FICHA UNICA SIAGIE','FICHA SIAGIE');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('CONSTANCIA DE MATRICULA SIAGIE','CONST. SIAGIE');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('CERTIFICADO DE ESTUDIOS','CERTIFICADO');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('CERTIFICADO DE CONDUCTA','CONDUCTA');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('CONSTANCIA DE NO ADEUDO','NO ADEUDO');

INSERT INTO [dbo].[smStudentDocumentType] ([name],[abbreviation])
VALUES ('FOTOS TAMAÑO CARNET','FOTOS');

SELECT * FROM [dbo].[smStudentDocumentType]


/************* RELATIONSHIP *************/

INSERT INTO [dbo].[smRelationship] ([name],[isDefault]) VALUES ('Padre',1)
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Madre')
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Tio(a)')
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Hermano(a)')
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Abuelo(a)')
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Otro')

SELECT * FROM [dbo].[smRelationship]


/******************** SCHOLAR STATUS ****************************/

INSERT INTO [dbo].[smScholarStatus] ([name],[abbreviation]) VALUES ('PROMOVIDO','PRO');
INSERT INTO [dbo].[smScholarStatus] ([name],[abbreviation]) VALUES ('RECUPERACIÓN','REC');
INSERT INTO [dbo].[smScholarStatus] ([name],[abbreviation]) VALUES ('REPITENTE','REP');

SELECT * FROM [dbo].[smScholarStatus]


/******************** JOB TITLE ****************************/

INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('ADMINISTRADOR','ADM');
INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('SUB DIRECTOR','SUB');
INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('DOCENTE','DOC');
INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('COORDINADOR GENERAL','COO GRL');
INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('COORDINADOR','COO');

SELECT * FROM [dbo].[hrJobTitle]


/************************ INSTITUTION ********************************/

INSERT INTO [dbo].[inInstitution] ([name],[abbreviation]) VALUES ('COLEGIO EL ALBA','ALVA');
INSERT INTO [dbo].[inInstitution] ([name],[abbreviation]) VALUES ('ACADEMIA MAX PLANK','MAXPLANK');
INSERT INTO [dbo].[inInstitution] ([name],[abbreviation]) VALUES ('COLEGIO NUEVO HORIZONTE','ALVA');

SELECT * FROM [dbo].[inInstitution]


/******************** PAYMENT CONCEPT ****************************/

INSERT INTO [dbo].[amPaymentConcept] ([name]) VALUES ('MATRICULA');
INSERT INTO [dbo].[amPaymentConcept] ([name]) VALUES ('MATERIALES');
INSERT INTO [dbo].[amPaymentConcept] ([name]) VALUES ('MENSUALIDAD');

SELECT * FROM [dbo].[amPaymentConcept]


/******************** PAYMENT STATUS ****************************/

INSERT INTO [dbo].[amPaymentStatus] ([name],[abbreviation]) VALUES ('REGISTRADO','REG');
INSERT INTO [dbo].[amPaymentStatus] ([name],[abbreviation]) VALUES ('PAGO PARCIAL','PAP');
INSERT INTO [dbo].[amPaymentStatus] ([name],[abbreviation]) VALUES ('CANCELADO','CAN');
INSERT INTO [dbo].[amPaymentStatus] ([name],[abbreviation]) VALUES ('ANULADO','ANU');

SELECT * FROM [dbo].[amPaymentStatus]


/******************** PAYMENT METHOD ****************************/

INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('EFECTIVO','CASH');
INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('YAPE','YAPE');
INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('PLIN','PLIN');
INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('TRANSFERENCIA BANCO BCP','BCP');
INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('TRANSFERENCIA BANCO BBVA','BBVA');

SELECT * FROM [dbo].[amPaymentMethod]

/************************ DISCOUNT ****************************/

INSERT INTO [dbo].[amDiscount] ([name],[description],[isActive],[needValidation],[registrationDate]) 
VALUES ('PRONTO PAGO','PAGO ADELANTADOS DIAS ANTES DE LA FECHA DE VENCIMIENTO',1,0,GETDATE());

INSERT INTO [dbo].[amDiscount] ([name],[description],[isActive],[needValidation],[registrationDate]) 
VALUES ('SEGUNDO HERMANO','SEGUNDO HERMANO MATRICULADO',1,0,GETDATE());

INSERT INTO [dbo].[amDiscount] ([name],[description],[isActive],[needValidation],[registrationDate]) 
VALUES ('TERCER HERMANO','TERCER HERMANO MATRICULADO',1,0,GETDATE());

SELECT * FROM [dbo].[amDiscount]


/******************* DISCOUNT VERSION *************************/

INSERT INTO [dbo].[amDiscountVersion] ([idDiscount],[name],[discountAmount],[startDate],[isRate]) 
VALUES (1,'PRONTO PAGO V.1',30,GETDATE(),0);

INSERT INTO [dbo].[amDiscountVersion] ([idDiscount],[name],[discountRate],[startDate],[isRate]) 
VALUES (2,'SEGUNDO HERMANO V.1',0.25,GETDATE(),1);

INSERT INTO [dbo].[amDiscountVersion] ([idDiscount],[name],[discountRate],[startDate],[isRate]) 
VALUES (3,'TERCER HERMANO V.1',0.50,GETDATE(),1);

SELECT * FROM [dbo].[amDiscountVersion]


/******************** EXPENSE CONCEPT ****************************/

INSERT INTO [dbo].[amExpenseConcept] ([name]) VALUES ('SUMINISTROS DE OFICINA');
INSERT INTO [dbo].[amExpenseConcept] ([name]) VALUES ('SERVICIOS BÁSICOS');
INSERT INTO [dbo].[amExpenseConcept] ([name]) VALUES ('MANTENIMIENTO');
INSERT INTO [dbo].[amExpenseConcept] ([name]) VALUES ('MOVILIDAD');
INSERT INTO [dbo].[amExpenseConcept] ([name]) VALUES ('LIMPIEZA');
INSERT INTO [dbo].[amExpenseConcept] ([name]) VALUES ('PUBLICIDAD');
INSERT INTO [dbo].[amExpenseConcept] ([name]) VALUES ('OTROS');

SELECT * FROM [dbo].[amExpenseConcept]


/******************** ROLE ****************************/

INSERT INTO [dbo].[syRole] ([name],[description],[registrationUser])
VALUES ('DIRECTOR','Gestión de personal, año escolar y reportes financieros',0);

INSERT INTO [dbo].[syRole] ([name],[description],[registrationUser])
VALUES ('COORDINADOR','Gestión de alumnos, matrículas y seguimiento académico',0);

INSERT INTO [dbo].[syRole] ([name],[description],[registrationUser])
VALUES ('CAJERO','Procesamiento de pagos, gastos y cierre de caja',0);

SELECT * FROM [dbo].[syRole]


/******************** PERMISSION ****************************/

INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('PM','PERSON_VIEW','Ver registros de personas');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('PM','PERSON_MANAGE','Crear y editar personas');

INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('HR','EMPLOYEE_VIEW','Ver registros de empleados');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('HR','EMPLOYEE_MANAGE','Crear y editar empleados');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('HR','CONTRACT_MANAGE','Gestionar contratos laborales');

INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('SM','STUDENT_VIEW','Ver registros de alumnos');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('SM','STUDENT_MANAGE','Crear y editar alumnos');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('SM','RELATIVE_VIEW','Ver registros de apoderados');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('SM','RELATIVE_MANAGE','Crear y editar apoderados');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('SM','DOCUMENT_MANAGE','Gestionar documentos del alumno');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('SM','ACADEMIC_BACKGROUND_MANAGE','Gestionar historial académico previo');

INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('EM','SCHOOLYEAR_MANAGE','Crear y configurar año escolar');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('EM','FEESCHEDULE_MANAGE','Configurar tarifas por nivel');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('EM','ENROLLMENT_VIEW','Ver matrículas');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('EM','ENROLLMENT_MANAGE','Crear y editar matrículas');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('EM','INSTALLMENT_VIEW','Ver cuotas de pago');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('EM','INSTALLMENT_MANAGE','Editar montos y fechas de cuotas');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('EM','NOTE_MANAGE','Crear y editar notas generales del alumno');

INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','PAYMENT_VIEW','Ver comprobantes de pago');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','PAYMENT_PROCESS','Emitir comprobantes de pago');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','PAYMENT_VOID','Anular comprobantes de pago');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','EXPENSE_MANAGE','Registrar y editar gastos');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','BALANCE_VIEW','Ver balances diarios y mensuales');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','BALANCE_CLOSE','Cerrar y conciliar balances');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','DISCOUNT_MANAGE','Crear y configurar descuentos');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','ACCOUNT_MANAGE','Gestionar cuentas de cobro');
INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('AM','NOTE_MANAGE','Crear y editar notas de seguimiento de pago');

INSERT INTO [dbo].[syPermission] ([module],[name],[description]) VALUES ('SY','USER_MANAGE','Crear y gestionar usuarios del sistema');

SELECT * FROM [dbo].[syPermission]


/******************** ROLE PERMISSION ****************************/

-- DIRECTOR
INSERT INTO [dbo].[syRolePermission] ([idRole],[idPermission],[registrationUser])
SELECT r.idRole, p.idPermission, 0
FROM [dbo].[syRole] r, [dbo].[syPermission] p
WHERE r.name = 'DIRECTOR'
  AND ((p.module = 'PM' AND p.name IN ('PERSON_VIEW','PERSON_MANAGE'))
    OR (p.module = 'HR' AND p.name IN ('EMPLOYEE_VIEW','EMPLOYEE_MANAGE','CONTRACT_MANAGE'))
    OR (p.module = 'SM' AND p.name IN ('STUDENT_VIEW','RELATIVE_VIEW'))
    OR (p.module = 'EM' AND p.name IN ('SCHOOLYEAR_MANAGE','FEESCHEDULE_MANAGE','ENROLLMENT_VIEW','INSTALLMENT_VIEW','INSTALLMENT_MANAGE'))
    OR (p.module = 'AM' AND p.name IN ('PAYMENT_VIEW','BALANCE_VIEW','BALANCE_CLOSE','DISCOUNT_MANAGE')))

-- COORDINADOR
INSERT INTO [dbo].[syRolePermission] ([idRole],[idPermission],[registrationUser])
SELECT r.idRole, p.idPermission, 0
FROM [dbo].[syRole] r, [dbo].[syPermission] p
WHERE r.name = 'COORDINADOR'
  AND ((p.module = 'PM' AND p.name IN ('PERSON_VIEW','PERSON_MANAGE'))
    OR (p.module = 'SM' AND p.name IN ('STUDENT_VIEW','STUDENT_MANAGE','RELATIVE_VIEW','RELATIVE_MANAGE','DOCUMENT_MANAGE','ACADEMIC_BACKGROUND_MANAGE'))
    OR (p.module = 'EM' AND p.name IN ('ENROLLMENT_VIEW','ENROLLMENT_MANAGE','INSTALLMENT_VIEW','NOTE_MANAGE'))
    OR (p.module = 'AM' AND p.name IN ('PAYMENT_VIEW')))

-- CAJERO
INSERT INTO [dbo].[syRolePermission] ([idRole],[idPermission],[registrationUser])
SELECT r.idRole, p.idPermission, 0
FROM [dbo].[syRole] r, [dbo].[syPermission] p
WHERE r.name = 'CAJERO'
  AND ((p.module = 'PM' AND p.name IN ('PERSON_VIEW'))
    OR (p.module = 'SM' AND p.name IN ('STUDENT_VIEW'))
    OR (p.module = 'EM' AND p.name IN ('ENROLLMENT_VIEW','INSTALLMENT_VIEW'))
    OR (p.module = 'AM' AND p.name IN ('PAYMENT_VIEW','PAYMENT_PROCESS','PAYMENT_VOID','EXPENSE_MANAGE','BALANCE_VIEW','BALANCE_CLOSE','NOTE_MANAGE')))

SELECT rp.idRole, r.name AS role, p.module, p.name AS permission
FROM [dbo].[syRolePermission] rp
JOIN [dbo].[syRole] r ON rp.idRole = r.idRole
JOIN [dbo].[syPermission] p ON rp.idPermission = p.idPermission
ORDER BY r.name, p.module, p.name
