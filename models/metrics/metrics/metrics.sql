{{ config(materialized = 'table') }}

with

metrics as (

    select * from {{ ref('metrics__calculated') }}

),

goals as (

    select * from {{ ref('goals') }}

),

joined as (

    select
    
        metrics.*,
        goals.metric_goal

    from metrics
    left join goals
      on metrics.date_day = goals.date_day
      and metrics.metric_name = goals.metric_name

)

select * from joined