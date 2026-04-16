
CREATE OR ALTER PROCEDURE gold.dim_load_sch_full_empployee
AS
BEGIN 
     merge [gold].[dim_sch_full_empployee] AS target
     using [silver].[dim_sch_full_empployee] AS source
           ON target.Name = source.Name
     WHEN MATCHED AND (
              target.GroupName <> source.GroupName
           OR target.Name_Shoft <> source.Name_Shoft
	       OR target.LoginID <> source.LoginID
	       OR target.JobTitle <> source.JobTitle
	       OR target.SickLeaveHours <>  source.SickLeaveHours
     )

     THEN UPDATE SET 
            target.GroupName = source.GroupName,
            target.Name_Shoft = source.Name_Shoft,
	        target.LoginID = source.LoginID,
	        target.JobTitle = source.JobTitle,
	        target.SickLeaveHours =  source.SickLeaveHours,
            target.last_update = GETDATE()

     WHEN NOT MATCHED BY target
     THEN
        INSERT(Name,GroupName,Name_Shoft,LoginID,JobTitle,SickLeaveHours,last_update)
        VALUES(source.Name,source.GroupName,source.Name_Shoft,source.LoginID,source.JobTitle,source.SickLeaveHours,GETDATE())
     WHEN NOT MATCHED BY source
     THEN DELETE;
        
END

EXEC gold.dim_load_sch_full_empployee



