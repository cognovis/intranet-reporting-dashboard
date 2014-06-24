--  upgrade-4.1.0.0.0-4.1.0.0.1.sql

SELECT acs_log__debug('/packages/intranet-reporting-dashboard/sql/postgresql/upgrade/upgrade-4.1.0.0.0-4.1.0.0.1.sql','');


-- Top Customers Widget
--
SELECT im_component_plugin__new (
	null,					-- plugin_id
	'im_component_plugin',			-- object_type
	now(),					-- creation_date
	null,					-- creation_user
	null,					-- creation_ip
	null,					-- context_id
	'Top Customers',			-- plugin_name
	'intranet-reporting-dashboard',		-- package_name
	'left',					-- location
	'/intranet/index',			-- page_url
	null,					-- view_name
	60,					-- sort_order
	'im_dashboard_top_customers -diagram_width 580 -diagram_height 300 -diagram_max_customers 8',
	'lang::message::lookup "" intranet-reporting-dashboard.Top_Customers "Top Customers"'
);

SELECT acs_permission__grant_permission(
        (select plugin_id from im_component_plugins where plugin_name = 'Top Customers'),
        (select group_id from groups where group_name = 'Senior Managers'),
        'read'
);

SELECT acs_permission__grant_permission(
        (select plugin_id from im_component_plugins where plugin_name = 'Top Customers'),
        (select group_id from groups where group_name = 'Accounting'),
        'read'
);

SELECT acs_permission__grant_permission(
        (select plugin_id from im_component_plugins where plugin_name = 'Top Customers'),
        (select group_id from groups where group_name = 'Sales'),
        'read'
);


-- Disable the old component
update im_component_plugins
set enabled_p = 'f'
where package_name = 'intranet-reporting-dashboard' and
      plugin_name = 'Home All-Time Top Customers';

