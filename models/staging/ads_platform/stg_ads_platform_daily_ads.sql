WITH source AS (

    SELECT * FROM {{ source('ads_platform', 'daily_ads') }}

),

renamed AS (

    SELECT
        date,
        campaign_id,
        {{ dbt_utils.generate_surrogate_key(['date', 'campaign_id']) }} AS surrogate_key,
        spend as campaign_spend,
        cpm as cost_per_thousand_impressions,
        ctr as campaign_click_through_rate

    FROM source

)

SELECT * FROM renamed
