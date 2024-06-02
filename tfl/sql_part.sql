-- таблица Группы --------------------------------
DROP TABLE IF EXISTS GROUPS CASCADE;

CREATE TABLE IF NOT EXISTS Groups (
    gr_id INT PRIMARY KEY,
    gr_name VARCHAR(255) NOT NULL
);
comment on table "groups"  is 'Группы товаров' ;
comment on column groups.gr_id is 'ID группы' ;
comment on column groups.gr_name is 'название группы';


-- таблица Продажи---------------------------------
DROP TABLE IF EXISTS Sales CASCADE;

CREATE TABLE Sales (
    an_id INT PRIMARY KEY,
    an_sku INT,
    an_name VARCHAR(255),
    an_cost DECIMAL(10, 2),
    an_amount DECIMAL(10, 2),
    an_group INT REFERENCES Groups (gr_id),
    CONSTRAINT positive_cost CHECK(an_cost >= 0),
    CONSTRAINT positive_amount CHECK(an_amount >= 0)
);
COMMENT ON TABLE Sales IS 'Продажи';
COMMENT ON COLUMN sales.an_id IS 'ID номер доставки';
COMMENT ON COLUMN sales.an_sku IS 'ID код товара';
COMMENT ON COLUMN sales.an_name IS 'название товара';
COMMENT ON COLUMN sales.an_cost IS 'себестоимость товара';
COMMENT ON COLUMN sales.an_amount IS 'розничная сумма товара';
COMMENT ON COLUMN sales.an_group IS 'ID группа товара';


-- таблица Заказы ------------------------------------------
DROP TABLE IF EXISTS Orders CASCADE;
CREATE TABLE Orders (
    ord_id INT NOT NULL,
    ord_datetime DATE DEFAULT current_date,
	ord_an INT REFERENCES Sales (an_id),
	PRIMARY KEY (ord_id, ord_an)
);
COMMENT ON TABLE Orders IS 'Заказы';
COMMENT ON COLUMN Orders.ord_id IS 'ID заказа';
COMMENT ON COLUMN Orders.ord_datetime IS 'дата и время заказа';
COMMENT ON COLUMN Orders.ord_an IS 'ID номер доставки';



-- insert Groups
INSERT INTO Groups VALUES (1, 'Пылесосы');
INSERT INTO Groups VALUES (2, 'Телевизоры');
INSERT INTO Groups VALUES (3, 'Компьютеры');
INSERT INTO Groups VALUES (4, 'Смартфоны');
INSERT INTO Groups VALUES (5, 'Пылесосы-PRO');
INSERT INTO Groups VALUES (6, 'пылесосы от tfl');
INSERT INTO Groups VALUES (7, 'пылесосы0001');
INSERT INTO Groups VALUES (8, '12_пылесосы');


-- insert Sales
INSERT INTO Sales VALUES (1, 1001, 'Пылесос A', 500.00, 1000.00, 1);
INSERT INTO Sales VALUES (2, 1002, 'Пылесос B', 600.00, 1200.00, 1);
INSERT INTO Sales VALUES (3, 1003, 'Телевизор C', 700.00, 1400.00, 2);
INSERT INTO Sales VALUES (4, 1004, 'Пылесос C', 800.00, 1600.00, 1);
INSERT INTO Sales VALUES (5, 1005, 'Телевизор D', 900.00, 1800.00, 2);
INSERT INTO Sales VALUES (6, 1006, 'Телевизор E', 1000.00, 2000.00, 2);
INSERT INTO Sales VALUES (7, 1007, 'Компьютер A', 1100.00, 2200.00, 3);
INSERT INTO Sales VALUES (8, 1008, 'Компьютер B', 1200.00, 2400.00, 3);
INSERT INTO Sales VALUES (9, 1009, 'Компьютер C', 1300.00, 2600.00, 3);
INSERT INTO Sales VALUES (10, 1010, 'Пылесос', 1800.00, 2300.00, 1);
INSERT INTO Sales VALUES (11, 1009, 'Компьютер C', 1300.00, 2600.00, 3);
INSERT INTO Sales VALUES (12, 1009, 'Компьютер C', 1300.00, 2600.00, 3);
INSERT INTO Sales VALUES (13, 1009, 'Компьютер C', 1300.00, 2600.00, 3);
INSERT INTO Sales VALUES (14, 1010, 'Пылесос', 1800.00, 2300.00, 5);
INSERT INTO Sales VALUES (15, 1010, 'Пылесос', 1800.00, 2300.00, 6);
INSERT INTO Sales VALUES (16, 1010, 'Пылесос', 1800.00, 2300.00, 7);
INSERT INTO Sales VALUES (17, 1009, 'Компьютер C', 1300.00, 2600.00, 3);
INSERT INTO Sales VALUES (18, 1010, 'Пылесос', 1800.00, 2300.00, 8);
INSERT INTO Sales VALUES (19, 1009, 'Компьютер C', 1300.00, 2600.00, 3);
INSERT INTO Sales VALUES (20, 1009, 'Компьютер C', 1300.00, 2600.00, 3);
INSERT INTO Sales VALUES (21, 1009, 'Компьютер C', 1300.00, 2600.00, 3);


-- insert Orders
INSERT INTO Orders VALUES (1, '2022-03-04 10:00:00', 1);
INSERT INTO Orders VALUES (1, '2024-03-21 10:00:00', 2);
INSERT INTO Orders VALUES (1, '2024-03-23 10:00:00', 20);
INSERT INTO Orders VALUES (1, '2024-03-06 10:00:00', 14);
INSERT INTO Orders VALUES (1, '2024-03-07 10:00:00', 15);
INSERT INTO Orders VALUES (1, '2024-03-09 10:00:00', 19);
INSERT INTO Orders VALUES (1, '2024-03-10 10:00:00', 21);
INSERT INTO Orders VALUES (2, '2021-03-05 11:00:00', 2);
INSERT INTO Orders VALUES (2, '2024-03-11 10:00:00', 1);
INSERT INTO Orders VALUES (3, '2024-03-14 10:00:00', 1);
INSERT INTO Orders VALUES (3, '2024-03-24 10:00:00', 2);
INSERT INTO Orders VALUES (3, '2019-03-06 12:00:00', 3);
INSERT INTO Orders VALUES (4, '2024-06-07 13:00:00', 4);
INSERT INTO Orders VALUES (4, '2024-03-16 10:00:00', 1);
INSERT INTO Orders VALUES (5, '2024-06-08 14:00:00', 5);
INSERT INTO Orders VALUES (5, '2024-03-15 10:00:00', 6);
INSERT INTO Orders VALUES (6, '2024-05-09 15:00:00', 6);
INSERT INTO Orders VALUES (7, '2024-05-10 16:00:00', 7);
INSERT INTO Orders VALUES (8, '2024-03-10 17:00:00', 8);
INSERT INTO Orders VALUES (9, '2024-03-12 18:00:00', 9);
INSERT INTO Orders VALUES (11, '2024-03-04 10:00:00', 1);
INSERT INTO Orders VALUES (11, '2024-03-04 11:00:00', 2);
INSERT INTO Orders VALUES (11, '2024-03-04 11:00:00', 3);
INSERT INTO Orders VALUES (13, '2024-03-04 11:00:00', 12);


--Задача 1. 
--Вывести номера заказов, где в группах товаров встречается слово “пылесос”.
SELECT DISTINCT ord_id
FROM orders o LEFT JOIN sales s ON o.ord_an = s.an_id LEFT JOIN "groups" g ON g.gr_id = s.an_group
WHERE gr_name ILIKE '%пылесос%';



--Задача 2. 
--Вывести даты заказов, название товаров и сумму для всех заказов, которые продавались 04 марта 2024 и всю следующую неделю.
WITH tt AS (SELECT ord_id, max(ord_datetime) AS final_date, string_agg(an_name, ', ' ORDER BY an_name) AS items, sum(an_amount) AS total_sum
			FROM orders o LEFT JOIN sales s ON o.ord_an = s.an_id
			GROUP BY ord_id
			HAVING max(ord_datetime) between '2024-03-04'::timestamp AND '2024-03-04'::timestamp + INTERVAL '6 days')
SELECT final_date, string_agg(items, ', ' ORDER BY items) AS items, sum(total_sum) AS final_amount
FROM tt
GROUP BY final_date;

--Задача 3. 
--Какой год был самый прибыльный по продажам?
SELECT extract(YEAR FROM ord_datetime) AS year
FROM orders o LEFT JOIN sales s ON o.ord_an = s.an_id
GROUP BY extract(YEAR FROM ord_datetime)
ORDER BY sum(an_amount) DESC
LIMIT 1;


--Задача 4. 
--Найдите второй по розничной сумме заказ.
WITH tt AS (SELECT *, DENSE_RANK() OVER (ORDER BY total_amount DESC) AS rg
			FROM (SELECT ord_id, sum(an_amount) AS total_amount
				  FROM orders o LEFT JOIN sales s ON o.ord_an = s.an_id
				  GROUP BY ord_id) AS query)
SELECT ord_id 
FROM tt 
WHERE rg = 2;


/* Задача 5.
Напишите запрос, который добавляет столбец с позицией каждого заказа на основе общей суммы заказа,
где заказ с самой высокой суммой получает позицию 1. Мы бы ожидали таблицу в таком виде:
Номер заказа | Сумма заказа |	Номер позиции */

SELECT *, DENSE_RANK() OVER (ORDER BY total_amount DESC) AS rg
FROM (SELECT ord_id, sum(an_amount) AS total_amount
	  FROM orders o LEFT JOIN sales s ON o.ord_an = s.an_id
	  GROUP BY ord_id) AS query;