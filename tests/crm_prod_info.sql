/*
=================================================
			DATA QUALITY CHECK

			TABLE - CRM_PRD_INFO
=================================================
*/


-- Duplicates and NULL values in primary key
-- EXPECTED RESULT: NO RECORDS

select prd_id,count(*) from bronze.crm_prd_info group by prd_id having count(*) >1

-- Checking for any additional space

SELECT *  FROM [DataWarehouse].[bronze].[crm_prd_info]  where prd_nm!=trim(prd_nm)

-- Defined columns

SELECT [prd_id]
   ,[prd_key]
   ,replace(SUBSTRING(prd_key,1,5),'-','_') as cat_id
   ,SUBSTRING(prd_key,7) as sls_key
   ,[prd_nm]
   ,[prd_cost]
   ,[prd_line]
   ,[prd_start_dt]
   ,[prd_end_dt]
FROM [DataWarehouse].[bronze].[crm_prd_info]

-- negative and null cost
-- EXPECTED RESULT: NO RECORDS
  
SELECT *  FROM [DataWarehouse].[bronze].[crm_prd_info]  where prd_cost<0 or prd_cost is null

-- Quality of DATES
-- EXPECTED RESULT: NO RECORDS

SELECT * FROM [DataWarehouse].[bronze].[crm_prd_info] where prd_start_dt>prd_end_dt