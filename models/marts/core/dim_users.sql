WITH

users AS (
    SELECT
        *
    FROM
        {{ ref('stg_bingeflix_users') }}
),

users_subscription_facts AS (
    SELECT
        user_id,
        MIN(subscription_starts_at) AS first_subscription_starts_at,
        COUNT(DISTINCT subscription_id) AS count_of_subscriptions
    FROM
        {{ ref('stg_bingeflix_subscriptions') }}
    GROUP BY user_id
),

final AS (
    SELECT
        u.user_id,
        u.user_created_at,
        u.phone_number,
        u.user_deleted_at,
        u.user_name,
        u.full_name,
        u.sex,
        u.email,
        u.birthdate,
        TRUNCATE(DATEDIFF(MONTH, u.birthdate, CURRENT_DATE)/12) AS current_age,
        TRUNCATE(DATEDIFF(MONTH, u.birthdate, u.user_created_at)/12) AS age_at_acquisition,
        u.region,
        u.country,
        usf.first_subscription_starts_at,
        usf.count_of_subscriptions
    FROM
        users AS u
        LEFT JOIN users_subscription_facts AS usf ON u.user_id = usf.user_id
)

SELECT * FROM final
