CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch
(
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(50),
  Contact_no INT
);

INSERT INTO Branch (Branch_no,Manager_Id,Branch_address,Contact_no) VALUES
(1,001,'Guruvayur Road,Thrissur',0487542363),
(2,002,'Thenjippalam Road,Calicut',0495272355),
(3,003,'MG Road,Kottayam',0481645443),
(4,004,'Sagar Road,Manjeri',0483836458),
(5,005,'Navatha Nagar,Kannur',0497837549);


CREATE TABLE Employee 
(
  Emp_Id INT PRIMARY KEY, 
  Emp_name VARCHAR(30),
  Position VARCHAR(30), 
  Salary DECIMAL(10,2)
);

INSERT INTO Employee(Emp_Id,Emp_name,Position,Salary) VALUES
(001,'Athira','Assistant',12000.00),
(002,'Baskar','Manager',15000.00),
(003,'David','Librarian',10000.00),
(004,'Favas','Assistant',12000.00),
(005,'Hamdan','Director',14000.00);


CREATE TABLE  Customer
( 
   Customer_Id INT PRIMARY KEY,
   Customer_name VARCHAR(30),
   Customer_address VARCHAR(50), 
   Reg_date DATE
 );
 
 
 INSERT INTO Customer(Customer_Id,Customer_name,Customer_address,Reg_date) VALUES
 (1,'Anjana','Calicut','2022-10-12'),
 (2,'Benzy','Thissur','2022-09-22'),
 (3,'Charlie','Kottayam','2023-01-02'),
 (4,'Vidhu','Kannur','2022-12-15'),
 (5,'Tovino','Manjeri','2022-11-18');
 
 
 CREATE TABLE Books 
 (
   ISBN VARCHAR(50) PRIMARY KEY, 
   Book_title VARCHAR(50), 
   Category VARCHAR(50),
   Rental_Price DECIMAL(10,2),
   Status  VARCHAR(10), 
   Author VARCHAR(50), 
   Publisher VARCHAR(50)
  );
  
  INSERT INTO Books(ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
  ('ISBNOO1','Pride and prejudice','Novel',399.00,'Yes','Jane Austen','H&C Publisher'),
  ('ISBNOO2','The Diary of a Young Girl','Autobiography',599.00,'Yes','Anne Frank','J&V Publisher'),
  ('ISBNOO3','A Touch of Eternity','Romance',299.00,'No','Durjoy Datta','H&C Publisher'),
  ('ISBNOO4','Death on the Nile','Mystery',699.00,'No','Agatha Christie','G&G Publisher'),
  ('ISBNOO5','Matilda','Childrensbook',199.00,'Yes','Roald Dahl','A&B Publisher');
  
  
  
 CREATE TABLE IssueStatus
 (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(30),
	Issue_date DATE, 
	Isbn_book VARCHAR(30),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
  );
 
 
 INSERT INTO IssueStatus (Issue_Id,Issued_cust,Issued_book_name,Issue_date,Isbn_book) VALUES
 (1,1,'Pride and prejudice','2023-01-12','ISBNOO1'),
 (2,2,'The Diary of a Young Girl','2023-02-09','ISBNOO2'),
 (3,3,'A Touch of Eternity','2023-02-22','ISBNOO3'),
 (4,4,'Death on the Nile','2023-03-02','ISBNOO4'),
 (5,5,'Matilda','2023-04-18','ISBNOO5');
 

CREATE TABLE  ReturnStatus 
(
  Return_Id  INT PRIMARY KEY, 
  Return_cust INT,
  Return_book_name VARCHAR(30), 
  Return_date DATE, 
  Isbn_book2 VARCHAR(30),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);


 INSERT INTO ReturnStatus (Return_Id,Return_cust,Return_book_name,Return_date,Isbn_book2) VALUES
 (1,1,'Pride and prejudice','2023-01-29','ISBNOO1'),
 (2,2,'The Diary of a Young Girl','2023-03-01','ISBNOO2'),
 (3,3,'A Touch of Eternity','2023-03-20','ISBNOO3'),
 (4,4,'Death on the Nile','2023-03-28','ISBNOO4'),
 (5,5,'Matilda','2023-05-02','ISBNOO5');
 
 
 SELECT * FROM Branch;
 SELECT * FROM Employee;
 SELECT * FROM Customer;
 SELECT* FROM Books;
 SELECT * FROM IssueStatus;
 SELECT * FROM ReturnStatus;
 
 /* 1.  Retrieve the book title, category, and rental price of all available 
books.*/

SELECT Book_title,Category,Rental_Price FROM Books WHERE Status = 'Yes';

/* 2.   List the employee names and their respective salaries in descending 
order of salary.*/

SELECT Emp_name ,Salary FROM Employee ORDER BY Salary DESC;

/* 3.  Retrieve the book titles and the corresponding customers who have 
issued those books.*/

SELECT IssueStatus.Issued_book_name,Customer.Customer_name FROM IssueStatus INNER JOIN 
Customer ON IssueStatus.Issued_Cust = Customer.Customer_Id;

/* 4.  Display the total count of books in each category.*/

SELECT Category,COUNT(*) AS Total_count_of_books FROM Books GROUP BY Category;

/*5.  Retrieve the employee names and their positions for the employees 
whose salaries are above Rs.12,000. */

SELECT Emp_name,Position,Salary From Employee WHERE Salary>12000.00;

/* 6.  List the customer names who registered before 2022-01-01 and have 
not issued any books yet. */

SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01'
AND  Customer_Id NOT IN (SELECT Issued_Cust FROM IssueStatus);

/* 7.  Display the branch numbers and the total count of employees in each 
branch.*/

SELECT Branch.Branch_no,COUNT(*) AS Total_Employees FROM Branch JOIN
Employee ON Branch.Manager_Id = Employee.Emp_Id GROUP BY Branch.Branch_no;


/* 8.  Display the names of customers who have issued books in the month 
of February 2023. */


SELECT Customer.Customer_name FROM Customer JOIN 
IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_Cust WHERE 
IssueStatus.Issue_date LIKE '2023-02-%';


/* 9.  Retrieve book_title from book table containing Mystery. */

SELECT Book_title FROM Books WHERE Category = 'Mystery';

/* 10. Retrieve the branch numbers along with the count of employees for 
branches having more than 5 employees. */

SELECT Branch.Branch_no,COUNT(*) AS Total_Employees FROM Branch JOIN
Employee ON Branch.Manager_Id = Employee.Emp_Id GROUP BY Branch.Branch_no HAVING COUNT(*) > 5;

