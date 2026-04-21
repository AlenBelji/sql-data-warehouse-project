/*
WARNING - The data in the table will be truncated and full load will be performed
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze as
BEGIN

DECLARE @Start_time DATETIME,@End_time DATETIME,@start DATETIME,@end DATETIME


	BEGIN TRY
		
		set @start=getdate();

		PRINT '===============================================================';
		PRINT '						Loading bronze Layer'
		PRINT '===============================================================
		';

		PRINT '---------------------------------------------------------------';
		PRINT '					   Loading into ERP Tables'
		PRINT '---------------------------------------------------------------
		';
		
		
	
		PRINT '>> TRUNCATING TABLE - bronze.erp_px_cat_g1v2';
		SET @Start_time=GETDATE();
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;

			PRINT '>> INSERTING INTO TABLE - bronze.erp_px_cat_g1v2';

			BULK INSERT bronze.erp_px_cat_g1v2 FROM 
			'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv' WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @End_time=GETDATE();
		
		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - bronze.erp_loc_a101';
			TRUNCATE TABLE bronze.erp_loc_a101;

			PRINT '>> INSERTING INTO TABLE - bronze.erp_loc_a101';

			BULK INSERT bronze.erp_loc_a101 FROM 
			'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv' WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @End_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - bronze.erp_cust_az12';
			TRUNCATE TABLE bronze.erp_cust_az12;

			PRINT '>> INSERTING INTO TABLE - bronze.erp_cust_az12';

			BULK INSERT bronze.erp_cust_az12 FROM 
			'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv' WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		PRINT '---------------------------------------------------------------';
		PRINT '					   Loading into ERP Tables';
		PRINT '---------------------------------------------------------------
		';

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - bronze.crm_sales_details';
			TRUNCATE TABLE bronze.crm_sales_details;

			PRINT '>> INSERTING INTO TABLE - bronze.crm_sales_details';

			BULK INSERT bronze.crm_sales_details FROM 
			'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv' WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - bronze.crm_prd_info';
			TRUNCATE TABLE bronze.crm_prd_info;

			PRINT '>> INSERTING INTO TABLE - bronze.crm_prd_info';

			BULK INSERT bronze.crm_prd_info FROM 
			'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv' WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time=GETDATE();

		PRINT 'LOAD DURATION '+CAST(DATEDIFF(SECOND,@Start_time,@End_time) as varchar(10))+' seconds'
		print '-----------'

		SET @Start_time=GETDATE();
			PRINT '>> TRUNCATING TABLE - bronze.crm_cust_info';
			TRUNCATE TABLE bronze.crm_cust_info;

			PRINT '>> INSERTING INTO TABLE - bronze.crm_cust_info';

			BULK INSERT bronze.crm_cust_info FROM 
			'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv' WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
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
