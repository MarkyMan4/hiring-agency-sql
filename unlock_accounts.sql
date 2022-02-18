-- unlock all accounts
update agency_api_accountstatus
set is_locked = false;

-- unlock one specefic account
update agency_api_accountstatus
set is_locked = false
where user_id = 1; -- replace with ID of account to unlock
