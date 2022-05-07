CREATE TABLE "suppliers"
(
    "supplier_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "name" VARCHAR2(80) NOT NULL,
    "address" VARCHAR2(80) NULL,
    "pic_name" VARCHAR2(100) NULL,
    "pic_contact_no" VARCHAR2(50) NULL,
    CONSTRAINT "suppliers_pk" 
        PRIMARY KEY ("supplier_id")
);

CREATE TABLE "customers"
(
    "customer_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "name" VARCHAR2(100) NOT NULL,
    "ic_no" VARCHAR2(20) NULL UNIQUE,
    "contact_no" VARCHAR2(20) NULL,
    "address" VARCHAR2(200) NULL,
    CONSTRAINT "customers_pk" 
        PRIMARY KEY ("customer_id")
);

CREATE TABLE "payment"
(
    "payment_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "amount" NUMBER(10,2) NOT NULL,
    "timestamp" TIMESTAMP NOT NULL,
    CONSTRAINT "payment_pk"
        PRIMARY KEY ("payment_id")
);

CREATE TABLE "installments"
(
    "agreement_no" VARCHAR2(50),
    "down_payment_amount" NUMBER(10,2) NOT NULL,
    "monthly_installment_amount" NUMBER(10,2) NOT NULL,
    "installment_period" NUMBER(5,0),
    CONSTRAINT "installments_pk"
        PRIMARY KEY ("agreement_no")
);

CREATE TABLE "staffs"
(
    "staff_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "name" VARCHAR2(100) NOT NULL,
    "ic_no" VARCHAR2(20) NOT NULL,
    "contact_no" VARCHAR2(20) NOT NULL,
    "address" VARCHAR2(200) NOT NULL,
    CONSTRAINT "staffs_pk"
        PRIMARY KEY ("staff_id")
);

CREATE TABLE "work_time"
(
    "staff_id" NUMBER NOT NULL,
    "check_in_time" TIMESTAMP NOT NULL,
    "check_out_time" TIMESTAMP NULL,
    CONSTRAINT "work_time_pk"
        PRIMARY KEY ("staff_id"),
    CONSTRAINT "work_time_fk"
        FOREIGN KEY ("staff_id")
        REFERENCES "staffs" ("staff_id")
);

CREATE TABLE "positions"
(
    "position_name" VARCHAR2(50),
    "staff_id" NUMBER NULL,
    "base_salary" NUMBER(10,2) NOT NULL,
    "overtime_rate" NUMBER(10,2) NULL,
    CONSTRAINT "positions_pk"
        PRIMARY KEY ("position_name"),
    CONSTRAINT "positions_fk"
        FOREIGN KEY ("staff_id")
        REFERENCES "staffs" ("staff_id")
);

CREATE TABLE "receipts"
(
    "receipt_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "payment_id" NUMBER NOT NULL,
    "staff_id" NUMBER NOT NULL,
    CONSTRAINT "receipts_pk"
        PRIMARY KEY ("receipt_id"),
    CONSTRAINT "receipts_fk1"
        FOREIGN KEY ("payment_id")
        REFERENCES "payment" ("payment_id"),
    CONSTRAINT "receipts_fk2"
        FOREIGN KEY ("staff_id")
        REFERENCES "staffs" ("staff_id")
);

CREATE TABLE "services"
(
    "service_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "description" VARCHAR2(200) NOT NULL,
    "customer_id" NUMBER NOT NULL,
    "payment_id" NUMBER NOT NULL,
    CONSTRAINT "services_pk"
        PRIMARY KEY ("service_id"),
    CONSTRAINT "services_fk1"
        FOREIGN KEY ("customer_id")
        REFERENCES "customers" ("customer_id"),
    CONSTRAINT "services_fk2"
        FOREIGN KEY ("payment_id")
        REFERENCES "payment" ("payment_id")
);

CREATE TABLE "supplier_orders"
(
    "supplier_order_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "supplier_id" NUMBER NOT NULL,
    "total_cost" NUMBER(10,2) NULL,
    CONSTRAINT "supplier_orders_pk"
        PRIMARY KEY ("supplier_order_id"),
    CONSTRAINT "supplier_order_fk"
        FOREIGN KEY ("supplier_id")
        REFERENCES "suppliers" ("supplier_id")
);

CREATE TABLE "customer_orders"
(
    "customer_order_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "customer_id" NUMBER NOT NULL,
    "product_id" NUMBER NOT NULL,
    "total_price" NUMBER NULL,
    "date" DATE NOT NULL,
    "agreement_no" VARCHAR2(50) NULL,
    "payment_id" NUMBER NULL,
    CONSTRAINT "customer_orders_pk"
        PRIMARY KEY ("customer_order_id"),
    CONSTRAINT "customer_orders_fk1"
        FOREIGN KEY ("customer_id")
        REFERENCES "customers" ("customer_id"),
    CONSTRAINT "customer_orders_fk2"
        FOREIGN KEY ("agreement_no")
        REFERENCES "installments" ("agreement_no"),
    CONSTRAINT "customer_orders_fk3"
        FOREIGN KEY ("payment_id")
        REFERENCES "payment" ("payment_id")
);

CREATE TABLE "products"
(
    "product_id" NUMBER GENERATED ALWAYS AS IDENTITY,
    "engine_no" VARCHAR2(50) NOT NULL UNIQUE,
    "chassis_no" VARCHAR2(50) NOT NULL UNIQUE,
    "brand" VARCHAR2(50) NOT NULL,
    "model" VARCHAR2(50) NOT NULL UNIQUE,
    "colour" VARCHAR2(50) NULL,
    "unit_cost" NUMBER(10,2) NOT NULL,
    "unit_price" NUMBER(10,2) NOT NULL,
    "supplier_order_id" NUMBER NOT NULL,
    "customer_order_id" NUMBER NULL,
    CONSTRAINT "products_pk"
        PRIMARY KEY ("product_id"),
    CONSTRAINT "products_fk1"
        FOREIGN KEY ("supplier_order_id")
        REFERENCES "supplier_orders" ("supplier_order_id"),
    CONSTRAINT "products_fk2"
        FOREIGN KEY ("customer_order_id")
        REFERENCES "customer_orders" ("customer_order_id")
);

