use [tempdb]
go
 
declare @tableName sysname
declare @objectID int
 
set @tableName = '[dbo].[CourseManagerUserLog_IE]'
set @objectID = object_id(@tableName)
 
SELECT
 
         [ObjectId]
 
        ,[ObjectName]
 
        ,[IndexId]
 
        ,[indexName]
 
        ,[IndexType]
 
        ,indexLevel
 
        ,[IndexSize(MB)]
            = CONVERT
                (
                      DECIMAL(16, 1)
                    , (SUM([avg_record_size_in_bytes] * [record_count]) / (1024.0 * 1024))
                )
 
        ,[StatisticLastUpdated]
            = max([lastupdated])
 
        , [AvgFragmentationInPercent]
            = avg([AvgFragmentationInPercent])
 
FROM (
 
        SELECT
               ObjectID = tblInd.OBJECT_ID
 
            ,  ObjectName
                = QuoteName
                    (
                        object_schema_name
                            (tblInd.object_id)
                    )
                    + '.'
                    + 
                    QuoteName
                    (
                        object_name
                        (
                            tblInd.object_id
                        )
                    )
 
            , [indexName]
                = tblSysInd.name
 
            , IndexID = tblInd.Index_ID
            , IndexType = Index_Type_Desc
            , IndexLevel = index_level
            , avg_record_size_in_bytes
            , record_count
            , LastUpdated
                = STATS_DATE
                    (
                          tblInd.object_id
                        , tblInd.index_id
                    )
            , AvgFragmentationInPercent
                = round(Avg_Fragmentation_In_Percent, 3)
 
        FROM sys.dm_db_index_physical_stats
            (
                  db_id()
                , @objectID
                , NULL
                , NULL
                , 'detailed'
            ) tblInd
 
        inner join sys.indexes tblSYSIND
 
            on tblInd.object_id = tblSysInd.object_id
            and tblInd.index_id = tblSysInd.index_id
 
        where index_level = 0
 
    ) T
 
GROUP BY
 
      ObjectId
    , ObjectName
    , IndexId
    , [indexName]
    , IndexType
    , indexLevel