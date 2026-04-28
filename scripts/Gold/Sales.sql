CREATE OR ALTER VIEW gold.vwFctSales AS
    SELECT
           sd.[sls_ord_num] AS OrderNumber
          ,c.CustomerKey AS CustomerKey
          ,p.ProductKey AS ProductKey
          ,sd.[sls_sales] AS Sales
          ,sd.[sls_quantity] AS Quantity
          ,sd.[sls_price] AS Price
          ,sd.[sls_order_dt] AS OrderDate
          ,sd.[sls_ship_dt] AS ShipDate
          ,sd.[sls_due_dt] AS DueDate
    FROM silver.crm_sales_details AS sd LEFT JOIN gold.vwDimCustomers AS c ON sd.sls_cust_id=c.CustomerID
    LEFT JOIN gold.vwDimProducts AS p ON sd.sls_prd_key = p.ProductNumber 