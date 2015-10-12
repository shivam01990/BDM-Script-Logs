Alter Table  bdm.NewsLetterTemplates
Add OfferType smallint

Update bdm.NewsLetterTemplates SET OfferType =1

ALTER TABLE bdm.NewsLetterTemplates
 ALTER COLUMN OfferType smallint Not NULL