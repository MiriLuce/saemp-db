USE DBMpams
GO

CREATE TRIGGER trg_InsertAudit_<TableName>
ON <TableName>
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE t
    SET registrationDate = ISNULL(t.registrationDate, SYSDATETIME()),
        registrationUser = ISNULL(t.registrationUser, CONVERT(INT, SESSION_CONTEXT(N'IdUser')))
    FROM <TableName> t
    INNER JOIN inserted i ON t.<PK> = i.<PK>;
END;


CREATE TRIGGER trg_UpdateAudit_<TableName>
ON <TableName>
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE t
    SET modifiedDate = SYSDATETIME(),
        modifiedUser = CONVERT(INT, SESSION_CONTEXT(N'IdUser'))
    FROM <TableName> t
    INNER JOIN inserted i ON t.<PK> = i.<PK>;
END;


CREATE TRIGGER trg_DeleteAudit_<TableName>
ON <TableName>
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE t
    SET deletedDate = SYSDATETIME(),
        deletedUser = CONVERT(INT, SESSION_CONTEXT(N'IdUser'))
    FROM <TableName> t
    INNER JOIN inserted i ON t.<PK> = i.<PK>
    INNER JOIN deleted d ON t.<PK> = d.<PK>
    WHERE d.isDeleted = 0 AND i.isDeleted = 1; -- Solo cuando el registro es marcado como eliminado
END;
GO