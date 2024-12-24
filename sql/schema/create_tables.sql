-- Switch to the twisted_spur schema
SET search_path TO twisted_spur;

-- Create a table named 'orders' within the custom_shirts_store schema
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    -- not sure what to do with this if passwd is removed
    email TEXT,
    -- eventually passwd should be removed, and another authentication
    -- provider should be used externally
    passwd TEXT,
    birthday DATE,
    phone_number TEXT,
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

CREATE TABLE addresses (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    title TEXT,
    billing_address TEXT,
    shipping_address TEXT,
    country TEXT,
    state_short TEXT,
    city TEXT,
    postal_code TEXT,
    phone_number TEXT,
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

ALTER TABLE addresses
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) 
REFERENCES users (id);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category TEXT,
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

CREATE TYPE transfer_types AS ENUM (
    'DTF',
    'SUBLIMATION',
    'GANG_SHEET',
    'SCREEN_PRINT'
);

CREATE TABLE transfers (
    id SERIAL PRIMARY KEY,
    category_id INTEGER,
    transfer_type transfer_types,
    -- should a larger range be used here?
    price NUMERIC(12,2),
    url_to_image TEXT,
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

ALTER TABLE transfers
ADD CONSTRAINT fk_category_id
FOREIGN KEY (category_id) 
REFERENCES categories (id);

CREATE TYPE shirt_type AS ENUM (
    'T_SHIRT',
    'LONG_SLEEVE',
    'CREW_NECK',
    'HOODIE',
    'T_SHIRT_KIDS',
    'CREW_NECK_KIDS'
);

CREATE TYPE shirt_size AS ENUM (
    'SMALL',
    'MEDIUM',
    'LARGE',
    'XL',
    'XXL',
    'XXXL',
    '4XL',
    '5XL'
);

CREATE TABLE shirt_colors (
    id SERIAL PRIMARY KEY,
    color_name TEXT,
    hex_rep BYTEA,
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    brand TEXT,
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

CREATE TABLE shirt_products (
    id SERIAL PRIMARY KEY,
    category_id INTEGER,
    supplier_id INTEGER,
    shirt_style shirt_type,
    shirt_size shirt_size,
    shirt_color_id INTEGER,
    transfer_id INTEGER,
    price numeric(12,2),
    cost numeric(12,2),
    quantity INTEGER,
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

ALTER TABLE shirt_products
ADD CONSTRAINT fk_category_id
FOREIGN KEY (category_id) 
REFERENCES categories (id);

ALTER TABLE shirt_products
ADD CONSTRAINT fk_supplier_id
FOREIGN KEY (supplier_id) 
REFERENCES suppliers (id);

ALTER TABLE shirt_products
ADD CONSTRAINT fk_shirt_color_id
FOREIGN KEY (shirt_color_id) 
REFERENCES shirt_colors (id);

ALTER TABLE shirt_products
ADD CONSTRAINT fk_transfer_id
FOREIGN KEY (transfer_id) 
REFERENCES transfers (id);

CREATE TABLE cart (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    total NUMERIC(12,2),
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

ALTER TABLE cart
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) 
REFERENCES users (id);

CREATE TABLE cart_item(
    id SERIAL PRIMARY KEY,
    cart_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    created_at TIMESTAMP,
    last_updated TIMESTAMP
);

ALTER TABLE cart_item
ADD CONSTRAINT fk_cart_id
FOREIGN KEY (cart_id) 
REFERENCES cart (id);

ALTER TABLE cart_item
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_id) 
REFERENCES products (id);

--     order_number VARCHAR(50),
--     number_of_shirts INTEGER,
--     status VARCHAR(50),
--     transfer_status VARCHAR(50),
--     shirt_status VARCHAR(50),
--     order_date DATE,
--     cost NUMERIC(10, 2),
--     price NUMERIC(10, 2),
--     tax NUMERIC(10, 2),
--     price_with_tax NUMERIC(10, 2),
--     profit NUMERIC(10, 2),
--     payment_system VARCHAR(100),
--     payment_status VARCHAR(50),
--     sales_platform VARCHAR(100),
--     notes TEXT

-- -- List all schemas in the database
-- SELECT schema_name
-- FROM information_schema.schemata;

-- -- List all tables in the custom_shirts_store schema
-- SELECT table_name
-- FROM information_schema.tables
-- WHERE table_schema = 'custom_shirts_store';