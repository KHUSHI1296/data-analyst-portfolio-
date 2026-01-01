/* ================================
   CHINOOK ADVANCED SQL PRACTICE
   Subqueries + Window Functions
   ================================ */


/* -------- SUBQUERY PRACTICE -------- */

/* 1. Customers whose total invoice amount is greater than average invoice total */
SELECT
    FirstName,
    LastName
FROM Customer
WHERE CustomerId IN (
    SELECT CustomerId
    FROM Invoice
    GROUP BY CustomerId
    HAVING SUM(Total) > (
        SELECT AVG(Total)
        FROM Invoice
    )
);


/* 2. Customers who have placed at least one invoice */
SELECT
    FirstName,
    LastName
FROM Customer
WHERE CustomerId IN (
    SELECT DISTINCT CustomerId
    FROM Invoice
);


/* 3. Customers who never placed an invoice */
SELECT
    FirstName,
    LastName
FROM Customer
WHERE CustomerId NOT IN (
    SELECT DISTINCT CustomerId
    FROM Invoice
);


/* 4. Invoices with total greater than overall average invoice total */
SELECT
    InvoiceId,
    Total
FROM Invoice
WHERE Total > (
    SELECT AVG(Total)
    FROM Invoice
);


/* -------- WINDOW FUNCTION PRACTICE -------- */

/* 5. Rank customers by total spending */
SELECT
    c.CustomerId,
    c.FirstName,
    c.LastName,
    SUM(i.Total) AS TotalSpent,
    RANK() OVER (ORDER BY SUM(i.Total) DESC) AS SpendingRank
FROM Customer c
JOIN Invoice i
    ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName;


/* 6. Row number for invoices ordered by total amount */
SELECT
    InvoiceId,
    CustomerId,
    Total,
    ROW_NUMBER() OVER (ORDER BY Total DESC) AS RowNum
FROM Invoice;


/* 7. Rank invoices per customer by invoice total */
SELECT
    InvoiceId,
    CustomerId,
    Total,
    RANK() OVER (
        PARTITION BY CustomerId
        ORDER BY Total DESC
    ) AS InvoiceRank
FROM Invoice;


/* 8. Top invoice per customer using ROW_NUMBER */
SELECT
    InvoiceId,
    CustomerId,
    Total
FROM (
    SELECT
        InvoiceId,
        CustomerId,
        Total,
        ROW_NUMBER() OVER (
            PARTITION BY CustomerId
            ORDER BY Total DESC
        ) AS rn
    FROM Invoice
) t
WHERE rn = 1;


/* 9. Rank artists by total sales */
SELECT
    ar.ArtistId,
    ar.Name,
    SUM(il.UnitPrice * il.Quantity) AS Revenue,
    RANK() OVER (ORDER BY SUM(il.UnitPrice * il.Quantity) DESC) AS ArtistRank
FROM Artist ar
JOIN Album al
    ON ar.ArtistId = al.ArtistId
JOIN Track t
    ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il
    ON t.TrackId = il.TrackId
GROUP BY ar.ArtistId, ar.Name;


/* 10. Row number of tracks by duration */
SELECT
    TrackId,
    Name,
    Milliseconds,
    ROW_NUMBER() OVER (ORDER BY Milliseconds DESC) AS DurationRank
FROM Track;
