/*=================================================
			DATA QUALITY CHECK

			TABLE - erp_px_cat_g1v2
=================================================
*/


-- Additional Space
-- EXPECTED RESULT: NO RECORDS

SELECT * FROM [DataWarehouse].[bronze].[erp_px_cat_g1v2] WHERE SUBCAT!=TRIM(SUBCAT)

-- NULL values
-- EXPECTED RESULT: NO RECORDS

SELECT * FROM [DataWarehouse].[bronze].[erp_px_cat_g1v2] WHERE id is null

-- distinct maintenance
-- EXPECTED RESULT: NO RECORDS

SELECT distinct maintenance FROM [DataWarehouse].[bronze].[erp_px_cat_g1v2]