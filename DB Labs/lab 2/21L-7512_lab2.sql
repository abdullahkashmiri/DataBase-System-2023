
SELECT * FROM production.brands;

SET IDENTITY_INSERT production.brands ON;

INSERT INTO production.brands (brand_id,brand_name)
VALUES (10,'Engine');


DELETE FROM production.brands WHERE brand_id = 1;

UPDATE production.brands
SET  brand_name = 'Guccii'
WHERE brand_id = 5 ;