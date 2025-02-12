-- Switch to the twisted_spur schema
SET search_path TO twisted_spur;

-- Insert sample data into users table
-- INSERT INTO users (first_name, last_name, email, passwd, birthday, phone_number)
-- VALUES
-- ('John', 'Doe', 'john.doe@example.com', 'password123', '1985-01-15', '123-456-7890'),
-- ('Jane', 'Smith', 'jane.smith@example.com', 'password123', '1990-02-20', '098-765-4321');

-- Insert sample data into addresses table
-- INSERT INTO addresses (user_id, title, billing_address, shipping_address, country, state_short, city, postal_code, phone_number)
-- VALUES
-- (1, 'Home', '123 Main St', '123 Main St', 'USA', 'NY', 'New York', '10001', '123-456-7890'),
-- (2, 'Office', '456 Elm St', '456 Elm St', 'USA', 'CA', 'Los Angeles', '90001', '098-765-4321');

-- Insert sample data into categories table
INSERT INTO categories (category)
VALUES
('Custom Shirts'),
('Custom Hats'),
('Custom Drinkware');

-- Insert sample data into transfer_types table
INSERT INTO transfer_types (transfer_type)
VALUES
('DTF'),
('Sublimation'),
('Screen Print'),
('Gang sheet');

INSERT INTO print_placements (category_id, placement)
VALUES
(0, 'Left Chest'),
(0, 'Center Chest'),
(0, 'Full Front'),
(0, 'Oversized Front'),
(0, 'Back Collar'),
(0, 'Upper Back'),
(0, 'Full Back'),
(1, 'Single Center'),
(2, 'Single Wrap');

-- Insert sample data into prints table
-- INSERT INTO prints (category_id, transfer_type_id, price, url_to_print)
-- VALUES
-- (1, 1, 19.99, 'http://example.com/print1'),
-- (2, 2, 29.99, 'http://example.com/print2');

-- Insert sample data into suppliers table
INSERT INTO suppliers (brand)
VALUES
('Gildan'),
('Jerzee'),
('Comfort Colors'),
('Bella');

-- Insert sample data into products table
-- INSERT INTO products (category_id, price, cost, quantity)
-- VALUES
-- (1, 99.99, 49.99, 100),
-- (2, 49.99, 19.99, 200);

-- Insert sample data into product_skus table
-- INSERT INTO product_skus (product_id, supplier_id, print_id, sku, price, cost, quantity)
-- VALUES
-- (1, 1, 1, 'SKU001', 99.99, 49.99, 100),
-- (2, 2, 2, 'SKU002', 49.99, 19.99, 200);

-- Insert sample data into sku_attributes table
-- INSERT INTO sku_attributes (product_sku_id, attribute_type, attribute_value)
-- VALUES
-- (1, 'Color', 'Red'),
-- (2, 'Size', 'L');

-- Insert sample data into cart table
-- INSERT INTO cart (user_id, total)
-- VALUES
-- (1, 149.98),
-- (2, 49.99);

-- Insert sample data into cart_item table
-- INSERT INTO cart_item (cart_id, product_sku_id, quantity)
-- VALUES
-- (1, 1, 1),
-- (2, 2, 1);

-- Insert sample data into order_statuses table
INSERT INTO order_statuses (order_status)
VALUES
('In Progress'),
('Shipped'),
('Ready To Deliver'),
('Delivered');

-- Insert sample data into order_details table
-- INSERT INTO order_details (user_id, payment_id, total, order_status, order_notes)
-- VALUES
-- (1, NULL, 149.98, 1, 'First order notes'),
-- (2, NULL, 49.99, 2, 'Second order notes');

-- Insert sample data into payment_systems table
INSERT INTO payment_systems (payment_system)
VALUES
('Cashapp'),
('Cash/Check'),
('Paypal'),
('Square'),
('Venmo');

-- Insert sample data into payment_states table
INSERT INTO payment_states (payment_state)
VALUES
('Pending'),
('Paid');

-- Insert sample data into payment_details table
-- INSERT INTO payment_details (order_id, amount, payment_system, payment_status)
-- VALUES
-- (1, 149.98, 1, 2),
-- (2, 49.99, 2, 1);

-- Update order_details table to set payment_id
-- UPDATE order_details SET payment_id = 1 WHERE id = 1;
-- UPDATE order_details SET payment_id = 2 WHERE id = 2;

-- Insert sample data into order_item table
-- INSERT INTO order_item (order_id, product_id, quantity, order_item_notes)
-- VALUES
-- (1, 1, 1, 'First order item notes'),
-- (2, 2, 1, 'Second order item notes');