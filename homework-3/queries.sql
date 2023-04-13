-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select customers.company_name, CONCAT(first_name, ' ', last_name) as full_name
from employees, customers
join orders on ship_via = 2
where employees.city = 'London' and customers.city = 'London'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select
	p.product_name,
	p.units_in_stock,
	p.supplier_id,
	s.contact_name,
	s.phone,
	p.category_id,
	c.category_name
from products p
join suppliers s on p.supplier_id = s.supplier_id
join categories c on p.category_id = c.category_id and c.category_name in ('Dairy Products', 'Condiments')
where p.discontinued = 0 and p.units_in_stock < 25
order by p.units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name
from customers
where exists (select * from orders where customer_id <> customers.customer_id)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select distinct product_name
from products
where exists (select quantity from order_details where quantity = 10)