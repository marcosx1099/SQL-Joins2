use hr;

-- task 1 The company wants to promote a hybrid work culture and reduce the operation cost and occupancy of its offices across different cities. 
-- Identify the top five cities that have the maximum number of employees #by max do you mean most?
select locations.city, count(employees.employee_id)
from employees
join departments on departments.department_id = employees.department_id
join locations on locations.location_id = departments.location_id
group by 1
order by 2 desc
limit 5;

-- task2 List the first names, last names, countries, cities, departments, and salaries of the employees from the top five cities identified in Task 1

select 
employees.first_name, 
employees.last_name,
locations.city, 
countries.country_name,
departments.department_name,
employees.salary
from employees
join departments on departments.department_id = employees.department_id
join locations on locations.location_id = departments.location_id
join countries on countries.country_id = locations.country_id
where not (locations.city = "Munich") and 
not (locations.city = "London")
order by locations.city;

-- task 3 List the cities in which the number of employees is less than 10
select 
locations.city,
count(*) as num
from employees
join departments on departments.department_id = employees.department_id
join locations on locations.location_id = departments.location_id
group by 1
having num  < 10;




-- Task 4
-- Find the average experience in years of each city identified in task 3
SELECT l.city, AVG(DATEDIFF(NOW(), e.hire_date) / 365) AS avg_experience
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city IN (
  SELECT l.city
  FROM employees e
  JOIN departments d ON e.department_id = d.department_id
  JOIN locations l ON d.location_id = l.location_id
  GROUP BY l.city
  HAVING COUNT(*) >= 10
)
GROUP BY l.city
ORDER BY l.city;

select *
from employees;


/*
select
locations.city,
round(avg(YEAR(curdate())- year(job_history.start_date)),2) as total_experience_years
from employees
left join departments on employees.department_id = departments.department_id
left join job_history on employees.employee_id = job_history.employee_id
left join locations on locations.location_id = departments.location_id
where locations.city = 'Munich' or locations.city = 'Southlake' or locations.city = 'London'or locations.city = 'Toronto'
group by 1;
*/

-- task5 
/* The company wants to communicate the work from home policy to those employees who are from the cities identified in Task 1 and have also completed
10 years in the organization.
Find the below-mentioned details of such employees:
First name
Last name
Email
Phone number
*/
select 
employees.first_name, 
employees.last_name,
employees.email,
employees.phone_number,
YEAR(curdate())- year(job_history.start_date) as total_experience_years
from employees
left join departments on departments.department_id = employees.department_id
left join job_history on employees.employee_id = job_history.employee_id
left join locations on locations.location_id = departments.location_id
where not (locations.city = "Munich") and 
not (locations.city = "London");

-- task6 List the IDs of the managers of the employees identified in Task 5.
select 
employees.manager_id,
employees.first_name, 
employees.last_name,
employees.email,
employees.phone_number,
YEAR(curdate())- year(job_history.start_date) as total_experience_years
from employees
left join departments on departments.department_id = employees.department_id
left join job_history on employees.employee_id = job_history.employee_id
left join locations on locations.location_id = departments.location_id
where not (locations.city = "Munich") and 
not (locations.city = "London");

