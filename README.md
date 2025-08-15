# SQL Developer Internship – Task 6: Subqueries & Nested Queries

This task focuses on learning and applying **subqueries** and **nested queries** in SQL using the `library_management_system` database.

## What I Did
- Wrote **scalar subqueries**, **correlated subqueries**, and **derived tables**.
- Used subqueries with `IN`, `EXISTS`, and `=` operators.
- Practiced placing subqueries inside **SELECT**, **WHERE**, and **FROM** clauses.# SQL_iinternship_task6

-- Database
USE library_management_system;

-- 1. Scalar Subquery – Show each book with average price for comparison
SELECT title, price,
       (SELECT AVG(price) FROM Books) AS average_price
FROM Books;

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
