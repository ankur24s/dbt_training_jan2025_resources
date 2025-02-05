USE ROLE ACCOUNTADMIN;

CREATE ROLE IF NOT EXISTS REPORTER_AIRBNB;

CREATE USER IF NOT EXISTS PRESET
 PASSWORD='presetPassword123'
 LOGIN_NAME='preset'
 MUST_CHANGE_PASSWORD=FALSE
 DEFAULT_WAREHOUSE='COMPUTE_WH'
 DEFAULT_ROLE='REPORTER_AIRBNB'
 DEFAULT_NAMESPACE='DWH.AIRBNB'
 COMMENT='Preset user for creating reports';
GRANT ROLE REPORTER_AIRBNB TO USER preset;
GRANT ROLE REPORTER_AIRBNB TO ROLE ACCOUNTADMIN;
GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE REPORTER_AIRBNB;
GRANT USAGE ON DATABASE DWH TO ROLE REPORTER_AIRBNB;
GRANT USAGE ON SCHEMA DWH.AIRBNB TO ROLE REPORTER_AIRBNB;
-- We don't want to grant select rights here; we'll do this through 
-- GRANT SELECT ON ALL TABLES IN SCHEMA DWH.AIRBNB TO ROLE REPORTER_AIRBNB;
-- GRANT SELECT ON ALL VIEWS IN SCHEMA DWH.AIRBNB  TO ROLE REPORTER_AIRBNB;
-- GRANT SELECT ON FUTURE TABLES IN SCHEMA DWH.AIRBNB TO ROLE REPORTER_AIRBNB
-- GRANT SELECT ON FUTURE VIEWS IN SCHEMA DWH.AIRBNB TO ROLE REPORTER_AIRBNB