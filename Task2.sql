USE shope;

/*Using Window Function: RANK()*/

SELECT OrderID, CustomerID, Product,  
       RANK() OVER (PARTITION BY CustomerID ORDER BY OrderID ASC) AS OrderRank  
FROM Orders;

/* Each customer had only 1 order, so RANK() always showed 1. so lets add more values*/

INSERT INTO Orders (OrderID, CustomerID, Product) VALUES
(105, 2, 'Laptop'),
(106, 2, 'Mobile'),
(107, 3, 'Tablet'),
(108, 4, 'Monitor'); 

SELECT * FROM shope.orders; 

/* lets rune the query again*/

SELECT OrderID, CustomerID, Product,  
       RANK() OVER (PARTITION BY CustomerID ORDER BY OrderID ASC) AS OrderRank  
FROM Orders;

/* Using Subquery to find customers who ordered "Laptop" */

SELECT CustomerID, Name, City
FROM Customers  
WHERE CustomerID IN (  
    SELECT CustomerID FROM Orders  
    WHERE Product = 'Laptop');
    
/* Using CTE to count total orders per customer */

 WITH OrderCounts AS (  
    SELECT CustomerID, COUNT(OrderID) AS TotalOrders  
    FROM Orders  
    GROUP BY CustomerID  
)  
SELECT Customers.CustomerID, Customers.Name, OrderCounts.TotalOrders  
FROM Customers  
JOIN OrderCounts ON Customers.CustomerID = OrderCounts.CustomerID;   