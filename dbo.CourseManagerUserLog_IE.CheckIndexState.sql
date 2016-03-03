use [tempdb]
go
 
declare @tableName sysname
declare @objectID int
 
set @tableName = '[dbo].[CourseManagerUserLog_IE]'
set @objectID = object_id(@tableName)
 
select
      ObjectName
        = object_name(tblSI.object_id)
    , [indexName]
            = tblSI.name
        , tblSI.index_id
    , tbLSI.is_disabled
from   sys.indexes tblSI
where  tblSI.object_id = @objectID
order by tblSI.index_id