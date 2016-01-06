USE MyiLibrary;
GO
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
GO
BEGIN TRANSACTION;
GO

set nocount on

SELECT TitleID, 
	'MILISBN' = (
		SELECT identifier 
		FROM mil_Title_Identifiers 
		WHERE Title_ID = ct.TitleID 
		    AND Format_Type_ID = 6),  
		c.CollectionID, c.Collection, c.CollectionTypeID,  a.Account_ID, a.Name, a.Account_Type_ID  
FROM tbl_Title_Rlt_CollectionTitle AS ct  
INNER JOIN tbl_Title_Cor_Collection AS c 
            ON ct.CollectionID = c.CollectionID  
INNER JOIN tbl_Title_Rlt_AccountCollection AS ac 
            ON c.CollectionID = ac.CollectionID  
INNER JOIN mil_Accounts AS a 
            ON ac.AccountID = a.Account_ID  
WHERE ct.TitleID IN $(varTitleID)
    AND (c.CollectionTypeID IN (2,4) OR (c.CollectionTypeID IN (11,13) AND a.Account_Type_ID = 10))

GO
COMMIT TRANSACTION;
GO