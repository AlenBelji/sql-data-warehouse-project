/*
=================================================
			DATA QUALITY CHECK

			TABLE - CRM_SALES_DETAILS
=================================================
*/


-- Additional Space
-- EXPECTED RESULT: NO RECORDS

select * from [bronze].crm_sales_details where sls_ord_num!=trim(sls_ord_num)

-- keys to other tables

select * from [bronze].crm_sales_details where sls_prd_key not in (select distinct sls_key from Silver.crm_prd_info)

select * from [bronze].crm_sales_details where sls_cust_id not in (select distinct cst_id from Silver.crm_cust_info)

-- STRING DATE TO DATE

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

      ,[sls_sales]
      ,[sls_quantity]
      ,[sls_price]
FROM [DataWarehouse].[bronze].[crm_sales_details]
  
-- Quality of DATES
-- EXPECTED RESULT: NO RECORDS

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

     ,[sls_sales]
     ,[sls_quantity]
     ,[sls_price]
  FROM [DataWarehouse].[bronze].[crm_sales_details] where [sls_order_dt]>[sls_ship_dt] or [sls_order_dt]>[sls_due_dt]

  -- Quality of sales, quatity and price

select case
      when [sls_price]<0 then ABS(sls_price)
      when sls_price is null or sls_price= 0 then sls_sales/sls_quantity
      else sls_price
      end as sls_price

      ,sls_quantity,sls_sales from bronze.crm_sales_details where sls_price <0 or sls_price is null


select case
      when [sls_price]<0 then ABS(sls_price)
      when sls_price is null or sls_price= 0 then sls_sales/sls_quantity
      else sls_price
      end as sls_price

      ,sls_quantity,sls_sales from bronze.crm_sales_details where sls_quantity <=0 or sls_quantity is null

select case
      when [sls_price]<0 then ABS(sls_price)
      when sls_price is null or sls_price= 0 then sls_sales/sls_quantity
      else sls_price
      end as sls_price

      ,sls_quantity,sls_sales from bronze.crm_sales_details where sls_sales <=0 or sls_sales is null