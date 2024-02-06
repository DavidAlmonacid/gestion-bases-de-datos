CREATE FUNCTION total_price_for_client(p_dni_cliente VARCHAR(12))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total_price INT;
    SELECT SUM(precio) INTO total_price FROM productos WHERE dni_cliente = p_dni_cliente;
    RETURN total_price;
END;

SELECT total_price_for_client('12345678');


CREATE FUNCTION product_count_for_client(p_dni_cliente VARCHAR(12))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE product_count INT;
    SELECT COUNT(*) INTO product_count FROM productos WHERE dni_cliente = p_dni_cliente;
    RETURN product_count;
END;

SELECT product_count_for_client('12345678');
