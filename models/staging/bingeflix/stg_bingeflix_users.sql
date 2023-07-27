with

source as (
    select
        user_id,
        created_at as user_created_at,
        phone_number,
        deleted_at as user_deleted_at,
        username as user_name,
        name as full_name,
        sex,
        email,
        birthdate,
        region,
        country
    from {{ source('bingeflix', 'users') }}
)

select * from source
