# Converted with pg2mysql-1.9
# Converted on Sat, 26 Aug 2017 13:02:49 -0400
# Lightbox Technologies Inc. http://www.lightbox.ca

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone="+00:00";

CREATE TABLE acl_board_links (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL,
    url varchar(255) NOT NULL,
    method varchar(255) NOT NULL,
    slug varchar(255) NOT NULL,
    group_id smallint,
    is_hide smallint DEFAULT 0 
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE acl_board_links_boards_user_roles (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    acl_board_link_id bigint NOT NULL,
    board_user_role_id bigint NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE acl_links (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL,
    url varchar(255) NOT NULL,
    method varchar(255) NOT NULL,
    slug varchar(255) NOT NULL,
    group_id smallint,
    is_user_action smallint DEFAULT 0 ,
    is_guest_action smallint DEFAULT 0 ,
    is_admin_action smallint DEFAULT 0 ,
    is_hide smallint DEFAULT 0 
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE acl_links_roles (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    acl_link_id bigint NOT NULL,
    role_id bigint NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE acl_organization_links (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL,
    url varchar(255) NOT NULL,
    method varchar(255) NOT NULL,
    slug varchar(255) NOT NULL,
    group_id smallint,
    is_hide smallint DEFAULT 0 
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE acl_organization_links_organizations_user_roles (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    acl_organization_link_id bigint NOT NULL,
    organization_user_role_id bigint NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE activities (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    board_id bigint DEFAULT 0,
    list_id bigint DEFAULT 0,
    card_id bigint DEFAULT 0,
    user_id bigint NOT NULL,
    foreign_id bigint,
    `type` varchar(255) NOT NULL,
    comment text NOT NULL,
    revisions text,
    root bigint DEFAULT 0,
    freshness_ts timestamp,
    depth int(11) DEFAULT 0,
    path text,
    materialized_path varchar(255) DEFAULT NULL,
    organization_id bigint DEFAULT 0 
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE boards (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    user_id bigint NOT NULL,
    organization_id bigint DEFAULT 0,
    name text NOT NULL,
    board_visibility smallint,
    background_color varchar(255),
    background_picture_url text,
    commenting_permissions smallint,
    voting_permissions smallint,
    inivitation_permissions smallint,
    is_closed bool DEFAULT 0 NOT NULL,
    is_allow_organization_members_to_join bool DEFAULT 0 NOT NULL,
    boards_user_count bigint DEFAULT 0,
    list_count bigint DEFAULT 0,
    card_count bigint DEFAULT 0,
    boards_subscriber_count bigint DEFAULT 0,
    background_pattern_url varchar(255),
    boards_star_count bigint DEFAULT 0,
    is_show_image_front_of_card bool DEFAULT 1,
    background_picture_path varchar(255),
    music_name varchar(255),
    music_content text,
    archived_list_count bigint DEFAULT 0 ,
    archived_card_count bigint DEFAULT 0 ,
    default_email_list_id bigint DEFAULT 0 ,
    is_default_email_position_as_bottom bool DEFAULT 0 NOT NULL,
    custom_fields text
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE cards (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    board_id bigint NOT NULL,
    list_id bigint NOT NULL,
    name text NOT NULL,
    description text,
    due_date timestamp,
    `position` double precision NOT NULL,
    is_archived bool DEFAULT 0 NOT NULL,
    attachment_count bigint DEFAULT 0,
    checklist_count bigint DEFAULT 0,
    checklist_item_count bigint DEFAULT 0,
    checklist_item_completed_count bigint DEFAULT 0,
    label_count bigint DEFAULT 0,
    cards_user_count bigint DEFAULT 0,
    cards_subscriber_count bigint DEFAULT 0,
    card_voter_count bigint DEFAULT 0,
    activity_count bigint DEFAULT 0,
    user_id bigint NOT NULL,
    is_deleted bool DEFAULT 0 NOT NULL,
    comment_count bigint DEFAULT 0 ,
    custom_fields text,
    color varchar(255)
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE checklist_items (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    user_id bigint NOT NULL,
    card_id bigint NOT NULL,
    checklist_id bigint NOT NULL,
    name text NOT NULL,
    is_completed bool DEFAULT 0 NOT NULL,
    `position` double precision NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE checklists (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    user_id bigint NOT NULL,
    card_id bigint NOT NULL,
    name varchar(255) NOT NULL,
    checklist_item_count bigint DEFAULT 0,
    checklist_item_completed_count bigint DEFAULT 0,
    `position` double precision NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE labels (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL,
    card_count bigint DEFAULT 0 NOT NULL,
    color varchar(255)
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE lists (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    board_id bigint NOT NULL,
    user_id bigint NOT NULL,
    name varchar(255) NOT NULL,
    `position` double precision NOT NULL,
    is_archived bool DEFAULT 0 NOT NULL,
    card_count bigint DEFAULT 0,
    lists_subscriber_count bigint DEFAULT 0,
    is_deleted bool DEFAULT 0 NOT NULL,
    custom_fields text,
    color varchar(255)
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE organizations (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    user_id bigint NOT NULL,
    name varchar(255) NOT NULL,
    website_url varchar(255),
    description text,
    logo_url varchar(255),
    organization_visibility smallint DEFAULT 1,
    organizations_user_count bigint DEFAULT 0,
    board_count bigint DEFAULT 0
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE users (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    role_id int(11) DEFAULT 0 NOT NULL,
    username varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    password text NOT NULL,
    full_name varchar(255),
    initials varchar(10),
    about_me text,
    profile_picture_path varchar(255),
    notification_frequency smallint,
    is_allow_desktop_notification bool DEFAULT 0 NOT NULL,
    is_active bool DEFAULT 0 NOT NULL,
    is_email_confirmed bool DEFAULT 0 NOT NULL,
    created_organization_count bigint DEFAULT 0,
    created_board_count bigint DEFAULT 0,
    joined_organization_count bigint DEFAULT 0,
    list_count bigint DEFAULT 0,
    joined_card_count bigint DEFAULT 0,
    created_card_count bigint DEFAULT 0,
    joined_board_count bigint DEFAULT 0,
    checklist_count bigint DEFAULT 0,
    checklist_item_completed_count bigint DEFAULT 0,
    checklist_item_count bigint DEFAULT 0,
    activity_count bigint DEFAULT 0,
    card_voter_count bigint DEFAULT 0,
    last_activity_id bigint DEFAULT 0 ,
    last_login_date timestamp,
    last_login_ip_id bigint,
    ip_id bigint,
    login_type_id smallint,
    is_productivity_beats bool DEFAULT 0 NOT NULL,
    user_login_count bigint DEFAULT 0 ,
    is_ldap bool DEFAULT 0 NOT NULL,
    is_send_newsletter smallint DEFAULT 2 ,
    last_email_notified_activity_id bigint DEFAULT 0 ,
    owner_board_count bigint DEFAULT 0 ,
    member_board_count bigint DEFAULT 0 ,
    owner_organization_count bigint DEFAULT 0 ,
    member_organization_count bigint DEFAULT 0 ,
    language varchar(10),
    timezone varchar(255)
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE boards_users (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    board_id bigint NOT NULL,
    user_id bigint NOT NULL,
    board_user_role_id smallint DEFAULT 0 
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE cities (
    id bigint NOT NULL,
    created timestamp,
    modified timestamp,
    country_id bigint,
    state_id bigint,
    latitude varchar(255),
    longitude varchar(255),
    name varchar(255),
    is_active bool DEFAULT 0
) ENGINE=MyISAM;

CREATE TABLE countries (
    id bigint NOT NULL,
    iso_alpha2 varchar(2) DEFAULT NULL,
    iso_alpha3 varchar(3) DEFAULT NULL,
    iso_numeric bigint,
    fips_code varchar(3) DEFAULT NULL,
    name varchar(200) DEFAULT NULL,
    capital varchar(200) DEFAULT NULL,
    areainsqkm double precision,
    population bigint,
    continent varchar(2) DEFAULT NULL,
    tld varchar(3) DEFAULT NULL,
    currency varchar(3) DEFAULT NULL,
    currencyname varchar(20) DEFAULT NULL,
    phone varchar(10) DEFAULT NULL,
    postalcodeformat varchar(20) DEFAULT NULL,
    postalcoderegex varchar(20) DEFAULT NULL,
    languages varchar(200) DEFAULT NULL,
    geonameid bigint,
    neighbours varchar(20) DEFAULT NULL,
    equivalentfipscode varchar(10) DEFAULT NULL,
    created timestamp,
    iso2 varchar(2),
    iso3 varchar(3),
    modified timestamp
) ENGINE=MyISAM;

CREATE TABLE ips (
    id bigint auto_increment NOT NULL,
    created timestamp,
    modified timestamp,
    ip varchar(255) NOT NULL,
    host varchar(255) NOT NULL,
    user_agent varchar(255) NOT NULL,
    `order` int(11) DEFAULT 0,
    city_id bigint,
    state_id bigint,
    country_id bigint,
    latitude double precision,
    longitude double precision
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE login_types (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE states (
    id bigint NOT NULL,
    created timestamp,
    modified timestamp,
    country_id bigint,
    name varchar(45),
    is_active bool DEFAULT 0
) ENGINE=MyISAM;

CREATE TABLE board_stars (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    board_id bigint NOT NULL,
    user_id bigint NOT NULL,
    is_starred bool NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE board_subscribers (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    board_id bigint NOT NULL,
    user_id bigint NOT NULL,
    is_subscribed bool NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE board_user_roles (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255)
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE cards_labels (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    label_id bigint NOT NULL,
    card_id bigint NOT NULL,
    list_id bigint,
    board_id bigint
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE card_attachments (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    card_id bigint,
    name varchar(255) NOT NULL,
    path varchar(255) NOT NULL,
    list_id bigint,
    board_id bigint DEFAULT 1,
    mimetype varchar(255),
    link varchar(255)
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE card_subscribers (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    card_id bigint NOT NULL,
    user_id bigint NOT NULL,
    is_subscribed bool NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE card_voters (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    card_id bigint NOT NULL,
    user_id bigint NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE cards_users (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    card_id bigint NOT NULL,
    user_id bigint NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE list_subscribers (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp,
    list_id bigint NOT NULL,
    user_id bigint NOT NULL,
    is_subscribed bool DEFAULT 0 NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE email_templates (
    id bigint auto_increment NOT NULL,
    created timestamp,
    modified timestamp,
    from_email varchar(255) DEFAULT NULL,
    reply_to_email varchar(255) DEFAULT NULL,
    name varchar(150) DEFAULT NULL,
    description text,
    subject varchar(255) DEFAULT NULL,
    email_text_content text,
    email_variables varchar(255) DEFAULT NULL,
    display_name text
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE languages (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(80) NOT NULL,
    iso2 varchar(25) NOT NULL,
    iso3 varchar(25) NOT NULL,
    is_active smallint DEFAULT 1 NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE oauth_access_tokens (
    access_token varchar(40) NOT NULL,
    client_id varchar(80),
    user_id varchar(255),
    expires timestamp,
    scope text
) ENGINE=MyISAM;

CREATE TABLE oauth_authorization_codes (
    authorization_code varchar(40) NOT NULL,
    client_id varchar(80),
    user_id varchar(255),
    redirect_uri text,
    expires timestamp,
    scope text
) ENGINE=MyISAM;

CREATE TABLE oauth_clients (
    client_id varchar(80) NOT NULL,
    client_secret varchar(80),
    redirect_uri text,
    grant_types varchar(80),
    scope varchar(100),
    user_id varchar(80),
    client_name varchar(255),
    client_url varchar(255),
    logo_url varchar(255),
    tos_url varchar(255),
    policy_url text,
    modified timestamp,
    created timestamp,
    id int(11) NOT NULL
) ENGINE=MyISAM;

CREATE TABLE oauth_jwt (
    client_id varchar(80) NOT NULL,
    subject varchar(80),
    public_key text
) ENGINE=MyISAM;

CREATE TABLE oauth_refresh_tokens (
    refresh_token varchar(40) NOT NULL,
    client_id varchar(80),
    user_id varchar(255),
    expires timestamp,
    scope text
) ENGINE=MyISAM;

CREATE TABLE oauth_scopes (
    scope text NOT NULL,
    is_default bool
) ENGINE=MyISAM;

CREATE TABLE organization_user_roles (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255)
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE organizations_users (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    organization_id bigint NOT NULL,
    user_id bigint NOT NULL,
    organization_user_role_id smallint DEFAULT 0 
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE roles (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE setting_categories (
    id int(11) NOT NULL,
    created timestamp,
    modified timestamp,
    parent_id bigint,
    name varchar(255),
    description text,
    `order` int(11) DEFAULT 0 NOT NULL
) ENGINE=MyISAM;

CREATE TABLE settings (
    id bigint auto_increment NOT NULL,
    setting_category_id bigint NOT NULL,
    setting_category_parent_id bigint DEFAULT 0,
    name varchar(255),
    value text,
    description text,
    `type` varchar(8),
    options text,
    label varchar(255),
    `order` int(11) DEFAULT 0 NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE user_logins (
    id int(11) NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    user_id bigint DEFAULT 0 ,
    ip_id bigint DEFAULT 0 ,
    user_agent varchar(255)
) ENGINE=MyISAM;

CREATE TABLE webhooks (
    id bigint auto_increment NOT NULL,
    created timestamp NOT NULL,
    modified timestamp NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255) NOT NULL,
    url varchar(255) NOT NULL,
    secret varchar(255) NOT NULL,
    is_active bool DEFAULT 0 NOT NULL
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

ALTER TABLE acl_board_links_boards_user_roles
    ADD CONSTRAINT acl_board_links_boards_user_roles_id PRIMARY KEY (id);
ALTER TABLE acl_board_links
    ADD CONSTRAINT acl_board_links_id PRIMARY KEY (id);
ALTER TABLE acl_links_roles
    ADD CONSTRAINT acl_links_roles_id PRIMARY KEY (id);
ALTER TABLE acl_organization_links
    ADD CONSTRAINT acl_organization_links_id PRIMARY KEY (id);
ALTER TABLE acl_organization_links_organizations_user_roles
    ADD CONSTRAINT acl_organization_links_organizations_user_roles_id PRIMARY KEY (id);
ALTER TABLE activities
    ADD CONSTRAINT activities_id PRIMARY KEY (id);
ALTER TABLE board_stars
    ADD CONSTRAINT board_stars_id PRIMARY KEY (id);
ALTER TABLE board_subscribers
    ADD CONSTRAINT board_subscribers_id PRIMARY KEY (id);
ALTER TABLE board_user_roles
    ADD CONSTRAINT board_user_roles_id PRIMARY KEY (id);
ALTER TABLE boards_users
    ADD CONSTRAINT board_users_id PRIMARY KEY (id);
ALTER TABLE boards
    ADD CONSTRAINT boards_id PRIMARY KEY (id);
ALTER TABLE card_attachments
    ADD CONSTRAINT card_attachments_id PRIMARY KEY (id);
ALTER TABLE card_subscribers
    ADD CONSTRAINT card_subscribers_id PRIMARY KEY (id);
ALTER TABLE cards_users
    ADD CONSTRAINT card_users_id PRIMARY KEY (id);
ALTER TABLE card_voters
    ADD CONSTRAINT card_voters_id PRIMARY KEY (id);
ALTER TABLE cards
    ADD CONSTRAINT cards_id PRIMARY KEY (id);
ALTER TABLE cards_labels
    ADD CONSTRAINT cards_labels_id PRIMARY KEY (id);
ALTER TABLE checklist_items
    ADD CONSTRAINT checklist_items_id PRIMARY KEY (id);
ALTER TABLE checklists
    ADD CONSTRAINT checklists_id PRIMARY KEY (id);
ALTER TABLE cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);
ALTER TABLE countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);
ALTER TABLE email_templates
    ADD CONSTRAINT email_templates_id PRIMARY KEY (id);
ALTER TABLE ips
    ADD CONSTRAINT ips_pkey PRIMARY KEY (id);
ALTER TABLE labels
    ADD CONSTRAINT labels_id PRIMARY KEY (id);
ALTER TABLE lists
    ADD CONSTRAINT lists_id PRIMARY KEY (id);
ALTER TABLE list_subscribers
    ADD CONSTRAINT lists_subscribers_pkey PRIMARY KEY (id);
ALTER TABLE login_types
    ADD CONSTRAINT login_types_id PRIMARY KEY (id);
ALTER TABLE oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_access_token PRIMARY KEY (access_token);
ALTER TABLE oauth_authorization_codes
    ADD CONSTRAINT oauth_authorization_codes_authorization_code PRIMARY KEY (authorization_code);
ALTER TABLE oauth_clients
    ADD CONSTRAINT oauth_clients_client_id PRIMARY KEY (client_id);
ALTER TABLE oauth_jwt
    ADD CONSTRAINT oauth_jwt_client_id PRIMARY KEY (client_id);
ALTER TABLE oauth_refresh_tokens
    ADD CONSTRAINT oauth_refresh_tokens_refresh_token PRIMARY KEY (refresh_token);
ALTER TABLE organization_user_roles
    ADD CONSTRAINT organization_user_roles_id PRIMARY KEY (id);
ALTER TABLE organizations_users
    ADD CONSTRAINT organization_users_id PRIMARY KEY (id);
ALTER TABLE organizations
    ADD CONSTRAINT organizations_id PRIMARY KEY (id);
ALTER TABLE roles
    ADD CONSTRAINT roles_id PRIMARY KEY (id);
ALTER TABLE setting_categories
    ADD CONSTRAINT setting_categories_id PRIMARY KEY (id);
ALTER TABLE settings
    ADD CONSTRAINT settings_id PRIMARY KEY (id);
ALTER TABLE states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);
ALTER TABLE user_logins
    ADD CONSTRAINT user_logins_id PRIMARY KEY (id);
ALTER TABLE users
    ADD CONSTRAINT users_id PRIMARY KEY (id);
ALTER TABLE webhooks
    ADD CONSTRAINT webhooks_id PRIMARY KEY (id);
ALTER TABLE `acl_board_links_boards_user_roles` ADD INDEX ( acl_board_link_id ) ;
ALTER TABLE `acl_board_links_boards_user_roles` ADD INDEX ( board_user_role_id ) ;
ALTER TABLE `acl_board_links` ADD INDEX ( group_id ) ;
ALTER TABLE `acl_board_links` ADD INDEX ( slug ) ;
ALTER TABLE `acl_board_links` ADD INDEX ( url ) ;
ALTER TABLE `acl_links` ADD INDEX ( group_id ) ;
ALTER TABLE `acl_links_roles` ADD INDEX ( acl_link_id ) ;
ALTER TABLE `acl_links_roles` ADD INDEX ( role_id ) ;
ALTER TABLE `acl_links` ADD INDEX ( slug ) ;
ALTER TABLE `acl_organization_links` ADD INDEX ( group_id ) ;
ALTER TABLE `acl_organization_links_organizations_user_roles` ADD INDEX ( acl_organization_link_id ) ;
ALTER TABLE `acl_organization_links_organizations_user_roles` ADD INDEX ( organization_user_role_id ) ;
ALTER TABLE `acl_organization_links` ADD INDEX ( slug ) ;
ALTER TABLE `acl_organization_links` ADD INDEX ( url ) ;
ALTER TABLE `activities` ADD INDEX ( foreign_id ) ;
ALTER TABLE `activities` ADD INDEX ( board_id ) ;
ALTER TABLE `activities` ADD INDEX ( card_id ) ;
ALTER TABLE `activities` ADD INDEX ( depth ) ;
ALTER TABLE `activities` ADD INDEX ( freshness_ts ) ;
ALTER TABLE `activities` ADD INDEX ( list_id ) ;
ALTER TABLE `activities` ADD INDEX ( materialized_path ) ;
ALTER TABLE `activities` ADD INDEX ( path ) ;
ALTER TABLE `activities` ADD INDEX ( root ) ;
ALTER TABLE `activities` ADD INDEX ( type ) ;
ALTER TABLE `activities` ADD INDEX ( user_id ) ;
ALTER TABLE `card_attachments` ADD INDEX ( card_id ) ;
ALTER TABLE `board_stars` ADD INDEX ( board_id ) ;
ALTER TABLE `board_stars` ADD INDEX ( user_id ) ;
ALTER TABLE `board_subscribers` ADD INDEX ( board_id ) ;
ALTER TABLE `board_subscribers` ADD INDEX ( user_id ) ;
ALTER TABLE `boards_users` ADD INDEX ( board_id ) ;
ALTER TABLE `boards_users` ADD INDEX ( user_id ) ;
ALTER TABLE `boards` ADD INDEX ( organization_id ) ;
ALTER TABLE `boards` ADD INDEX ( user_id ) ;
ALTER TABLE `boards_users` ADD INDEX ( board_user_role_id ) ;
ALTER TABLE `card_attachments` ADD INDEX ( board_id ) ;
ALTER TABLE `card_attachments` ADD INDEX ( list_id ) ;
ALTER TABLE `card_subscribers` ADD INDEX ( card_id ) ;
ALTER TABLE `card_subscribers` ADD INDEX ( user_id ) ;
ALTER TABLE `cards_users` ADD INDEX ( card_id ) ;
ALTER TABLE `cards_users` ADD INDEX ( user_id ) ;
ALTER TABLE `card_voters` ADD INDEX ( card_id ) ;
ALTER TABLE `card_voters` ADD INDEX ( user_id ) ;
ALTER TABLE `cards` ADD INDEX ( board_id ) ;
ALTER TABLE `cards_labels` ADD INDEX ( board_id ) ;
ALTER TABLE `cards_labels` ADD INDEX ( card_id ) ;
ALTER TABLE `cards_labels` ADD INDEX ( label_id ) ;
ALTER TABLE `cards_labels` ADD INDEX ( list_id ) ;
ALTER TABLE `cards` ADD INDEX ( list_id ) ;
ALTER TABLE `cards` ADD INDEX ( user_id ) ;
ALTER TABLE `checklist_items` ADD INDEX ( card_id ) ;
ALTER TABLE `checklist_items` ADD INDEX ( checklist_id ) ;
ALTER TABLE `checklist_items` ADD INDEX ( user_id ) ;
ALTER TABLE `checklists` ADD INDEX ( card_id ) ;
ALTER TABLE `checklists` ADD INDEX ( user_id ) ;
ALTER TABLE `email_templates` ADD INDEX ( name ) ;
ALTER TABLE `ips` ADD INDEX ( city_id ) ;
ALTER TABLE `ips` ADD INDEX ( country_id ) ;
ALTER TABLE `ips` ADD INDEX ( ip ) ;
ALTER TABLE `ips` ADD INDEX ( state_id ) ;
ALTER TABLE `labels` ADD INDEX ( name ) ;
ALTER TABLE `list_subscribers` ADD INDEX ( list_id ) ;
ALTER TABLE `list_subscribers` ADD INDEX ( user_id ) ;
ALTER TABLE `lists` ADD INDEX ( board_id ) ;
ALTER TABLE `lists` ADD INDEX ( user_id ) ;
ALTER TABLE `oauth_access_tokens` ADD INDEX ( client_id ) ;
ALTER TABLE `oauth_access_tokens` ADD INDEX ( user_id ) ;
ALTER TABLE `oauth_authorization_codes` ADD INDEX ( client_id ) ;
ALTER TABLE `oauth_authorization_codes` ADD INDEX ( user_id ) ;
ALTER TABLE `oauth_clients` ADD INDEX ( user_id ) ;
ALTER TABLE `oauth_refresh_tokens` ADD INDEX ( client_id ) ;
ALTER TABLE `oauth_refresh_tokens` ADD INDEX ( user_id ) ;
ALTER TABLE `organizations_users` ADD INDEX ( organization_id ) ;
ALTER TABLE `organizations_users` ADD INDEX ( user_id ) ;
ALTER TABLE `organizations` ADD INDEX ( user_id ) ;
ALTER TABLE `organizations_users` ADD INDEX ( organization_user_role_id ) ;
ALTER TABLE `roles` ADD INDEX ( name ) ;
ALTER TABLE `setting_categories` ADD INDEX ( parent_id ) ;
ALTER TABLE `settings` ADD INDEX ( setting_category_id ) ;
ALTER TABLE `settings` ADD INDEX ( setting_category_parent_id ) ;
ALTER TABLE `user_logins` ADD INDEX ( ip_id ) ;
ALTER TABLE `user_logins` ADD INDEX ( user_id ) ;
ALTER TABLE `users` ADD INDEX ( email ) ;
ALTER TABLE `users` ADD INDEX ( ip_id ) ;
ALTER TABLE `users` ADD INDEX ( last_activity_id ) ;
ALTER TABLE `users` ADD INDEX ( last_email_notified_activity_id ) ;
ALTER TABLE `users` ADD INDEX ( last_login_ip_id ) ;
ALTER TABLE `users` ADD INDEX ( login_type_id ) ;
ALTER TABLE `users` ADD INDEX ( role_id ) ;
ALTER TABLE `users` ADD INDEX ( username ) ;
ALTER TABLE `webhooks` ADD INDEX ( url ) ;
--- NOT VALID ---

('.'),
(''),
(''),
('--'),
('-- Name: webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -'),
('--'),
(''),
('SELECT pg_catalog.setval(\'webhooks_id_seq\', 1, false);'),
(''),
(''),
('--'),
('-- Name: acl_board_links_boards_user_roles_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT acl_board_links_boards_user_roles_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: acl_board_links_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT acl_board_links_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: acl_links_roles_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT acl_links_roles_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: acl_organization_links_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT acl_organization_links_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: acl_organization_links_organizations_user_roles_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT acl_organization_links_organizations_user_roles_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: activities_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT activities_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: board_stars_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT board_stars_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: board_subscribers_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT board_subscribers_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: board_user_roles_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT board_user_roles_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: board_users_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT board_users_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: boards_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT boards_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: card_attachments_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT card_attachments_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: card_subscribers_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT card_subscribers_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: card_users_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT card_users_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: card_voters_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT card_voters_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: cards_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT cards_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: cards_labels_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT cards_labels_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: checklist_items_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT checklist_items_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: checklists_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT checklists_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: cities_pkey; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT cities_pkey PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT countries_pkey PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: email_templates_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT email_templates_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: ips_pkey; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT ips_pkey PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: labels_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT labels_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: lists_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT lists_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: lists_subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT lists_subscribers_pkey PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: login_types_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT login_types_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: oauth_access_tokens_access_token; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT oauth_access_tokens_access_token PRIMARY KEY (access_token);'),
(''),
(''),
('--'),
('-- Name: oauth_authorization_codes_authorization_code; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT oauth_authorization_codes_authorization_code PRIMARY KEY (authorization_code);'),
(''),
(''),
('--'),
('-- Name: oauth_clients_client_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT oauth_clients_client_id PRIMARY KEY (client_id);'),
(''),
(''),
('--'),
('-- Name: oauth_jwt_client_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT oauth_jwt_client_id PRIMARY KEY (client_id);'),
(''),
(''),
('--'),
('-- Name: oauth_refresh_tokens_refresh_token; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT oauth_refresh_tokens_refresh_token PRIMARY KEY (refresh_token);'),
(''),
(''),
('--'),
('-- Name: organization_user_roles_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT organization_user_roles_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: organization_users_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT organization_users_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: organizations_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT organizations_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: roles_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT roles_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: setting_categories_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT setting_categories_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: settings_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT settings_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: states_pkey; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT states_pkey PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: user_logins_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT user_logins_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: users_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT users_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: webhooks_id; Type: CONSTRAINT; Schema: public; Owner: -'),
('--'),
(''),
('ADD CONSTRAINT webhooks_id PRIMARY KEY (id);'),
(''),
(''),
('--'),
('-- Name: acl_board_links_boards_user_roles_acl_board_link_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_board_links_boards_user_roles_acl_board_link_id ON acl_board_links_boards_user_roles USING btree (acl_board_link_id);'),
(''),
(''),
('--'),
('-- Name: acl_board_links_boards_user_roles_board_user_role_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_board_links_boards_user_roles_board_user_role_id ON acl_board_links_boards_user_roles USING btree (board_user_role_id);'),
(''),
(''),
('--'),
('-- Name: acl_board_links_group_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_board_links_group_id ON acl_board_links USING btree (group_id);'),
(''),
(''),
('--'),
('-- Name: acl_board_links_slug; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_board_links_slug ON acl_board_links USING btree (slug);'),
(''),
(''),
('--'),
('-- Name: acl_board_links_url; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_board_links_url ON acl_board_links USING btree (url);'),
(''),
(''),
('--'),
('-- Name: acl_links_group_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_links_group_id ON acl_links USING btree (group_id);'),
(''),
(''),
('--'),
('-- Name: acl_links_roles_acl_link_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_links_roles_acl_link_id ON acl_links_roles USING btree (acl_link_id);'),
(''),
(''),
('--'),
('-- Name: acl_links_roles_role_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_links_roles_role_id ON acl_links_roles USING btree (role_id);'),
(''),
(''),
('--'),
('-- Name: acl_links_slug; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_links_slug ON acl_links USING btree (slug);'),
(''),
(''),
('--'),
('-- Name: acl_organization_links_group_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_organization_links_group_id ON acl_organization_links USING btree (group_id);'),
(''),
(''),
('--'),
('-- Name: acl_organization_links_organizations_user_roles_acl_organizatio; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_organization_links_organizations_user_roles_acl_organizatio ON acl_organization_links_organizations_user_roles USING btree (acl_organization_link_id);'),
(''),
(''),
('--'),
('-- Name: acl_organization_links_organizations_user_roles_organization_us; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_organization_links_organizations_user_roles_organization_us ON acl_organization_links_organizations_user_roles USING btree (organization_user_role_id);'),
(''),
(''),
('--'),
('-- Name: acl_organization_links_slug; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_organization_links_slug ON acl_organization_links USING btree (slug);'),
(''),
(''),
('--'),
('-- Name: acl_organization_links_url; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX acl_organization_links_url ON acl_organization_links USING btree (url);'),
(''),
(''),
('--'),
('-- Name: activities_attachment_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_attachment_id ON activities USING btree (foreign_id);'),
(''),
(''),
('--'),
('-- Name: activities_board_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_board_id ON activities USING btree (board_id);'),
(''),
(''),
('--'),
('-- Name: activities_card_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_card_id ON activities USING btree (card_id);'),
(''),
(''),
('--'),
('-- Name: activities_depth; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_depth ON activities USING btree (depth);'),
(''),
(''),
('--'),
('-- Name: activities_freshness_ts; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_freshness_ts ON activities USING btree (freshness_ts);'),
(''),
(''),
('--'),
('-- Name: activities_list_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_list_id ON activities USING btree (list_id);'),
(''),
(''),
('--'),
('-- Name: activities_materialized_path; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_materialized_path ON activities USING btree (materialized_path);'),
(''),
(''),
('--'),
('-- Name: activities_path; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_path ON activities USING btree (path);'),
(''),
(''),
('--'),
('-- Name: activities_root; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_root ON activities USING btree (root);'),
(''),
(''),
('--'),
('-- Name: activities_type; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_type ON activities USING btree (type);'),
(''),
(''),
('--'),
('-- Name: activities_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX activities_user_id ON activities USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: attachments_card_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX attachments_card_id ON card_attachments USING btree (card_id);'),
(''),
(''),
('--'),
('-- Name: board_stars_board_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX board_stars_board_id ON board_stars USING btree (board_id);'),
(''),
(''),
('--'),
('-- Name: board_stars_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX board_stars_user_id ON board_stars USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: board_subscribers_board_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX board_subscribers_board_id ON board_subscribers USING btree (board_id);'),
(''),
(''),
('--'),
('-- Name: board_subscribers_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX board_subscribers_user_id ON board_subscribers USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: board_users_board_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX board_users_board_id ON boards_users USING btree (board_id);'),
(''),
(''),
('--'),
('-- Name: board_users_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX board_users_user_id ON boards_users USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: boards_organization_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX boards_organization_id ON boards USING btree (organization_id);'),
(''),
(''),
('--'),
('-- Name: boards_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX boards_user_id ON boards USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: boards_users_board_user_role_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX boards_users_board_user_role_id ON boards_users USING btree (board_user_role_id);'),
(''),
(''),
('--'),
('-- Name: card_attachments_board_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX card_attachments_board_id ON card_attachments USING btree (board_id);'),
(''),
(''),
('--'),
('-- Name: card_attachments_list_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX card_attachments_list_id ON card_attachments USING btree (list_id);'),
(''),
(''),
('--'),
('-- Name: card_subscribers_card_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX card_subscribers_card_id ON card_subscribers USING btree (card_id);'),
(''),
(''),
('--'),
('-- Name: card_subscribers_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX card_subscribers_user_id ON card_subscribers USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: card_users_card_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX card_users_card_id ON cards_users USING btree (card_id);'),
(''),
(''),
('--'),
('-- Name: card_users_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX card_users_user_id ON cards_users USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: card_voters_card_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX card_voters_card_id ON card_voters USING btree (card_id);'),
(''),
(''),
('--'),
('-- Name: card_voters_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX card_voters_user_id ON card_voters USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: cards_board_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX cards_board_id ON cards USING btree (board_id);'),
(''),
(''),
('--'),
('-- Name: cards_labels_board_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX cards_labels_board_id ON cards_labels USING btree (board_id);'),
(''),
(''),
('--'),
('-- Name: cards_labels_card_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX cards_labels_card_id ON cards_labels USING btree (card_id);'),
(''),
(''),
('--'),
('-- Name: cards_labels_label_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX cards_labels_label_id ON cards_labels USING btree (label_id);'),
(''),
(''),
('--'),
('-- Name: cards_labels_list_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX cards_labels_list_id ON cards_labels USING btree (list_id);'),
(''),
(''),
('--'),
('-- Name: cards_list_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX cards_list_id ON cards USING btree (list_id);'),
(''),
(''),
('--'),
('-- Name: cards_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX cards_user_id ON cards USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: checklist_items_card_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX checklist_items_card_id ON checklist_items USING btree (card_id);'),
(''),
(''),
('--'),
('-- Name: checklist_items_checklist_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX checklist_items_checklist_id ON checklist_items USING btree (checklist_id);'),
(''),
(''),
('--'),
('-- Name: checklist_items_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX checklist_items_user_id ON checklist_items USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: checklists_card_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX checklists_card_id ON checklists USING btree (card_id);'),
(''),
(''),
('--'),
('-- Name: checklists_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX checklists_user_id ON checklists USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: email_templates_name; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX email_templates_name ON email_templates USING btree (name);'),
(''),
(''),
('--'),
('-- Name: ips_city_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX ips_city_id ON ips USING btree (city_id);'),
(''),
(''),
('--'),
('-- Name: ips_country_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX ips_country_id ON ips USING btree (country_id);'),
(''),
(''),
('--'),
('-- Name: ips_ip; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX ips_ip ON ips USING btree (ip);'),
(''),
(''),
('--'),
('-- Name: ips_state_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX ips_state_id ON ips USING btree (state_id);'),
(''),
(''),
('--'),
('-- Name: labels_name; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX labels_name ON labels USING btree (name);'),
(''),
(''),
('--'),
('-- Name: list_subscribers_list_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX list_subscribers_list_id ON list_subscribers USING btree (list_id);'),
(''),
(''),
('--'),
('-- Name: list_subscribers_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX list_subscribers_user_id ON list_subscribers USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: lists_board_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX lists_board_id ON lists USING btree (board_id);'),
(''),
(''),
('--'),
('-- Name: lists_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX lists_user_id ON lists USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: oauth_access_tokens_client_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX oauth_access_tokens_client_id ON oauth_access_tokens USING btree (client_id);'),
(''),
(''),
('--'),
('-- Name: oauth_access_tokens_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX oauth_access_tokens_user_id ON oauth_access_tokens USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: oauth_authorization_codes_client_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX oauth_authorization_codes_client_id ON oauth_authorization_codes USING btree (client_id);'),
(''),
(''),
('--'),
('-- Name: oauth_authorization_codes_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX oauth_authorization_codes_user_id ON oauth_authorization_codes USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: oauth_clients_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX oauth_clients_user_id ON oauth_clients USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: oauth_refresh_tokens_client_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX oauth_refresh_tokens_client_id ON oauth_refresh_tokens USING btree (client_id);'),
(''),
(''),
('--'),
('-- Name: oauth_refresh_tokens_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX oauth_refresh_tokens_user_id ON oauth_refresh_tokens USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: organization_users_organization_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX organization_users_organization_id ON organizations_users USING btree (organization_id);'),
(''),
(''),
('--'),
('-- Name: organization_users_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX organization_users_user_id ON organizations_users USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: organizations_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX organizations_user_id ON organizations USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: organizations_users_organization_user_role_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX organizations_users_organization_user_role_id ON organizations_users USING btree (organization_user_role_id);'),
(''),
(''),
('--'),
('-- Name: roles_name; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX roles_name ON roles USING btree (name);'),
(''),
(''),
('--'),
('-- Name: setting_categories_parent_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX setting_categories_parent_id ON setting_categories USING btree (parent_id);'),
(''),
(''),
('--'),
('-- Name: settings_setting_category_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX settings_setting_category_id ON settings USING btree (setting_category_id);'),
(''),
(''),
('--'),
('-- Name: settings_setting_category_parent_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX settings_setting_category_parent_id ON settings USING btree (setting_category_parent_id);'),
(''),
(''),
('--'),
('-- Name: user_logins_ip_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX user_logins_ip_id ON user_logins USING btree (ip_id);'),
(''),
(''),
('--'),
('-- Name: user_logins_user_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX user_logins_user_id ON user_logins USING btree (user_id);'),
(''),
(''),
('--'),
('-- Name: users_email; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX users_email ON users USING btree (email);'),
(''),
(''),
('--'),
('-- Name: users_ip_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX users_ip_id ON users USING btree (ip_id);'),
(''),
(''),
('--'),
('-- Name: users_last_activity_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX users_last_activity_id ON users USING btree (last_activity_id);'),
(''),
(''),
('--'),
('-- Name: users_last_email_notified_activity_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX users_last_email_notified_activity_id ON users USING btree (last_email_notified_activity_id);'),
(''),
(''),
('--'),
('-- Name: users_last_login_ip_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX users_last_login_ip_id ON users USING btree (last_login_ip_id);'),
(''),
(''),
('--'),
('-- Name: users_login_type_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX users_login_type_id ON users USING btree (login_type_id);'),
(''),
(''),
('--'),
('-- Name: users_role_id; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX users_role_id ON users USING btree (role_id);'),
(''),
(''),
('--'),
('-- Name: users_username; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX users_username ON users USING btree (username);'),
(''),
(''),
('--'),
('-- Name: webhooks_url; Type: INDEX; Schema: public; Owner: -'),
('--'),
(''),
('CREATE INDEX webhooks_url ON webhooks USING btree (url);'),
(''),
(''),
('--'),
('-- Name: label_card_count_update; Type: TRIGGER; Schema: public; Owner: -'),
('--'),
(''),
('CREATE TRIGGER label_card_count_update AFTER INSERT OR DELETE OR UPDATE ON cards_labels FOR EACH ROW EXECUTE PROCEDURE label_card_count_update();'),
(''),
(''),
('--'),
('-- Name: update_board_count; Type: TRIGGER; Schema: public; Owner: -'),
('--'),
(''),
('CREATE TRIGGER update_board_count AFTER INSERT OR DELETE OR UPDATE ON boards FOR EACH ROW EXECUTE PROCEDURE update_board_count();'),
(''),
(''),
('--'),
('-- Name: update_board_star_count; Type: TRIGGER; Schema: public; Owner: -'),
('--'),
(''),
('CREATE TRIGGER update_board_star_count AFTER INSERT OR DELETE OR UPDATE ON board_stars FOR EACH ROW EXECUTE PROCEDURE update_board_star_count();'),
(''),
(''),
('--'),
('-- Name: update_board_subscriber_count; Type: TRIGGER; Schema: public; Owner: -'),
('--'),
(''),
('CREATE TRIGGER update_board_subscriber_count AFTER INSERT OR DELETE OR UPDATE ON board_subscribers FOR EACH ROW EXECUTE PROCEDURE update_board_subscriber_count();'),
(''),
(''),
('--'),
('-- Name: update_board_user_count; Type: TRIGGER; Schema: public; Owner: -'),
('--'),
(''),
('CREATE TRIGGER update_board_user_count AFTER INSERT OR DELETE OR UPDATE ON boards_users FOR EACH ROW EXECUTE PROCEDURE update_board_user_count();'),
(''),
(''),
('--'),
('-- Name: update_card_attachment_count; Type: TRIGGER; Schema: public; Owner: -'),
('--'),
(''),
('CREATE TRIGGER update_card_attachment_count AFTER INSERT OR DELETE OR UPDATE ON card_attachments FOR EACH ROW EXECUTE PROCEDURE update_card_attachment_count();'),
(''),
(''),
('--'),
('-- Name: update_card_checklist_count; Type: TRIGGER; Schema: public; Owner: -'),
('--'),
(''),
('CREATE TRIGGER update_card_checklist_count AFTER INSERT OR DELETE OR UPDATE ON checklists FOR EACH ROW EXECUTE PROCEDURE update_card_checklist_count();'),
(''),
(''),
('--'),
('-- Name: update_card_checklist_item_count; Type: TRIGGER; Schema: public; Owner: -'),
('--'),
(''),
('CREATE TRIGGER update_card_checklist_item_count AFTER INSERT OR DELETE OR UPDATE ON checklist_items FOR EACH ROW EXECUTE PROCEDURE update_card_checklist_item_count();'),
(''),
(''),
('--'),
('-- Name: update_card_count; Type: TRIGGER; Schema: public; Owner: -'),
('--');
