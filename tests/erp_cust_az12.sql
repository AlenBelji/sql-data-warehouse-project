/*=================================================
			DATA QUALITY CHECK

			TABLE - erp_cust_az12
=================================================
*/


-- NULL DATE
-- EXPECTED RESULT: NO RECORDS

SELECT * FROM [DataWarehouse].[bronze].[erp_cust_az12] WHERE BDATE IS NULL

-- NULL GENDER
-- EXPECTED RESULT: NO RECORDS

SELECT DISTINCT GEN FROM [DataWarehouse].[bronze].[erp_cust_az12]

SELECT 
      CID
     ,[BDATE]
     ,CASE UPPER([GEN])
      WHEN 'MALE' THEN 'Male'
      WHEN 'FEMALE' THEN 'Female'
      WHEN 'F' THEN 'Female'
      WHEN 'M' THEN 'Male'
      else 'N/A'
      END AS GEN
FROM [DataWarehouse].[bronze].[erp_cust_az12] 

-- NEW COLUMN

SELECT 
      CASE 
      WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
      ELSE CID
      END AS CID

     ,CASE
     WHEN [BDATE]>GETDATE() THEN NULL 
     ELSE BDATE
     END AS BDATE

     ,CASE UPPER([GEN])
      WHEN 'MALE' THEN 'Male'
      WHEN 'FEMALE' THEN 'Female'
      WHEN 'F' THEN 'Female'
      WHEN 'M' THEN 'Male'
      else 'N/A'
      END AS GEN
FROM [DataWarehouse].[bronze].[erp_cust_az12]