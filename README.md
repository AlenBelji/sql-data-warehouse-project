# sql-data-warehouse-project
SQL data warehouse project 

The data warehouse is designed with medallion architecture. The three layers are:

   Bronze- Row data as it is for texting and error handling
   Silver- Layer on which the first level of processing is done like standardization, cleaning, aggregation etc
   Gold  - Final level of processing like implemention business logic to make it user ready

