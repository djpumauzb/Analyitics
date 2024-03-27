-- Задача 1: Функция преобразования секунд 


-- (PostgreSQL):
CREATE OR REPLACE FUNCTION format_seconds(total_seconds INT)
RETURNS TEXT AS $$
DECLARE
    days INT;
    hours INT;
    minutes INT;
    seconds INT;
BEGIN
    days := total_seconds / 86400;
    hours := (total_seconds % 86400) / 3600;
    minutes := (total_seconds % 3600) / 60;
    seconds := total_seconds % 60;

    RETURN days || ' days ' || hours || ' hours ' || minutes || ' minutes ' || seconds || ' seconds';
END;
$$ LANGUAGE plpgsql;


-- (MySQL):
DELIMITER //

CREATE FUNCTION format_seconds(total_seconds INT)
RETURNS VARCHAR(100)
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE seconds INT;
    SET days = total_seconds DIV 86400;
    SET hours = (total_seconds MOD 86400) DIV 3600;
    SET minutes = (total_seconds MOD 3600) DIV 60;
    SET seconds = total_seconds MOD 60;

    RETURN CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
END //

DELIMITER ;

/* --------------------------  */


-- Задача 2: Вывод четных чисел от 1 до 10 


-- (PostgreSQL):
SELECT num
FROM generate_series(1, 10) AS num
WHERE num % 2 = 0;


-- (MySQL):
SELECT 2 AS even_number UNION
SELECT 4 UNION
SELECT 6 UNION
SELECT 8 UNION
SELECT 10;