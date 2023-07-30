with source as (

    select * from {{ source('bingeflix', 'subscription_plans') }}

),

renamed as (

    select
        subscription_plan_id,
        plan_name as subscription_name,
        TO_NUMBER(pricing, 6, 2) as subscription_price,
        payment_period as billing_period

    from source

)

select * from renamed
