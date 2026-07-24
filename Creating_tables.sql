/* Creating  customers table */

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    E_mail VARCHAR(100) NOT NULL,
    Phone_number BIGINT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    registration_date DATE NOT NULL,
    date_of_birth DATE NOT NULL
);


/* Creating category table*/

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    category_name VARCHAR(25) NOT NULL
);


/* Creating  products table*/
drop table products;
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id)
        REFERENCES categories (category_id),
    product_name VARCHAR(20) NOT NULL,
    price INT NOT NULL,
    stock_quantity INT NOT NULL
);


/*Creating table orders*/
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),
    order_date DATE,
    total_amount BIGINT NOT NULL,
    order_status VARCHAR(10) NOT NULL
);


/*Creating table order item*/



CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    product_id INT NOT NULL,
    FOREIGN KEY (product_id)
        REFERENCES products (product_id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL
);




/*Creating table payment*/

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    payment_method VARCHAR(10) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status VARCHAR(15) NOT NULL,
    amount BIGINT NOT NULL
);