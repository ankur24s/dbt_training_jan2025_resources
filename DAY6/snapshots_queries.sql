Snapshots


SNAPSHOTS FOR LISTING
The contents of snapshots/listings_snapshot.sql :
{% snapshot listings_snapshot %}

{{
    config(
        target_database = 'INT',
        unique_key='id',
        target_schema = 'SNAPSHOT',
        strategy = 'timestamp',
        updated_at = 'updated_at',
       invalidate_hard_deletes=True
    )
}}

    SELECT 
    id , 
    name , 
    listing_url, 
    room_type, 
    minimum_nights,
    host_id,
    price,
    created_at,
    updated_at
    FROM
    {{source('raw_airbnb','listings')}}

{% endsnapshot %}

---------------------------------------------------------------------
The contents of snapshots/hosts_snapshot.sql :
{{
 config(
 target_schema='DEV',
 unique_key='id',
 strategy='timestamp',
 updated_at='updated_at',
 invalidate_hard_deletes=True
 )
}}
select * FROM {{ source('raw_airbnb', 'hosts') }}
{% endsnapshot %}


-----------------------------------------------------------