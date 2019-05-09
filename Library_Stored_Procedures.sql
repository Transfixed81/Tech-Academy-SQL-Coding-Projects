
CREATE PROC [dbo].[The_Lost_Tribe_Sharpstown]
AS
BEGIN
SELECT * FROM BOOK_COPIES
WHERE BookID = 42
AND BranchID = 1;
END

-----------------

CREATE PROC [dbo].[The_Lost_Tribe_Total]
AS
BEGIN
SELECT * FROM BOOK_COPIES
WHERE BookID = 42
END

-----------------

CREATE PROC [dbo].[Borrowers_With_No_Books]
AS
BEGIN
SELECT * FROM BORROWER
WHERE BORROWER.CardNo NOT IN
    (SELECT CardNo 
     FROM BOOK_LOANS);
END

-----------------

CREATE PROC [dbo].[Borrowers_Due_Today@Sharpstown]
AS
BEGIN
SELECT BOOKS.Title, BORROWER.Name, BORROWER.Address FROM BOOK_LOANS
INNER JOIN BOOKS ON BOOKS.BookID = BOOK_LOANS.BookID
INNER JOIN BORROWER ON BORROWER.CardNo = BOOK_LOANS.CardNo
WHERE BranchID = 1 AND DateDue = '2019-05-09';
END

-----------------

CREATE PROC [dbo].[Borrowed_Books_By_Branch]
AS
BEGIN
SELECT BranchName, COUNT(BOOK_LOANS.BookID) AS TotalBooksBorrowed 
FROM LIBRARY_BRANCH
LEFT JOIN BOOK_LOANS ON BOOK_LOANS.BranchID = LIBRARY_BRANCH.BranchID
GROUP BY BranchName;
END

-----------------

CREATE PROC [dbo].[Borrowing_5_Or_More_Books]
AS
BEGIN
SELECT Name, Address, COUNT(BOOK_LOANS.BookID) AS Books_Checked_Out
FROM BOOK_LOANS
INNER JOIN BORROWER ON BORROWER.CardNo = BOOK_LOANS.CardNo
GROUP BY Name, Address
HAVING COUNT(BOOK_LOANS.BookID) > 5;
END

-----------------

CREATE PROC [dbo].[Stephen_King_Books_at_Central]
AS
BEGIN
SELECT BOOKS.Title AS Stephen_King_Books_at_Central, BOOK_COPIES.Number_Of_Copies
FROM BOOKS
INNER JOIN BOOK_COPIES ON BOOK_COPIES.BookID = BOOKS.BookID
INNER JOIN LIBRARY_BRANCH ON LIBRARY_BRANCH.BranchID = BOOK_COPIES.BranchID
INNER JOIN BOOK_AUTHORS ON BOOK_AUTHORS.BookID = BOOKS.BookID
WHERE LIBRARY_BRANCH.BranchName = 'Central'
AND BOOK_AUTHORS.AuthorName = 'Stephen King';
END