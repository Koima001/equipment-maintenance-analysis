--SQL_DATA_CLEANING.
 --Data_preview.

SELECT work_order_id, equipment_id, opened_date, closed_date, site_id, work_type, priority, failure_mode, technician_id, labor_hours, parts_cost_kes, labor_cost_kes, downtime_hours, status
FROM practice.sql_equipment_maintenance_work_orders
limit 10;

	--Blanks_and_duplicates_assesment
	SELECT
    'Blank Closed Date' AS Assessment,
    COUNT(*) AS Number_of_Records
FROM practice.sql_equipment_maintenance_work_orders
WHERE closed_date IS NULL OR closed_date = ''
UNION ALL
SELECT
    'Blank Technician ID' AS Assessment,
    COUNT(*) AS Number_of_Records
FROM practice.sql_equipment_maintenance_work_orders
WHERE technician_id IS NULL OR technician_id = ''
UNION ALL
SELECT
    'Duplicate Records' AS Assessment,
    COUNT(*) AS Number_of_Records
FROM (
    SELECT
        ROW_NUMBER() OVER (
            PARTITION BY
                work_order_id, equipment_id, opened_date,
                closed_date, site_id, work_type, priority,
                failure_mode, technician_id, labor_hours,
                parts_cost_kes, labor_cost_kes, downtime_hours, status
        ) AS row_num
    FROM practice.sql_equipment_maintenance_work_orders
) AS duplicates
WHERE row_num > 1;

	--setting_blanks_to_null
update practice.sql_equipment_maintenance_work_orders
set closed_date = NULL
where closed_date = "";

update practice.sql_equipment_maintenance_work_orders
set technician_id = NULL
where technician_id = "";

	--Identifying_duplicates
create table practice.sql_equipment_maintenance_work_orders_clean as
select work_order_id, equipment_id, opened_date, closed_date, site_id, work_type, priority, failure_mode, technician_id, labor_hours, parts_cost_kes, labor_cost_kes, downtime_hours, status,
row_number() over (partition by work_order_id, equipment_id, opened_date, closed_date, site_id, work_type, priority, failure_mode, technician_id, labor_hours, parts_cost_kes, labor_cost_kes, downtime_hours, status)
as row_num
from practice.sql_equipment_maintenance_work_orders;

	--Deleting_duplicates
delete 
from practice.sql_equipment_maintenance_work_orders_clean
where row_num > 1;



	--Eliminating_helper_column
alter table  practice.sql_equipment_maintenance_work_orders_clean
drop column row_num;

	--Viewing_clean_table
select *
 from practice.sql_equipment_maintenance_work_orders_clean;
	

	--Formatting_decimal_place_and_adding_total_column	
alter table practice.sql_equipment_maintenance_work_orders_clean
add column Total DECIMAL(20,2);

update practice.sql_equipment_maintenance_work_orders_clean
set parts_cost_kes = round(parts_cost_kes,2),
    labor_cost_kes = round(labor_cost_kes,2);

update practice.sql_equipment_maintenance_work_orders_clean
set Total = round(labor_cost_kes + parts_cost_kes, 2)


	--Exploratory_data_analysis
select  work_type,  max(parts_cost_kes ), max(labor_cost_kes ), max(Total) 
from practice.sql_equipment_maintenance_work_orders_clean
group by 1

select  site_id ,  max(parts_cost_kes ), max(labor_cost_kes ) 
from practice.sql_equipment_maintenance_work_orders_clean
group by 1
order by max(parts_cost_kes) desc

select work_type,  sum(parts_cost_kes)parts_cost, sum(labor_cost_kes)labor_cost 
from practice.sql_equipment_maintenance_work_orders_clean 
group by work_type
order by parts_cost 

select priority, sum(parts_cost_kes)parts_cost, sum(labor_cost_kes)labor_cost 
from practice.sql_equipment_maintenance_work_orders_clean 
group by  priority
order by parts_cost

select site_id, sum(parts_cost_kes)parts_cost, sum(labor_cost_kes)labor_cost 
from practice.sql_equipment_maintenance_work_orders_clean 
group by  site_id 
order by site_id 

select failure_mode,  round(sum(parts_cost_kes),2)parts_cost, round(sum(labor_cost_kes), 2)labor_cost 
from practice.sql_equipment_maintenance_work_orders_clean 
group by failure_mode
order by parts_cost

select site_id, work_type, priority, failure_mode, sum(parts_cost_kes)parts_cost, sum(labor_cost_kes)labor_cost 
from practice.sql_equipment_maintenance_work_orders_clean
group by site_id, work_type, priority, failure_mode
having sum(parts_cost_kes) !=  NULL
order by parts_cost 

with costs as 
	(select work_type, sum(parts_cost_kes)parts_cost, sum(labor_cost_kes)labor_cost, sum(Total) Total 
from practice.sql_equipment_maintenance_work_orders_clean
group by  work_type
order by parts_cost) 
select work_type, max(parts_cost), min(parts_cost), min(labor_cost), max(labor_cost), max(Total)
from costs
group by 1

