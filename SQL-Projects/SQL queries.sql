
-- ===============================
-- 1. BASIC SELECT
-- ===============================

SELECT * FROM customers;

SELECT FirstName, LastName, Country
FROM customers;

-- ===============================
-- 2. WHERE CLAUSE
-- ===============================

SELECT *
FROM customers
WHERE Country = 'India';

SELECT *
FROM customers
WHERE Country = 'USA' AND City = 'New York';

-- ===============================
-- 3. ORDER BY & LIMIT
-- ===============================

SELECT *
FROM customers
ORDER BY LastName ASC;

SELECT *
FROM customers
LIMIT 10;

-- ===============================
-- 4. AGGREGATE FUNCTIONS
-- ===============================

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT Country, COUNT(*) AS customers_per_country
FROM customers
GROUP BY Country;

-- ===============================
-- 5. INVOICES ANALYSIS
-- ===============================

SELECT SUM(Total) AS total_revenue
FROM invoices;

SELECT CustomerId, SUM(Total) AS total_spent
FROM invoices
GROUP BY CustomerId;

-- ===============================
-- 6. JOINS (IMPORTANT)
-- ===============================

SELECT c.FirstName, c.LastName, i.Total
FROM customers c
JOIN invoices i
ON c.CustomerId = i.CustomerId;

-- ===============================
-- 7. TOP CUSTOMERS
-- ===============================

SELECT c.FirstName, c.LastName,
       SUM(i.Total) AS total_spent
FROM customers c
JOIN invoices i
ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
ORDER BY total_spent DESC
LIMIT 5;
