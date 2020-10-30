with

raw_source as (

    select * from {{ref('fct_orders')}}

),

metric_agg as (

    select
        date(order_date) as date_day,
        sum(amount) as total_order_revenue

    from raw_source
    group by 1

),

metric_lagged as (

    select
        *,
        lag(total_order_revenue) over (
            order by date_day
        ) as prev_total_order_revenue

    from metric_agg

),

metric_source as (

    select
        date_day,
        
        (
            total_order_revenue - coalesce(prev_total_order_revenue,0)
        ) as total_new_revenue

    from metric_lagged

)

{{ format_metric('New Order Revenue', 'date_day', 'total_new_revenue') }}