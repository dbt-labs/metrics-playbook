with

goals as (

    select * from {{ref('goals__unioned')}}

),

all_days_base as (

    select * from {{ref('util_all_days')}}

),

all_days as (

    select
    
        date_day,
        date_trunc('month', date_day)::date as date_month,
        extract(day from (last_day(date_day))) as total_days_in_month

    from all_days_base

),

joined as (

    select
    
        goals.metric_name,
        all_days.date_day,
        all_days.total_days_in_month,
        goals.metric_value

    from all_days
    left join goals
        on all_days.date_month = goals.date_month::date

),

final as (

    select
    
        {{dbt_utils.surrogate_key([
          'metric_name',
          'date_day'
        ])}} as unique_id,
        metric_name,
        date_day,
        metric_value/total_days_in_month as metric_goal

    from joined

)

select * from final