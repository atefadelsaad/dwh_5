
CREATE OR ALTER PROCEDURE silver.load_sch_full_empployee
AS
BEGIN
    INSERT INTO silver.dim_sch_full_empployee
	SELECT 
	d.Name,
	d.GroupName,
	s.Name as Name_Shoft,
	e.LoginID,
	e.JobTitle,
	e.SickLeaveHours
	FROM [bronze].[erp_Departmen] d
	INNER JOIN [bronze].[erp_EmployeeDepartmentHistory] ed
	ON d.DepartmentID = ed.DepartmentID
	INNER JOIN [bronze].[erp_Shift] s
	ON s.ShiftID = ed.ShiftID
	INNER JOIN [bronze].[erp_Employee] e
	ON e.BusinessEntityID = ed.BusinessEntityID
END

EXEC silver.load_sch_full_empployee

