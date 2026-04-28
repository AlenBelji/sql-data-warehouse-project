/*
=================================================
			DATA QUALITY CHECK

			TABLE - CRM_CUST_INFO
=================================================
*/


-- Duplicates and NULL values in primary key
-- EXPECTED RESULT: NO RECORDS
SELECT CST_ID,COUNT(*) FROM bronze.crm_cust_info group by cst_id having count(*) >1 or cst_id is NULL

-- Additional Space
-- EXPECTED RESULT: NO RECORDS

SELECT * FROM bronze.crm_cust_info WHERE  cst_lastname!=trim(cst_lastname)

-- Abbreviation to full name
-- EXPECTED RESULT: FULL NAMES

SELECT DISTINCT UPPER(CST_MARITAL_STATUS) FROM bronze.crm_cust_info