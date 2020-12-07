{% docs goals %}

## Goals
This table is built off of monthly KPI goals which are spread across on a daily-level.

### How to Add a KPI Goal
Note: Before you add a KPI goal, we recommend reading and completing the Metrics process first. Please refer to the `metrics` model documentation if you haven't already.

To add a KPI goal, you will need to do the following:
- Create a CSV of the monthly goals for a single KPI. Alternatively, you may also create an excel sheet and export it as a CSV.
- The table must have three fields: `date_month`, `metric_value`, `metric_name`.
- The `goals.metric_name` should be the same as `metrics.metric_name`. This is important because this field is used to join the KPI goal to its associated metric.
- Ensure that the file name follows the standardized naming convention: `metric_goals__<metric_name>`. Note that it should follow the same model naming as its associated `metric__<metric_name>` model located in the `models/marts/metrics/base_metrics` folder.
- Move the file into the project's `data` folder.
- run `dbt seed`
- Add the `metric_goals__<metric_name>` model to the `goals__unioned` list.

Tips:
- We recommend looking at the existing goals to use as an example for what the final output should look like.

{% enddocs %}