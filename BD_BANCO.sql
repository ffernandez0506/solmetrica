CREATE DATABASE BANCO
GO
USE BANCO
GO


CREATE TABLE [dbo].[Banco]
(
	[IdBanco] INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    [Direccion] VARCHAR(50) NULL, 
    [FechaRegistro] VARCHAR(50) NULL, 
    [Nombre] VARCHAR(50) NULL
)
go
CREATE TABLE [dbo].[Sucursal]
(
	[IdSucursal] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [Direccion] VARCHAR(50) NULL, 
    [FechaRegistro] VARCHAR(50) NULL, 
    [Nombre] VARCHAR(50) NULL,
	[IdBanco] INT NOT NULL
)
go
CREATE TABLE [dbo].[OrdenPago]
(
	[IdOrdenPago] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Estado] VARCHAR(10) NULL,
    [FechaPago] VARCHAR(50) NULL,
	[Moneda] VARCHAR(10) NULL,
	[Monto] DECIMAL(18,2) NULL,    
	[IdBanco] INT NOT NULL,
	[IdSucursal] INT NOT NULL
)
GO
CREATE PROCEDURE LISTAR_BANCO
AS
BEGIN
SELECT * FROM [Banco]
END
GO
CREATE PROCEDURE DETALLE_BANCO(@idBanco int)
AS
BEGIN
SELECT * FROM [Banco]
where IdBanco=@idBanco;
END
GO
CREATE PROCEDURE INSERT_BANCO (@direccion varchar(50), @fechaRegistro varchar(50),@nombre varchar(50))
AS
BEGIN
 INSERT INTO BANCO ([Direccion],[FechaRegistro],[Nombre])
 VALUES (@direccion,@fechaRegistro,@nombre)
END
GO
CREATE PROCEDURE UPDATE_BANCO (@idBanco int, @direccion varchar(50), @fechaRegistro varchar(50),@nombre varchar(50))
AS
BEGIN
UPDATE banco
set 
[Direccion]=@direccion,
[FechaRegistro]=@fechaRegistro,
[Nombre]=@nombre
where IdBanco=@idBanco;
END;
GO
CREATE PROCEDURE DELETE_BANCO (@idBanco int)
AS
BEGIN
DELETE FROM banco
where IdBanco=@idBanco;
END;
GO
CREATE PROCEDURE LISTAR_SUCURSAL
AS
BEGIN
SELECT S.*,B.Nombre AS NOMBREBANCO FROM [Sucursal] s
INNER JOIN [Banco] B
ON S.IdBanco=B.IdBanco
END
GO
CREATE PROCEDURE DETALLE_SUCURSAL(@idSucursal int)
AS
BEGIN
--SELECT * FROM [Sucursal]
SELECT S.*,B.Nombre AS NOMBREBANCO FROM [Sucursal] s
INNER JOIN [Banco] B
ON S.IdBanco=B.IdBanco
WHERE [IdSucursal]=@idSucursal;
END
GO
CREATE PROCEDURE INSERT_SUCURSAL(@direccion varchar(50), @fechaRegistro varchar(50),@nombre varchar(50),@idBanco int)
AS
BEGIN
 INSERT INTO [Sucursal] ([Direccion],[FechaRegistro],[Nombre],[IdBanco])
 VALUES (@direccion,@fechaRegistro,@nombre,@idBanco)
END
GO
CREATE PROCEDURE UPDATE_SUCURSAL(@idSucursal int, @direccion varchar(50), @fechaRegistro varchar(50),@nombre varchar(50))
AS
BEGIN
UPDATE [Sucursal]
SET 
[Direccion]=@direccion,
[FechaRegistro]=@fechaRegistro,
[Nombre]=@nombre
WHERE [IdSucursal]=@idSucursal;
END;
GO
CREATE PROCEDURE DELETE_SUCURSAL(@idSucursal int)
AS
BEGIN
DELETE FROM [Sucursal]
WHERE [IdSucursal]=@idSucursal;
END;
GO
GO
CREATE PROCEDURE LISTAR_ORDENPAGO
AS
BEGIN
SELECT P.*, B.Nombre AS NOMBREBANCO, S.Nombre AS NOMBRESUCURSAL FROM [OrdenPago] p
INNER JOIN Banco B
ON B.IdBanco=P.IdBanco
INNER JOIN Sucursal S
ON S.IdSucursal=P.IdSucursal
END
GO
CREATE PROCEDURE DETALLE_ORDENPAGO(@idOrdenPago int)
AS
BEGIN
--SELECT * FROM [OrdenPago]
SELECT P.*, B.Nombre AS NOMBREBANCO, S.Nombre AS NOMBRESUCURSAL FROM [OrdenPago] p
INNER JOIN Banco B
ON B.IdBanco=P.IdBanco
INNER JOIN Sucursal S
ON S.IdSucursal=P.IdSucursal
WHERE [IdOrdenPago]=@idOrdenPago;
END
GO
CREATE PROCEDURE INSERT_ORDENPAGO(@estado varchar(50), @fechapago varchar(50),@moneda varchar(50), @monto decimal, @idBanco int,@idSucursal int)
AS
BEGIN
 INSERT INTO [OrdenPago] ([Estado],[FechaPago],[Moneda],[Monto],[IdBanco],[IdSucursal])
 VALUES (@estado, @fechapago,@moneda, @monto, @idBanco,@idSucursal)
END
GO
CREATE PROCEDURE UPDATE_ORDENPAGO(@idOrdenPago int, @estado varchar(50), @fechapago varchar(50),@moneda varchar(50), @monto decimal, @idBanco int,@idSucursal int)
AS
BEGIN
UPDATE [OrdenPago]
SET 
	[Estado]=@estado,
    [FechaPago]=@fechapago,
	[Moneda]=@moneda,
	[Monto]=@monto,
	[IdBanco]=@idBanco,
	[IdSucursal]=@idSucursal
WHERE [IdOrdenPago]=@idOrdenPago;
END;
GO
CREATE PROCEDURE DELETE_ORDENPAGO(@idOrdenPago int)
AS
BEGIN
DELETE FROM [OrdenPago]
WHERE [IdOrdenPago]=@idOrdenPago;
END;
GO
