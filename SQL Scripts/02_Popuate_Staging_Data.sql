select * from dbo.Regional_Sales_Data
sp_help 'Regional_Sales_Data'

select CONCAT(COLUMN_NAME,' bigint not null constraint FK_',COLUMN_NAME,' FOREIGN KEY (',COLUMN_NAME,') references ',TABLE_SCHEMA,'.',replace(TABLE_NAME,'STG_','DIM_'),' (',COLUMN_NAME,'),')
from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
bigint NOT NULL CONSTRAINT FK_Profit_Center FOREIGN KEY (Profit_Center_ID) REFERENCES dbo.DIM_Profit_Centre (Profit_Center_ID),