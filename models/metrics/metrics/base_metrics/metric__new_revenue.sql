with

metric_source as (

    select * from {{ref('fct_orders')}}

),

metric_agg as (

    select
    
        order_date,
        sum(amount) as total_order_revenue

    from metric_source
    group by 1

),

metric_lagged as (

    select
    
        *,
        
        lag(total_order_revenue) over (
            order by order_date
        ) as prev_total_order_revenue

    from metric_agg

),

metric_final as (

    select
    
        order_date,
        
        total_order_revenue - coalesce(prev_total_order_revenue,0) 
        as total_new_revenue

    from metric_lagged

)

{{ format_metric('New Order Revenue', 'order_date', 'total_new_revenue') }}