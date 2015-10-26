USE [BDM]
GO

/****** Object:  Table [bdm].[ChatHistory]    Script Date: 10/26/2015 12:30:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [bdm].[ChatHistory](
	[ChatID] [bigint] IDENTITY(1,1) NOT NULL,
	[FromUserID] [int] NOT NULL,
	[ToUserID] [int] NOT NULL,
	[Msg] [nvarchar](max) NULL,
	[MessageDate] [datetime] NULL,
 CONSTRAINT [PK_ChatHistory] PRIMARY KEY CLUSTERED 
(
	[ChatID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [bdm].[ChatHistory] ADD  CONSTRAINT [DF_Table_1_CreatedDate]  DEFAULT (getdate()) FOR [MessageDate]
GO


