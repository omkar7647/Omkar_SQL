

-- --------------------------------------------  Assignment no 2 : WHERE, AND, OR   ---------------------------------------------------------------------------

use ass1;
---------------------------------------------------------------------------------------

-- 1 List all suppliers located in India.

select * from suppliers 
where country="India";

------------------------------------------------------------------------------------------
-- 2 Find suppliers where supplier_name contains 'Tech' and country is not 'USA'

select * from suppliers
where supplier_name like "%Tech%" and country != "USA";

--------------------------------------------------------------------------------------------
-- 3 Show suppliers created after 2024-01-01 and before 2024-12-31 (inclusive).

select * from suppliers
where created_at >= '2024-01-01'AND created_at < '2025-01-01';    -- when useing betwween miss some records 

---------------------------------------------------------------------------------------------
 -- 4 Return suppliers where contact_person IS NULL OR email IS NULL.
 
 select * from suppliers
 where contact_person is null or email is null;
 
 ----------------------------------------------------------------------------------------------
 -- 5 Get suppliers whose phone_number starts with '+91' AND email ends with '.com'.
 
 select * from suppliers 
 where phone_number like "+91%" and email like "%.com";

--------------------------------------------------------------------------------------------------
-- 6 List warehouses in the state 'Maharashtra' OR city = 'Pune'.

select * from warehouse
where state="Maharashtra" or city= "Pune";

------------------------------------------------------------------------------------------------
-- 7 Find warehouses in India AND capacity_units >= 10000.

select * from warehouse
where country="India" and  capacity_units >= 10000;

------------------------------------------------------------------------------------------------
-- 8 Show warehouses where warehouse_name ILIKE '%central%' AND country = 'India'.

select * from warehouse
where warehouse_name like "%central%" and country="India";

------------------------------------------------------------------------------------------------
-- 9 Return warehouses created in the last 30 days (use current_date) OR capacity_units <1000.

select * from warehouse
where created_at >= NOW() - INTERVAL 30 DAY;

------------------------------------------------------------------------------------------------
-- 10 Get warehouses where state IS NULL OR city IS NULL (missing location details).

select * from warehouse
where state is null or city is null ;

------------------------------------------------------------------------------------------------
-- 11 List customers with email ending in '@gmail.com' AND country = 'India'.

select * from customers
where email like "%@gmail.com" and country="India";

------------------------------------------------------------------------------------------------
-- 12 Find customers whose city IN ('Mumbai', 'Pune', 'Delhi') OR phone_number LIKE '022%'.

select * from customers 
where city in ("Mumbai","Pune","Delhi") or phone_number like "022%";

------------------------------------------------------------------------------------------------
-- 13 Show customers created_at between two dates, e.g., 2025-01-01 AND 2025-06-30.

select * from customers
where created_at between 2025-01-01 AND 2025-06-30;

------------------------------------------------------------------------------------------------
-- 14 Return customers where customer_name ILIKE '%store%' OR ILIKE '%mart%'.

select * from customers 
where customer_name like "%store%" or "%mart%";

------------------------------------------------------------------------------------------------
-- 15 Get customers with missing phone_number OR invalid phone_number (NOT LIKE '+%').

select * from customers 
where phone_number is null or phone_number not like "+%";

------------------------------------------------------------------------------------------------
-- 16 List purchase orders where status = 'Pending' OR status = 'Approved'.

select * from purchase_orders
where status="Pending" or status="Approved";

------------------------------------------------------------------------------------------------
-- 17 Find purchase orders for supplier_id = 5 AND total_amount > 100000.

select * from purchase_orders
where supplier_id=5 and total_amount>100000;

------------------------------------------------------------------------------------------------
-- 18 Show purchase orders expected_date < po_date (late entry) OR expected_date IS NULL.

select * from purchase_orders
where expected_date < po_date or expected_date is null;

------------------------------------------------------------------------------------------------
-- 19 Return purchase orders in 2025 (po_date between 2025-01-01 and 2025-12-31).

select * from purchase_orders
where po_date between 2025-01-01 and 2025-12-31;

------------------------------------------------------------------------------------------------
-- 20 Get purchase orders with total_amount BETWEEN 5000 AND 20000 AND status <>'Cancelled'.

select * from purchase_orders
where total_amount between 5000 and 20000 and status <> "Cancelled";

------------------------------------------------------------------------------------------------
-- 21 List PO items where quantity >= 100 AND unit_price <= 50.

select * from sales_order_items
where quantity >=100 and unit_price <= 50;

------------------------------------------------------------------------------------------------
-- 22 Find PO items for a given po_id (e.g., 101) OR product_id IN (10, 20, 30).

select * from sales_order_items
where product_id=101 or product_id in (10,20,30);

------------------------------------------------------------------------------------------------
-- 23 Show PO items created_at IS NOT NULL AND quantity % 2 = 0 (even quantities).

select * from sales_order_items
where created_at is not null and quantity % 2=0;

------------------------------------------------------------------------------------------------
-- 24 Return PO items where unit_price * quantity > 5000 OR unit_price IS NULL.

select * from sales_order_items
where unit_price * quantity > 5000 or unit_price is null;

------------------------------------------------------------------------------------------------
-- 25 Get PO items with quantity BETWEEN 1 AND 10 AND NOT (unit_price > 100).

select * from sales_order_items
where quantity between 1 and 10 and not unit_price >100;

------------------------------------------------------------------------------------------------
-- 26 List inventory rows where quantity_on_hand < reorder_level OR quantity_on_hand = 0.

select * from inventory
where quantity_on_hand < reorder_level OR quantity_on_hand = 0;

------------------------------------------------------------------------------------------------
-- 27 Find inventory for warehouse_id = 3 AND product_id = 1001.

select * from inventory
where warehouse_id = 3 AND product_id = 1001;

------------------------------------------------------------------------------------------------
-- 28 Show inventory last_updated > now() - interval '7 days' OR quantity_on_hand > 1000.

select * from inventory
where last_updated > now() - interval 7 day OR quantity_on_hand > 1000;

------------------------------------------------------------------------------------------------
-- 29 Return inventory with product_id IN (SELECT product_id FROM purchase_order_items)AND quantity_on_hand > 0.

select * from inventory
where product_id IN (SELECT product_id FROM purchase_order_items) AND quantity_on_hand > 0;

------------------------------------------------------------------------------------------------
-- 30 Get inventory records where warehouse_id IN (SELECT warehouse_id FROM warehouses WHERE country = 'India') AND reorder_level >= 50.

select * from inventory
where warehouse_id IN (SELECT warehouse_id FROM warehouse WHERE country = 'India') AND reorder_level >= 50;

------------------------------------------------------------------------------------------------
-- 31 List sales orders where status IN ('Pending','Shipped') AND total_amount > 20000.

select * from sales_orders
where status IN ('Pending','Shipped') AND total_amount > 20000;

------------------------------------------------------------------------------------------------
-- 32 Find sales order items for sales_order_id = 200 OR quantity >= 50.

select * from sales_order_items
where sales_order_id = 200 OR quantity >= 50;

------------------------------------------------------------------------------------------------
-- 33 Show shipments where shipment_status = 'Delivered' AND delivery_date BETWEEN '2025-01-01' AND '2025-12-31'.

select * from shipments
where shipment_status = 'Delivered' AND delivery_date BETWEEN '2025-01-01' AND '2025-12-31';
