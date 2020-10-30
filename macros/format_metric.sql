{% macro format_metric(metric_name, date_field, metric_value) %}

select
    '{{metric_name}}' as metric_name,
    {{date_field}} as date_day,
    {{metric_value}} as metric_value

from metric_source

{% endmacro %}