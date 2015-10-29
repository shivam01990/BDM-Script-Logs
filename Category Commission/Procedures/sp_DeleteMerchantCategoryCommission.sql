
CREATE PROCEDURE sp_DeleteMerchantCategoryCommission
    @MerchantCommissionID INT = 0
AS 
    BEGIN
        SET NOCOUNT ON ;
        DELETE  bdm.MerchantCategoryCommission
        WHERE   MerchantCommissionID = @MerchantCommissionID
 
    END
GO
