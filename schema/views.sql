CREATE OR REPLACE VIEW acl_organization_links_listing AS
 SELECT aolour.organization_user_role_id,
    aol.slug,
    aol.url,
    aol.method
   FROM acl_organization_links_organizations_user_roles aolour
     JOIN acl_organization_links aol ON aol.id = aolour.acl_organization_link_id;

CREATE OR REPLACE VIEW activities_listing AS
 SELECT activity.id,
    DATE_FORMAT(activity.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(activity.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    activity.board_id,
    activity.list_id,
    activity.card_id,
    activity.user_id,
    activity.foreign_id,
    activity.type,
    activity.comment,
    activity.revisions,
    activity.root,
    activity.freshness_ts,
    activity.depth,
    activity.path,
    activity.materialized_path,
    board.name AS board_name,
    list.name AS list_name,
    card.name AS card_name,
    users.username,
    users.full_name,
    users.profile_picture_path,
    users.initials,
    la.name AS label_name,
    card.description AS card_description,
    users.role_id AS user_role_id,
    checklist_item.name AS checklist_item_name,
    checklist.name AS checklist_item_parent_name,
    checklist1.name AS checklist_name,
    organizations.id AS organization_id,
    organizations.name AS organization_name,
    organizations.logo_url AS organization_logo_url,
    list1.name AS moved_list_name,
    DATE_FORMAT(activity.created, '%H:%i') AS created_time,
    card.position AS card_position,
    card.comment_count
   FROM activities activity
     LEFT JOIN boards board ON board.id = activity.board_id
     LEFT JOIN lists list ON list.id = activity.list_id
     LEFT JOIN lists list1 ON list1.id = activity.foreign_id
     LEFT JOIN cards card ON card.id = activity.card_id
     LEFT JOIN labels la ON la.id = activity.foreign_id AND activity.type = 'add_card_label'
     LEFT JOIN checklist_items checklist_item ON checklist_item.id = activity.foreign_id
     LEFT JOIN checklists checklist ON checklist.id = checklist_item.checklist_id
     LEFT JOIN checklists checklist1 ON checklist1.id = activity.foreign_id
     LEFT JOIN users users ON users.id = activity.user_id
     LEFT JOIN organizations organizations ON organizations.id = activity.organization_id;

  -- View: admin_boards_listing

-- DROP VIEW admin_boards_listing;

CREATE OR REPLACE VIEW admin_boards_listing AS
 SELECT board.id,
    board.name,
    DATE_FORMAT(board.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(board.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    users.username,
    users.full_name,
    users.profile_picture_path,
    users.initials,
    board.user_id,
    board.organization_id,
    board.board_visibility,
    board.background_color,
    board.background_picture_url,
    CAST(board.is_closed AS integer) AS is_closed,
    board.boards_user_count,
    board.list_count,
    board.card_count,
    board.archived_list_count,
    board.archived_card_count,
    board.boards_subscriber_count,
    board.background_pattern_url,
    board.music_name,
    organizations.name AS organization_name,
    organizations.website_url AS organization_website_url,
    organizations.description AS organization_description,
    organizations.logo_url AS organization_logo_url,
    organizations.organization_visibility,
    ( SELECT array_to_json(array_agg(row_to_json(bu.*))) AS array_to_json
           FROM ( SELECT boards_users.id,
                    boards_users.created,
                    boards_users.modified,
                    boards_users.board_id,
                    boards_users.user_id,
                    boards_users.board_user_role_id,
                    boards_users.username,
                    boards_users.email,
                    boards_users.full_name,
                    CAST(boards_users.is_active AS INTEGER) AS is_active,
                    CAST(boards_users.is_email_confirmed AS integer) AS is_email_confirmed,
                    boards_users.board_name,
                    boards_users.profile_picture_path,
                    boards_users.initials
                   FROM boards_users_listing boards_users
                  WHERE boards_users.board_id = board.id
                  ORDER BY boards_users.id) bu) AS boards_users,
    board.default_email_list_id,
    board.is_default_email_position_as_bottom
   FROM boards board
     LEFT JOIN users users ON users.id = board.user_id
     LEFT JOIN organizations organizations ON organizations.id = board.organization_id;
-- View: admin_users_listing

-- DROP VIEW admin_users_listing;

CREATE OR REPLACE VIEW admin_users_listing AS
 SELECT users.id,
    users.role_id,
    users.username,
    users.password,
    users.email,
    users.full_name,
    users.initials,
    users.about_me,
    users.profile_picture_path,
    users.notification_frequency,
    CAST(users.is_allow_desktop_notification AS integer) AS is_allow_desktop_notification,
    CAST(users.is_active AS integer) AS is_active,
    CAST(users.is_email_confirmed AS integer) AS is_email_confirmed,
    users.created_organization_count,
    users.created_board_count,
    users.joined_organization_count,
    users.list_count,
    users.joined_card_count,
    users.created_card_count,
    users.joined_board_count,
    users.checklist_count,
    users.checklist_item_completed_count,
    users.checklist_item_count,
    users.activity_count,
    users.card_voter_count,
    CAST(users.is_productivity_beats AS integer) AS is_productivity_beats,
    users.last_activity_id,
    users.last_login_date,
    li.ip AS last_login_ip,
    lci.name AS login_city_name,
    lst.name AS login_state_name,
    lco.name AS login_country_name,
    lower(lco.iso_alpha2) AS login_country_iso2,
    i.ip AS registered_ip,
    rci.name AS register_city_name,
    rst.name AS register_state_name,
    rco.name AS register_country_name,
    LOWER(rco.iso_alpha2) AS register_country_iso2,
    lt.name AS login_type,
    DATE_FORMAT(users.created, '%Y-%m-%dT%H:%i:%s') AS created,
    users.user_login_count,
    users.is_send_newsletter,
    users.last_email_notified_activity_id,
    users.owner_board_count,
    users.member_board_count,
    users.owner_organization_count,
    users.member_organization_count,
    users.language,
    CAST(users.is_ldap AS integer) AS is_ldap,
    users.timezone
   FROM users users
     LEFT JOIN ips i ON i.id = users.ip_id
     LEFT JOIN cities rci ON rci.id = i.city_id
     LEFT JOIN states rst ON rst.id = i.state_id
     LEFT JOIN countries rco ON rco.id = i.country_id
     LEFT JOIN ips li ON li.id = users.last_login_ip_id
     LEFT JOIN cities lci ON lci.id = li.city_id
     LEFT JOIN states lst ON lst.id = li.state_id
     LEFT JOIN countries lco ON lco.id = li.country_id
     LEFT JOIN login_types lt ON lt.id = users.login_type_id;

-- View: boards_labels_listing

-- DROP VIEW boards_labels_listing;

CREATE OR REPLACE VIEW boards_labels_listing AS
 SELECT cards_labels.id,
    DATE_FORMAT(cards_labels.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(cards_labels.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    cards_labels.label_id,
    cards_labels.card_id,
    cards_labels.list_id,
    cards_labels.board_id,
    labels.name
   FROM cards_labels cards_labels
     LEFT JOIN labels labels ON labels.id = cards_labels.label_id;

-- View: boards_listing

-- DROP VIEW boards_listing;

CREATE OR REPLACE VIEW boards_listing AS
 SELECT board.id,
    board.name,
    DATE_FORMAT(board.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(board.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    users.username,
    users.full_name,
    users.profile_picture_path,
    users.initials,
    board.user_id,
    board.organization_id,
    board.board_visibility,
    board.background_color,
    board.background_picture_url,
    board.commenting_permissions,
    board.voting_permissions,
    CAST(board.is_closed AS integer) AS is_closed,
    CAST(board.is_allow_organization_members_to_join AS integer) AS is_allow_organization_members_to_join,
    board.boards_user_count,
    board.list_count,
    board.card_count,
    board.archived_list_count,
    board.archived_card_count,
    board.boards_subscriber_count,
    board.background_pattern_url,
    CAST(board.is_show_image_front_of_card AS integer) AS is_show_image_front_of_card,
    board.music_name,
    board.music_content,
    organizations.name AS organization_name,
    organizations.website_url AS organization_website_url,
    organizations.description AS organization_description,
    organizations.logo_url AS organization_logo_url,
    organizations.organization_visibility,
    ( SELECT array_to_json(array_agg(row_to_json(ba.*))) AS array_to_json
           FROM ( SELECT activities.id,
                    DATE_FORMAT(activities.created, '%Y-%m-%dT%H:%i:%s') AS created,
                    DATE_FORMAT(activities.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
                    activities.board_id,
                    activities.list_id,
                    activities.card_id,
                    activities.user_id,
                    activities.foreign_id AS attachment_id,
                    activities.type,
                    activities.comment,
                    activities.revisions,
                    activities.root,
                    activities.freshness_ts,
                    activities.depth,
                    activities.path,
                    activities.materialized_path,
                    users_1.username,
                    users_1.role_id,
                    users_1.profile_picture_path,
                    users_1.initials
                   FROM activities activities
                     LEFT JOIN users users_1 ON users_1.id = activities.user_id
                  WHERE activities.board_id = board.id
                  ORDER BY activities.freshness_ts DESC, activities.materialized_path
                  LIMIT 20 OFFSET 0) ba) AS activities,
    ( SELECT array_to_json(array_agg(row_to_json(bs.*))) AS array_to_json
           FROM ( SELECT boards_subscribers.id,
                    DATE_FORMAT(boards_subscribers.created, '%Y-%m-%dT%H:%i:%s') AS created,
                    DATE_FORMAT(boards_subscribers.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
                    boards_subscribers.board_id,
                    boards_subscribers.user_id,
                    CAST(boards_subscribers.is_subscribed AS integer) AS is_subscribed
                   FROM board_subscribers boards_subscribers
                  WHERE boards_subscribers.board_id = board.id
                  ORDER BY boards_subscribers.id) bs) AS boards_subscribers,
    ( SELECT array_to_json(array_agg(row_to_json(bs.*))) AS array_to_json
           FROM ( SELECT boards_stars.id,
                    DATE_FORMAT(boards_stars.created, '%Y-%m-%dT%H:%i:%s') AS created,
                    DATE_FORMAT(boards_stars.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
                    boards_stars.created,
                    boards_stars.modified,
                    boards_stars.board_id,
                    boards_stars.user_id,
                    CAST(boards_stars.is_starred AS integer) AS is_starred
                   FROM board_stars boards_stars
                  WHERE boards_stars.board_id = board.id
                  ORDER BY boards_stars.id) bs(id, created, modified, created_1, modified_1, board_id, user_id, is_starred)) AS boards_stars,
    ( SELECT array_to_json(array_agg(row_to_json(batt.*))) AS array_to_json
           FROM ( SELECT card_attachments.id,
                    DATE_FORMAT(card_attachments.created, '%Y-%m-%dT%H:%i:%s') AS created,
                    DATE_FORMAT(card_attachments.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
                    card_attachments.card_id,
                    card_attachments.name,
                    card_attachments.path,
                    card_attachments.mimetype,
                    card_attachments.list_id,
                    card_attachments.board_id,
                    card_attachments.link
                   FROM card_attachments card_attachments
                  WHERE card_attachments.board_id = board.id
                  ORDER BY card_attachments.id DESC) batt) AS attachments,
    ( SELECT array_to_json(array_agg(row_to_json(bl.*))) AS array_to_json
           FROM ( SELECT lists_listing.id,
                    lists_listing.created,
                    lists_listing.modified,
                    lists_listing.board_id,
                    lists_listing.name,
                    lists_listing.position,
                    CAST(lists_listing.is_archived AS integer) AS is_archived,
                    lists_listing.card_count,
                    lists_listing.lists_subscriber_count,
                    lists_listing.cards,
                    lists_listing.lists_subscribers,
                    lists_listing.custom_fields,
                    lists_listing.color
                   FROM lists_listing lists_listing
                  WHERE lists_listing.board_id = board.id
                  ORDER BY lists_listing.position) bl) AS lists,
    ( SELECT array_to_json(array_agg(row_to_json(bu.*))) AS array_to_json
           FROM ( SELECT boards_users.id,
                    boards_users.created,
                    boards_users.modified,
                    boards_users.board_id,
                    boards_users.user_id,
                    boards_users.board_user_role_id,
                    boards_users.username,
                    boards_users.email,
                    boards_users.full_name,
                    CAST(boards_users.is_active AS integer) AS is_active,
                    CAST(boards_users.is_email_confirmed AS integer) AS is_email_confirmed,
                    boards_users.board_name,
                    boards_users.profile_picture_path,
                    boards_users.initials
                   FROM boards_users_listing boards_users
                  WHERE boards_users.board_id = board.id
                  ORDER BY boards_users.id) bu) AS boards_users,
    board.default_email_list_id,
    board.is_default_email_position_as_bottom,
    board.custom_fields
   FROM boards board
     LEFT JOIN users users ON users.id = board.user_id
     LEFT JOIN organizations organizations ON organizations.id = board.organization_id;


-- View: boards_users_listing

-- DROP VIEW boards_users_listing;

CREATE OR REPLACE VIEW boards_users_listing AS
 SELECT bu.id,
    DATE_FORMAT(bu.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(bu.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    bu.board_id,
    bu.user_id,
    bu.board_user_role_id,
    u.username,
    u.email,
    u.full_name,
    CAST(u.is_active AS integer) AS is_active,
    CAST(u.is_email_confirmed AS integer) AS is_email_confirmed,
    b.name AS board_name,
    u.profile_picture_path,
    u.initials,
    b.default_email_list_id,
    CAST(b.is_default_email_position_as_bottom AS integer) AS is_default_email_position_as_bottom
   FROM boards_users bu
     JOIN users u ON u.id = bu.user_id
     JOIN boards b ON b.id = bu.board_id;


-- View: card_voters_listing

-- DROP VIEW card_voters_listing;

CREATE OR REPLACE VIEW card_voters_listing AS
 SELECT card_voters.id,
    DATE_FORMAT(card_voters.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(card_voters.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    card_voters.user_id,
    card_voters.card_id,
    users.username,
    users.role_id,
    users.profile_picture_path,
    users.initials,
    users.full_name
   FROM card_voters card_voters
     LEFT JOIN users users ON users.id = card_voters.user_id;


-- View: cards_elasticsearch_listing

-- DROP VIEW cards_elasticsearch_listing;

CREATE OR REPLACE VIEW cards_elasticsearch_listing AS
 SELECT card.id,
    row_to_json(card.*) AS json
   FROM ( SELECT cards.id,
            cards.board_id,
            boards.name AS board,
            cards.list_id,
            lists.name AS list,
            cards.name,
            cards.description,
            DATE_FORMAT(cards.due_date, '%Y-%m-%dT%H:%i:%s') AS due_date,
            DATE_FORMAT(cards.created, '%Y-%m-%dT%H:%i:%s') AS created,
            DATE_FORMAT(cards.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
            CAST(cards.is_archived AS integer) AS is_archived,
            cards.attachment_count,
            cards.checklist_item_count,
            cards.checklist_item_completed_count,
            cards.card_voter_count,
            cards.cards_user_count,
            cards.color,
            ( SELECT array_to_json(array_agg(row_to_json(cc.*))) AS array_to_json
                   FROM ( SELECT boards_users.user_id
                           FROM boards_users boards_users
                          WHERE boards_users.board_id = cards.board_id
                          ORDER BY boards_users.id) cc) AS board_users,
            ( SELECT array_to_json(array_agg(row_to_json(cc.*))) AS array_to_json
                   FROM ( SELECT board_stars.user_id
                           FROM board_stars board_stars
                          WHERE board_stars.board_id = cards.board_id
                          ORDER BY board_stars.id) cc) AS board_stars,
            ( SELECT array_to_json(array_agg(row_to_json(cc.*))) AS array_to_json
                   FROM ( SELECT checklists.name,
                            checklist_items.name AS checklist_item_name
                           FROM checklists checklists
                             LEFT JOIN checklist_items checklist_items ON checklist_items.checklist_id = checklists.id
                          WHERE checklists.card_id = cards.id
                          ORDER BY checklists.id) cc) AS cards_checklists,
            ( SELECT array_to_json(array_agg(row_to_json(cc.*))) AS array_to_json
                   FROM ( SELECT cards_users_listing.username,
                            cards_users_listing.user_id
                           FROM cards_users_listing cards_users_listing
                          WHERE cards_users_listing.card_id = cards.id
                          ORDER BY cards_users_listing.id) cc) AS cards_users,
            ( SELECT array_to_json(array_agg(row_to_json(cl.*))) AS array_to_json
                   FROM ( SELECT cards_labels.name
                           FROM cards_labels_listing cards_labels
                          WHERE cards_labels.card_id = cards.id
                          ORDER BY cards_labels.id) cl) AS cards_labels,
            ( SELECT array_to_json(array_agg(row_to_json(cl.*))) AS array_to_json
                   FROM ( SELECT activities.comment
                           FROM activities activities
                          WHERE activities.type = 'add_comment' AND activities.card_id = cards.id
                          ORDER BY activities.id) cl) AS activities
           FROM cards cards
             LEFT JOIN boards boards ON boards.id = cards.board_id
             LEFT JOIN lists lists ON lists.id = cards.list_id
          WHERE boards.name IS NOT NULL) card;



-- View: cards_labels_listing

-- DROP VIEW cards_labels_listing;

CREATE OR REPLACE VIEW cards_labels_listing AS
 SELECT cl.id,
    DATE_FORMAT(cl.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(cl.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    cl.label_id,
    cl.card_id,
    c.name AS card_name,
    c.list_id,
    l.name,
    cl.board_id,
    l.color
   FROM cards_labels cl
     LEFT JOIN cards c ON c.id = cl.card_id
     LEFT JOIN labels l ON l.id = cl.label_id;


-- View: cards_listing

-- DROP VIEW cards_listing;

CREATE OR REPLACE VIEW cards_listing AS
 SELECT cards.id,
    DATE_FORMAT(cards.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(cards.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    cards.board_id,
    cards.list_id,
    cards.name,
    cards.description,
    DATE_FORMAT(cards.due_date, '%Y-%m-%dT%H:%i:%s') AS due_date,
    DATE_FORMAT(FROM_UNIXTIME(`cards.due_date`), '%Y/%m/%d') AS to_date,
    cards.position,
    CAST(cards.is_archived AS integer) AS is_archived,
    cards.attachment_count,
    cards.checklist_count,
    cards.checklist_item_count,
    cards.checklist_item_completed_count,
    cards.label_count,
    cards.cards_user_count,
    cards.cards_subscriber_count,
    cards.card_voter_count,
    cards.activity_count,
    cards.user_id,
    cards.name AS title,
    cards.due_date AS start,
    cards.due_date AS "end",
    ( SELECT array_to_json(array_agg(row_to_json(cc.*))) AS array_to_json
           FROM ( SELECT checklists_listing.id,
                    checklists_listing.created,
                    checklists_listing.modified,
                    checklists_listing.user_id,
                    checklists_listing.card_id,
                    checklists_listing.name,
                    checklists_listing.checklist_item_count,
                    checklists_listing.checklist_item_completed_count,
                    checklists_listing.position,
                    checklists_listing.checklists_items
                   FROM checklists_listing checklists_listing
                  WHERE checklists_listing.card_id = cards.id
                  ORDER BY checklists_listing.id) cc) AS cards_checklists,
    ( SELECT array_to_json(array_agg(row_to_json(cc.*))) AS array_to_json
           FROM ( SELECT cards_users_listing.username,
                    cards_users_listing.profile_picture_path,
                    cards_users_listing.id,
                    cards_users_listing.created,
                    cards_users_listing.modified,
                    cards_users_listing.card_id,
                    cards_users_listing.user_id,
                    cards_users_listing.initials,
                    cards_users_listing.full_name,
                    cards_users_listing.email
                   FROM cards_users_listing cards_users_listing
                  WHERE cards_users_listing.card_id = cards.id
                  ORDER BY cards_users_listing.id) cc) AS cards_users,
    ( SELECT array_to_json(array_agg(row_to_json(cv.*))) AS array_to_json
           FROM ( SELECT card_voters_listing.id,
                    card_voters_listing.created,
                    card_voters_listing.modified,
                    card_voters_listing.user_id,
                    card_voters_listing.card_id,
                    card_voters_listing.username,
                    card_voters_listing.role_id,
                    card_voters_listing.profile_picture_path,
                    card_voters_listing.initials,
                    card_voters_listing.full_name
                   FROM card_voters_listing card_voters_listing
                  WHERE card_voters_listing.card_id = cards.id
                  ORDER BY card_voters_listing.id) cv) AS cards_voters,
    ( SELECT array_to_json(array_agg(row_to_json(cs.*))) AS array_to_json
           FROM ( SELECT cards_subscribers.id,
                    DATE_FORMAT(cards_subscribers.created, '%Y-%m-%dT%H:%i:%s') AS created,
                    DATE_FORMAT(cards_subscribers.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
                    cards_subscribers.card_id,
                    cards_subscribers.user_id,
                    CAST(cards_subscribers.is_subscribed AS integer) AS is_subscribed
                   FROM card_subscribers cards_subscribers
                  WHERE cards_subscribers.card_id = cards.id
                  ORDER BY cards_subscribers.id) cs) AS cards_subscribers,
    ( SELECT array_to_json(array_agg(row_to_json(cl.*))) AS array_to_json
           FROM ( SELECT cards_labels.label_id,
                    cards_labels.card_id,
                    cards_labels.list_id,
                    cards_labels.board_id,
                    cards_labels.name,
                    cards_labels.color
                   FROM cards_labels_listing cards_labels
                  WHERE cards_labels.card_id = cards.id
                  ORDER BY cards_labels.name) cl) AS cards_labels,
    cards.comment_count,
    u.username,
    b.name AS board_name,
    l.name AS list_name,
    cards.custom_fields,
    cards.color,
    cards.due_date AS notification_due_date
   FROM cards cards
     LEFT JOIN users u ON u.id = cards.user_id
     LEFT JOIN boards b ON b.id = cards.board_id
     LEFT JOIN lists l ON l.id = cards.list_id;

-- View: cards_users_listing

-- DROP VIEW cards_users_listing;

CREATE OR REPLACE VIEW cards_users_listing AS
 SELECT u.username,
    u.profile_picture_path,
    cu.id,
    DATE_FORMAT(cu.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(cu.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    cu.card_id,
    cu.user_id,
    u.initials,
    u.full_name,
    u.email
   FROM cards_users cu
     LEFT JOIN users u ON u.id = cu.user_id;


-- View: checklist_add_listing

-- DROP VIEW checklist_add_listing;

CREATE OR REPLACE VIEW checklist_add_listing AS
 SELECT c.id,
    c.name,
    c.board_id,
    cl.checklist_item_count,
    cl.name AS checklist_name,
    cl.id AS checklist_id
   FROM cards c
     LEFT JOIN checklists cl ON cl.card_id = c.id
  WHERE c.checklist_item_count > 0
  ORDER BY c.id;

-- View: checklists_listing

-- DROP VIEW checklists_listing;

CREATE OR REPLACE VIEW checklists_listing AS
 SELECT checklists.id,
    DATE_FORMAT(checklists.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(checklists.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    checklists.user_id,
    checklists.card_id,
    checklists.name,
    checklists.checklist_item_count,
    checklists.checklist_item_completed_count,
    ( SELECT array_to_json(array_agg(row_to_json(ci.*))) AS array_to_json
           FROM ( SELECT checklist_items.id,
                    checklist_items.created,
                    checklist_items.modified,
                    checklist_items.user_id,
                    checklist_items.card_id,
                    checklist_items.checklist_id,
                    checklist_items.name,
                    CAST(checklist_items.is_completed AS integer) AS is_completed,
                    checklist_items.position
                   FROM checklist_items checklist_items
                  WHERE checklist_items.checklist_id = checklists.id
                  ORDER BY checklist_items.position) ci) AS checklists_items,
    checklists.position
   FROM checklists checklists;


-- View: gadget_users_listing

-- DROP VIEW gadget_users_listing;

CREATE OR REPLACE VIEW gadget_users_listing AS
 SELECT checklists.id,
    DATE_FORMAT(checklists.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(checklists.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    checklists.user_id,
    checklists.card_id,
    checklists.name,
    checklists.checklist_item_count,
    checklists.checklist_item_completed_count,
    ( SELECT array_to_json(array_agg(row_to_json(ci.*))) AS array_to_json
           FROM ( SELECT checklist_items.id,
                    DATE_FORMAT(checklist_items.created, '%Y-%m-%dT%H:%i:%s') AS created,
                    DATE_FORMAT(checklist_items.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
                    checklist_items.user_id,
                    checklist_items.card_id,
                    checklist_items.checklist_id,
                    checklist_items.name,
                    CAST(checklist_items.is_completed AS integer) AS is_completed
                   FROM checklist_items checklist_items
                  WHERE checklist_items.checklist_id = checklists.id
                  ORDER BY checklist_items.id) ci) AS checklist_items
   FROM checklists checklists;

-- View: lists_listing

-- DROP VIEW lists_listing;

CREATE OR REPLACE VIEW lists_listing AS
 SELECT lists.id,
    DATE_FORMAT(lists.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(lists.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    lists.board_id,
    lists.name,
    lists.position,
    CAST(lists.is_archived AS integer) AS is_archived,
    lists.card_count,
    lists.lists_subscriber_count,
    ( SELECT array_to_json(array_agg(row_to_json(lc.*))) AS array_to_json
           FROM ( SELECT cards_listing.id,
                    cards_listing.created,
                    cards_listing.modified,
                    cards_listing.board_id,
                    cards_listing.list_id,
                    cards_listing.name,
                    cards_listing.description,
                    cards_listing.due_date,
                    cards_listing.to_date,
                    cards_listing.position,
                    CAST(cards_listing.is_archived AS integer) AS is_archived,
                    cards_listing.attachment_count,
                    cards_listing.checklist_count,
                    cards_listing.checklist_item_count,
                    cards_listing.checklist_item_completed_count,
                    cards_listing.label_count,
                    cards_listing.cards_user_count,
                    cards_listing.cards_subscriber_count,
                    cards_listing.card_voter_count,
                    cards_listing.activity_count,
                    cards_listing.user_id,
                    cards_listing.title,
                    cards_listing.start,
                    cards_listing.end,
                    cards_listing.cards_checklists,
                    cards_listing.cards_users,
                    cards_listing.cards_voters,
                    cards_listing.cards_subscribers,
                    cards_listing.cards_labels,
                    cards_listing.comment_count,
                    cards_listing.custom_fields,
                    cards_listing.color
                   FROM cards_listing cards_listing
                  WHERE cards_listing.list_id = lists.id
                  ORDER BY cards_listing.position) lc) AS cards,
    ( SELECT array_to_json(array_agg(row_to_json(ls.*))) AS array_to_json
           FROM ( SELECT lists_subscribers.id,
                    DATE_FORMAT(lists_subscribers.created, '%Y-%m-%dT%H:%i:%s') AS created,
                    DATE_FORMAT(lists_subscribers.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
                    lists_subscribers.list_id,
                    lists_subscribers.user_id,
                    CAST(lists_subscribers.is_subscribed AS integer) AS is_subscribed
                   FROM list_subscribers lists_subscribers
                  WHERE lists_subscribers.list_id = lists.id
                  ORDER BY lists_subscribers.id) ls) AS lists_subscribers,
    lists.custom_fields,
    lists.color
   FROM lists lists;





-- View: organizations_listing

-- DROP VIEW organizations_listing;

CREATE OR REPLACE VIEW organizations_listing AS
 SELECT organizations.id,
    DATE_FORMAT(organizations.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(organizations.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    organizations.user_id,
    organizations.name,
    organizations.website_url,
    organizations.description,
    organizations.logo_url,
    organizations.organization_visibility,
    organizations.organizations_user_count,
    organizations.board_count,
    ( SELECT array_to_json(array_agg(row_to_json(b.*))) AS array_to_json
           FROM ( SELECT boards_listing.id,
                    boards_listing.name,
                    boards_listing.user_id,
                    boards_listing.organization_id,
                    boards_listing.board_visibility,
                    boards_listing.background_color,
                    boards_listing.background_picture_url,
                    boards_listing.commenting_permissions,
                    boards_listing.voting_permissions,
                    CAST(boards_listing.is_closed AS integer) AS is_closed,
                    CAST(boards_listing.is_allow_organization_members_to_join AS integer) AS is_allow_organization_members_to_join,
                    boards_listing.boards_user_count,
                    boards_listing.list_count,
                    boards_listing.card_count,
                    boards_listing.boards_subscriber_count,
                    boards_listing.background_pattern_url,
                    CAST(boards_listing.is_show_image_front_of_card AS integer) AS is_show_image_front_of_card,
                    boards_listing.organization_name,
                    boards_listing.organization_website_url,
                    boards_listing.organization_description,
                    boards_listing.organization_logo_url,
                    boards_listing.organization_visibility,
                    boards_listing.activities,
                    boards_listing.boards_subscribers,
                    boards_listing.boards_stars,
                    boards_listing.attachments,
                    boards_listing.lists,
                    boards_listing.boards_users
                   FROM boards_listing boards_listing
                  WHERE boards_listing.organization_id = organizations.id
                  ORDER BY boards_listing.id) b) AS boards_listing,
    ( SELECT array_to_json(array_agg(row_to_json(c.*))) AS array_to_json
           FROM ( SELECT organizations_users_listing.id,
                    organizations_users_listing.created,
                    organizations_users_listing.modified,
                    organizations_users_listing.user_id,
                    organizations_users_listing.organization_id,
                    organizations_users_listing.organization_user_role_id,
                    organizations_users_listing.role_id,
                    organizations_users_listing.username,
                    organizations_users_listing.email,
                    organizations_users_listing.full_name,
                    organizations_users_listing.initials,
                    organizations_users_listing.about_me,
                    organizations_users_listing.created_organization_count,
                    organizations_users_listing.created_board_count,
                    organizations_users_listing.joined_organization_count,
                    organizations_users_listing.list_count,
                    organizations_users_listing.joined_card_count,
                    organizations_users_listing.created_card_count,
                    organizations_users_listing.joined_board_count,
                    organizations_users_listing.checklist_count,
                    organizations_users_listing.checklist_item_completed_count,
                    organizations_users_listing.checklist_item_count,
                    organizations_users_listing.activity_count,
                    organizations_users_listing.card_voter_count,
                    organizations_users_listing.name,
                    organizations_users_listing.website_url,
                    organizations_users_listing.description,
                    organizations_users_listing.logo_url,
                    organizations_users_listing.organization_visibility,
                    organizations_users_listing.profile_picture_path,
                    organizations_users_listing.boards_users,
                    organizations_users_listing.user_board_count
                   FROM organizations_users_listing organizations_users_listing
                  WHERE organizations_users_listing.organization_id = organizations.id
                  ORDER BY organizations_users_listing.id) c) AS organizations_users,
    u.username,
    u.full_name,
    u.initials,
    u.profile_picture_path
   FROM organizations organizations
     LEFT JOIN users u ON u.id = organizations.user_id;






-- View: organizations_users_listing

-- DROP VIEW organizations_users_listing;

CREATE OR REPLACE VIEW organizations_users_listing AS
 SELECT organizations_users.id,
    DATE_FORMAT(organizations_users.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(organizations_users.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    organizations_users.user_id,
    organizations_users.organization_id,
    organizations_users.organization_user_role_id,
    users.role_id,
    users.username,
    users.email,
    users.full_name,
    users.initials,
    users.about_me,
    users.created_organization_count,
    users.created_board_count,
    users.joined_organization_count,
    users.list_count,
    users.joined_card_count,
    users.created_card_count,
    users.joined_board_count,
    users.checklist_count,
    users.checklist_item_completed_count,
    users.checklist_item_count,
    users.activity_count,
    users.card_voter_count,
    organizations.name,
    organizations.website_url,
    organizations.description,
    organizations.logo_url,
    organizations.organization_visibility,
    users.profile_picture_path,
    ( SELECT array_to_json(array_agg(row_to_json(o.*))) AS array_to_json
           FROM ( SELECT boards_users.id,
                    boards_users.board_id,
                    boards_users.user_id,
                    boards_users.board_user_role_id,
                    boards.name
                   FROM boards_users boards_users
                     JOIN boards ON boards.id = boards_users.board_id
                  WHERE boards_users.user_id = organizations_users.user_id AND (boards_users.board_id IN ( SELECT boards_1.id
                           FROM boards boards_1
                          WHERE boards_1.organization_id = organizations_users.organization_id))
                  ORDER BY boards_users.id) o) AS boards_users,
    ( SELECT count(boards.id) AS count
           FROM boards
             JOIN boards_users bu ON bu.board_id = boards.id
          WHERE boards.organization_id = organizations_users.organization_id AND bu.user_id = organizations_users.user_id) AS user_board_count
   FROM organizations_users organizations_users
     LEFT JOIN users users ON users.id = organizations_users.user_id
     LEFT JOIN organizations organizations ON organizations.id = organizations_users.organization_id;

-- View: role_links_listing

-- DROP VIEW role_links_listing;

CREATE OR REPLACE VIEW role_links_listing AS
 SELECT role.id,
    ( SELECT array_to_json(array_agg(link.*)) AS array_to_json
           FROM ( SELECT alls.slug
                   FROM acl_links_listing alls
                  WHERE alls.role_id = role.id) link) AS links
   FROM roles role;


-- View: settings_listing

-- DROP VIEW settings_listing;

CREATE OR REPLACE VIEW settings_listing AS
 SELECT setting_categories.id,
    DATE_FORMAT(setting_categories.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(setting_categories.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    setting_categories.parent_id,
    setting_categories.name,
    setting_categories.description,
    ( SELECT array_to_json(array_agg(row_to_json(o.*))) AS array_to_json
           FROM ( SELECT settings.id,
                    settings.name,
                    settings.setting_category_id,
                    settings.setting_category_parent_id,
                    settings.value,
                    settings.type,
                    settings.options,
                    settings.label,
                    settings.`order`
                   FROM settings settings
                  WHERE settings.setting_category_id = setting_categories.id
                  ORDER BY settings.`order`) o) AS settings
   FROM setting_categories setting_categories;

-- View: simple_board_listing

-- DROP VIEW simple_board_listing;

CREATE OR REPLACE VIEW simple_board_listing AS
 SELECT board.id,
    board.name,
    board.user_id,
    board.organization_id,
    board.board_visibility,
    board.background_color,
    board.background_picture_url,
    board.commenting_permissions,
    board.voting_permissions,
    CAST(board.is_closed AS integer) AS is_closed,
    CAST(board.is_allow_organization_members_to_join AS integer) AS is_allow_organization_members_to_join,
    board.boards_user_count,
    board.list_count,
    board.card_count,
    board.boards_subscriber_count,
    board.background_pattern_url,
    ( SELECT array_to_json(array_agg(row_to_json(l.*))) AS array_to_json
           FROM ( SELECT lists.id,
                    DATE_FORMAT(lists.created, '%Y-%m-%dT%H:%i:%s') AS created,
                    DATE_FORMAT(lists.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
                    lists.board_id,
                    lists.user_id,
                    lists.name,
                    lists.position,
                    CAST(lists.is_archived AS integer) AS is_archived,
                    lists.card_count,
                    lists.lists_subscriber_count,
                    lists.color,
                    CAST(lists.is_deleted AS integer) AS is_deleted
                   FROM lists lists
                  WHERE lists.board_id = board.id
                  ORDER BY lists.position) l) AS lists,
    ( SELECT array_to_json(array_agg(row_to_json(l.*))) AS array_to_json
           FROM ( SELECT cll.label_id,
                    cll.name
                   FROM cards_labels_listing cll
                  WHERE cll.board_id = board.id
                  ORDER BY cll.name) l) AS labels,
    ( SELECT array_to_json(array_agg(row_to_json(l.*))) AS array_to_json
           FROM ( SELECT bs.id,
                    bs.board_id,
                    bs.user_id,
                    CAST(bs.is_starred AS integer) AS is_starred
                   FROM board_stars bs
                  WHERE bs.board_id = board.id
                  ORDER BY bs.id) l) AS stars,
    org.name AS organization_name,
    org.logo_url AS organization_logo_url,
    board.music_content,
    board.music_name
   FROM boards board
     LEFT JOIN organizations org ON org.id = board.organization_id
  ORDER BY board.name;


-- View: users_cards_listing

-- DROP VIEW users_cards_listing;

CREATE OR REPLACE VIEW users_cards_listing AS
 SELECT b.name AS board_name,
    l.name AS list_name,
    c.id,
    DATE_FORMAT(c.created, '%Y-%m-%dT%H:%i:%s') AS created,
    DATE_FORMAT(c.modified, '%Y-%m-%dT%H:%i:%s') AS modified,
    c.board_id,
    c.list_id,
    c.name,
    c.description,
    c.due_date,
    c.position,
    CAST(c.is_archived AS integer) AS is_archived,
    c.attachment_count,
    c.checklist_count,
    c.checklist_item_count,
    c.checklist_item_completed_count,
    c.label_count,
    c.cards_user_count,
    c.cards_subscriber_count,
    c.card_voter_count,
    c.activity_count,
    c.user_id AS created_user_id,
    c.color AS card_color,
    CAST(c.is_deleted AS integer) AS is_deleted,
    cu.user_id,
    c.comment_count
   FROM cards_users cu
     JOIN cards c ON c.id = cu.card_id
     JOIN boards b ON b.id = c.board_id
     JOIN lists l ON l.id = c.list_id;


-- View: users_listing

-- DROP VIEW users_listing;

CREATE OR REPLACE VIEW users_listing AS
 SELECT users.id,
    users.role_id,
    users.username,
    users.password,
    users.email,
    users.full_name,
    users.initials,
    users.about_me,
    users.profile_picture_path,
    users.notification_frequency,
    CAST(users.is_allow_desktop_notification AS integer) AS is_allow_desktop_notification,
    CAST(users.is_active AS integer) AS is_active,
    CAST(users.is_email_confirmed AS integer) AS is_email_confirmed,
    users.created_organization_count,
    users.created_board_count,
    users.joined_organization_count,
    users.list_count,
    users.joined_card_count,
    users.created_card_count,
    users.joined_board_count,
    users.checklist_count,
    users.checklist_item_completed_count,
    users.checklist_item_count,
    users.activity_count,
    users.card_voter_count,
    CAST(users.is_productivity_beats AS integer) AS is_productivity_beats,
    ( SELECT array_to_json(array_agg(row_to_json(o.*))) AS array_to_json
           FROM ( SELECT organizations_users_listing.organization_id AS id,
                    organizations_users_listing.name,
                    organizations_users_listing.description,
                    organizations_users_listing.website_url,
                    organizations_users_listing.logo_url,
                    organizations_users_listing.organization_visibility
                   FROM organizations_users_listing organizations_users_listing
                  WHERE organizations_users_listing.user_id = users.id
                  ORDER BY organizations_users_listing.id) o) AS organizations,
    users.last_activity_id,
    ( SELECT array_to_json(array_agg(row_to_json(o.*))) AS array_to_json
           FROM ( SELECT boards_stars.id,
                    boards_stars.board_id,
                    boards_stars.user_id,
                    CAST(boards_stars.is_starred AS integer) AS is_starred
                   FROM board_stars boards_stars
                  WHERE boards_stars.user_id = users.id
                  ORDER BY boards_stars.id) o) AS boards_stars,
    ( SELECT array_to_json(array_agg(row_to_json(o.*))) AS array_to_json
           FROM ( SELECT boards_users.id,
                    boards_users.board_id,
                    boards_users.user_id,
                    boards_users.board_user_role_id,
                    boards.name,
                    boards.background_picture_url,
                    boards.background_pattern_url,
                    boards.background_color
                   FROM boards_users boards_users
                     JOIN boards ON boards.id = boards_users.board_id
                  WHERE boards_users.user_id = users.id
                  ORDER BY boards_users.id) o) AS boards_users,
    users.last_login_date,
    li.ip AS last_login_ip,
    lci.name AS login_city_name,
    lst.name AS login_state_name,
    lco.name AS login_country_name,
    LOWER(lco.iso_alpha2) AS login_country_iso2,
    i.ip AS registered_ip,
    rci.name AS register_city_name,
    rst.name AS register_state_name,
    rco.name AS register_country_name,
    LOWER(rco.iso_alpha2) AS register_country_iso2,
    lt.name AS login_type,
    DATE_FORMAT(users.created, '%Y-%m-%dT%H:%i:%s') AS created,
    users.user_login_count,
    users.is_send_newsletter,
    users.last_email_notified_activity_id,
    users.owner_board_count,
    users.member_board_count,
    users.owner_organization_count,
    users.member_organization_count,
    users.language,
    CAST(users.is_ldap AS integer) AS is_ldap,
    users.timezone
   FROM users users
     LEFT JOIN ips i ON i.id = users.ip_id
     LEFT JOIN cities rci ON rci.id = i.city_id
     LEFT JOIN states rst ON rst.id = i.state_id
     LEFT JOIN countries rco ON rco.id = i.country_id
     LEFT JOIN ips li ON li.id = users.last_login_ip_id
     LEFT JOIN cities lci ON lci.id = li.city_id
     LEFT JOIN states lst ON lst.id = li.state_id
     LEFT JOIN countries lco ON lco.id = li.country_id
     LEFT JOIN login_types lt ON lt.id = users.login_type_id;


