CREATE DATABASE `northwind_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE Northwind_DW;


CREATE TABLE dim_customers (
    customer_key INT PRIMARY KEY,
    customer_name VARCHAR(255),
    contact_name VARCHAR(255),
    contact_title VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(50),
    region VARCHAR(50),
    postal_code VARCHAR(10),
    country VARCHAR(50),
    phone VARCHAR(20),
    fax VARCHAR(20)
);

CREATE TABLE dim_employees (
    employee_key INT PRIMARY KEY AUTO_INCREMENT,
    company VARCHAR(50),
    last_name VARCHAR(50),
    first_name VARCHAR(50),
    email_address VARCHAR(50),
    job_title VARCHAR(50),
    business_phone VARCHAR(25),
    home_phone VARCHAR(25),
    mobile_phone VARCHAR(25),
    fax_number VARCHAR(25),
    address TEXT,
    city VARCHAR(50),
    state_province VARCHAR(50),
    zip_postal_code VARCHAR(15),
    country_region VARCHAR(50),
    web_page TEXT,
    notes TEXT
);
CREATE TABLE dim_products (
    product_key INT PRIMARY KEY AUTO_INCREMENT,
    product_code VARCHAR(25),
    product_name VARCHAR(50),
    description TEXT,
    standard_cost DECIMAL(19 , 4 ) DEFAULT '0.0000',
    list_price DECIMAL(19 , 4 ) NOT NULL DEFAULT '0.0000',
    reorder_level INT,
    target_level INT,
    quantity_per_unit VARCHAR(50),
    discontinued TINYINT(1) NOT NULL DEFAULT '0',
    minimum_reorder_quantity INT,
    category VARCHAR(50)
);
CREATE TABLE dim_shippers (
    shipper_key INT PRIMARY KEY AUTO_INCREMENT,
    company VARCHAR(50),
    last_name VARCHAR(50),
    first_name VARCHAR(50),
    email_address VARCHAR(50),
    job_title VARCHAR(50),
    business_phone VARCHAR(25),
    home_phone VARCHAR(25),
    mobile_phone VARCHAR(25),
    fax_number VARCHAR(25),
    address TEXT,
    city VARCHAR(50),
    state_province VARCHAR(50),
    zip_postal_code VARCHAR(15),
    country_region VARCHAR(50),
    web_page TEXT,
    notes TEXT
);
#1.2
CREATE TABLE fact_orders (
    order_id INT,
    customer_key INT,
    employee_key INT,
    product_key INT,
    shipper_key INT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    freight DECIMAL(10, 2),
    orders_status_name VARCHAR(255),
    order_details_status_name VARCHAR(255),
    product_quantity INT,
    product_unit_price DECIMAL(10, 2),
    discount FLOAT,
    FOREIGN KEY (customer_key) REFERENCES dim_customers(customer_key),
    FOREIGN KEY (employee_key) REFERENCES dim_employees(employee_key),
    FOREIGN KEY (product_key) REFERENCES dim_products(product_key),
    FOREIGN KEY (shipper_key) REFERENCES dim_shippers(shipper_key)
);

 
INSERT INTO Northwind_DW.dim_employees (
    company, 
    last_name, 
    first_name, 
    email_address, 
    job_title, 
    business_phone, 
    home_phone, 
    mobile_phone, 
    fax_number, 
    address, 
    city, 
    state_province, 
    zip_postal_code, 
    country_region, 
    web_page, 
    notes
)
SELECT 
    company, 
    last_name, 
    first_name, 
    email_address, 
    job_title, 
    business_phone, 
    home_phone, 
    mobile_phone, 
    fax_number, 
    address, 
    city, 
    state_province, 
    zip_postal_code, 
    country_region, 
    web_page, 
    notes
FROM Northwind.employees;

INSERT INTO Northwind_DW.dim_products (
    product_code, 
    product_name, 
    description, 
    standard_cost, 
    list_price, 
    reorder_level, 
    target_level, 
    quantity_per_unit, 
    discontinued, 
    minimum_reorder_quantity, 
    category
)
SELECT 
    product_code, 
    product_name, 
    description, 
    standard_cost, 
    list_price, 
    reorder_level, 
    target_level, 
    quantity_per_unit, 
    discontinued, 
    minimum_reorder_quantity, 
    category
FROM Northwind.products;

INSERT INTO Northwind_DW.dim_shippers (
    company, 
    last_name, 
    first_name, 
    email_address, 
    job_title, 
    business_phone, 
    home_phone, 
    mobile_phone, 
    fax_number, 
    address, 
    city, 
    state_province, 
    zip_postal_code, 
    country_region, 
    web_page, 
    notes
)
SELECT 
    company, 
    last_name, 
    first_name, 
    email_address, 
    job_title, 
    business_phone, 
    home_phone, 
    mobile_phone, 
    fax_number, 
    address, 
    city, 
    state_province, 
    zip_postal_code, 
    country_region, 
    web_page, 
    notes
FROM Northwind.shippers;

USE Northwind_DW;

SELECT 
    e.last_name AS "Employee's Last Name",
    SUM(f.product_quantity) AS "Total Order Quantity",
    SUM(f.product_unit_price) AS "Total Order Unit Price"
FROM 
    dim_employees e
JOIN fact_orders f ON e.employee_key = f.employee_key
GROUP BY 
    e.last_name;


