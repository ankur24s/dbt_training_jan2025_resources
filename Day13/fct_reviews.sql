{{
    config(
    materialized = 'incremental',on_schema_change='fail',
    unique_key = ['listing_id','reviewer_name'],
    merge_update_columns = ['review_text','REVIEW_DATE']
    )
}}
SELECT 
{{dbt_utils.generate_surrogate_key(['listing_id','review_date', 'reviewer_name', 'review_text','review_sentiment'])}} as review_id,
* FROM {{ ref('src_reviews') }}
WHERE review_text is not null
{% if is_incremental() %}
and review_date > (select max(review_date) from {{this}})
{% endif %}

