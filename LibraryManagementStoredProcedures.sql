USE LibraryMgmtSystem
GO
-- STORED PROCEDURE 1: HOW MANY COPIES OF THE BOOK TITLED 
-- "THE LOST TRIBE" ARE OWNED BY THE LIBRARY BRANCH WHOSE
-- NAME IS "SHAPRSTOWN"?
-- 
-- USE THIS PROCEDURE AND INCLUDE THE TITLE OF THE BOOK 
-- ("The Lost Tribe") AND THE BRANCH ("Sharpstown") AS
-- VARIABLES.

CREATE PROC dbo.uspGetBookNum @Title nvarchar(50) = NULL, @BranchName nvarchar(30) = NULL
AS
SELECT lb.BranchName, b.Title, bc.Number_Of_Copies FROM BOOK_COPIES bc
INNER JOIN LIBRARY_BRANCH lb ON lb.BranchID = bc.BranchID
INNER JOIN BOOKS b ON b.BookID = bc.BookID
WHERE Title = ISNULL(@Title, Title)
AND BranchName = ISNULL(@BranchName, BranchName);
GO


-- STORED PROCEDURE 2: HOW MANY COPIES OF THE BOOK TITLED
-- "THE LOST TRIBE" ARE OWNED BY EACH LIBRARY BRANCH?"
-- 
-- SAME PROCEDURE AS ABOVE, BUT JUST DON'T INCLUDE A BRANCH
-- NAME IN YOUR QUERY.
USE LibraryMgmtSystem
GO

CREATE PROC dbo.uspGetBookNum @Title nvarchar(50) = NULL, @BranchName nvarchar(30) = NULL
AS
SELECT lb.BranchName, b.Title, bc.Number_Of_Copies FROM BOOK_COPIES bc
INNER JOIN LIBRARY_BRANCH lb ON lb.BranchID = bc.BranchID
INNER JOIN BOOKS b ON b.BookID = bc.BookID
WHERE Title = ISNULL(@Title, Title)
AND BranchName = ISNULL(@BranchName, BranchName);
GO


-- STORED PROCEDURE 3: RETRIEVE THE NAMES OF ALL BORROWERS
-- WHO DO NOT HAVE ANY BOOKS CHECKED OUT.
USE LibraryMgmtSystem
GO

CREATE PROC dbo.uspGetNonBorrowers
AS
SELECT BORROWER.Name FROM BOOK_LOANS
FULL OUTER JOIN BORROWER ON BORROWER.CardNo = BOOK_LOANS.CardNo
WHERE BOOK_LOANS.BookID IS NULL;
GO


-- STORED PROCEDURE 4: FOR EACH BOOK THAT IS LOANED OUT FROM
-- THE "SHARPSTOWN BRANCH AND WHOSE DUEDATE IS TODAY, RETRIEVE
-- THE BOOK TITLE, THE BORROWER'S NAME, AND THE BORROWER'S ADDRESS.
USE LibraryMgmtSystem
GO

CREATE PROC dbo.uspGetPeopleDueToday
AS
-- b = BOOKS, br = BORROWER, bl = BOOK_lOANS, lb = LIBRARY_BRANCH
SELECT b.Title, br.Name, br.Address FROM BOOK_LOANS bl
INNER JOIN BOOKS b ON b.BookID = bl.BookID
INNER JOIN BORROWER br ON br.CardNo = bl.CardNo
INNER JOIN LIBRARY_BRANCH lb ON lb.BranchID = bl.BranchID
WHERE DateDue = CONVERT(VARCHAR(10), getdate(), 23) --CONVERTS TODAY'S DATE INTO A STRING SO IT CAN BE COMPARED TO THE DUE DATES
AND lb.BranchName = 'Sharpstown';
GO



-- STORED PROCEDURE 5: FOR EACH LIBRARY BRANCH, RETRIEVE 
-- THE BRANCH NAME AND THE TOTAL NUMBER OF BOOKS LOANED 
-- OUT FROM THAT BRANCH.
USE LibraryMgmtSystem
GO

CREATE PROC dbo.usbGetTotalBookLoansByBranch
AS
SELECT lb.BranchName, COUNT(*) 'Books on loan' FROM BOOK_LOANS bl
INNER JOIN LIBRARY_BRANCH lb ON lb.BranchID = bl.BranchID
GROUP BY lb.BranchName;
GO


-- STORED PROCEDURE 6: RETRIEVE THE NAMES, ADDRESSES, AND
-- THE NUMBER OF BOOKS CHECKED OUT FOR ALL BORROWERS WHO
-- HAVE MORE THAN FIVE BOOKS CHECKED OUT.
USE LibraryMgmtSystem
GO

CREATE PROC dbo.uspGetHighCheckouts
AS
SELECT 
br.Name, br.Address, COUNT(*) 'Book Number' 
FROM BOOK_LOANS bl
INNER JOIN BORROWER br ON br.CardNo = bl.CardNo
GROUP BY br.Name, br.Address
HAVING COUNT(*) > 5
ORDER BY 'Book Number' DESC
GO

-- STORED PROCEDURE 7: FOR EACH BOOK AUTHORED (OR CO-AUTHORED)
-- BY "STEPHEN KING", RETRIEVE THE TITLE AND THE NUMBER OF 
-- COPIES OWNED BY THE LIBRARY BRANCH WHOSE NAME IS "CENTRAL".

USE LibraryMgmtSystem
GO

CREATE PROC dbo.uspGetStephenKingCopiesAtCentral
AS

SELECT 
b.Title, bc.Number_Of_Copies
FROM BOOKS b
INNER JOIN BOOK_AUTHORS ba ON ba.BookID = b.BookID
INNER JOIN BOOK_COPIES bc ON bc.BookID = b.BookID
INNER JOIN LIBRARY_BRANCH lb ON lb.BranchID = bc.BranchID
WHERE ba.AuthorName = 'King, Stephen'
AND lb.BranchName = 'Central'
ORDER BY b.BookID

GO