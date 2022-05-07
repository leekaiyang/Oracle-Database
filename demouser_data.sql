-- add 1 supplier first
INSERT INTO "DEMOUSER"."suppliers" ("name", "address", "pic_name", "pic_contact_no")
VALUES ('Kee Tech Motor Sdn Bhd', 'NO 388, Jalan Kenari, 46200 Petaling Jaya, Selangor', 'Tan Bee Bee', '0128787566');

-- add 2nd supplier
INSERT INTO "DEMOUSER"."suppliers" ("name", "address")
VALUES ('Kian Shyan Motor Sdn Bhd', 'NO 466, Jalan Timan, 46200 Petaling Jaya, Selangor');

-- add 3rd supplier
INSERT INTO "DEMOUSER"."suppliers" ("name", "pic_name", "pic_contact_no")
VALUES ('Bauto Motor Sdn Bhd', 'See Won', '0165813566');

-- ERROR
INSERT INTO "DEMOUSER"."suppliers" ("address", "pic_name", "pic_contact_no")
VALUES ('NO 508, Jalan Damai, 46200 Petaling Jaya, Selangor', 'See Won', '0165813566');
---
UPDATE "DEMOUSER"."suppliers"
SET "name"='Jonathon'
WHERE "supplier_id" = 1;

-- order from the supplier
INSERT INTO "DEMOUSER"."supplier_orders" ("supplier_id")
VALUES (1);

-- order from the supplier
INSERT INTO "DEMOUSER"."supplier_orders" ("supplier_id")
VALUES (2);

-- order from the supplier
INSERT INTO "DEMOUSER"."supplier_orders" ("supplier_id")
VALUES (3);

-- add 1 product purchased through the order
INSERT INTO "DEMOUSER"."products" ("engine_no", "chassis_no", "brand", "model", "colour", "unit_cost", "unit_price", "supplier_order_id")
VALUES ('83901283018', '7839217398', 'HONDA', 'C100B', 'BLUE', '4500', '5000', 1);

-- add 1 product purchased through the 2ndorder
INSERT INTO "DEMOUSER"."products" ("engine_no", "chassis_no", "brand", "model", "colour", "unit_cost", "unit_price", "supplier_order_id")
VALUES ('83901283818', '6824217398', 'KAWASAKI', 'Z100', 'GREEN', '23000', '28000', 2);


-- add 1 product purchased through the 3ndorder
INSERT INTO "DEMOUSER"."products" ("engine_no", "chassis_no", "brand", "model", "colour", "unit_cost", "unit_price", "supplier_order_id")
VALUES ('83901569818', '6824333398', 'YAMAHA', 'A10', 'WHITE', '8900', '9200', 3);

-- add cost to the order
UPDATE "DEMOUSER"."supplier_orders"
SET "total_cost" = (SELECT "unit_cost" FROM "DEMOUSER"."products" WHERE "supplier_order_id" = 1);

-- add cost to the order
UPDATE "DEMOUSER"."supplier_orders"
SET "total_cost" = (SELECT "unit_cost" FROM "DEMOUSER"."products" WHERE "supplier_order_id" = 2);

-- add cost to the order
UPDATE "DEMOUSER"."supplier_orders"
SET "total_cost" = (SELECT "unit_cost" FROM "DEMOUSER"."products" WHERE "supplier_order_id" = 3);

-- add 1 customer
INSERT INTO "DEMOUSER"."customers" ("name", "ic_no", "contact_no", "address")
VALUES ('Hawk', '870412030523', '0187878562', 'NO 123, Jalan Kamunting, 46200 Petaling Jaya, Selangor');

-- add 2nd customer
INSERT INTO "DEMOUSER"."customers" ("name", "ic_no", "contact_no")
VALUES ('John', '670420035285', '0175656438');

-- add 3rd customer
INSERT INTO "DEMOUSER"."customers" ("name", "ic_no", "address")
VALUES ('Ahmad', '590303036363', 'NO 789, Jalan Kemuning, 46200 Petaling Jaya, Selangor');

-- customer buy the product
INSERT INTO "DEMOUSER"."customer_orders" ("customer_id", "product_id", "total_price", "date")
VALUES (1, 1, (SELECT "unit_price" FROM "products" WHERE "product_id" = 1), (SELECT SYSDATE FROM DUAL));

-- customer buy the product
INSERT INTO "DEMOUSER"."customer_orders" ("customer_id", "product_id", "total_price", "date")
VALUES (2, 2, (SELECT "unit_price" FROM "products" WHERE "product_id" = 2), (SELECT SYSDATE FROM DUAL));

-- customer buy the product
INSERT INTO "DEMOUSER"."customer_orders" ("customer_id", "product_id", "total_price", "date")
VALUES (3, 3, (SELECT "unit_price" FROM "products" WHERE "product_id" = 3), (SELECT SYSDATE FROM DUAL));

-- customer requests for installment
INSERT INTO "DEMOUSER"."installments" ("agreement_no", "down_payment_amount", "monthly_installment_amount", "installment_period")
VALUES ('8409238043298', 1000, 200, 60);

--2nd customer requests for installment
INSERT INTO "DEMOUSER"."installments" ("agreement_no", "down_payment_amount", "monthly_installment_amount", "installment_period")
VALUES ('7779236943298', 16000, 400, 30);

--3rd customer requests for installment
INSERT INTO "DEMOUSER"."installments" ("agreement_no", "down_payment_amount", "monthly_installment_amount", "installment_period")
VALUES ('8409238052893', 2900, 105, 60);

-- add installment to the customer order
UPDATE "DEMOUSER"."customer_orders"
SET "agreement_no" = '8409238043298'
WHERE "customer_order_id" = 1;

-- add installment to the customer order
UPDATE "DEMOUSER"."customer_orders"
SET "agreement_no" = '7779236943298'
WHERE "customer_order_id" = 2;

-- add installment to the customer order
UPDATE "DEMOUSER"."customer_orders"
SET "agreement_no" = '8409238052893'
WHERE "customer_order_id" = 3;

-- insert customer_order_id into products
UPDATE "DEMOUSER"."products"
SET "customer_order_id" = 1
WHERE "supplier_order_id" = 1;

UPDATE "DEMOUSER"."products"
SET "customer_order_id" = 2
WHERE "supplier_order_id" = 2;

UPDATE "DEMOUSER"."products"
SET "customer_order_id" = 3
WHERE "supplier_order_id" = 3;

-- create new payment
INSERT INTO "DEMOUSER"."payment" ("amount", "timestamp")
VALUES ((SELECT "total_price" FROM "customer_orders" WHERE "customer_order_id" = 1), (SELECT SYSTIMESTAMP FROM DUAL));

-- create new payment
INSERT INTO "DEMOUSER"."payment" ("amount", "timestamp")
VALUES ((SELECT "total_price" FROM "customer_orders" WHERE "customer_order_id" = 2), (SELECT SYSTIMESTAMP FROM DUAL));

-- create new payment
INSERT INTO "DEMOUSER"."payment" ("amount", "timestamp")
VALUES ((SELECT "total_price" FROM "customer_orders" WHERE "customer_order_id" = 3), (SELECT SYSTIMESTAMP FROM DUAL));

-- add payment to respective customer order
UPDATE "DEMOUSER"."customer_orders"
SET "payment_id" = 1
WHERE "customer_order_id" = 1;

-- add payment to respective customer order
UPDATE "DEMOUSER"."customer_orders"
SET "payment_id" = 2
WHERE "customer_order_id" = 2;

-- add payment to respective customer order
UPDATE "DEMOUSER"."customer_orders"
SET "payment_id" = 3
WHERE "customer_order_id" = 3;

-- add 1 staff to the shop
INSERT INTO "DEMOUSER"."staffs" ("name", "ic_no", "contact_no", "address")
VALUES ('Tee Fen', '001121070707', '0123456789', 'NO 701, Jalan Tepi Pantai, 46200 Petaling Jaya, Selangor');

-- add 2nd staff to the shop
INSERT INTO "DEMOUSER"."staffs" ("name", "ic_no", "contact_no", "address")
VALUES ('Kei Yang', '011121030507', '0135956789', 'NO 606, Jalan Atas Pantai, 46200 Petaling Jaya, Selangor');

-- add 1 staff to the shop
INSERT INTO "DEMOUSER"."staffs" ("name", "ic_no", "contact_no", "address")
VALUES ('Jun Jie', '001120070505', '0123585889', 'NO 801, Jalan Gajah, 46200 Petaling Jaya, Selangor');

-- create 1 position for the staff
INSERT INTO "DEMOUSER"."positions" ("position_name", "staff_id", "base_salary")
VALUES ('Sales Assistant', 1, 2500);

-- create 1 position for the staff
INSERT INTO "DEMOUSER"."positions" ("position_name", "staff_id", "base_salary")
VALUES ('Manager', 2, 8000);

-- create 1 position for the staff
INSERT INTO "DEMOUSER"."positions" ("position_name", "staff_id", "base_salary")
VALUES ('Accountant', 3, 3500);

-- staff check in
INSERT INTO "DEMOUSER"."work_time" ("staff_id", "check_in_time")
VALUES (1, (SELECT SYSTIMESTAMP FROM DUAL));

-- staff check in
INSERT INTO "DEMOUSER"."work_time" ("staff_id", "check_in_time")
VALUES (2, (SELECT SYSTIMESTAMP FROM DUAL));

-- staff check in
INSERT INTO "DEMOUSER"."work_time" ("staff_id", "check_in_time")
VALUES (3, (SELECT SYSTIMESTAMP FROM DUAL));

-- open receipt
INSERT INTO "DEMOUSER"."receipts" ("staff_id", "payment_id")
VALUES (1, 1);

-- open receipt
INSERT INTO "DEMOUSER"."receipts" ("staff_id", "payment_id")
VALUES (2, 2);

-- open receipt
INSERT INTO "DEMOUSER"."receipts" ("staff_id", "payment_id")
VALUES (1, 3);

-- staff check out
UPDATE "DEMOUSER"."work_time"
SET "check_out_time" = (SELECT SYSTIMESTAMP FROM DUAL)
WHERE "staff_id" = 1;

-- staff check out
UPDATE "DEMOUSER"."work_time"
SET "check_out_time" = (SELECT SYSTIMESTAMP FROM DUAL)
WHERE "staff_id" = 2;

-- staff check out
UPDATE "DEMOUSER"."work_time"
SET "check_out_time" = (SELECT SYSTIMESTAMP FROM DUAL)
WHERE "staff_id" = 3;

-- insert services provided 
INSERT INTO "DEMOUSER"."services" ("description", "customer_id", "payment_id")
VALUES ('change gear oil', 1, 1);

INSERT INTO "DEMOUSER"."services" ("description", "customer_id", "payment_id")
VALUES ('change engine oil', 2, 2);

/*
-- DELETE record
DELETE FROM "DEMOUSER"."positions"
WHERE "position_name"='Sales Assistant';
*/

SELECT "DEMOUSER"."suppliers.supplier_id", "suppliers.name", "suppliers.address"
FROM "suppliers"
INNER JOIN "DEMOUSER"."supplier_orders" ON "supplier_orders.supplier_id"="suppliers.supplier_id";




-- Queries that the company may perform (using SELECT keyword) --

SELECT s."supplier_id", s."name" AS "supplier_name", s."address" AS "supplier_address", sod."total_cost"
FROM "DEMOUSER"."suppliers" s
INNER JOIN "DEMOUSER"."supplier_orders" sod ON sod."supplier_id"= s."supplier_id";

SELECT COUNT("staff_id")
FROM "staffs";

SELECT MAX("unit_price") AS HighestPrice
FROM "products";

SELECT MIN("unit_price") AS LowestPrice
FROM "products";

SELECT sod."supplier_id", p."product_id", p."brand", p."model", p."colour" 
FROM "supplier_orders" sod
INNER JOIN "products" p ON sod."supplier_order_id" = p."supplier_order_id";

SELECT c."name" AS "customer_name", p."brand", p."model", p."colour" 
FROM "customer_orders" cod 
INNER JOIN "customers" c ON cod."customer_id" = c."customer_id"
INNER JOIN "products" p ON cod."customer_order_id" = p."customer_order_id";

/*
SELECT *
FROM "DEMOUSER"."products"
WHERE "customer_order_id" is not null;
*/

SELECT c."name" AS "customer_name", s."name" AS "staff_name" FROM "receipts" r
INNER JOIN "payment" p ON r."payment_id" = p."payment_id"
INNER JOIN "customer_orders" cod ON cod."payment_id" = r."payment_id"
INNER JOIN "customers" c ON c."customer_id" = cod."customer_id"
INNER JOIN "staffs" s ON r."staff_id" = s."staff_id";

SELECT r."receipt_id", s."name" AS "staff_name" FROM "receipts" r
INNER JOIN "staffs" s ON r."staff_id" = s."staff_id";

-------------------------------------------------------------------
-- FAIL EXAMPLE
-------------------------------------------------------------------

-- cannot add another product with same engine_no
INSERT INTO "DEMOUSER"."products" ("engine_no", "chassis_no", "brand", "model", "colour", "unit_cost", "unit_price", "supplier_order_id")
VALUES ('83901283018', '89423094820', 'YAMAHA', 'Y15ZR', 'GP BLUE', '7800', '11000', 1);

-- cannot insert a customer whose ic_no is previously in the record
INSERT INTO "DEMOUSER"."customers" ("name", "ic_no")
VALUES ('Ben', '870412030523');

--------------------------------------------------------------
-- Data Definition Language --
--------------------------------------------------------------

-- ALTER
ALTER TABLE "DEMOUSER"."customers"
ADD "email" varchar2(255);

ALTER TABLE "DEMOUSER"."customers"
DROP COLUMN "email";
/*
-- TRUNCATE 
TRUNCATE TABLE "DEMOUSER"."receipts";
*/
-- COMMENT

--SINGLE LINE COMMENT--
--Select all:
SELECT * FROM "DEMOUSER"."customers"-- WHERE "name"='Tee Fen';
--SELECT * FROM "DEMOUSER"."customers";

; 

--MULTI LINE COMMENT--
/*Select all the columns
of all the records
in the Customers table:*/
SELECT * FROM "DEMOUSER"."customers";

/*SELECT * FROM "DEMOUSER"."customers";
SELECT * FROM "DEMOUSER"."products";
SELECT * FROM "DEMOUSER"."staffs";*/
SELECT * FROM "DEMOUSER"."suppliers";

SELECT "name", /*"contact_no",*/ "address" FROM "DEMOUSER"."customers";

--RENAME
RENAME "work_time" TO "workTime";
RENAME "workTime" TO "work_time";
