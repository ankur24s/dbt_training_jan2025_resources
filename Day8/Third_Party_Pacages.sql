--updated versions of packages


DBT utils and third-party packages get updated rapidly. 
Please make sure that you install the latest version of dbt-utils. 
You can see the latest tested dbt-utils version on dbt GitHub page. 

url - hub.getdbt.com


create a file in project folder - packages.yml


fct_reviews.yml

{{
    config(
    materialized = 'incremental',
    unique_key = ['listing_id','reviewer_name'],
    merge_update_columns = ['review_text','REVIEW_DATE']
    )
}}
SELECT 
{{ dbt_utils.generate_surrogate_key(['listing_id','review_date', 'reviewer_name', 'review_text','review_sentiment']) }}
as review_id,
* FROM {{ ref('src_reviews') }}
WHERE review_text is not null
{% if is_incremental() %}
and review_date > (select max(review_date) from {{this}})
{% endif %}



try changing the confi of incremental load now:



add - on_schema_change='fail'
--------------------

