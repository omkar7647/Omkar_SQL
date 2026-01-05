
-- --------------------------- Assignment no 3 : PostgreSQL Schema with Columns, Data Types, and Constraints ------------------------------------------
use ass1;

----------------------------------------------------------------------------------------------
-- 1) suppliers
-- onstraints:- Primary Key: supplier_id- NOT NULL: supplier_name, email, country, created_at- UNIQUE: email- DEFAULT: created_at = CURRENT_TIMESTAMP

describe  suppliers;

ALTER TABLE suppliers
ADD CONSTRAINT supplier_id PRIMARY KEY (supplier_id),
ADD CONSTRAINT email UNIQUE (email);

ALTER TABLE suppliers
MODIFY supplier_name VARCHAR(255) NOT NULL,
MODIFY country VARCHAR(100) NOT NULL,
MODIFY created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
modify email varchar(150) default "unknown@gmail.com";

describe  suppliers;

--------------------------------------------------------------------------------------------------
-- Table: warehouses
-- Primary Key: warehouse_id- NOT NULL: warehouse_name, city, country, capacity_units- DEFAULT: created_at = CURRENT_TIMESTAMP- CHECK: capacity_units >= 0

describe  warehouse;

alter table warehouse
add constraint warehouse_id primary key(warehouse_id);

alter table warehouse
modify warehouse_name varchar(200) not null,
modify city varchar(150) not null,
modify country varchar(200) not null,
modify capacity_units int not null, 
modify created_at timestamp default current_timestamp,
add check (capacity_units >=0) ;
 
describe  warehouse;

-----------------------------------------------------------------------------------------------------------------
-- Table: customers
-- onstraints:- Primary Key: customer_id- NOT NULL: customer_name, email, country- UNIQUE: email- DEFAULT: created_at = CURRENT_TIMESTAMP

describe customers;

alter table customers
add constraint customer_id  primary key(customer_id),
add constraint email unique(email); 

alter table customers
modify customer_id int  not null,
modify  customer_name varchar(200) not null,
modify country varchar(200) not null,
modify email varchar(200) default "default",
modify created_at timestamp default current_timestamp;

describe customers;

----------------------------------------------------------------------------------------------------
-- Table: purchase_orders
-- onstraints:- Primary Key: po_id- NOT NULL: supplier_id, po_date, status, total_amount - DEFAULT: status='Pending', total_amount=0.00, created_at=CURRENT_TIMESTAMP
-- CHECK: total_amount >= 0- CHECK: expected_date IS NULL OR expected_date >= po_date- Foreign Key: supplier_id -> suppliers(supplier_id)

alter table suppliers
modify supplier_id int ;

alter table purchase_orders
-- add constraint po_id primary key(po_id);
 add constraint fk_purchase_orders_supplier foreign key  (supplier_id) references suppliers(supplier_id);

ALTER TABLE purchase_orders
MODIFY po_date DATE NOT NULL,
MODIFY status VARCHAR(50) NOT NULL DEFAULT 'Pending',
MODIFY total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
MODIFY created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT chk_total_amount_positive
    CHECK (total_amount >= 0);
    
describe purchase_orders;


------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table: purchase_order_items
--  onstraints:- Primary Key: po_item_id- NOT NULL: po_id, product_id, quantity, unit_price DEFAULT: quantity=1, created_at=CURRENT_TIMESTAMP 
-- UNIQUE (composite): (po_id, product_id)- CHECK: quantity > 0, unit_price >= 0- Foreign Key: po_id -> purchase_orders(po_id)

ALTER TABLE purchase_order_items
MODIFY po_id INT UNSIGNED NOT NULL;

ALTER TABLE purchase_order_items
ADD CONSTRAINT pk_po_items PRIMARY KEY (po_id, product_id);

ALTER TABLE purchase_order_items
ADD CONSTRAINT fk_po_id FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id);

ALTER TABLE purchase_order_items
ADD CONSTRAINT chk_quantity_positive CHECK (quantity > 0),
ADD CONSTRAINT chk_unit_price_positive CHECK (unit_price >= 0);

ALTER TABLE purchase_order_items
modify quantity int default 1,
modify created_at datetime default current_timestamp;

describe purchase_order_items;

------------------------------------------------------------------------------------------------------------------
-- Table: inventory
-- onstraints:- Primary Key: inventory_id- NOT NULL: warehouse_id, product_id, quantity_on_hand, reorder_level- DEFAULT: quantity_on_hand=0, reorder_level=10- 
-- UNIQUE (composite): (warehouse_id, product_id)- CHECK: quantity_on_hand >= 0, reorder_level >= 0 -Foreign Key: warehouse_id -> warehouse(warehouse_id)

ALTER TABLE inventory
MODIFY inventory_id INT NOT NULL,
MODIFY warehouse_id INT UNSIGNED NOT NULL,
MODIFY product_id INT NOT NULL,
MODIFY quantity_on_hand INT NOT NULL DEFAULT 0,
MODIFY reorder_level INT NOT NULL DEFAULT 10;

alter table warehouse
MODIFY warehouse_id INT UNSIGNED NOT NULL;

ALTER TABLE inventory
ADD CONSTRAINT pk_inventory PRIMARY KEY (inventory_id),
ADD CONSTRAINT uq_inventory_warehouse_product UNIQUE (product_id),
ADD CONSTRAINT fk_inventory_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id),
ADD CONSTRAINT chk_quantity_on_hand_non_negative CHECK (quantity_on_hand >= 0),
ADD CONSTRAINT chk_reorder_level_non_negative CHECK (reorder_level >= 0);

describe inventory;

-------------------------------------------------------------------------------------------------------------------------------------
-- Table: sales_orders
-- onstraints:- Primary Key: sales_order_id- NOT NULL: customer_id, order_date, status, total_amount
-- DFAULT: status='Pending', total_amount=0.00, created_at=CURRENT_TIMESTAMP- CHECK: total_amount >= 0- Foreign Key: customer_id -> customers(customer_id)

ALTER TABLE sales_orders
MODIFY customer_id INT UNSIGNED NOT NULL,
MODIFY order_date datetime  NOT NULL,
MODIFY status varchar(200) NOT NULL default "Pending",
MODIFY total_amount numeric(10,2) NOT NULL default 0.00,
MODIFY created_at timestamp default current_timestamp;

alter table customers
MODIFY customer_id INT UNSIGNED NOT NULL;

ALTER TABLE sales_orders
ADD CONSTRAINT pk_sales_orders PRIMARY KEY (sales_order_id),
ADD CONSTRAINT fk_sales_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
ADD CONSTRAINT chk_total_amount CHECK (total_amount >= 0);

describe sales_orders;

---------------------------------------------------------------------------------------------------------------------------
-- Table: sales_order_items
-- nstraints:- Primary Key: so_item_id- NOT NULL: sales_order_id, product_id, quantity, unit_price- DEFAULT: created_at=CURRENT_TIMESTAMP
-- UNIQUE (composite): (sales_order_id, product_id)- CHECK: quantity > 0, unit_price >= 0- Foreign Key: sales_order_id -> sales_orders(sales_order_id)

ALTER TABLE sales_order_items
MODIFY sales_order_id INT UNSIGNED NOT NULL,
MODIFY product_id int  NOT NULL,
MODIFY quantity int NOT NULL ,
MODIFY unit_price numeric(10,2) NOT NULL,
MODIFY created_at timestamp default current_timestamp;

alter table sales_orders
MODIFY sales_order_id INT UNSIGNED NOT NULL;

ALTER TABLE sales_order_items
ADD CONSTRAINT pk_sales_order_items PRIMARY KEY (sales_order_id, product_id),
ADD CONSTRAINT fk_sales_order_items_sales_orders FOREIGN KEY (sales_order_id) REFERENCES sales_orders(sales_order_id),
ADD CONSTRAINT chk_quantity CHECK (quantity > 0);

describe sales_order_items;

----------------------------------------------------------------------------------------------------------------------------------
-- Table: shipments
-- onstraints:- Primary Key: shipment_id - not NuLL: sales_order_id, warehouse_id, shipment_date, shipment_status- UNIQUE: tracking_number
-- DEFAULT: shipment_status='Created', created_at=CURRENT_TIMESTAMP- CHECK: delivery_date IS NULL OR delivery_date >= shipment_date
-- Foreign Keys: sales_order_id -> sales_orders(sales_order_id), warehouse_id -> warehouses(warehouse_id)

ALTER TABLE shipments
MODIFY sales_order_id INT UNSIGNED NOT NULL,
MODIFY warehouse_id int UNSIGNED  NOT NULL,
MODIFY shipment_date date NOT NULL ,
MODIFY shipment_status varchar(200) NOT NULL;

alter table sales_orders
MODIFY sales_order_id INT UNSIGNED NOT NULL;

alter table warehouse
MODIFY warehouse_id INT UNSIGNED NOT NULL;

ALTER TABLE shipments
ADD CONSTRAINT pk_shipments PRIMARY KEY (shipment_id),
ADD CONSTRAINT uk_shipments unique KEY (tracking_number),
ADD CONSTRAINT fk1_shipments_sales_orders FOREIGN KEY (sales_order_id) REFERENCES sales_orders(sales_order_id),
ADD CONSTRAINT fk2_shipments_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id);

describe shipments;

--------------------------------------------------------------------------------------------------------------------------------------------