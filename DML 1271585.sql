/*
					SQL PROJECT NAME:Hospital Management System(HMS)
							Trainee Name:HAJERA KHATUN
								Trainee ID:1271585
							Batch ID:ESAD-CS/PNTL-M/R_53/01
				--------------------------------------------------------------
CONTENT OF DML:

				SECTION-1 : INSERT DATA USING INSERT INTO KEYWORD
				SECTION-2 : INSERT DATA THROUGH STORED PROCEDURE
				SECTION-3 : TRIGGER
				SECTION-4 : INSERT UPDATE DELETE DATA THROUGH VIEW
				SECTION-5 : QUERY


*/





/*
==============================  SECTION 01  ==============================
					INSERT DATA USING INSERT INTO KEYWORD
==========================================================================
*/


USE HMS1
GO
INSERT INTO Employees VALUES
('Doctor'),
('Nurse'),
('Cleaner')
GO
SELECT * FROM Employees
GO

INSERT INTO Doctor VALUES 
(101,'Nurologists','Rahat',1,'Male'),
(102,'Pathology','Tareq',1,'Male'),
(103,'Medicine','Sumon',1,'Male'),
(104,'Arthopedic','Tania',1,'Female'),
(106,'Dentist','Suma',1,'Female')
GO
SELECT * FROM Doctor
GO

INSERT INTO Room VALUES
(10,'Cabin',3000),
(11,'VIP',5000),
(12,'Normal',1000)
GO
SELECT * FROM Room
GO

INSERT INTO Patient VALUES
(1,'Nila','Female','Dhaka',11,'Tuimer','A+',101,'2022-03-10','2022-03-15'),
(2,'Rabbi','Male','Khulna',10,'Cancer','o+',103,'2021-05-11','2021-05-15'),
(3,'Mahin','Male','Uttra',12,'Chest','B+',102,'2022-06-15','2022-06-20'),
(4,'Toma','Female','Pabna',10,'Heart Disease','A-',103,'2020-02-05','2020-02-15'),
(5,'Fahim','Male','Dhaka',11,'Infectious Diseases','o+',104,'2022-09-20','2022-09-25')
GO
INSERT INTO Patient VALUES
(6,'Emran','Male','Dhaka',10,'Cancer','A+',103,'2022-09-25','2022-09-30'),
(7,'Rahat','Male','Rajshahi',11,'Chest','o+',102,'2022-09-27','2022-09-30')
GO
INSERT INTO Patient VALUES
(8,'Rima','Female','Rajshahi',10,'Cancer','o+',103,'2022-09-28','2022-09-30')
GO
SELECT * FROM Patient
GO

INSERT INTO patientRelative VALUES
(1,'Hasan','01722334455','brother',1),
(2,'Rafi','01722330850','Father',4),
(3,'Mizan','01722332269','brother',2)
GO
SELECT * FROM patientRelative
GO

INSERT INTO Nurse VALUES
(1,'Mukta',2,3),
(2,'Rima',2,1),
(3,'Farabi',2,2),
(4,'Nipa',2,4)
GO
SELECT * FROM Nurse
GO

INSERT INTO Lab VALUES
(1,2,102,'Chest',1500),
(2,1,101,'Tuimer',2000),
(3,5,104,'Infectious Diseases',3000)
GO
SELECT * FROM Lab
GO

INSERT INTO Reciption VALUES
(1,3,'Chest','2022-06-20',12,3000,2000,5),
(2,5,'Infectious Diseases','2022-09-25',11,2000,1500,7),
(3,1,'Tuimer','2022-03-15',11,7000,5000,8)
GO


SELECT * FROM Reciption
GO
INSERT INTO tProduct VALUES
(1,'Monitor',1500,0),
(2,'USB Drive',250,0),
(3,'Keyboard',400,0)
GO


INSERT INTO tProductMy VALUES(1,'Bag',500,2)
GO

SELECT * FROM tProductMy
GO

INSERT INTO Cleaner VALUES
(1,'karim',28),
(2,'Rahim',20)
GO
SELECT * FROM Cleaner
GO

INSERT INTO Gurd VALUES
(5,'Mamun'),
(6,'Rifat')
GO

									--===SEQUENCE=====
			--=============================================================
INSERT INTO rom.Room VALUES
(5,'Nice',10),
(7,'Great',12),
(8,'Sweet',15)
GO
SELECT * FROM rom.Room

/*
==============================  SECTION 02  ==============================
					INSERT DATA THROUGH STORED PROCEDURE
==========================================================================
*/

						--INPUT PARAMETER IN STORE PROCEDURE--
			--=============================================================


EXEC spBillpatientType 'Tuimer'
EXEC spBillpatientType 'Chest'
GO

							--INSERT INTO  STORE PROCEDURE--
			--=============================================================


EXEC spLabINSERT1 4,4,103,'Heart Disease',1500
EXEC spLabINSERT1 5,3,102,'Chest',2000
GO
SELECT * FROM Lab

						--RETURNING VALUE WITH STORE PROCEDURE--
			--=============================================================


DECLARE @@labId INT
EXEC @@labId=spLabInsertTWithReturn2 6,7,102,'Chest',3000
PRINT 'New product inserted with Id:'+STR(@@labId)
GO

					--====USING OUTPUT PARAMETER IN STORE PROCEDURE====--
				--=============================================================


DECLARE @labId INT
EXEC spLabInsertWithoutputParameter4 7,6,103,'Cancer',1500,@labId OUTPUT
SELECT @labId 'New Id'
GO

					---====APPLYING PROCEDURAL INTEGRITY IN STORE PROCEDURE====---
				--=====================================================================


EXEC spLabInsertWithcheckAmount3 8,8,103,'Cancer',-1000
GO						
						
						
						---====STORED PROCEDURE FOR DELETE TABLE DATA====---
				--=============================================================

EXEC spDeleteNurse Nipa
EXEC spDeleteNurse Rima
GO
SELECT * FROM Nurse
GO
/*
==============================  SECTION 03  ==============================
								 TRIGGER
==========================================================================
*/

							--===INSERT AFTER/FOR TRIGGER===---
				--=============================================================


INSERT INTO stock VALUES (GETDATE(),1,20)
INSERT INTO stock VALUES (GETDATE(),2,50)
INSERT INTO stock VALUES (GETDATE(),1,50)

SELECT * FROM tProduct
SELECT * FROM stock
GO

						--===DELETE AFTER/FOR TRIGGER===---
			--=============================================================


DELETE FROM stock WHERE stockId=3
GO

							--===INSTEAD OF TRIGGER WITH TABLE===---
					--=============================================================


SELECT * FROM tProductMy
GO
INSERT INTO tProductMy VALUES
(2,'Shirt',1000,4),
(3,'Cake',5000,4)
GO

							--===INSTEAD OF TRIGGER WITH VIEW===---
				--=============================================================



SELECT * FROM VRoom
GO
INSERT INTO VRoom(roomId,roomType,roomcost) VALUES
(5,'Small',100)
GO

/*
==============================  SECTION 04  ==============================
					INSERT UPDATE DELETE DATA THROUGH VIEW
==========================================================================
*/


SELECT * FROM Vdoctor
GO
INSERT INTO Vdoctor(doctorId,doctorName,doctorType) VALUES
(107,'Kader','Nurologists')
GO
SELECT * FROM Vdoctor

					--======= DELETE DATA THROUGH VIEW =========--
				--=============================================================


DELETE FROM Vdoctor WHERE doctorId=107
GO
SELECT * FROM Vdoctor



/*
==============================  SECTION 05  ==============================
								  QUERY
==========================================================================
*/


					--=====SELECT STATEMENT IN TABLE=====-----


SELECT * FROM Employees
GO	

							--=====WHERE STATEMENT IN TABLE=====-----
					--=============================================================



SELECT doctorId,doctorType,doctorName,gender FROM Doctor WHERE doctorType='Medicine'
GO

					--=====ORDER BY STATEMENT IN TABLE=====-----
				--=============================================================


SELECT doctorId,doctorType,doctorName,gender FROM Doctor
Order By (doctorType)
GO

							---=====DISTINCT KEYWORD=====
					--=============================================================



SELECT DISTINCT doctorId,doctorType,doctorName,gender FROM Doctor
GO

						---=====MULTIPLICATION OPERATORS=====
					--=============================================================


SELECT (labcharge*medicineCost)AS Total FROM Reciption
GO

						---=====TOP CLAUSE WITH TIES=====
				--=============================================================


SELECT TOP 5 WITH TIES patientId,PatientName,admitDate FROM Patient
Order By patientId
GO

					---===== COMPARISON,LOGICAL AND BETWEEN OPERATOR=====
				--=============================================================


SELECT * FROM patient WHERE disease ='Tuimer'
AND admitdate BETWEEN '2022-03-10' AND '2022-06-15'
GO

								---=====IN OPERATOR=====


SELECT patientId FROM Patient WHERE patientId IN(SELECT patientId FROM Room)
GO

							---=====NOT IN OPERATOR=====


SELECT patientId FROM Patient WHERE patientId NOT IN(SELECT patientId FROM Room)
GO

								---=====LIKE OPERATOR=====
						--=============================================================


SELECT * FROM Doctor WHERE doctorName LIKE 'Ta%'
GO

								--======OFFSET FETCH ============--
						--=============================================================


SELECT * FROM Reciption 
ORDER BY paymentId
OFFSET 5 ROWS
GO

						--====OFFSET 2 ROWS AND GET NEXT 3 ROWS ======--
				--=============================================================



SELECT *FROM Patient ORDER BY patientId
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY

							--============== UNION ============--
					--=============================================================


SELECT * FROM Patient WHERE patientId IN(1,2)
UNION
SELECT * FROM Patient WHERE patientId IN(3,4)
GO

									
									--======JOIN ============--
				--=============================================================


								--======INNER JOIN ============--
						--=============================================================



SELECT e. EmployeeId,e.employeeType,d.doctorName FROM Doctor d
INNER JOIN Employees e ON e.employeeID=d.employeeId
GO

								--======OUTER JOIN ============--
								----LEFT OUTER JOIN----
				--=============================================================



SELECT e. EmployeeId,e.employeeType,d.doctorName FROM Doctor d
LEFT OUTER JOIN Employees e ON e.employeeID=d.employeeId
GO

									----RIGHT OUTER JOIN----
						--=============================================================



SELECT e. EmployeeId,e.employeeType,d.doctorName FROM Doctor d
Right OUTER JOIN Employees e ON e.employeeID=d.employeeId
GO

										----- FULL JOIN-----
					--=============================================================


SELECT e. EmployeeId,e.employeeType,d.doctorName FROM Doctor d
Right OUTER JOIN Employees e ON e.employeeID=d.employeeId
GO

										----- CROSS JOIN------
							--=============================================================


SELECT p.patientId,p.PatientName,p.admitDate,pR.relativeName FROM Patient p
CROSS JOIN patientRelative pR
Order By p.admitDate

	--==========================================================================

						--============== AGGREGATE FUNCTION ============--

			--==========================================================================


SELECT paymentId,patientId,AVG(labCharge)AS Average FROM Reciption
GO		

SELECT SUM(labCharge)AS Total FROM Reciption
GO

SELECT MIN(labCharge)AS Lowest FROM Reciption
GO

SELECT MAX(labCharge)AS Highest FROM Reciption
GO

SELECT COUNT (*) AS NumberOfRow FROM Patient

GO

						--======= AGGREGATE FUNCTION WITH GROUP BY  =======--
				--=============================================================


SELECT paymentId,patientId,AVG(labCharge)AS Average FROM Reciption
GROUP BY paymentId,patientId
GO

					--====== AGGREGATE FUNCTION WITH GROUP BY AND HAVING ======--
					--=============================================================



SELECT paymentId,patientId,AVG(labCharge)AS Average FROM Reciption
GROUP BY paymentId,patientId
HAVING AVG(labCharge)>0
GO

								--======= ROLLUP  OPERATOR =====--
				--=============================================================


SELECT roomId,roomtype,AVG(roomcost)AS total FROM Room
GROUP BY ROLLUP (roomId,roomtype)
GO

									--===== CUBE OPERATOR ====--


SELECT roomId,AVG(roomcost)AS total FROM Room
GROUP BY CUBE (roomId)
GO

									--===== GROUPING SETS =====--


SELECT roomId,roomtype,AVG(roomcost)AS total FROM Room
GROUP BY GROUPING SETS (roomId,roomtype)
GO

						--============== EXCEPT INTERSECT ============--
					--=============================================================


-- EXCEPT
SELECT * FROM Employees

EXCEPT

SELECT * FROM Employees WHERE employeeId = 3
GO


--INTERSECT

SELECT * FROM Patient WHERE patientId >2

INTERSECT

SELECT * FROM Patient WHERE patientId >5
GO


							--============== SUB-QUERIES============--
				--=============================================================



SELECT * FROM Patient WHERE patientId IN(SELECT patientId FROM Reciption)
GO


									----=====ANY====----
				--=============================================================


SELECT * FROM Patient WHERE patientId =ANY (SELECT patientId FROM Reciption)
GO

									----=====SOME====----


SELECT * FROM Patient WHERE patientId =SOME (SELECT patientId FROM Reciption)
GO

			
									----=====ALL====---
					--=============================================================


SELECT * FROM Patient WHERE patientId >ALL (SELECT patientId FROM Patient WHERE patientId<=2)
GO							

									----=====EXISTS====----
						--=============================================================



SELECT * FROM Doctor d 
WHERE EXISTS (SELECT p.doctorId FROM Patient p WHERE  p.doctorId=d.doctorId)
GO

								--============== CTE ============--
					--=============================================================

WITH CTEPatient AS
(

		SELECT patientId,patientName,gender,[address] FROM Patient
)
SELECT * FROM CTEPatient
GO

								--============== MERGE ============--
						--=============================================================



	MERGE Cleaner AS TARGET
USING Gurd AS SOURCE ON TARGET.id=SOURCE.id
WHEN NOT MATCHED THEN
INSERT(id,[name])VALUES(id,[name]);
GO
SELECT * FROM Cleaner



						--==============USING FUNCTION============--
				--=============================================================


----GET MONTH NAME

SELECT DATENAME(MONTH, GETDATE()) AS 'Month'


---GETDATE

SELECT GETDATE()



---CAST

SELECT CAST('01-July-2021 9:00AM'AS date) 'Date'



---CONVERT

DECLARE @MyTime DATETIME='01-July-2021 9:00AM'
SELECT CONVERT(VARCHAR,@MyTime,8)'Time'



							--============== CASE ============--
				--=============================================================


SELECT roomId,roomtype,roomCost,
CASE
	WHEN RoomType='Cabin' THEN 'Nice'
	WHEN RoomType='VIP' THEN 'Great'
ELSE 'NA'
END
FROM Room
GO

						   --==============  IIF ============--
					 --=============================================================


SELECT labId,SUM(amount)AS Total,IIF(SUM(amount)>2000,'High','Poor') FROM Lab
GROUP BY labId
GO


							   --==============  CHOOSE ============--
					 --=============================================================


SELECT labId,patientId,CHOOSE(labId,1,3,5)AS CHOOSENUMBER FROM Lab


						--==============  RANKING FUNCTION ============--
				--=============================================================


--ROW_NUMBER Funtion
SELECT ROW_NUMBER() OVER(Order By patientName DESC)AS Number,patientId ,patientName,[address] FROM Patient
GO


---RANK Function
SELECT  patientId ,patientName,[address],RANK() OVER(Order By patientName)As 'Rank' FROM Patient


---DENSE RANK Function
SELECT  patientId ,patientName,[address],DENSE_RANK() OVER(Order By patientName)As 'DENSE_Rank' FROM Patient

---NTILE function

SELECT  patientId ,patientName,[address],NTILE(2) OVER(Order By patientName)As 'NTILE' FROM Patient
GO

							--==============  TRY CATCH ============--
					--=============================================================


BEGIN TRY
	SELECT 1/0 AS result
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_LINE () AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure
			
END CATCH
GO

								--============== IF ============--
					--=============================================================

DECLARE @Mark INT
SET @Mark=60

IF  @Mark<50
BEGIN
	PRINT 'You are Pass'

END
GO


								--============== LOOP ============--
					--=============================================================


DECLARE @val INT=0
WHILE @val<100
	BEGIN
		IF(@val=30)
			BREAK
		PRINT @val
		SET @val=@val+1
	END
GO

								--============== TRANSACTION ============--
					--=============================================================


SELECT * INTO #tProduct
FROM tProduct
GO
SELECT * FROM #tProduct
GO

BEGIN TRANSACTION
DELETE FROM #tProduct WHERE productId = 1
	SAVE TRANSACTION tran1
DELETE FROM #tProduct WHERE productId = 2
	SAVE TRANSACTION tran2
DELETE FROM #tProduct WHERE productId = 3
			SAVE TRANSACTION tran3
SELECT * FROM #tProduct
		ROLLBACK TRANSACTION tran2
SELECT * FROM #tProduct
		ROLLBACK TRANSACTION tran1
SELECT * FROM #tProduct
	COMMIT TRANSACTION
GO




--------------------------------------------  END --------------------------------------------------------