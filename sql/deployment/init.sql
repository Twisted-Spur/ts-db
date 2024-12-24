-- Create a new database named 'twisted_spur'
CREATE DATABASE twisted_spur;

-- Create a new schema named 'twisted_spur'
CREATE SCHEMA twisted_spur;

-- Switch to the twisted_spur schema
SET search_path TO twisted_spur;

-- Create a table named 'orders' within the custom_shirts_store schema
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    priority VARCHAR(50),
    customer VARCHAR(255),
    order_number VARCHAR(50),
    shirt_style VARCHAR(100),
    shirt_size VARCHAR(50),
    shirt_brand VARCHAR(100),
    shirt_color VARCHAR(50),
    number_of_shirts INTEGER,
    transfer_code VARCHAR(50),
    transfer_type VARCHAR(50),
    status VARCHAR(50),
    transfer_status VARCHAR(50),
    shirt_status VARCHAR(50),
    order_date DATE,
    cost NUMERIC(10, 2),
    price NUMERIC(10, 2),
    tax NUMERIC(10, 2),
    price_with_tax NUMERIC(10, 2),
    profit NUMERIC(10, 2),
    payment_system VARCHAR(100),
    payment_status VARCHAR(50),
    sales_platform VARCHAR(100),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    phone_number VARCHAR(20),
    notes TEXT
);

-- List all schemas in the database
SELECT schema_name
FROM information_schema.schemata;

-- List all tables in the custom_shirts_store schema
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'custom_shirts_store';