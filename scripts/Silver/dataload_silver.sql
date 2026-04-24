/*
The data comign from silver has been cleaned and loaded to silver

WARNING - The data in the table will be truncated and full load will be performed
*/

CREATE OR ALTER PROCEDURE silver.load_silver as
BEGIN

DECLARE @Start_time DATETIME,@End_time DATETIME,@start DATETIME,@end DATETIME


	BEGIN TRY
		
		set @start=getdate();

		PRINT '===============================================================';
		PRINT '				Loading Silver Layer after cleansing'
		PRINT '===============================================================
		';

		PRINT '---------------------------------------------------------------';
		PRINT '					   Loading into ERP Tables'
		PRINT '---------------------------------------------------------------
		';
		
		
	
		PRINT '>> TRUNCATING TABLE - silver.erp_px_cat_g1v2';
		SET @Start_time=GETDATE();
			TRUNCATE TABLE silver.erp_px_cat_g1v2;

			PRINT '>> INSERTING INTO TABLE - silver.erp_px_cat_g1v2';

			INSERT INTO SILVER.erp_px_cat_g1v2 (
		    [ID]
		   ,[CAT]
		   ,[SUBCAT]
		   ,[MAINTENANCE])
			SELECT ID, CAT, SUBCAT,MAINTENANCE FROM [DataWarehouse].[bronze].[erp_px_cat_g1v2]

		SET @End_time=GETDATE();
		
		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - silver.erp_loc_a101';
			TRUNCATE TABLE silver.erp_loc_a101;

			PRINT '>> INSERTING INTO TABLE - silver.erp_loc_a101';

			INSERT INTO SILVER.erp_loc_a101 ([CID]
		   ,[CNTRY])
			SELECT REPLACE([CID],'-','') AS CID
		   ,case TRIM(upper(ISNULL([CNTRY],'')))
				when 'US' THEN 'UNITED STATES'
				WHEN 'DE' THEN 'GERMANY'
				when 'USA' THEN 'UNITED STATES'
				WHEN '' THEN 'N/A'
				ELSE TRIM(UPPER(CNTRY))
		    END CNTRY
		    FROM [DataWarehouse].[bronze].[erp_loc_a101] 

		SET @End_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - silver.erp_cust_az12';
			TRUNCATE TABLE silver.erp_cust_az12;

			PRINT '>> INSERTING INTO TABLE - silver.erp_cust_az12';

			INSERT INTO SILVER.ERP_CUST_AZ12 (
			[CID]
		   ,[BDATE]
		   ,[GEN])
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

		SET @end_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		PRINT '---------------------------------------------------------------';
		PRINT '					   Loading into CRM Tables';
		PRINT '---------------------------------------------------------------
		';

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - silver.crm_CUST_INFO';
			TRUNCATE TABLE silver.crm_CUST_INFO;

			PRINT '>> INSERTING INTO TABLE - silver.crm_CUST_INFO';

			INSERT INTO silver.crm_cust_info ([cst_id]
		  ,[cst_key]
		  ,[cst_firstname]
		  ,[cst_lastname]
		  ,[cst_marital_status]
		  ,[cst_gndr]
		  ,[cst_create_date]) 

			SELECT [cst_id]
			,trim([cst_key]) as cst_key
		    ,trim([cst_firstname]) as cst_firstname
		    ,trim([cst_lastname]) as cst_lastname,

			case upper(trim([cst_marital_status]))
			  WHEN 'M' THEN 'Married'
			  when 'S' THEN 'Single'
			  else 'N/A' 
			end as [cst_marital_status],

			case upper(trim([cst_gndr]))
			  WHEN 'F' THEN 'Female'
			  when 'M' THEN 'Male'
			  else 'N/A' 
			end as [cst_gndr],

			[cst_create_date] FROM (
			SELECT *,ROW_NUMBER() over(partition by cst_id order by cst_create_date desc) AS FLAG FROM
			bronze.crm_cust_info where cst_id is not NULL)T WHERE FLAG=1 

		SET @end_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - silver.crm_prd_info';
			TRUNCATE TABLE silver.crm_prd_info;

			PRINT '>> INSERTING INTO TABLE - silver.crm_prd_info';

			INSERT INTO silver.crm_prd_info (
		   [prd_id]
		  ,[cat_id]
		  ,[sls_key]
		  ,[prd_nm]
		  ,[prd_cost]
		  ,[prd_line]
		  ,[prd_start_dt]
		  ,[prd_end_dt]) 

		   SELECT  [prd_id],
		   replace(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
		   SUBSTRING(prd_key,7) as sls_key,
           trim([prd_nm]) as [prd_nm]
		  ,isnull([prd_cost],0) as [prd_cost] 

		  ,case upper(trim([prd_line]))
			  when 'T' then 'Touring'
			  when 'M' then 'Mountain'
			  when 'R' then 'Road'
			  when 'S' then 'Other sales'
			  else 'N/A'
		   end as [prd_line] 

		  ,[prd_start_dt],
		   dateadd(day,-1,lead(prd_start_dt,1,'9999-12-31') over(partition by prd_key order by prd_start_dt asc )) as [prd_end_dt]

	  FROM [DataWarehouse].[bronze].[crm_prd_info]

		SET @end_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - silver.crm_sales_details';
			TRUNCATE TABLE silver.crm_sales_details;

			PRINT '>> INSERTING INTO TABLE - silver.crm_sales_details';

			INSERT INTO silver.crm_sales_details (
		    [sls_ord_num]
		   ,[sls_prd_key]
		   ,[sls_cust_id]
		   ,[sls_order_dt]
		   ,[sls_ship_dt]
		   ,[sls_due_dt]
		   ,[sls_sales]
		   ,[sls_quantity]
		   ,[sls_price]) 

			SELECT [sls_ord_num]
			,[sls_prd_key]
			,[sls_cust_id]

			,case 
				   when [sls_order_dt]=0 OR LEN(CAST([sls_order_dt] AS VARCHAR))!=8 THEN null
				   ELSE CAST(CAST([sls_order_dt] AS varchar) AS DATE)
			end  as [sls_order_dt]

			,case 
				   when [sls_ship_dt]=0 OR LEN(CAST([sls_ship_dt] AS VARCHAR))!=8 THEN null
				   ELSE CAST(CAST([sls_ship_dt] AS varchar) AS DATE)
			end  as [sls_ship_dt]
       
			,case 
				   when [sls_due_dt]=0 OR LEN(CAST([sls_due_dt] AS VARCHAR))!=8 THEN null
				   ELSE CAST(CAST([sls_due_dt] AS varchar) AS DATE)
			end  as [sls_due_dt]

			,case
				  when sls_sales is null or sls_sales<= 0 OR sls_sales!= ABS(sls_price)*sls_quantity then sls_price*sls_quantity
				  else sls_sales
			end as sls_sales

			,sls_quantity

			,case
				  when [sls_price]<0 then ABS(sls_price)
				  when sls_price is null or sls_price= 0 then sls_sales/sls_quantity
				  else sls_price
			end as sls_price

			FROM [DataWarehouse].[bronze].[crm_sales_details]

		SET @end_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		set @end=getdate();

		PRINT '*********************'
		PRINT 'TOTAL LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start,@End) as varchar(10))+' seconds'
		PRINT '*********************'

	END TRY

	BEGIN CATCH

	PRINT '>> ERROR <<';
	PRINT 'ERROR MESSAGE - '+ERROR_MESSAGE();
	PRINT 'ERROR NUMBER - '+CAST(ERROR_NUMBER() AS VARCHAR(10));

	END CATCH

END

exec silver.load_silver