use [tempdb]
go
 
 
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO


 
if object_id('[dbo].[CourseManagerUserLog_ID]') is not null
begin
 
    drop table [dbo].[CourseManagerUserLog_ID]
     
end
go
 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CourseManagerUserLog_ID]') AND type in (N'U'))
BEGIN
 
CREATE TABLE [dbo].[CourseManagerUserLog_ID]
(
    [id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
    [username] [varchar](100) NOT NULL,
    [resourceID] [int] NOT NULL,
    [status] [varchar](10) NOT NULL,
    [message] [varchar](250) NULL,
    [details] [xml] NULL,
    [userID] [varchar](100) NULL,
    [refID] [varchar](100) NULL,
    [record_created] [datetime] NOT NULL
    CONSTRAINT [DF_CourseManagerUserLogCustom_record_created_1]  DEFAULT (getdate()),
 
    CONSTRAINT [PK_CourseManagerUserLogCustom_1] PRIMARY KEY CLUSTERED 
    (
       [id] ASC
    )
    ON [PRIMARY]
 ) 
 ON [PRIMARY] 
 
END
GO
 
 
/****** Object:  Index [INDX_ADMIN_CourseManagerUserLogCustom_userID]    Script Date: 3/2/2016 5:50:32 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Admin].[CourseManagerUserLog_ID]') AND name = N'INDX_ADMIN_CourseManagerUserLogCustom_userID')
CREATE NONCLUSTERED INDEX [INDX_ADMIN_CourseManagerUserLogCustom_userID] 
ON [dbo].[CourseManagerUserLog_ID]
(
    [userID] ASC
)
INCLUDE (   [id],
    [username],
    [resourceID],
    [status],
    [message],
    [details],
    [refID],
    [record_created])  ON [PRIMARY]
GO
 
 
/****** Object:  Index [INDX_DBA_RecordCreated_UserID]    Script Date: 3/2/2016 5:50:32 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Admin].[CourseManagerUserLog_ID]') AND name = N'INDX_DBA_RecordCreated_UserID')
CREATE NONCLUSTERED INDEX [INDX_DBA_RecordCreated_UserID] 
ON [dbo].[CourseManagerUserLog_ID]
(
    [record_created] ASC,
    [username] ASC
)
GO
 
 
/****** Object:  Index [INDX_DBA_USERNAME_RecordCreated]    Script Date: 3/2/2016 5:50:32 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Admin].[CourseManagerUserLog_ID]') AND name = N'INDX_DBA_USERNAME_RecordCreated')
CREATE NONCLUSTERED INDEX [INDX_DBA_USERNAME_RecordCreated] 
ON [dbo].[CourseManagerUserLog_ID]
(
    [username] ASC,
    [record_created] ASC
) 
GO
 
 
/****** Object:  Index [INDX_DBA_XML_MAIN]    Script Date: 3/2/2016 5:50:32 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Admin].[CourseManagerUserLog_ID]') AND name = N'INDX_DBA_XML_MAIN')
CREATE PRIMARY XML INDEX [INDX_DBA_XML_MAIN] 
ON [dbo].[CourseManagerUserLog_ID]
(
    [details]
)
GO
 
ALTER INDEX [INDX_DBA_XML_MAIN] ON[dbo].[CourseManagerUserLog_ID] DISABLE
GO
 
 
/****** Object:  Index [INDX_DBA_XML_Property]    Script Date: 3/2/2016 5:50:32 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Admin].[CourseManagerUserLog_ID]') AND name = N'INDX_DBA_XML_Property')
CREATE XML INDEX [INDX_DBA_XML_Property] 
ON [dbo].[CourseManagerUserLog_ID]
(
    [details]
)
USING XML INDEX [INDX_DBA_XML_MAIN] FOR PROPERTY 
GO
 
ALTER INDEX [INDX_DBA_XML_Property] ON[dbo].[CourseManagerUserLog_ID] DISABLE
GO
 
 
/****** Object:  Index [INDX_DBA_XML_Secondary_Path]    Script Date: 3/2/2016 5:50:32 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Admin].[CourseManagerUserLog_ID]') AND name = N'INDX_DBA_XML_Secondary_Path')
CREATE XML INDEX [INDX_DBA_XML_Secondary_Path] 
ON [dbo].[CourseManagerUserLog_ID]
(
    [details]
)
USING XML INDEX [INDX_DBA_XML_MAIN] FOR PATH 
GO
 
ALTER INDEX [INDX_DBA_XML_Secondary_Path] ON[dbo].[CourseManagerUserLog_ID] DISABLE
GO