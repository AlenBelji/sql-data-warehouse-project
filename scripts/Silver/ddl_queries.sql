/*
WARNING: This script will DROP and RECREATE the listed tables.
All existing data in these tables will be permanently deleted.

Use with caution and ensure that any required data is backed up
before executing this script.
*/

use DataWarehouse



GO
-- Checks if the table already exist
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
DROP TABLE  silver.crm_cust_info

GO
-- CREATE TABLE CRM_CUST_INFO IN SCHEMA silver
CREATE TABLE silver.crm_cust_info (
cst_id	INT,
cst_key	VARCHAR(20),
cst_firstname VARCHAR(20),
cst_lastname VARCHAR(20),
cst_marital_status VARCHAR(10),
cst_gndr VARCHAR(10),
cst_create_date DATE,
dwh_create_date DATETIME DEFAULT GETDATE());

GO
-- Checks if the table already exist
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
DROP TABLE  silver.crm_prd_info

GO
-- CREATE TABLE crm_prd_info IN SCHEMA silver
CREATE TABLE silver.crm_prd_info (
prd_id	INT,
cat_id	VARCHAR(10),
sls_key	VARCHAR(15),
prd_nm VARCHAR(50),
prd_cost INT,
prd_line VARCHAR(15),
prd_start_dt DATE,
prd_end_dt DATE,
dwh_create_date DATETIME DEFAULT GETDATE());

GO
-- Checks if the table already exist
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
DROP TABLE  silver.crm_sales_details

GO
-- CREATE TABLE crm_sales_details IN SCHEMA silver
CREATE TABLE silver.crm_sales_details (
sls_ord_num	VARCHAR(20),
sls_prd_key	VARCHAR(20),
sls_cust_id INT,
sls_order_dt DATE,
sls_ship_dt DATE,
sls_due_dt DATE,
sls_sales INT,
sls_quantity INT,
sls_price INT,
dwh_create_date DATETIME DEFAULT GETDATE());

GO

-- ERP TABLES
GO
-- Checks if the table already exist
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
DROP TABLE  silver.erp_cust_az12

GO
-- CREATE TABLE erp_cust_az12 IN SCHEMA silver
CREATE TABLE silver.erp_cust_az12 (
CID	VARCHAR(20),
BDATE DATE,
GEN VARCHAR(10),
dwh_create_date DATETIME DEFAULT GETDATE());

GO
-- Checks if the table already exist
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
DROP TABLE  silver.erp_loc_a101

GO
-- CREATE TABLE erp_loc_a101 IN SCHEMA silver
CREATE TABLE silver.erp_loc_a101 (
CID	VARCHAR(20),
CNTRY VARCHAR(30),
dwh_create_date DATETIME DEFAULT GETDATE());

GO
-- Checks if the table already exist
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
DROP TABLE  silver.erp_px_cat_g1v2

GO
-- CREATE TABLE erp_px_cat_g1v2 IN SCHEMA silver
CREATE TABLE silver.erp_px_cat_g1v2 (
ID	VARCHAR(10),
CAT	VARCHAR(20),
SUBCAT VARCHAR(20),
MAINTENANCE VARCHAR(10),
dwh_create_date DATETIME DEFAULT GETDATE());