CREATE OR ALTER VIEW Gold.vwDimProducts AS
    SELECT 
           ROW_NUMBER() OVER(ORDER BY PIO.sls_key,PIO.prd_start_dt) as ProductKey
          ,pio.[prd_id] AS ProductID
          ,pio.[prd_nm] AS ProductName
          ,pio.[sls_key] AS ProductNumber 
          ,pio.[prd_cost] AS ProductCost
          ,pio.[prd_line] AS ProductLine
          ,pio.[cat_id] AS CategoryID
          ,pc.[CAT] AS Category
          ,pc.[SUBCAT] AS SubCategory
          ,pio.[prd_start_dt] AS StartDate
          ,pc.[MAINTENANCE] AS Maintenance
    FROM silver.crm_prd_info as pio LEFT JOIN silver.erp_px_cat_g1v2 as pc ON pio.cat_id=pc.ID
    WHERE PIO.prd_end_dt>'9999-12-29' -- TO DISPLAY ONLY ACTIVE RECORDS