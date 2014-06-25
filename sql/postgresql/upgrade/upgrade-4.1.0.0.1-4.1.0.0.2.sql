--  upgrade-4.1.0.0.1-4.1.0.0.2.sql

SELECT acs_log__debug('/packages/intranet-reporting-dashboard/sql/postgresql/upgrade/upgrade-4.1.0.0.1-4.1.0.0.2.sql','');


-- Top Customers Widget
--
SELECT im_component_plugin__new (
	null,					-- plugin_id
	'im_component_plugin',			-- object_type
	now(),					-- creation_date
	null,					-- creation_user
	null,					-- creation_ip
	null,					-- context_id
	'Project EVA',				-- plugin_name
	'intranet-reporting-dashboard',		-- package_name
	'left',					-- location
	'/intranet/projects/view',		-- page_url
	null,					-- view_name
	46,					-- sort_order
	'im_dashboard_project_eva -project_id $project_id -diagram_width 580 -diagram_height 300',
	'lang::message::lookup "" intranet-reporting-dashboard.Project_EVA "Project EVA"'
);

SELECT acs_permission__grant_permission(
        (select plugin_id from im_component_plugins where plugin_name = 'Top Customers'),
        (select group_id from groups where group_name = 'Employees'),
        'read'
);
