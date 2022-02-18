-- get security question answers for all users
select 
	usr.username, 
	qstn.question,
	qa.answer
from 
	auth_user usr
	inner join agency_api_securityquestionanswer qa
		on usr.id = qa.user_id
	inner join agency_api_securityquestion qstn
		on qa.question_id = qstn.id
order by username;

-- see what group each user is part of
select 
	usr.username,
	grps.name
from 
	auth_user_groups user_groups
	inner join auth_user usr
		on user_groups.user_id = usr.id
	inner join auth_group grps
		on user_groups.group_id = grps.id;

-- see what permissions are associated with each group
select 
	grp.name,
	perm.name
from
	auth_group grp
	inner join auth_group_permissions grp_perm
		on grp.id = grp_perm.group_id
	inner join auth_permission perm
		on grp_perm.permission_id = perm.id
order by grp.name;
