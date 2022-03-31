-- security questions
insert into agency_api_securityquestion (question) values
    ('In what city were you born?'),
    ('What is the name of your favorite pet?'),
    ('What is your mother''s maiden name?'),
    ('What high school did you attend?'),
    ('What is the name of your first school?'),
    ('What was the make of your first car?'),
    ('What was your favorite food as a child?')
;

-- education types
insert into agency_api_educationtype (name) values ('Bachelors'), ('Masters');
insert into agency_api_educationtype (name) values ('PHD');

-- service types
insert into agency_api_servicetype (name, hourly_rate) values ('Nurse', 50.0), ('Physiotherapist', 60.0);
insert into agency_api_servicetype (name, hourly_rate) values ('Psychologist', 70.0);

-- update earliest and latest work times for each type of HP
update agency_api_servicetype
set 
	earliest_work_time = '06:00:00'::time,
	latest_work_time = 
		case
			when id in (1, 2) then '18:00:00'::time
			else '20:00:00'::time
		end;

-- create security question answers (only need to do this for admin, other users add answers through the app)
insert into agency_api_securityquestionanswer (answer, question_id, user_id) values
('test', 1, 1), -- replace third item with ID of your admin user
('test', 2, 1),
('test', 3, 1);
