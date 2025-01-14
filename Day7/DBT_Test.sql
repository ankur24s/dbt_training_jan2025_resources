-- https://docs.getdbt.com/docs/build/data-tests


select * from  int.airbnb.dim_listings


select distinct room_type from  int.airbnb.dim_listings
/*
['Entire home/apt',
'Private room',
'Shared room',
'Entire Home',
'Hotel room']
*/

-- source.yml
version: 2

models:
  - name: dim_listings
    columns:
      
      - name: listing_id
        tests:
          - unique
          - not_null

      - name: host_id
        tests:
          - not_null
          - relationships:
              to: ref('dim_hosts')
              field: host_id

      
      - name: room_type
        tests:
          - accepted_values:
              values: ['Entire home/apt',
                      'Private room',
                      'Shared room',
                      'Entire Home',
                      'Hotel room']
					  
					  
					  
-- Generic tests
-- create a test in test>dim_listings_minimum_nights.SQL
select * from 
{{ref('dim_listings')}}
where minimum_nights <1
limit 10


--Assignment instructions

-- Create a singular test in tests/consistent_created_at.sql that checks that there is no review date that is submitted before its listing was created: Make sure that every review_date in fct_reviews is more recent than the associated created_at in dim_listings_cleansed.


--Please provide the source code of the test.

