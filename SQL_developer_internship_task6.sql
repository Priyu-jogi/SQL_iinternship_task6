-- Task :Subqueries and Nested Queries

-- Database
USE library_management_system;

-- 1. Scalar Subquery – Show each book with average price for comparison
SELECT title, price,
       (SELECT AVG(price) FROM Books) AS average_price
FROM Books;

-- insert  sample data in books and issue table
INSERT INTO Books (isbn, title, category, price) VALUES ('FIC123', 'Sample Fiction Book', 'Fiction', 500);
INSERT INTO Issue (issue_id, reader_id, isbn, issue_date) VALUES (101, 1, 'FIC123', CURDATE());

-- 2. Subquery with IN – Readers who issued books in the 'Fiction' category
SELECT first_name, last_name
FROM Readers
WHERE reader_id IN (
    SELECT reader_id
    FROM Issue
    WHERE isbn IN (
        SELECT isbn FROM Books WHERE category = 'Fiction'
    )
);

-- 3. Subquery with EXISTS – Readers who have issued at least one book
SELECT first_name, last_name
FROM Readers r
WHERE EXISTS (
    SELECT 1
    FROM Issue i
    WHERE i.reader_id = r.reader_id
);

-- 4. Correlated Subquery – Show each reader and how many books they issued
SELECT r.first_name, r.last_name,
       (SELECT COUNT(*)
        FROM Issue i
        WHERE i.reader_id = r.reader_id) AS books_issued
FROM Readers r;

-- 5. Subquery in FROM (Derived Table) – Categories and their average price
SELECT category, average_price
FROM (
    SELECT category, AVG(price) AS average_price
    FROM Books
    GROUP BY category
) AS category_avg;

-- 6. Subquery with = – Find the most expensive book
SELECT title, price
FROM Books
WHERE price = (SELECT MAX(price) FROM Books);
