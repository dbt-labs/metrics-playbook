{{ config(materialized='table') }}

{{ dbt_utils.date_spine(
  datepart="day",
  start_date="to_date('01/01/2016', 'mm/dd/yyyy')",
  end_date="dateadd(year, 1, current_date)"
 )
}}