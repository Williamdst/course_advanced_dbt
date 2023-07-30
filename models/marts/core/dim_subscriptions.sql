WITH

final AS (
    SELECT
        s.subscription_id,
        s.subscription_plan_id,
        s.user_id,
        s.subscription_starts_at,
        s.subscription_ends_at,
        sp.subscription_name,
        sp.subscription_price,
        sp.billing_period
    FROM
        {{ ref('stg_bingeflix_subscriptions') }} AS s
        LEFT JOIN {{ ref('stg_bingeflix_subscription_plans') }} AS sp
            ON s.subscription_plan_id = sp.subscription_plan_id
)

SELECT * FROM final
