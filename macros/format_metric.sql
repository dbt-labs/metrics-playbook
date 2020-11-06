{% macro format_metric(metric_name, date_field, metric_value) %}

select

    -- This unique key is generated for your metric/date combo.
    {{ dbt_utils.surrogate_key([
        "'" ~ metric_name ~ "'",
        date_field
    ]) }} as unique_id,
    
    -- Standardize the column names of the metric model before
    -- moving to the metrics__unioned model.
    '{{ metric_name }}' as metric_name,
    {{ date_field }} as date_day,
    {{ metric_value }} as metric_value

from metric_final

{% endmacro %}