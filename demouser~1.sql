SELECT s."supplier_id", s."name", s."address", sod."total_cost"
FROM "DEMOUSER"."suppliers" s
INNER JOIN "DEMOUSER"."supplier_orders" sod ON sod."supplier_id"= s."supplier_id";

SELECT COUNT("staff_id")
FROM "staffs";

SELECT MAX("unit_price") AS HighestPrice
FROM "products";

SELECT MIN("unit_price") AS LowestPrice
FROM "products";

SELECT sod."supplier_id", p."product_id",p."model",p."brand",p."colour" 
FROM "supplier_orders" sod
INNER JOIN "products" p
ON sod."supplier_id" = p."supplier_id";