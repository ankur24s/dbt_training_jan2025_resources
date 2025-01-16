POST-HOOK
Add this to your dbt_project.yml :
+post-hook:
 - "GRANT SELECT ON {{ this }} TO ROLE REPORTER_AIRBNB"