
CREATE PROCEDURE sp_SaveMerchantCategoryCommission
    @MerchantCommissionID INT ,
    @AgencyID INT ,
    @MerchantID INT ,
    @CategoryID INT ,
    @NetworkCommission DECIMAL(4, 2) ,
    @CashbackType BIT ,
    @CashbackCommission DECIMAL(10, 2)
AS 
    BEGIN	
        SET NOCOUNT ON ;
        IF NOT EXISTS ( SELECT  MerchantCommissionID
                        FROM    bdm.MerchantCategoryCommission
                        WHERE   AgencyID = @AgencyID
                                AND MerchantID = @MerchantID
                                AND CategoryID = @CategoryID ) 
            BEGIN
                INSERT  INTO bdm.MerchantCategoryCommission
                        ( AgencyID ,
                          MerchantID ,
                          CategoryID ,
                          NetworkCommission ,
                          CashbackType ,
                          CashbackCommission ,
                          DateCreated ,
                          DateModified
                        )
                VALUES  ( @AgencyID ,
                          @MerchantID ,
                          @CategoryID ,
                          @NetworkCommission ,
                          @CashbackType ,
                          @CashbackCommission ,
                          GETDATE() ,
                          GETDATE()
                        )
                        
                SET @MerchantCommissionID = @@IDENTITY
                SELECT  @MerchantCommissionID AS MerchantCommissionID
            END
        ELSE 
            BEGIN
                UPDATE  bdm.MerchantCategoryCommission
                SET     NetworkCommission = @NetworkCommission ,
                        CashbackType = @CashbackType ,
                        CashbackCommission = @CashbackCommission ,
                        DateModified = GETDATE()
                WHERE   MerchantCommissionID = @MerchantCommissionID
                        AND AgencyID = @AgencyID  
                SELECT  @MerchantCommissionID AS MerchantCommissionID     
            END
            
    
    END
GO
