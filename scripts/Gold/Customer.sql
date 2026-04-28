CREATE OR ALTER VIEW Gold.vwDimCustomers AS
   SELECT 
        ROW_NUMBER() OVER(ORDER BY ci.cst_id) as CustomerKey
        ,ci.[cst_id] as CustomerID
        ,ci.[cst_key] AS CustomerNumber
        ,ci.[cst_firstname] AS FirstName
        ,ci.[cst_lastname] AS LastName
        ,cl.[CNTRY] as Country

        ,case -- To retrive the correct data
            when ci.[cst_gndr] != 'N/A' then ci.cst_gndr
            else coalesce(ca.gen,'N/A') 
        end AS Gender
        ,ci.[cst_marital_status] as MaritalStatus
      
        ,ca.[BDATE] as BirthDate
        ,ci.[cst_create_date] as CreateDate

    FROM silver.crm_cust_info AS ci LEFT JOIN silver.erp_cust_az12 AS ca ON ci.cst_key = ca.CID
    LEFT JOIN silver.erp_loc_a101 AS cL ON ci.cst_key = cl.CID
