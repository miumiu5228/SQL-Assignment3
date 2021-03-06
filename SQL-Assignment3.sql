
/*
-In SQL Server, assuming you can find the result by using both joins and subqueries, which one would you prefer to use and why?
 What is CTE and when to use it?
 I will use subqueries since it has a better time complexity.

-What are Table Variables? What is their scope and where are they created in SQL Server?
 The table variable is a special type of the local variable that helps to store data temporarily. 
 We can define a table variable inside a stored procedure and function as well. 
 In this case, the table variable scope is within the stored procedure and function. 
 We cannot use it outside the scope of the batch, stored procedure or function.
 

-What is the difference between DELETE and TRUNCATE? Which one will have better performance and why?
 DELETE deletes records one by one and makes an entry for each and every deletion in the transaction log, 
 whereas TRUNCATE de-allocates pages and makes an entry for de-allocation of pages in the transaction log.

-What is Identity column? How does DELETE and TRUNCATE affect it?
 An identity column is a column in a database table that is made up of values generated by the database
 "Delete" retains the identity and does not reset it to the seed value. "Truncate" command reset the identity to its seed value.

*/

USE Northwind



SELECT DISTINCT C.City FROM dbo.Customers C
JOIN dbo.Employees E ON C.City = E.City


SELECT DISTINCT C.City FROM dbo.Customers C
LEFT JOIN dbo.Employees E ON C.City != E.City


SELECT DISTINCT C.City FROM dbo.Customers C
WHERE C.City NOT IN
(
	SELECT E.City FROM dbo.Employees E
)

SELECT O.ProductID, SUM(O.Quantity) AS theCount FROM dbo.[Order Details] O
GROUP BY ProductID


SELECT O.ShipCity, SUM(OD.Quantity) AS theTotal FROM dbo.[Order Details] OD
JOIN dbo.Orders O ON OD.OrderID = O.OrderID
GROUP BY O.ShipCity


SELECT O.ShipCity FROM dbo.Orders O
WHERE O.ShipCity IN
(
	SELECT O.ShipCity FROM dbo.Orders O
	GROUP BY O.ShipCity
	HAVING COUNT(O.ShipName) >=2
) 



SELECT O.ShipCity,COUNT(OD.ProductID) FROM dbo.[Order Details] OD
JOIN dbo.Orders O ON O.OrderID = OD.OrderID
GROUP BY O.ShipCity
HAVING COUNT(OD.ProductID) >=2


SELECT O.ShipName FROM dbo.Customers C
JOIN dbo.Orders O ON C.CustomerID = C.CustomerID
WHERE C.City != O.ShipCity



SELECT TOP 5 OD.ProductID, AVG(od.UnitPrice) AS theAvg FROM dbo.[Order Details] OD
GROUP BY OD.ProductID
HAVING SUM(OD.Quantity) > 0
ORDER BY 2 DESC 




SELECT O.ShipCity, COUNT(OD.ProductID) FROM dbo.Orders O 
JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.ShipCity



SELECT E.City FROM dbo.Employees E
WHERE E.City NOT IN
(
	SELECT O.ShipCity FROM dbo.Orders O
)


SELECT DISTINCT E.City FROM dbo.Employees E
JOIN dbo.Orders O ON E.EmployeeID = O.EmployeeID
WHERE E.City NOT LIKE O.ShipCity


SELECT TOP 1 O.ShipCity FROM dbo.Orders O
GROUP BY O.ShipCity
HAVING COUNT(O.OrderID) >0
ORDER BY COUNT(O.OrderID) DESC


/*
11. How do you remove the duplicates record of a table?
	Use "Distinct" to remove dupicate record.

12. Sample table to be used for solutions below- Employee ( empid integer, mgrid integer, deptid integer, salary integer) Dept (deptid integer, deptname text)
    Find employees who do not manage anybody.

	SELECT A.empid, B.empid  FROM Employee A, Employee B
	WHERE B.empid NOT IN A.empid 

13. Find departments that have maximum number of employees. (solution should consider scenario having more than 1 departments that have maximum number of employees). Result should only have - deptname, count of employees sorted by deptname.
	
	SELECT deptname FROM
	(
		SELECT TOP1 D.deptname, COUNT(E.empid) FROM Employee E
		JOIN Dept D ON D.depid = E.depid
		ORDER BY 2 DESC
	)


14. Find top 3 employees (salary based) in every department. Result should have deptname, empid, salary sorted by deptname and then employee with high to low salary.
	
	WITH salaryCTE AS
	(
		SELECT deptname, empid, salary, DENSE_RANK() OVER(PARTITION BY empid ORDER BY salary DESC) AS rank 
		FROM salary 
	)
	SELECT deptname, empid, salary FROM salaryCTE
	WHERE rank <=3

*/






