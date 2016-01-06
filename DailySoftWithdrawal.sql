
USE MyiLibrary;
GO
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
GO
BEGIN TRANSACTION;
GO

set nocount on

-- this is where your action code will go
SELECT TC.TitleID
FROM tbl_Operations_Rlt_TitleChanges as TC
WHERE TC.ToSellableReasonID = '6'
   AND TC.DateTimeChanged >= dateadd(day,datediff(day,1,GETDATE()),0)
   AND TC.DateTimeChanged < dateadd(day,datediff(day,0,GETDATE()),0)
  --AND TC.DateTimeChanged <= CAST(ceiling(cast(getdate() as float)) as datetime)
  --AND TC.DateTimeChanged >=  CAST(floor(cast(getdate() as float)) as datetime)

--select GETDATE(), CAST(getdate() as float), CAST(ceiling(cast(getdate() as float)) as datetime)

--select GETDATE(), CAST(getdate() as float), CAST(floor(cast(getdate() as float)) as datetime)
--MILISBN, TitleID, AccountID, Account Name, CollectionID, CollectionName

GO
COMMIT TRANSACTION;
GO