with

all_days as (

    select * from {{ ref('util_all_days') }}

),

unioned_metrics as (

    select * from {{ ref('metrics__unioned') }}

),

metric_names as (

    select distinct
    
        metric_name

    from unioned_metrics

),

filled as (

    select * from all_days
    cross join metric_names

),

joined as (

    select
    
        {{ dbt_utils.surrogate_key([
            'filled.metric_name',
            'filled.date_day'
        ]) }} as unique_id,
        filled.metric_name,
        filled.date_day,

        case
            when filled.date_day < current_date
                then coalesce(metric_value, 0)
            else null
        end as metric_value

    from filled
    left join unioned_metrics
      on filled.metric_name = unioned_metrics.metric_name
      and filled.date_day = unioned_metrics.date_day

)

select * from joined