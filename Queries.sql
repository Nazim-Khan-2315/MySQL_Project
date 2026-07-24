USE E_Commerce_Database_Management_System;
SHOW TABLES;
--  Find all products
DESCRIBE PRODUCTS;

SELECT DISTINCT
    (product_name)
FROM
    E_Commerce_Database_Management_System.products;
--  Find customers 
DESCRIBE customers;
SELECT DISTINCT
    (CONCAT(first_name, last_name))
FROM
    E_Commerce_Database_Management_System.customers;

SELECT 
    first_name, last_name
FROM
    customers;
    
-- Products costing more than ₹ 1000
SELECT DISTINCT
    (product_name), price
FROM
    E_Commerce_Database_Management_System.products
WHERE
    PRICE > 1000;

-- Products sorted by price
SELECT 
    product_name,price
FROM
    E_Commerce_Database_Management_System.products
ORDER BY price DESC;
DESC categories;
DESC products;

-- products with category
SELECT 
    P.product_name, C.category_name
FROM
    products P
        JOIN
    categories C ON P.category_id = C.category_id;
    
DESC customers;
DESC orders;
DESC products;
DESC order_items;

-- CUSTOMER WITH EACH
SELECT 
    C.customer_id,
    CONCAT(C.first_name, ' ', C.last_name) customer_name,
    P.product_name
FROM
    customers C
        JOIN
    orders O ON C.customer_id = O.customer_id
        JOIN
    order_items OI ON O.order_id = OI.order_id
        JOIN
    products P ON OI.product_id = P.product_id;


-- SHOW PRODUCT WITH EACH ORDER  

SELECT 
    O.order_id, P.product_name, OI.quantity, OI.unit_price
FROM
    orders O
        JOIN
    order_items OI ON O.order_id = OI.order_id
        JOIN
    products P ON OI.product_id = P.product_id
ORDER BY O.order_id;


-- SHOW PAYMENT WITH EACH ORDER

SELECT 
    OI.order_id, P.amount, P.payment_status
FROM
    orders O
        JOIN
    order_items OI ON O.order_id = OI.order_id
        JOIN
    payments P ON OI.product_id = P.payment_id
WHERE
    P.payment_status = 'Paid';
    
    
-- total customers
SELECT DISTINCT
    COUNT((CONCAT(C.first_name, ' ', C.last_name))) Customer_Name
FROM
    customers C;
    
    
-- total products
    
SELECT COUNT(DISTINCT
    (P.product_name))
FROM
    products P;


-- AVERAGE PRODUCT PRICE
SELECT 
    P.product_name, AVG(P.price) Average_price
FROM
    products P
GROUP BY P.product_name;

-- MOST EXPENSIVE PRODUCT
SELECT 
    P.product_name, P.price
FROM
    products P
ORDER BY P.price DESC
LIMIT 1;

-- NUMBER OF PRODUCTS IN EACH CATEGORY
SELECT 
    category_name, COUNT(category_name) No_of_Products
FROM
    categories C
        JOIN
    products P ON C.category_id = P.category_id
GROUP BY P.category_id;

-- TOTAL SALES BY COSTUMER
SELECT 
    C.customer_id,CONCAT(C.first_name, ' ', C.last_name) Customer_name,
    SUM(O.total_amount)
FROM
    customers C
        JOIN
    orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_id;

-- SUBQUERY :- MOST EXPENSIVE PRODUCT
SELECT 
    P.product_name, P.price
FROM
    products P
WHERE
    P.price = (SELECT 
            MAX(P.price)
        FROM
            products P);
            
-- create view customer order
CREATE VIEW customer_orders AS
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        o.order_id,
        o.order_date,
        o.total_amount
    FROM
        customers c
            JOIN
        orders o ON c.customer_id = o.customer_id;
SELECT 
    *
FROM
    customer_orders;
/*chacking data duplicacy*/
SELECT 
    first_name, last_name, COUNT(*) AS duplicate_count
FROM
    customers
GROUP BY first_name , last_name
HAVING COUNT(*) > 1;

/* creating index */
CREATE INDEX index_last_name
ON customers (last_name);
/* search using index*/
SELECT * FROM customers
WHERE last_name = 'sharma';

/* Agggragate functions*/
SELECT SUM(products.price)-SUM( orders.total_amount) AS PROFIT FROM products,orders ;

/* SOME REPORTS*/
/* TOP 5 SALING PRODUCTS*/
SELECT 
    P.product_name,OI.quantity
FROM
    products P
        JOIN
    order_items OI ON P.product_id = OI.product_id
ORDER BY OI.quantity DESC
LIMIT 5;
/* TOP 5 EXPENSIVE PRODUCT*/
SELECT  P.product_name,OI.unit_price FROM products P JOIN order_items OI ON P.product_id = OI.product_id
ORDER BY OI.unit_price DESC LIMIT 5;