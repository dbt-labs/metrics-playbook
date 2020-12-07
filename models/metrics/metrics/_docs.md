{% docs metrics %}

## Metrics
The metrics table consists of exclusively summed metrics where departments can seamlessly add their own KPI goals and coordinating metrics. The final output will allow the end user to compare their metrics to corresponding goals and execute MoM/YoY comparisons in Looker.

### How to Add a Metric
- Create a model under the `base_metrics` directory, ensuring that it fits the standard naming convention: `metric__<metric_name>`.
- This model's query only needs two fields: `date_day` and `metric_value`.
- The last CTE should be named `metric_final` because that is what the `format_metric()` macro references
- Input the fields inside the `format_metric()` macro, where the first input is the name of the metric (a string value), the date field, and the metric value field.
- Add the defined metric model to the `metric__unioned` model

Note: Please look at existing defined metrics as examples. 

{% enddocs %}