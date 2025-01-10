{{
  config(
    materialized = 'incremental',
    unique_key = ['listing_id','reviewer_name'],
    cluster_by = ['review_date'],  
    incremental_strategy = 'merge',
    incremental_predicates = [
      "DBT_INTERNAL_DEST.review_date > dateadd(year, -5, current_date)"
      ]
  )
}}
SELECT * FROM {{ ref('src_reviews') }}
WHERE review_text is not null
{% if is_incremental() %}
and review_date > (select max(review_date) from {{this}})
{% endif %}
