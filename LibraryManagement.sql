USE LibraryMgmtSystem

CREATE TABLE LIBRARY_BRANCH (
	BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	BranchName NVARCHAR(30) NOT NULL,
	Address NVARCHAR(30) NOT NULL
);

CREATE TABLE PUBLISHER (
	PublisherName NVARCHAR(30) PRIMARY KEY NOT NULL,
	Address NVARCHAR(30) NOT NULL,
	Phone NVARCHAR(30) NOT NULL
);

CREATE TABLE BOOKS (
	BookID INT PRIMARY KEY NOT NULL IDENTITY,
	Title NVARCHAR(50) NOT NULL,
	PublisherName NVARCHAR(30) NOT NULL CONSTRAINT fk_PublisherName FOREIGN KEY REFERENCES PUBLISHER(PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BOOK_AUTHORS (
	BookID INT NOT NULL CONSTRAINT fk_BookID FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	AuthorName NVARCHAR(30) NOT NULL
);

CREATE TABLE BOOK_COPIES (
	BookID INT NOT NULL CONSTRAINT fk_BookID2 FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT NOT NULL CONSTRAINT fk_BranchID FOREIGN KEY REFERENCES LIBRARY_BRANCH(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	Number_Of_Copies INT NOT NULL
);

CREATE TABLE BORROWER (
	CardNo INT PRIMARY KEY NOT NULL IDENTITY (100, 1),
	Name NVARCHAR(30) NOT NULL,
	Address NVARCHAR(50) NOT NULL,
	Phone NVARCHAR(30)
);

CREATE TABLE BOOK_LOANS (
	BookID INT NOT NULL CONSTRAINT fk_BookID3 FOREIGN KEY REFERENCES BOOKS(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	BranchID INT NOT NULL CONSTRAINT fk_BranchID2 FOREIGN KEY REFERENCES LIBRARY_BRANCH(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	CardNo INT NOT NULL CONSTRAINT fk_CardNo FOREIGN KEY REFERENCES BORROWER(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	DateOut DATE NOT NULL,
	DateDue DATE NOT NULL
);

INSERT INTO LIBRARY_BRANCH 
	(BranchName, Address)
	VALUES
	('Central', '130 Main Street'),
	('Sharpstown', '4585 Market Street'),
	('Colonial Park', '1270 Whitehall Street'),
	('York', '430 Cameron Street')
;

INSERT INTO PUBLISHER
	(PublisherName, Address, Phone)
	VALUES
	('Amazon Publishing', 'Seattle, WA', '333-333-3333'),
	('Broadway Books', 'Danvers, MA 01923', '978-750-8400'),
	('Doubleday', 'New York, NY 10019', '212-940-7390'),
	('Harper Collins', 'New York, NY', '212-207-7000'),
	('Penguin Books', 'London, England', '800-733-3000'),
	('Scholastic', 'New York, NY', '1-800-724-6527'),
	('Thomas & Mercer', 'Seattle, WA', '333-333-4444'),
	('Viking Press','New York, NY', '444-444-4444')
;

INSERT INTO BOOKS
	(Title, PublisherName)
	VALUES
	('The Caves of Steel', 'Doubleday'),
	('The Naked Sun', 'Doubleday'),
	('The Robots of Dawn', 'Doubleday'),
	('Robots and Empire', 'Doubleday'),
	('The Lost Continent', 'Harper Collins'),
	('A Short History of Nearly Everything', 'Broadway Books'),
	('The Lost Tribe', 'Amazon Publishing'),
	('Pines', 'Thomas & Mercer'),
	('Wayward', 'Thomas & Mercer'),
	('The Last Town', 'Thomas & Mercer'),
	('The Richest Man in Babylon', 'Penguin Books'),
	('Forrest Gump', 'Doubleday'),
	('Mystic River', 'Harper Collins'),
	('Shutter Island', 'Harper Collins'),
	('It', 'Viking Press'),
	('The Shining', 'Doubleday'),
	('Carrie', 'Doubleday'),
	('Set for Life', 'Amazon Publishing'),
	('Harry Potter and the Sorcerer''s Stone', 'Scholastic'),
	('Harry Potter and the Chamber of Secrets', 'Scholastic'),
	('Harry Potter and the Prisoner of Azkaban', 'Scholastic'),
	('Harry Potter and the Goblet of Fire', 'Scholastic'),
	('Harry Potter and the Order of the Phoenix', 'Scholastic'),
	('Harry Potter and the Half-Blood Prince', 'Scholastic'),
	('Harry Potter and the Deathly Hallows', 'Scholastic')
;

INSERT INTO BOOK_AUTHORS
	(BookID, AuthorName)
	VALUES
	(1,'Asimov, Isaac'),
	(2,'Asimov, Isaac'),
	(3,'Asimov, Isaac'),
	(4,'Asimov, Isaac'),
	(5,'Bryson, Bill'),
	(6,'Bryson, Bill'),
	(7,'Caldwell, Matthew'),
	(8,'Crouch, Blake'),
	(9,'Crouch, Blake'),
	(10,'Crouch, Blake'),
	(11,'Clason, George S.'),
	(12,'Groom, Winston'),
	(13,'Lehane, Dennis'),
	(14,'Lehane, Dennis'),
	(15,'King, Stephen'),
	(16,'King, Stephen'),
	(17,'King, Stephen'),
	(18,'Trench, Scott'),
	(19,'Rowling, J.K.'),
	(20,'Rowling, J.K.'),
	(21,'Rowling, J.K.'),
	(22,'Rowling, J.K.'),
	(23,'Rowling, J.K.'),
	(24,'Rowling, J.K.'),
	(25,'Rowling, J.K.')
;

INSERT INTO BOOK_COPIES
	(BranchID, BookID, Number_Of_Copies)
	VALUES
	(1, 8, 2),
	(1, 9, 2),
	(1, 10, 2),
	(1, 12, 3),
	(1, 13, 2),
	(1, 14, 3),
	(1, 15, 4),
	(1, 16, 3),
	(1, 17, 2),
	(1, 18, 2),
	(2, 1, 3),
	(2, 2, 2),
	(2, 3, 4),
	(2, 4, 5),
	(2, 7, 2),
	(2, 12, 3),
	(2, 13, 2),
	(2, 15, 4),
	(2, 17, 2),
	(2, 18, 4),
	(3, 5, 2),
	(3, 6, 3),
	(3, 11, 5),
	(3, 19, 4),
	(3, 20, 4),
	(3, 21, 4),
	(3, 22, 4),
	(3, 23, 4),
	(3, 24, 4),
	(3, 25, 4),
	(4, 6, 2),
	(4, 12, 4),
	(4, 16, 4),
	(4, 19, 2),
	(4, 20, 2),
	(4, 21, 2),
	(4, 22, 2),
	(4, 23, 2),
	(4, 24, 2),
	(4, 25, 2)
;

INSERT INTO BORROWER
	(Name, Address, Phone)
	VALUES
	('John Hancock', '1876 Meridian Way', '717-332-4728'),
	('Thomas Jefferson', '451 Virginia Ave', '717-528-2754'),
	('Ben Franklin', '345 Pennsylvania Blvd', '717-528-5282'),
	('Alex Hamilton', '2627 York Path', '717-739-3749'),
	('George Washington', '369 Cherry Tree Road', '717-552-5592'),
	('Jim Hopper', '6268 Hawkins Street', '717-333-5368'),
	('Joyce Byers', '3786 Indiana Way', '717-378-2785'),
	('Elle Evans', '1111 Laboratory Road', '717-711-7111'),
	('Pika Chu', '2673 Ketchem Path', '717- 246-3726'),
	('Chandler Bing', '144 Broadway, Apt. 55', '222-233-3444'),
	('Joey Tribiani', '144 Broadway, Apt. 55', '222-233-3444'),
	('Monica Geller', '144 Broadway, Apt. 56', '222-233-2445'),
	('Ross Geller', 'The Museum', '800-DINOSAUR'),
	('Phoebe Buffet', '345 Main Street', '349-349-3349'),
	('Mike Montgomery', '82921 Sunnyside Place', '746-257-3578'),
	('Maria Bell', '1939 Happiness Court', '113-235-8839')
;

INSERT INTO BOOK_LOANS
	(BranchID, BookID, CardNo, DateOut, DateDue)
	VALUES
	(2, 3, 100, '2019-08-24', '2019-09-08'),
	(2, 4, 100, '2019-08-24', '2019-09-08'),
	(1, 8, 100, '2019-08-25', '2019-09-09'),
	(1, 9, 100, '2019-08-25', '2019-09-09'),
	(1, 9, 104, '2019-09-03', '2019-09-17'),
	(1, 10, 100, '2019-09-06', '2019-09-20'),
	(1, 12, 103, '2019-09-07', '2019-09-21'),
	(1, 12, 110, '2019-09-01', '2019-09-15'),
	(1, 13, 100, '2019-09-06', '2019-09-20'),
	(1, 14, 100, '2019-09-06', '2019-09-20'),
	(1, 14, 104, '2019-09-03', '2019-09-17'),
	(1, 14, 109, '2019-09-01', '2019-09-15'),
	(1, 15, 103, '2019-09-07', '2019-09-21'),
	(1, 15, 104, '2019-09-03', '2019-09-17'),
	(1, 16, 103, '2019-09-07', '2019-09-21'),
	(1, 16, 109, '2019-09-01', '2019-09-15'),
	(1, 16, 110, '2019-09-01', '2019-09-15'),
	(1, 17, 103, '2019-09-07', '2019-09-21'),
	(1, 18, 111, '2019-09-06', '2019-09-20'),
	(1, 18, 102, '2019-09-08', '2019-09-22'),
	(2, 1, 101, '2019-09-04', '2019-09-18'),
	(2, 1, 112, '2019-08-26', '2019-09-10'),
	(2, 3, 101, '2019-09-04', '2019-09-18'),
	(2, 4, 101, '2019-09-04', '2019-09-18'),
	(2, 4, 112, '2019-09-02', '2019-09-16'),
	(2, 4, 108, '2019-09-06', '2019-09-20'),
	(2, 7, 101, '2019-09-04', '2019-09-18'),
	(2, 12, 102, '2019-09-07', '2019-09-21'),
	(2, 13, 101, '2019-09-04', '2019-09-18'),
	(2, 15, 101, '2019-09-04', '2019-09-18'),
	(2, 15, 102, '2019-09-07', '2019-09-21'),
	(2, 18, 112, '2019-09-02', '2019-09-16'),
	(2, 18, 102, '2019-09-07', '2019-09-21'),
	(3, 6, 106, '2019-09-03', '2019-09-17'),
	(3, 11, 105, '2019-09-01', '2019-09-15'),
	(3, 11, 106, '2019-09-03', '2019-09-17'),
	(3, 19, 107, '2019-09-03', '2019-09-17'),
	(3, 20, 107, '2019-09-03', '2019-09-17'),
	(3, 20, 105, '2019-09-01', '2019-09-15'),
	(3, 21, 107, '2019-09-03', '2019-09-17'),
	(3, 22, 107, '2019-09-03', '2019-09-17'),
	(3, 22, 105, '2019-09-01', '2019-09-15'),
	(3, 22, 106, '2019-09-03', '2019-09-17'),
	(3, 23, 107, '2019-09-03', '2019-09-17'),
	(3, 24, 107, '2019-09-03', '2019-09-17'),
	(4, 6, 112, '2019-09-02', '2019-09-16'),
	(4, 12, 112, '2019-09-02', '2019-09-16'),
	(4, 12, 113, '2019-09-07', '2019-09-21'),
	(4, 16, 112, '2019-09-02', '2019-09-16'),
	(4, 16, 113, '2019-09-07', '2019-09-21'),
	(4, 19, 108, '2019-09-05', '2019-09-19'),
	(4, 23, 108, '2019-09-05', '2019-09-19'),
	(4, 24, 108, '2019-09-05', '2019-09-19'),
	(4, 24, 110, '2019-09-03', '2019-09-17'),
	(4, 25, 108, '2019-09-05', '2019-09-19')
;

SELECT * FROM LIBRARY_BRANCH;
SELECT * FROM PUBLISHER;
SELECT * FROM BOOKS;
SELECT * FROM BOOK_AUTHORS;
SELECT * FROM BOOK_COPIES;
SELECT * FROM BORROWER;
SELECT * FROM BOOK_LOANS;