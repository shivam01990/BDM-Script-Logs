USE [BDM]
GO
/****** Object:  StoredProcedure [bdm].[sp_SaveChatHistory]    Script Date: 10/26/2015 12:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [bdm].[sp_SaveChatHistory]
    @FromUserID INT ,
    @ToUserID INT ,
    @Msg NVARCHAR(MAX)
AS 
    BEGIN	
        SET NOCOUNT ON ;
        DECLARE @ChatID BIGINT= 0
        INSERT  INTO [bdm].[ChatHistory]
                ( [FromUserID], [ToUserID], [Msg] )
        VALUES  ( @FromUserID, @ToUserID, @Msg )
        SET @ChatID = @@IDENTITY
          
    END
