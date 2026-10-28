-- ---------------------------------------------------------------------------
-- Sample `simba` database for HW1
-- ---------------------------------------------------------------------------
-- The homework reads from a MySQL database called `simba` that lives on my
-- own machine. Nobody else has that database, so this script recreates a small
-- version of it with the same table structure and a few rows of sample data.
--
-- Run it once before knitting the homework:
--
--     mysql -u root -p < 01_create_simba_sample.sql
--
-- Or open it in MySQL Workbench and click the lightning bolt.
-- ---------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS simba
  DEFAULT CHARACTER SET utf8mb4;

USE simba;

-- Product categories. `products.category_id` points here.
CREATE TABLE IF NOT EXISTS categories (
  id   INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

-- The products a shop keeps in stock.
-- `reorder_level` is the point where stock is low enough to order more,
-- which is what the "low stock" query in the homework looks for.
CREATE TABLE IF NOT EXISTS products (
  id                INT PRIMARY KEY AUTO_INCREMENT,
  name              VARCHAR(100)   NOT NULL,
  category_id       INT,
  supplier_id       INT,
  barcode           VARCHAR(20),
  unit_price        DECIMAL(10, 2) NOT NULL,
  quantity_in_stock INT            NOT NULL DEFAULT 0,
  reorder_level     INT            NOT NULL DEFAULT 0,
  is_active         TINYINT(1)     NOT NULL DEFAULT 1,
  created_at        TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMP      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO categories (id, name) VALUES
  (1, 'Drinks'),
  (2, 'Dairy'),
  (3, 'Bakery'),
  (4, 'Cereals')
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO products
  (name, category_id, supplier_id, barcode, unit_price, quantity_in_stock, reorder_level, is_active)
VALUES
  ('Inyange Mineral Water 1.5L',    1, 1, '56900017',  700.00,  89, 40, 1),
  ('Inyange Mango Juice 1L',        1, 1, '56900024', 1800.00,  47, 25, 1),
  ('Fanta Orange 500ml',            1, 3, '56900031',  600.00,  59, 60, 1),
  ('Coca-Cola 500ml',               1, 3, '56900048',  600.00, 191, 60, 1),
  ('Primus Beer 500ml',             1, 3, '56900055', 1200.00, 113, 48, 1),
  ('Inyange Fresh Milk 1L',         2, 1, '56900062', 1200.00,  30, 30, 1),
  ('Inyange Vanilla Yoghurt 500ml', 2, 1, '56900079', 1500.00,   1, 20, 1),
  ('Inyange Butter 250g',           2, 1, '56900086', 2800.00,  12, 15, 1),
  ('Blue Band Margarine 500g',      2, 8, '56900093', 3500.00,   1, 12, 1),
  ('Kigali Fresh White Bread 600g', 3, 6, '56900100', 1300.00,  23, 25, 1),
  ('Kigali Fresh Brown Bread 600g', 3, 6, '56900117', 1500.00,  25, 20, 1),
  ('Sweet Buns Pack of 6',          3, 6, '56900124', 1800.00,   2, 15, 1),
  ('Azam Wheat Flour 2kg',          4, 2, '56900131', 2900.00,  38, 20, 1),
  ('Azam Maize Flour 2kg',          4, 2, '56900148', 2200.00,   2, 25, 1),
  ('Super Mwea Rice 5kg',           4, 7, '56900155', 9500.00,   1, 10, 1);
