
-- -------------------------------------------Assignment No 1 (columns and data types) -----------------------------------------------------------

create database ass1;
use ass1; 
-------------------------------------------------------------------------------------
-- suppliers

create table suppliers (
		supplier_id serial auto_increment,
        supplier_name varchar(150),
        contact_person varchar(100),
        phone_number varchar(20),
        email varchar(150),
        country varchar(100),
        created_at datetime
        );

INSERT INTO suppliers (supplier_name, contact_person, phone_number, email, country, created_at)
VALUES ('Tech Solutions India', 'Amit Verma', '+91-9876543210', 'amit@techsolutions.com', 'India', '2024-03-15'),
('Global Tech Corp', NULL, '+1-555-1112222', 'info@globaltech.com', 'Canada', '2024-07-10'),
('Asia Supplies', 'Li Wei', NULL, 'contact@asiasupplies.cn', 'China', '2023-11-20'),
('Local Traders', 'Rajesh Kumar', '+91-9988776655', NULL, 'India', '2025-01-05'),
('Tech Importers', 'John Doe', '+44-7778889999', 'sales@techimporters.co.uk', 'UK', '2024-12-31');


describe suppliers;
select * from suppliers;
----------------------------------------------------------------------------------------------------
-- warehouses

create table warehouse (
		warehouse_id serial auto_increment,
        warehouse_name varchar(150),
        city varchar(100),
        state varchar(100),
        country varchar(100),
        capacity_units int,
        created_at datetime
        );

INSERT INTO warehouse (warehouse_name, city, state, country, capacity_units, created_at)
VALUES('Mumbai Central Warehouse', 'Mumbai', 'Maharashtra', 'India', 50000, now()- INTERVAL 10 day),
('Pune Storage Hub', 'Pune', 'Maharashtra', 'India', 800, now() - INTERVAL 40 day),
('Delhi North Warehouse', 'Delhi', 'Delhi', 'India', 12000, now() - INTERVAL 5 day),
('Small Backup Warehouse', NULL, NULL, 'India', 500, now() - INTERVAL 2 day),
('Foreign Central Depot', 'New York', 'NY', 'USA', 20000, now() - INTERVAL 60 day);



------------------------------------------------------------------------------------------------
-- customers

create table customers (
		customer_id serial auto_increment,
		customer_name varchar(150),
        phone_number varchar(20),
        email varchar(150),
        city varchar(100),
        country varchar(100),
        created_at datetime
        );

INSERT INTO customers(customer_name, phone_number, email, city, country, created_at)
VALUES('ABC Store', '+91-9000000001', 'abcstore@gmail.com', 'Mumbai', 'India', '2025-02-01'),
('XYZ Mart', '0221234567', 'xyzmart@yahoo.com', 'Pune', 'India', '2025-03-15'),
('Online Retail Hub', NULL, 'sales@onlineretail.com', 'Delhi', 'India', '2025-05-10'),
('Quick Shop', '1234567890', 'contact@quickshop.com', 'Bangalore', 'India', '2024-12-20'),
('Global Store', '+1-8887776666', 'info@globalstore.com', 'New York', 'USA', '2025-01-10');

------------------------------------------------------------------------------------------------
-- purchase_orders

create table purchase_orders (
		po_id serial auto_increment,
        supplier_id int,
        po_date date,
        expected_date date,
        status varchar(50),
        total_amount numeric(10,2),                  -- ex= 9999999999.99  (max)
        created_at datetime
        );
        
INSERT INTO purchase_orders(supplier_id, po_date, expected_date, status, total_amount, created_at)
VALUES(1, '2025-01-10', '2025-01-20', 'Pending', 150000, '2025-01-10'),
(2, '2025-02-05', '2025-02-01', 'Approved', 18000, '2025-02-05'),
(3, '2024-12-15', NULL, 'Cancelled', 8000, '2024-12-15'),
(5, '2025-06-01', '2025-06-15', 'Approved', 120000, '2025-06-01');


------------------------------------------------------------------------------------------------
-- purchase_order_items

create table purchase_order_items (
		po_item_id serial auto_increment,
        po_id int,
        product_id int,
        quantity int,
        unit_price numeric(10,2),
		created_at datetime
        );

INSERT INTO purchase_order_items (po_id, product_id, quantity, unit_price, created_at)
VALUES (1, 10, 100, 45, NOW()),
(1, 20, 50, 120, NOW()),
(2, 30, 200, 40, NOW()),
(2, 40, 15, NULL, NOW()),
(3, 50, 8, 90, NOW());



------------------------------------------------------------------------------------------------
-- inventory

create table inventory (
		inventory_id serial auto_increment,
        warehouse_id int,
        product_id int,
        quantity_on_hand int,
        reorder_level  int,
        last_updated timestamp
        );

INSERT INTO inventory (warehouse_id, product_id, quantity_on_hand, reorder_level, last_updated)
VALUES (1, 10, 500, 100, NOW() - INTERVAL 2 day),
(2, 20, 0, 50, NOW() - INTERVAL 10 day),
(3, 30, 1500, 200, NOW() - INTERVAL 1 day),
(4, 40, 5, 10, NOW() - INTERVAL 3 day),
(5, 50, 300, 50, NOW() - INTERVAL 20 day);


------------------------------------------------------------------------------------------------
-- sales_orders

create table sales_orders (
		sales_order_id serial auto_increment,
        customer_id int,
        order_date date,
        status varchar(50),
        total_amount numeric(12,2),
        created_at datetime
        );

INSERT INTO sales_orders(customer_id, order_date, status, total_amount, created_at)
VALUES(1, '2025-03-01', 'Pending', 25000, NOW()),
(2, '2025-03-05', 'Shipped', 40000, NOW()),
(3, '2025-04-10', 'Delivered', 15000, NOW());



------------------------------------------------------------------------------------------------
-- sales_order_items

create table sales_order_items (
		so_item_id serial auto_increment,
        sales_order_id int,
        product_id int,
        quantity int,
        unit_price numeric(12,2),
        created_at datetime
        );

INSERT INTO sales_order_items(sales_order_id, product_id, quantity, unit_price, created_at)
VALUES(1, 10, 60, 500, NOW()),
(2, 20, 30, 700, NOW()),
(3, 30, 80, 200, NOW());

------------------------------------------------------------------------------------------------
-- shipments
create table shipments(
		shipment_id serial auto_increment,
        sales_order_id int,
        warehouse_id int,
        shipment_date date,
        delivery_date date,
        shipment_status varchar(50),
        tracking_number varchar(100),
        created_at timestamp
);


INSERT INTO shipments(sales_order_id, warehouse_id, shipment_date, delivery_date, shipment_status, tracking_number, created_at)
VALUES(2, 1, '2025-03-06', '2025-03-10', 'Delivered', 'TRK123IND', NOW()),
(3, 3, '2025-04-11', '2025-04-15', 'Delivered', 'TRK456IND', NOW()),
(1, 2, '2025-03-02', NULL, 'In Transit', 'TRK789IND', NOW());



----------------------------------------------------------------------------------------------------------
show tables 


