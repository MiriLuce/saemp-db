# mpams-db
DDL Definición de la base de datos del proyecto MP-AMS 

## Módulos

El sistema está dividido en 7 módulos

| Prefijo | Módulo                | Descripción                             |
|---------|-----------------------|-----------------------------------------|
| **PM**  | Person Management     | Datos personales, documentos de identidad, teléfonos y referencias geográficas (países, departamentos, provincias, distritos) |
| **HR**  | Human Resources       | Empleados, cargos (job titles) y contratos laborales |
| **IN**  | Institution           | Instituciones educativas, sedes (campus) y aulas |
| **FN**  | Finance               | Conceptos de pago, métodos, cuentas, recibos, descuentos, gastos y balances |
| **SM**  | Student Management    | Alumnos, apoderados, documentos del alumno, historial académico previo |
| **EM**  | Enrollment Management | Niveles académicos, grados, años escolares, tarifas (fee schedule), matrículas |
| **SY**  | System / Security     | Usuarios del sistema, roles, permisos y RBAC |

## Convenciones de nomenclatura

### Tablas
- Prefijo de 2 letras del módulo: `pmPerson`, `hrEmployee`, `syUser`, etc.

### Columnas
- **PK:** `id[NombreTabla]` — `BIGINT` para entidades derivadas de persona, `INT` para catálogos
- **FK:** mismo nombre que la PK referenciada
- **Auditoría:** `registrationDate`, `registrationUser`, `modifiedDate`, `modifiedUser`, `deletedDate`, `deletedUser`
- **Soft-delete:** `isActive BIT DEFAULT 1` (el login de la app tiene `DENY DELETE`)
- **Dinero:** `DECIMAL(12,2)`
- **Fechas con hora:** `DATETIME`; solo fecha: `DATE`
- **Banderas/enumerados:** `BIT` o `CHAR(1)`

### Stored Procedures
- Formato: `usp_[módulo]_[Verbo][Sustantivo]`
- Ejemplos: `usp_hr_GetEmployeeById`, `usp_sy_CreateUser`, `usp_pm_SavePhones`

### Parámetros de SP
- Prefijo `@p` en todos los parámetros: `@pIdEmployee`, `@pSearchTerm`, `@pIdUserActing`

### TVP (Table-Valued Parameters)
- Formato: `tp_[módulo]_[Sustantivo]Type`
- Ejemplo: `dbo.tp_pm_SavePhoneType`, `dbo.IdListType`