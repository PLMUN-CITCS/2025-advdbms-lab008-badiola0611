CREATE DATABASE `BookstoreDB`;
-- Books Table [cite: 11]
CREATE TABLE `Books` (
   `ISBN` VARCHAR(20) PRIMARY KEY,
   `Title` VARCHAR(255) NOT NULL,
   `Price` DECIMAL(10,2) NOT NULL
);

-- Authors Table [cite: 11]
CREATE TABLE `Authors` (
   `AuthorID` INT PRIMARY KEY,
   `Name` VARCHAR(255) NOT NULL
);

-- BookAuthors Table (Associative Entity) [cite: 11]
CREATE TABLE `BookAuthors` (
   `ISBN` VARCHAR(20),
   `AuthorID` INT,
   PRIMARY KEY (`ISBN`, `AuthorID`),
   FOREIGN KEY (`ISBN`) REFERENCES `Books`(`ISBN`),
   FOREIGN KEY (`AuthorID`) REFERENCES `Authors`(`AuthorID`)
);

-- Customers Table [cite: 11]
CREATE TABLE `Customers` (
   `CustomerID` INT PRIMARY KEY,
   `Name` VARCHAR(255) NOT NULL,
   `Email` VARCHAR(255) NOT NULL
);

-- Orders Table [cite: 11]
CREATE TABLE `Orders` (
   `OrderID` INT PRIMARY KEY,
   `CustomerID` INT,
   `OrderDate` DATE NOT NULL,
   FOREIGN KEY (`CustomerID`) REFERENCES `Customers`(`CustomerID`)
);

-- OrderDetails Table [cite: 11]
CREATE TABLE `OrderDetails` (
   `OrderID` INT,
   `ISBN` VARCHAR(20),
   `Quantity` INT NOT NULL,
   PRIMARY KEY (`OrderID`, `ISBN`),
   FOREIGN KEY (`OrderID`) REFERENCES `Orders`(`OrderID`),
   FOREIGN KEY (`ISBN`) REFERENCES `Books`(`ISBN`)
);
USE `BookstoreDB`;
-- Insert into Books
INSERT INTO `Books` (`ISBN`, `Title`, `Price`) VALUES
('9781234567890', 'The Hitchhiker''s Guide to the Galaxy', 7.99),
('9780321765723', 'The Lord of the Rings', 12.99),
('9780743273565', 'Pride and Prejudice', 9.99);

-- Insert into Authors
INSERT INTO `Authors` (`AuthorID`, `Name`) VALUES
(1, 'Douglas Adams'),
(2, 'J.R.R. Tolkien'),
(3, 'Jane Austen');

-- Insert into BookAuthors
INSERT INTO `BookAuthors` (`ISBN`, `AuthorID`) VALUES
('9781234567890', 1),
('9780321765723', 2),
('9780743273565', 3);

-- Insert into Customers
INSERT INTO `Customers` (`CustomerID`, `Name`, `Email`) VALUES
(1, 'John Doe', 'john.doe@example.com'),
(2, 'Jane Smith', 'jane.smith@example.com'),
(3, 'David Lee', 'david.lee@example.com');

-- Insert into Orders
INSERT INTO `Orders` (`OrderID`, `CustomerID`, `OrderDate`) VALUES
(1, 1, '2024-07-26'),
(2, 2, '2024-07-27'),
(3, 3, '2024-07-28');

-- Insert into OrderDetails
INSERT INTO `OrderDetails` (`OrderID`, `ISBN`, `Quantity`) VALUES
(1, '9781234567890', 1),
(1, '9780321765723', 2),
(2, '9780743273565', 1);
USE `BookstoreDB`;
SELECT `c`.`Name` AS `CustomerName`, `o`.`OrderDate`, `b`.`Title` AS `BookTitle`, `od`.`Quantity`
FROM `Customers` `c`
JOIN `Orders` `o` ON `c`.`CustomerID` = `o`.`CustomerID`
JOIN `OrderDetails` `od` ON `o`.`OrderID` = `od`.`OrderID`
JOIN `Books` `b` ON `od`.`ISBN` = `b`.`ISBN`;
UPDATE `Books` SET `Price` = 8.99 WHERE `ISBN` = '9781234567890';

SELECT * FROM `Books` WHERE `ISBN` = '9781234567890';
DELETE FROM `OrderDetails` WHERE `OrderID` = 1 AND `ISBN` = '9780321765723';

SELECT * FROM `OrderDetails` WHERE `OrderID` = 1;
SELECT `a`.`Name` AS `AuthorName`, `b`.`Title` AS `BookTitle`
FROM `Authors` `a`
JOIN `BookAuthors` `ba` ON `a`.`AuthorID` = `ba`.`AuthorID`
JOIN `Books` `b` ON `ba`.`ISBN` = `b`.`ISBN`;
SELECT `c`.`Name` AS `CustomerName`
FROM `Customers` `c`
JOIN `Orders` `o` ON `c`.`CustomerID` = `o`.`CustomerID`
JOIN `OrderDetails` `od` ON `o`.`OrderID` = `od`.`OrderID`
JOIN `Books` `b` ON `od`.`ISBN` = `b`.`ISBN`
JOIN `BookAuthors` `ba` ON `b`.`ISBN` = `ba`.`ISBN`
JOIN `Authors` `a` ON `ba`.`AuthorID` = `a`.`AuthorID`
WHERE `a`.`Name` = 'Douglas Adams'; -- Change author name as needed
