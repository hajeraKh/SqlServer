/*
					SQL PROJECT NAME:Hospital Management System(HMS)
							Trainee Name:HAJERA KHATUN
								Trainee ID:1271585
							Batch ID:ESAD-CS/PNTL-M/R_53/01
				--------------------------------------------------------------
CONTENT OF DDL:

				SECTION-1 : CREATE DATABASE[HMS1]
				SECTION-2 : CREATE TABLE AND COLOUM DEFINATION
				SECTION-3 : ALTER AND DROP TABLE & COLUMN 
				SECTION-4 : CREATE VIEW
				SECTION-5 : CREATE INDEX & NONCLUSTERED INDEX
				SECTION-6 : CREATE STORE PROCEDURE
				SECTION-7 : CREATE TRIGGER
				SECTION-8 : CREATE USER DEFIND FUNCTION
*/

/*

									 =======SECTION-1========
					--=============================================================

*/

/*
									=======CREATE DATABASE======
					--=============================================================

*/

CREATE DATABASE HMS1
ON
(

	name='HMS1_Data',
	fileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HMS1_Data.mdf',
	size=10MB,
	maxsize=100MB,
	filegrowth=5%
)
LOG ON
(
	name='HMS1_log',
	fileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HMS1_log.ldf',
	size=5MB,
	maxsize=50MB,
	filegrowth=2%
	

)
GO
USE HMS1
GO

/*
									=======SECTION-2========	
								CREATE TABLE AND COLOUM DEFINATION
				--=============================================================


						----CREATE TABLE WITH IDENTITY,PRIMARY KEY,NULLABILITY----
				--=============================================================
*/
CREATE TABLE Employees
(
	employeeId INT IDENTITY PRIMARY KEY,
	employeeType VARCHAR(40) NOT NULL
)
GO
/*
						----CREATE TABLE WITH CHECK CONSTRAINT----
				--=============================================================

*/
CREATE TABLE Doctor
(
	doctorId INT NOT NULL PRIMARY KEY,
	doctorType VARCHAR(30) NOT NULL,
	doctorName VARCHAR(30),
	employeeId INT REFERENCES Employees(employeeId),
	Gender NVARCHAR(20)
)
GO

CREATE TABLE Room
(
	roomId INT PRIMARY KEY NONCLUSTERED,
	roomType VARCHAR(30),
	roomCost MONEY 

)
GO

			--============== Table with PRIMARY KEY & FOREIGN KEY ============--

CREATE TABLE Patient
(
	patientId INT PRIMARY KEY,
	patientName VARCHAR(30) NOT NULL,
	gender VARCHAR(20),
	[address] NVARCHAR(50),
	roomId INT REFERENCES Room(roomId),
	disease NVARCHAR(50),
	bloodGroup CHAR(10),
	doctorId INT REFERENCES Doctor (doctorId),
	admitDate DATE NOT NULL,
	dischargeDate DATE NOT NULL,
	
)
GO

CREATE TABLE patientRelative
(
	relativeId INT PRIMARY KEY,
	relativeName VARCHAR(30),
	phone CHAR(30),
	relation NVARCHAR(30),
	patientId INT REFERENCES Patient(patientId)

)
GO
CREATE TABLE Nurse
(
	nurseId INT PRIMARY KEY,
	nurseName VARCHAR(30) NOT NULL DEFAULT 'NA',
	employeeId INT REFERENCES Employees(employeeId),
	patientId INT REFERENCES  Patient (patientId)
)
GO
CREATE TABLE Lab
(
	labId INT PRIMARY KEY,
	patientId INT REFERENCES Patient(patientId),
	doctorId INT REFERENCES Doctor(doctorId),
	patientType NVARCHAR(20),
	amount MONEY
)
GO

CREATE TABLE Reciption
(
	paymentId INT, 
	patientId INT REFERENCES Patient(patientId),
	patientType NVARCHAR(30),
	paymentDate DATE,
	roomId INT REFERENCES Room(roomId),
	labCharge MONEY,
	medicineCost MONEY,
	numberOfDays INT
)
GO

/*
					------COMPOSITE PRIMARY KEY AND  & DEFAULT CONSTRAINT...------
					--=============================================================
*/

CREATE TABLE patientInfo
(
	patientInfoId INT PRIMARY KEY,
	patientId INT REFERENCES Patient(patientId),
	doctorId INT REFERENCES Doctor(doctorId),
	roomId INT REFERENCES Room(roomId)
)
GO
CREATE TABLE tProduct
(
	productId INT PRIMARY KEY,
	productName VARCHAR(30) NOT NULL,
	price MONEY,
	stock INT DEFAULT 0
)
GO
CREATE TABLE stock
(
	stockId INT IDENTITY PRIMARY KEY,
	date DATETIME DEFAULT GETDATE(),
	productId INT REFERENCES tProduct(productId),
	quantity INT
)
GO
CREATE TABLE tProductMy
(
	productId INT PRIMARY KEY,
	productName VARCHAR(30) ,
	price MONEY,
	Quantity INT,
	amount AS price*Quantity

)
GO
CREATE TABLE Cleaner
(
	id INT,
	[name] VARCHAR(20),
	age INT
)
GO
CREATE TABLE Gurd
(
	id INT,
	[name] VARCHAR(20)
)
GO



											---Schema
					--=============================================================

CREATE SCHEMA  rom
GO


									---USE SCHEMA IN TABLE
				--=============================================================


CREATE TABLE  rom.Room
(
	RoomID INT,
	RoomName VARCHAR(50)NULL,
	RoomBed INT NULL
)
GO



/*
									 =======SECTION-3========
					--=============================================================

									ALTER AND DROP TABLE
						ALTER AND DROP TABLE & COLUMN DEFINATION
			--=============================================================
					

*/

ALTER TABLE Room
ALTER COLUMN NAME roomType VARCHAR(30) NOT NULL
--GO

							--===ALTER ADD COLUMN=====
			--=============================================================

ALTER TABLE Room
ADD roomBed MONEY NOT NULL
GO

							--===ALTER ADD COLUMN WITH DEFAULT VALUE=====
				--=============================================================

ALTER TABLE Room
ADD roomBed MONEY NOT NULL DEFAULT 0
GO

							--=== DROP TABLE =====
			--=============================================================


DROP TABLE patientRelative

							--===ALTER DROP COLUMN=====
			--=============================================================


ALTER TABLE Room
DROP COLUMN roomBed 
GO

						
							--============== DROP SCHEMA ============--
				--=============================================================

DROP SCHEMA rom
GO
								--===SEQUENCE=====
				--=============================================================

CREATE SEQUENCE Seq
AS INT
START WITH 500
INCREMENT BY 1
MINVALUE 0
MAXVALUE 1000
CYCLE
GO



					--============== ALTER SEQUENCE ============--
			--=============================================================
ALTER SEQUENCE Seq
MAXVALUE 1000
CYCLE
GO


/*
								 =======SECTION-4========
					--=============================================================
								 
								 --=====CREATE VIEW=====--
					--=============================================================

*/

CREATE VIEW Vdoctor
AS
SELECT doctorId,doctorName,doctorType FROM Doctor
GO

							--====CREATE VIEW WITH ENCRYPTION===---
				--=============================================================


CREATE VIEW VPatient
WITH ENCRYPTION
AS
SELECT patientId,patientName,gender FROM Patient
GO




							--=====ALTER VIEW WITH SCHEMABINDING & CHECK OPTION=====---
					--===============================================================
					

ALTER VIEW VPatient
WITH SCHEMABINDING
AS
SELECT patientId,patientName,gender FROM dbo. Patient
WITH CHECK OPTION
GO

							--=======SECTION-5========
				--=============================================================


						--==CREATE INDEX & NONCLUSTERED INDEX====---
				--=============================================================
						-----CREATE CLUSTERED INDEX----
			--=============================================================



CREATE CLUSTERED INDEX IX_Room1
ON dbo.Room(roomID)
GO


							--===CREATE NONCLUSTERED INDEX====
			--=============================================================



CREATE NONCLUSTERED INDEX IX_Reciption1
ON dbo.Reciption(labCharge,numberOfdays)
GO

								--=======SECTION-6========
					--=============================================================

							 --=====CREATE STORE PROCEDURE=====--
						--=============================================================



CREATE PROC spBill
AS
SELECT paymentId,patientId,labCharge,medicineCost,numberOfDays FROM Reciption
GO


								--INPUT PARAMETER IN STORE PROCEDURE--
					--=============================================================
					


CREATE PROC spBillpatientType @patientType NVARCHAR(20)
AS
SELECT paymentId,patientId,patientType,paymentDate,roomId, labCharge,medicineCost,numberOfDays FROM Reciption WHERE 
patientType=@patientType
GO




							--INSERT INTO  STORE PROCEDURE--
			--=============================================================


CREATE PROC spLabInsert
AS
SELECT labId,patientId,doctorId,patientType,amount FROM Lab
GO
CREATE PROC spLabINSERT1	@labId INT,
							@patientId INT,
							@doctorId INT,
							@patientType NVARCHAR(20),
							@amount MONEY
AS
INSERT INTO Lab(labId,patientId,doctorId,patientType,amount) VALUES
(@labId,@patientId,@doctorId,@patientType,@amount)
GO


								--RETURNING VALUE WITH STORE PROCEDURE--
					--=============================================================



CREATE PROC spLabInsertTWithReturn2		@labId INT,
										@patientId INT,
										@doctorId INT,
										@patientType NVARCHAR(20),
										@amount MONEY
AS
DECLARE @@labId INT 
INSERT INTO Lab(labId,patientId,doctorId,patientType,amount) VALUES
(@labId,@patientId,@doctorId,@patientType,@amount)
SELECT @@labId=IDENT_CURRENT ('Lab')
RETURN @@labId

GO



						---====APPLYING PROCEDURAL INTEGRITY IN STORE PROCEDURE====---
				--=====================================================================



CREATE PROC spLabInsertWithcheckAmount3		@labId INT,
											@patientId INT,
											@doctorId INT,
											@patientType NVARCHAR(20),
											@amount MONEY
AS
IF @amount>0
INSERT INTO Lab(labId,patientId,doctorId,patientType,amount) VALUES
(@labId,@patientId,@doctorId,@patientType,@amount)
ELSE
BEGIN
	RAISERROR('Price cannot be 0 or -ve',10,1)
	RETURN
END
GO


						--====USING OUTPUT PARAMETER IN STORE PROCEDURE====--
				--=============================================================



CREATE PROC spLabInsertWithoutputParameter4  @labId INT,
											@patientId INT,
											@doctorId INT,
											@patientType NVARCHAR(20),
											@amount MONEY,
											@Id INT OUTPUT
AS
INSERT INTO Lab(labId,patientId,doctorId,patientType,amount) VALUES
(@labId,@patientId,@doctorId,@patientType,@amount)
SELECT @id=IDENT_CURRENT('Lab')
GO

						---====STORED PROCEDURE FOR DELETE TABLE DATA====---
				--=============================================================


CREATE PROC spDeleteNurse  @nurseName VARCHAR(30)
AS
BEGIN
	DELETE FROM Nurse
	WHERE nurseName = @nurseName
END
GO


								--=======SECTION-07========
				--=============================================================


							  --=====CREATE TRIGGER=====--


							  --===AFTER/FOR TRIGGER===---

							--===INSERT AFTER/FOR TRIGGER===---
				--=============================================================


CREATE TRIGGER trstock
ON stock
FOR INSERT 
AS
BEGIN 
	DECLARE @i INT
	DECLARE @q INT
	SELECT @i=productId,@q=quantity FROM inserted
UPDATE tProduct SET stock=stock+@q
WHERE productId=@i
END
GO

						--===DELETE AFTER/FOR TRIGGER===---
			--=============================================================


CREATE TRIGGER trstockD
ON stock
FOR DELETE
AS
BEGIN 
	DECLARE @i INT
	DECLARE @q INT
	SELECT @i=productId,@q=quantity FROM deleted
UPDATE tProduct SET stock=stock-@q
WHERE productId=@i
END
GO

									--===INSTEAD OF TRIGGER===---	


								--===INSTEAD OF TRIGGER WITH TABLE===---
					--=============================================================



CREATE TRIGGER trtProduct1
ON tProductMy
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO tProductMy(productId ,productName,price)
	SELECT productId ,productName,price FROM inserted
END
GO


								--===INSTEAD OF TRIGGER WITH VIEW===---
				--=============================================================


CREATE VIEW VRoom
AS
SELECT roomId,roomType,roomCost FROM Room
GO
CREATE TRIGGER tVRoom
ON VRoom 
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO Room(roomId,roomType,roomCost)
	SELECT roomId,roomType,roomCost FROM inserted
END
GO







								--===ALTER TRIGGER===---
				--=============================================================


ALTER TRIGGER trtProduct1
ON tProductMy
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO tProductMy(productId ,productName,price,Quantity)
	SELECT productId ,productName,price,Quantity FROM inserted
END
GO


								--=======SECTION-08========

						--=====CREATE USER DEFIND FUNCTION=====--
				--=============================================================


CREATE FUNCTION fnlabBill( @labId INT,
						  @patientId INT,
						  @doctorId INT,
						  @patientType NVARCHAR)
RETURNS TABLE
AS
RETURN
(
	SELECT
	SUM(amount) AS 'Netamount'
	FROM Lab
)
GO

--------------------------------------------  END --------------------------------------------------------