select * from dbo.inventory_analysis_final
sp_help 'inventory_analysis_final'

select t.TABLE_CATALOG, t.TABLE_SCHEMA,T.TABLE_NAME,C.COLUMN_NAME
from STG_Sales_Analysis.INFORMATION_SCHEMA.TABLES T inner join STG_Sales_Analysis.INFORMATION_SCHEMA.COLUMNS C on T.Table_Name = C.Table_Name
where t.TABLE_NAME like 'STG%'

select CONCAT('A','-','B')

select concat(DM.QRY , ' ' , STG.QRY , char(13) , ' GO ', char(13))
from
(
SELECT DISTINCT ST2.TABLE_NAME, 
    concat('Select ',SUBSTRING(
        (
            SELECT ','+ST1.COLUMN_NAME  AS [text()]
            FROM ( select t.TABLE_SCHEMA,T.TABLE_NAME,C.COLUMN_NAME
					from STG_Sales_Analysis.INFORMATION_SCHEMA.TABLES T inner join STG_Sales_Analysis.INFORMATION_SCHEMA.COLUMNS C on T.Table_Name = C.Table_Name
					where t.TABLE_NAME like 'STG%') ST1
            WHERE ST1.TABLE_NAME = ST2.TABLE_NAME
            ORDER BY ST1.TABLE_NAME
            FOR XML PATH (''), TYPE
        ).value('text()[1]','nvarchar(max)'), 2, 1000), ' From ', st2.TABLE_CATALOG, '.' ,  ST2.TABLE_SCHEMA , '.', ST2.TABLE_NAME) [QRY]
FROM ( select t.TABLE_CATALOG, t.TABLE_SCHEMA,T.TABLE_NAME,C.COLUMN_NAME
					from STG_Sales_Analysis.INFORMATION_SCHEMA.TABLES T inner join STG_Sales_Analysis.INFORMATION_SCHEMA.COLUMNS C on T.Table_Name = C.Table_Name
					where t.TABLE_NAME like 'STG%') ST2
) STG 
inner join 
(
SELECT DISTINCT ST2.TABLE_NAME, 
    concat('Insert into ',st2.TABLE_CATALOG, '.' ,  ST2.TABLE_SCHEMA , '.', ST2.TABLE_NAME,' (',SUBSTRING(
        (
            SELECT ','+ST1.COLUMN_NAME  AS [text()]
            FROM ( select t.TABLE_SCHEMA,T.TABLE_NAME,C.COLUMN_NAME
					from DM_Sales_Analysis.INFORMATION_SCHEMA.TABLES T inner join DM_Sales_Analysis.INFORMATION_SCHEMA.COLUMNS C on T.Table_Name = C.Table_Name
					where t.TABLE_NAME like 'DIM%') ST1
            WHERE ST1.TABLE_NAME = ST2.TABLE_NAME
            ORDER BY ST1.TABLE_NAME
            FOR XML PATH (''), TYPE
        ).value('text()[1]','nvarchar(max)'), 2, 1000) , ') ') [QRY]
FROM ( select t.TABLE_CATALOG, t.TABLE_SCHEMA,T.TABLE_NAME,C.COLUMN_NAME
					from DM_Sales_Analysis.INFORMATION_SCHEMA.TABLES T inner join DM_Sales_Analysis.INFORMATION_SCHEMA.COLUMNS C on T.Table_Name = C.Table_Name
					where t.TABLE_NAME like 'DIM%') ST2
) DM on trim(STG.Table_Name) = trim(replace(DM.Table_Name,'DIM_','STG_'))

