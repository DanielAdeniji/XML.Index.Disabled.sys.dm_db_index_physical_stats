use [tempdb]
go
 
declare @tableName sysname
declare @objectID int
 
set @tableName = '[dbo].[CourseManagerUserLog_ID]'
set @objectID = object_id(@tableName)
 
 
select
      tblSI.name
        , tblSI.index_id
    , tbLSI.is_disabled
 
from   sys.indexes tblSI
 
where  tblSI.object_id = @objectID
 
order by tblSI.index_id