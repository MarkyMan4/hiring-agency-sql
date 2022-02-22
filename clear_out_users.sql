-- this deletes all non-admin users and their associated data, can be helpful to clear out your local database sometimes
-- replace 12 with the ID of your admin user
delete from knox_authtoken;
delete from agency_api_servicerequest;
delete from agency_api_staffmember;
delete from agency_api_caretaker;
delete from agency_api_securityquestionanswer where user_id <> 12;
delete from agency_api_accountstatus where user_id <> 12;
delete from auth_user_groups where user_id <> 12;
delete from auth_user where is_superuser = false;

-- may also want to reset the autoincrementing ID for auth_user
select setval('auth_user_id_seq', 1);
