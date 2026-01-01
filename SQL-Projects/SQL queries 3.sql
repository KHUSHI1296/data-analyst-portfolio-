/* =====================================================
   CHINOOK DATABASE – SQL SUBQUERY PRACTICE
   
   ===================================================== */


/* -----------------------------------------------------
1. Customers whose TOTAL purchase amount
   is greater than the AVERAGE invoice total
----------------------------------------------------- */

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


/* -----------------------------------------------------
2. Customers who have made AT LEAST ONE purchase
----------------------------------------------------- */

SELECT 
    FirstName,
    LastName
FROM Customer
WHERE CustomerId IN (
    SELECT DISTINCT CustomerId
    FROM Invoice
);


/* -----------------------------------------------------
3. Customers who have NEVER made a purchase
----------------------------------------------------- */

SELECT 
    FirstName,
    LastName
FROM Customer
WHERE CustomerId NOT IN (
    SELECT DISTINCT CustomerId
    FROM Invoice
);


/* -----------------------------------------------------
4. Tracks that cost MORE THAN the average track price
----------------------------------------------------- */

SELECT 
    Name,
    UnitPrice
FROM Track
WHERE UnitPrice > (
    SELECT AVG(UnitPrice)
    FROM Track
);


/* -----------------------------------------------------
5. Artists who have MORE THAN the average number of albums
----------------------------------------------------- */

SELECT 
    Name
FROM Artist
WHERE ArtistId IN (
    SELECT ArtistId
    FROM Album
    GROUP BY ArtistId
    HAVING COUNT(AlbumId) > (
        SELECT AVG(album_count)
        FROM (
            SELECT COUNT(AlbumId) AS album_count
            FROM Album
            GROUP BY ArtistId
        ) AS AvgAlbums
    )
);


/* -----------------------------------------------------
6. Customers whose TOTAL spending is MORE THAN
   the highest single invoice amount
----------------------------------------------------- */

SELECT 
    FirstName,
    LastName
FROM Customer
WHERE CustomerId IN (
    SELECT CustomerId
    FROM Invoice
    GROUP BY CustomerId
    HAVING SUM(Total) > (
        SELECT MAX(Total)
        FROM Invoice
    )
);


/* -----------------------------------------------------
7. Tracks that have NEVER been sold
----------------------------------------------------- */

SELECT 
    Name
FROM Track
WHERE TrackId NOT IN (
    SELECT DISTINCT TrackId
    FROM InvoiceLine
);


/* -----------------------------------------------------
8. Customers from INDIA
   (simple subquery example)
----------------------------------------------------- */

SELECT 
    FirstName,
    LastName,
    City
FROM Customer
WHERE Country = 'India';

