"# XML.Index.Disabled.sys.dm_db_index_physical_stats" 

1) Create table - dbo.CourseManagerUserLog_ID

  a) Create table - XML Index Initially disabled
      dbo.CourseManagerUserLog_ID.CreateTable.sql
      
  b) Check Index State
    dbo.CourseManagerUserLog_ID.CheckIndexState.sql
    
  c) Check Index Size
     dbo.CourseManagerUserLog_ID.CheckIndexSize.sql
     
     

2) Create table - dbo.CourseManagerUserLog_IE

  a) Create table - XML Index Initially Enabled
      dbo.CourseManagerUserLog_IE.CreateTable.sql
      
  b) Check Index State
    dbo.CourseManagerUserLog_IE.CheckIndexState.sql
    
  c) Check Index Size
     dbo.CourseManagerUserLog_IE.CheckIndexSize.sql
     
  d) Disable Primary XML Index 
    dbo.CourseManagerUserLog_IE.DisablePrimaryXMLIndex.sql
    
    
     
     
