/*
WARNING: This script will DROP and RECREATE the listed tables.
All existing data in these tables will be permanently deleted.

Use with caution and ensure that any required data is backed up
before executing this script.
*/

use DataWarehouse

GO
-- Checks if the table already exist
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
DROP TABLE  bronze.crm_cust_info

GO
-- CREATE TABLE CRM_CUST_INFO IN SCHEMA bronze
CREATE TABLE bronze.crm_cust_info (
cst_id	INT,
cst_key	VARCHAR(20),
cst_firstname VARCHAR(20),
cst_lastname VARCHAR(20),
cst_marital_status VARCHAR(2),
cst_gndr VARCHAR(2),
cst_create_date DATE);

GO
-- Checks if the table already exist
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
DROP TABLE  bronze.crm_prd_info

GO
-- CREATE TABLE crm_prd_info IN SCHEMA bronze
CREATE TABLE bronze.crm_prd_info (
prd_id	INT,
prd_key	VARCHAR(20),
prd_nm VARCHAR(30),
prd_cost INT,
prd_line VARCHAR(2),
prd_start_dt DATE,
prd_end_dt DATE);

GO
-- Checks if the table already exist
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
DROP TABLE  bronze.crm_sales_details

GO
-- CREATE TABLE crm_prd_info IN SCHEMA bronze
CREATE TABLE bronze.crm_sales_details (
sls_ord_num	VARCHAR(20),
sls_prd_key	VARCHAR(20),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT);

GO

-- ERP TABLES
GO
-- Checks if the table already exist
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
DROP TABLE  bronze.erp_cust_az12

GO
-- CREATE TABLE CRM_CUST_INFO IN SCHEMA bronze
CREATE TABLE bronze.erp_cust_az12 (
CID	VARCHAR(20),
BDATE DATE,
GEN VARCHAR(10));

GO
-- Checks if the table already exist
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
DROP TABLE  bronze.erp_loc_a101

GO
-- CREATE TABLE crm_prd_info IN SCHEMA bronze
CREATE TABLE bronze.erp_loc_a101 (
CID	VARCHAR(20),
CNTRY VARCHAR(30));

GO
-- Checks if the table already exist
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
DROP TABLE  bronze.erp_px_cat_g1v2

GO
-- CREATE TABLE crm_prd_info IN SCHEMA bronze
CREATE TABLE bronze.erp_px_cat_g1v2 (
ID	VARCHAR(10),
CAT	VARCHAR(20),
SUBCAT VARCHAR(20),
MAINTENANCE VARCHAR(10));