{%- set metrics = [
    'metric__new_revenue'
    ]
-%}

{%- for metric in metrics -%}

select * from {{ ref(metric) }}
{% if not loop.last %} union all {% endif %}

{%- endfor -%}