CREATE TABLE MY_INVENTORY (
    SKU VARCHAR
    ,PRICE NUMBER
);

EXECUTE IMMEDIATE FROM 'scripts/02_execute_immediate/insert_inventory.sql';


SELECT
    SKU
    ,PRICE 
FROM MY_INVENTORY
ORDER BY PRICE DESC;

--DROP TABLE MY_INVENTORY;