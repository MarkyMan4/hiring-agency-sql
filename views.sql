create or replace view agency_api_pendingpayment as (
    with work_history as (
        select 
            healthcare_professional_id,
            sum(extract(epoch from (end_time - start_time)) / 60 / 60) as hours_worked
        from agency_api_serviceentry
        group by healthcare_professional_id
    ),
    payment_history as (
        select 
            healthcare_professional_id,
            sum(amount) as amt_paid
        from agency_api_payment
        group by healthcare_professional_id
    ),
    money_owed as (
        select 
            usr.id as user_id,
            hp.id as healthcare_professional_id,
            usr.first_name || ' ' || usr.last_name as full_name,
            usr.username,
            hp.hourly_rate,
            wh.hours_worked,
            ph.amt_paid,
            (hp.hourly_rate * wh.hours_worked) - ph.amt_paid as amt_owed
        from
            agency_api_healthcareprofessional hp
            inner join auth_user usr
                on hp.user_id = usr.id
            inner join work_history wh
                on hp.id = wh.healthcare_professional_id
            inner join payment_history ph
                on hp.id = ph.healthcare_professional_id
    )
    select 
        row_number() over(partition by user_id order by amt_owed) as id,
        *
    from money_owed
    where amt_owed > 0
    order by amt_owed desc
);
