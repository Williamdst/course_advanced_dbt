{% set import_mrr = unit_testing_select_table(ref('fct_mrr'), ref('uit_agg_mrr_input')) %}

WITH mrr_table AS (

    SELECT * FROM {{ import_mrr }}
)

SELECT
    date_month,
    SUM(mrr_amount) AS mrr_amount
FROM mrr_table
GROUP BY date_month
