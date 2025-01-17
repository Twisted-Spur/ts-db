-- Switch to the twisted_spur schema
SET search_path TO twisted_spur;

-- Create a table named 'users' within the twisted_spur schema
CREATE TABLE users (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    -- not sure what to do with this if passwd is removed
    email TEXT NOT NULL UNIQUE,
    -- eventually passwd should be removed, and another authentication
    -- provider should be used externally
    passwd TEXT NOT NULL, -- DO NOT store clear text of this
    birthday DATE NOT NULL,
    phone_number TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE addresses (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INTEGER,
    title TEXT,
    billing_address TEXT,
    shipping_address TEXT,
    country TEXT,
    state_short TEXT,
    city TEXT,
    postal_code TEXT,
    phone_number TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE addresses
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) 
REFERENCES users (id);

CREATE TABLE categories (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category TEXT UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transfer_types (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    transfer_type TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE prints (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_id INTEGER,
    transfer_type_id INTEGER,
    -- should a larger range be used here?
    price NUMERIC(12,2) NOT NULL,
    url_to_print TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE prints
ADD CONSTRAINT fk_category_id
FOREIGN KEY (category_id) 
REFERENCES categories (id);

ALTER TABLE prints
ADD CONSTRAINT fk_transfer_type_id
FOREIGN KEY (transfer_type_id) 
REFERENCES transfer_types (id);

CREATE TABLE suppliers (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    brand TEXT UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_id INTEGER,
    price numeric(12,2),
    cost numeric(12,2),
    quantity INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE products
ADD CONSTRAINT fk_category_id
FOREIGN KEY (category_id) 
REFERENCES categories (id);

CREATE TABLE product_skus (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    print_id INTEGER NOT NULL,
    sku TEXT UNIQUE,
    price numeric(12,2),
    cost numeric(12,2),
    quantity INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE product_skus
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_id) 
REFERENCES products (id);

ALTER TABLE product_skus
ADD CONSTRAINT fk_supplier_id
FOREIGN KEY (supplier_id) 
REFERENCES suppliers (id);

ALTER TABLE product_skus
ADD CONSTRAINT fk_print_id
FOREIGN KEY (print_id) 
REFERENCES prints (id);

CREATE TABLE sku_attributes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_sku_id INTEGER,
    attribute_type TEXT NOT NULL,
    attribute_value TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE sku_attributes
ADD CONSTRAINT fk_product_sku_id
FOREIGN KEY (product_sku_id) 
REFERENCES product_skus (id);

CREATE TABLE cart (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INTEGER,
    total NUMERIC(12,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE cart
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) 
REFERENCES users (id);

CREATE TABLE cart_item(
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cart_id INTEGER,
    product_sku_id INTEGER,
    quantity INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE cart_item
ADD CONSTRAINT fk_cart_id
FOREIGN KEY (cart_id) 
REFERENCES cart (id);

ALTER TABLE cart_item
ADD CONSTRAINT fk_product_sku_id
FOREIGN KEY (product_sku_id) 
REFERENCES product_skus (id);

CREATE TABLE order_statuses (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_status TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_details (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INTEGER,
    payment_id INTEGER,
    total NUMERIC(12,2),
    order_status INTEGER,
    order_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE order_details
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id)
REFERENCES users (id);

CREATE TABLE payment_systems (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    payment_system TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_states (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    payment_state TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_details (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER,
    amount NUMERIC(12,2),
    payment_system INTEGER,
    payment_status INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE payment_details
ADD CONSTRAINT fk_order_id
FOREIGN KEY (order_id)
REFERENCES order_details (id);

ALTER TABLE payment_details
ADD CONSTRAINT fk_payment_system
FOREIGN KEY (payment_system)
REFERENCES payment_systems (id);

ALTER TABLE payment_details
ADD CONSTRAINT fk_payment_status
FOREIGN KEY (payment_status)
REFERENCES payment_states (id);

CREATE TABLE order_item (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    order_item_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE order_item
ADD CONSTRAINT fk_order_id
FOREIGN KEY (order_id)
REFERENCES order_details (id);

ALTER TABLE order_details
ADD CONSTRAINT fk_payment_id
FOREIGN KEY (payment_id)
REFERENCES payment_details (id);

-- -- List all schemas in the database
-- SELECT schema_name
-- FROM information_schema.schemata;

-- -- List all tables in the custom_shirts_store schema
-- SELECT table_name
-- FROM information_schema.tables
-- WHERE table_schema = 'custom_shirts_store';