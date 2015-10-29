
CREATE PROCEDURE sp_GetMerchantCategoryCommission
    @MerchantCommissionID INT ,
    @AgencyID INT ,
    @MerchantID INT ,
    @CategoryID INT ,
    @OrderBy NVARCHAR(MAX) = 'MerchantCommissionID' ,
    @OrderDir NVARCHAR(MAX) = 'ASC' ,
    @PageNumber INT = 1 ,
    @PageSize INT = 25
AS 
    BEGIN
        SET NOCOUNT ON ;     
        WITH    CategoryCommission
                  AS ( SELECT   CC.MerchantCommissionID ,
                                CC.AgencyID ,
                                CC.MerchantID ,
                                M.MerchantName ,
                                CC.CategoryID ,
                                C.CategoryName ,
                                CC.NetworkCommission ,
                                CC.CashbackType ,
                                CC.CashbackCommission ,
                                CC.DateCreated ,
                                CC.DateModified ,
                                ROW_NUMBER() OVER ( ORDER BY CASE
                                                              WHEN @OrderDir = 'ASC'
                                                              THEN CASE
                                                              WHEN @OrderBy = 'MerchantName'
                                                              THEN M.MerchantName
                                                              WHEN @OrderBy = 'CategoryName'
                                                              THEN C.CategoryName
                                                              END
                                                             END ASC, CASE
                                                              WHEN @OrderDir = 'DESC'
                                                              THEN CASE
                                                              WHEN @OrderBy = 'MerchantName'
                                                              THEN M.MerchantName
                                                              WHEN @OrderBy = 'CategoryName'
                                                              THEN C.CategoryName
                                                              END
                                                              END DESC, CASE
                                                              WHEN @OrderDir = 'ASC'
                                                              THEN CASE
                                                              WHEN @OrderBy = 'DateCreated'
                                                              THEN CC.[DateCreated]
                                                              END
                                                              END ASC , CASE
                                                              WHEN @OrderDir = 'DESC'
                                                              THEN CASE
                                                              WHEN @OrderBy = 'DateCreated'
                                                              THEN CC.[DateCreated]
                                                              END
                                                              END DESC, CASE
                                                              WHEN @OrderDir = 'ASC'
                                                              THEN CASE
                                                              WHEN @OrderBy = 'MerchantCommissionID'
                                                              THEN CC.MerchantCommissionID
                                                              END
                                                              END ASC , CASE
                                                              WHEN @OrderDir = 'DESC'
                                                              THEN CASE
                                                              WHEN @OrderBy = 'MerchantCommissionID'
                                                              THEN CC.MerchantCommissionID
                                                              END
                                                              END DESC ) RowNumber
                       FROM     [bdm].[MerchantCategoryCommission] CC
                                INNER JOIN bdm.Merchants M ON CC.MerchantID = M.MerchantID
                                INNER JOIN bdm.Categories C ON cc.CategoryID = C.CategoryID
                       WHERE    CC.MerchantCommissionID IN ( 0,
                                                             @MerchantCommissionID )
                                AND M.MerchantID IN ( 0, @MerchantID )
                                AND C.CategoryID IN ( 0, @CategoryID )
                     )
            SELECT  MerchantCommissionID ,
                    AgencyID ,
                    MerchantID ,
                    MerchantName ,
                    CategoryID ,
                    CategoryName ,
                    NetworkCommission ,
                    CashbackType ,
                    CashbackCommission ,
                    DateCreated ,
                    DateModified ,
                    ( SELECT    COUNT(MerchantCommissionID)
                      FROM      CategoryCommission
                    ) TotalRecords
            FROM    CategoryCommission
            WHERE   ( RowNumber BETWEEN ( ( @PageNumber - 1 ) * @PageSize + 1 )
                                AND     ( ( @PageNumber - 1 ) * @PageSize
                                          + @PageSize ) )
                    OR ( @PageSize = 0
                         OR @PageNumber = 0
                       )

    END
GO
