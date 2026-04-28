/*=================================================
			DATA QUALITY CHECK

			TABLE - erp_loc_a101
=================================================
*/


-- EXTRA SPACE
-- EXPECTED RESULT: NO RECORDS

SELECT * FROM [DataWarehouse].[bronze].[erp_loc_a101] WHERE CID != TRIM(CID) OR CNTRY!=TRIM(CNTRY)

-- REPLACE "-"

SELECT REPLACE([CID],'-','') AS CID
      ,[CNTRY] FROM [DataWarehouse].[bronze].[erp_loc_a101] 

-- FIX COUNTRY COLUMN

SELECT DISTINCT [CNTRY] FROM [DataWarehouse].[bronze].[erp_loc_a101] 


SELECT REPLACE([CID],'-','') AS CID
      ,case TRIM(upper(ISNULL([CNTRY],'')))
      when 'US' THEN 'United States'
      WHEN 'DE' THEN 'Germany'
      when 'USA' THEN 'United States'
      WHEN '' THEN 'N/A'
      ELSE TRIM(CNTRY)
      END CNTRY
      FROM [DataWarehouse].[bronze].[erp_loc_a101] 