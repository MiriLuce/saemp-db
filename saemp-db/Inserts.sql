USE [DBSaemp]
GO

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

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('COPIA DE DNI DEL ALUMNO','DNI ALUM',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('COPIA DE DNI DEL PADRE','DNI PADRE',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('COPIA DE DNI DE LA MADRE','DNI MADRE',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('LIBRETA DE NOTAS','LIBRETA',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('FICHA UNICA SIAGIE','FICHA SIAGIE',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('CONSTANCIA DE MATRICULA SIAGIE','CONST. SIAGIE',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('CERTIFICADO DE ESTUDIOS','CERTIFICADO',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('CERTIFICADO DE CONDUCTA','CONDUCTA',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('CONSTANCIA DE NO ADEUDO','NO ADEUDO',GETDATE(),NULL,1);

INSERT INTO [dbo].[epStudentDocumentType] ([name],[abbreviation],[effectiveDate],[expirationDate],[inEffect])
VALUES ('FOTOS TAMAÑO CARNET','FOTOS',GETDATE(),NULL,1);

SELECT * FROM [dbo].[epStudentDocumentType]


/************* TYPE DOCUMENT IDENTITY *************/

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType])
VALUES ('DOCUMENTO DE IDENTIDAD NACIONAL','DNI',8,'E','N','N');

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType])
VALUES ('CARNET DE EXTRANJERÍA','CARNET EXT.',12,'M','A','A')

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType])
VALUES ('PASAPORTE','PASAPORTE',12,'M','A','A')

INSERT INTO [dbo].[pmTypeDocumentIdentity] ([name],[abbreviation],[length],[lengthType],[characterType],[nationalityType])
VALUES ('PERMISO TEMPORAL DE PERMANENCIA','PTP',15,'M','A','E')

SELECT * FROM [dbo].[pmTypeDocumentIdentity]


/************* COUNTRY *************/

INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Afganistán','004','AFG')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Albania','008','ALB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Alemania','276','DEU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Andorra','020','AND')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Angola','024','AGO')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Anguila','660','AIA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Antártida','010','ATA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Antigua y Barbuda','028','ATG')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Antillas Neerlandesas','530','ANT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Arabia Saudita','682','SAU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Argel','012','DZA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Argentina','032','ARG')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Armenia','051','ARM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Aruba','533','ABW')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Australia','036','AUS')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Austria','040','AUT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Azerbaiyán','031','AZE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bahamas','044','BHS')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bahréin','048','BHR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bangladesh','050','BGD')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Barbados','052','BRB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Belarús','112','BLR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bélgica','056','BEL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Belice','084','BLZ')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Benin','204','BEN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bermudas','060','BMU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bhután','064','BTN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bolivia','068','BOL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bosnia y Herzegovina','070','BIH')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Botsuana','072','BWA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Brasil','076','BRA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Brunéi','096','BRN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Bulgaria','100','BGR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Burkina Faso','854','BFA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Burundi','108','BDI')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Cabo Verde','132','CPV')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Camboya','116','KHM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Camerún','120','CMR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Canadá','124','CAN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Chad','148','TCD')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Chile','152','CHL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('China','156','CHN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Chipre','196','CYP')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Ciudad del Vaticano','336','VAT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Colombia','170','COL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Comoros','174','COM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Congo','178','COG')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Corea del Norte','408','PRK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Corea del Sur','410','KOR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Costa de Marfil','384','CIV')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Costa Rica','188','CRI')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Croacia','191','HRV')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Cuba','192','CUB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Dinamarca','208','DNK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Domínica','212','DMA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Ecuador','218','ECU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Egipto','818','EGY')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('El Salvador','222','SLV')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Emiratos Árabes Unidos','784','ARE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Eritrea','232','ERI')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Eslovaquia','703','SVK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Eslovenia','705','SVN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('España','724','ESP')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Estados Unidos de América','840','USA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Estonia','233','EST')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Etiopía','231','ETH')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Fiji','242','FJI')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Filipinas','608','PHL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Finlandia','246','FIN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Francia','250','FRA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Gabón','266','GAB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Gambia','270','GMB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Georgia','268','GEO')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Georgia del Sur e Islas Sandwich del Sur','239','SGS')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Ghana','288','GHA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Gibraltar','292','GIB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Granada','308','GRD')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Grecia','300','GRC')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Groenlandia','304','GRL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guadalupe','312','GLP')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guam','316','GUM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guatemala','320','GTM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guayana','328','GUY')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guayana Francesa','254','GUF')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guernsey','831','GGY')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guinea','324','GIN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guinea Ecuatorial','226','GNQ')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Guinea-Bissau','624','GNB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Haití','332','HTI')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Honduras','340','HND')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Hong Kong','344','HKG')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Hungría','348','HUN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('India','356','IND')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Indonesia','360','IDN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Irak','368','IRQ')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Irán','364','IRN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Irlanda','372','IRL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Isla Bouvet','074','BVT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Isla de Man','833','IMN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islandia','352','ISL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Áland','248','ALA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Caimán','136','CYM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Christmas','162','CXR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Cocos','166','CCK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Cook','184','COK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Faroe','234','FRO')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Heard y McDonald','334','HMD')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Malvinas','238','KLK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Marshall','584','MHL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Norkfolk','574','NFK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Palaos','585','PLW')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Pitcairn','612','PCN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Solomón','090','SLB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Svalbard y Jan Mayen','744','SJM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Turcas y Caicos','796','TCA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Vírgenes Británicas','092','VGB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Islas Vírgenes de los Estados Unidos de América','850','VIR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Israel','376','ISR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Italia','380','ITA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Jamaica','388','JAM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Japón','392','JPN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Jersey','832','JEY')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Jordania','400','JOR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Kazajstán','398','KAZ')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Kenia','404','KEN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Kirguistán','417','KGZ')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Kiribati','296','KIR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Kuwait','414','KWT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Laos','418','LAO')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Lesotho','426','LSO')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Letonia','428','LVA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Líbano','422','LBN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Liberia','430','LBR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Libia','434','LBY')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Liechtenstein','438','LIE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Lituania','440','LTU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Luxemburgo','442','LUX')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Macao','446','MAC')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Macedonia','807','MKD')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Madagascar','450','MDG')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Malasia','458','MYS')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Malawi','454','MWI')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Maldivas','462','MDV')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Mali','466','MLI')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Malta','470','MLT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Marruecos','504','MAR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Martinica','474','MTQ')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Mauricio','480','MUS')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Mauritania','478','MRT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Mayotte','175','MYT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('México','484','MEX')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Micronesia','583','FSM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Moldova','498','MDA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Mónaco','492','MCO')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Mongolia','496','MNG')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Montenegro','499','MNE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Montserrat','500','MSR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Mozambique','508','MOZ')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Myanmar','104','MMR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Namibia','516','NAM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Nauru','520','NRU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Nepal','524','NPL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Nicaragua','558','NIC')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Níger','562','NER')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Nigeria','566','NGA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Niue','570','NIU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Noruega','578','NOR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Nueva Caledonia','540','NCL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Nueva Zelanda','554','NZL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Omán','512','OMN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Países Bajos','528','NLD')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Pakistán','586','PAK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Palestina','275','PSE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Panamá','591','PAN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Papúa Nueva Guinea','598','PNG')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Paraguay','600','PRY')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode],[isDefault]) VALUES ('Perú','604','PER',1)
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Polinesia Francesa','258','PYF')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Polonia','616','POL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Portugal','620','PRT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Puerto Rico','630','PRI')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Qatar','634','QAT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Reino Unido','826','GBR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('República Centro-Africana','140','CAF')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('República Checa','203','CZE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('República Dominicana','214','DOM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Reunión','638','REU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Ruanda','646','RWA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Rumanía','642','ROU')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Rusia','643','RUS')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Sahara Occidental','732','ESH')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Samoa','882','WSM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Samoa Americana','016','ASM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('San Bartolomé','652','BLM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('San Cristóbal y Nieves','659','KNA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('San Marino','674','SMR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('San Pedro y Miquelón','666','SPM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('San Vicente y las Granadinas','670','VCT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Santa Elena','654','SHN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Santa Lucía','662','LCA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Santo Tomé y Príncipe','678','STP')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Senegal','686','SEN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Serbia y Montenegro','688','SRB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Seychelles','690','SYC')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Sierra Leona','694','SLE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Singapur','702','SGP')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Siria','760','SYR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Somalia','706','SOM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Sri Lanka','144','LKA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Suazilandia','748','SWZ')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Sudáfrica','710','ZAF')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Sudán','736','SDN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Suecia','752','SWE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Suiza','756','CHE')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Surinam','740','SUR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Tailandia','764','THA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Taiwán','158','TWN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Tanzania','834','TZA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Tayikistán','762','TJK')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Territorio Británico del Océano Índico','086','IOT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Territorios Australes Franceses','260','ATF')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Timor-Leste','626','TLS')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Togo','768','TGO')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Tokelau','772','TKL')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Tonga','776','TON')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Trinidad y Tobago','780','TTO')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Túnez','788','TUN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Turkmenistán','795','TKM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Turquía','792','TUR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Tuvalu','798','TUV')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Ucrania','804','UKR')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Uganda','800','UGA')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Uruguay','858','URY')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Uzbekistán','860','UZB')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Vanuatu','548','VUT')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Venezuela','862','VEN')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Vietnam','704','VNM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Wallis y Futuna','876','WLF')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Yemen','887','YEM')
INSERT INTO [dbo].[pmCountry] ([name],[letterCode],[numericCode]) VALUES ('Yibuti','262','DJI')

SELECT * FROM [dbo].[pmCountry]


/************* RELATIONSHIP *************/

INSERT INTO [dbo].[smRelationship] ([name],[isDefault]) VALUES ('Padre',1)
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Madre')
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Tio(a)')
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Hermano(a)')
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Abuelo(a)')
INSERT INTO [dbo].[smRelationship] ([name]) VALUES ('Otro')

SELECT * FROM [dbo].[smRelationship]


/******************** SCHOLAR STATUS ****************************/

INSERT INTO [dbo].[epScholarStatus] ([name],[abbreviation]) VALUES ('PROMOVIDO','PRO');
INSERT INTO [dbo].[epScholarStatus] ([name],[abbreviation]) VALUES ('RECUPERACIÓN','REC');
INSERT INTO [dbo].[epScholarStatus] ([name],[abbreviation]) VALUES ('REPITENTE','REP');

SELECT * FROM [dbo].[epScholarStatus]


/******************** JOB TITLE ****************************/

INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('ADMINISTRADOR','ADM');
INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('SUB DIRECTOR','SUB');
INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('DOCENTE','DOC');
INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('COORDINADOR GENERAL','COO GRL');
INSERT INTO [dbo].[hrJobTitle] ([name],[abbreviation]) VALUES ('COORDINADOR','COO');

SELECT * FROM [dbo].[hrJobTitle]


/******************** PHONE COMPANY ****************************/

INSERT INTO [dbo].[pmPhoneCompany] ([name]) VALUES ('CLARO');
INSERT INTO [dbo].[pmPhoneCompany] ([name]) VALUES ('MOVISTAR');
INSERT INTO [dbo].[pmPhoneCompany] ([name]) VALUES ('ENTEL');
INSERT INTO [dbo].[pmPhoneCompany] ([name]) VALUES ('BITEL');
INSERT INTO [dbo].[pmPhoneCompany] ([name]) VALUES ('OTRO');

SELECT * FROM [dbo].[pmPhoneCompany]


/******************** PHONE TYPE ****************************/

INSERT INTO [dbo].[pmPhoneType] ([name]) VALUES ('FIJO');
INSERT INTO [dbo].[pmPhoneType] ([name]) VALUES ('CELULAR');
INSERT INTO [dbo].[pmPhoneType] ([name]) VALUES ('TRBAJO');
INSERT INTO [dbo].[pmPhoneType] ([name]) VALUES ('OTRO');

SELECT * FROM [dbo].[pmPhoneType]


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

INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('CAJA PRESENCIAL','CAJ');
INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('BANCO BCP','BCP');
INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('BANCO BBVA','BBVA');
INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('BANCO INTERBANK','INTER');
INSERT INTO [dbo].[amPaymentMethod] ([name],[abbreviation]) VALUES ('BANCO SCOTIABANK','SCOTI');

SELECT * FROM [dbo].[amPaymentMethod]


/************************ INSTITUTION ********************************/

INSERT INTO [dbo].[inInstitution] ([name],[abbreviation]) VALUES ('COLEGIO EL ALBA','ALVA');
INSERT INTO [dbo].[inInstitution] ([name],[abbreviation]) VALUES ('ACADEMIA MAX PLANK','MAXPLANK');
INSERT INTO [dbo].[inInstitution] ([name],[abbreviation]) VALUES ('COLEGIO NUEVO HORIZONTE','ALVA');

SELECT * FROM [dbo].[inInstitution]


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

