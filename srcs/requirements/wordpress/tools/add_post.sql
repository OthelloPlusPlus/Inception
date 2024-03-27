-- wp_posts
-- +-----------------------+---------------------+------+-----+---------------------+----------------+
-- | Field                 | Type                | Null | Key | Default             | Extra          |
-- +-----------------------+---------------------+------+-----+---------------------+----------------+
-- | ID                    | bigint(20) unsigned | NO   | PRI | NULL                | auto_increment |
-- | post_author           | bigint(20) unsigned | NO   | MUL | 0                   |                |
-- | post_date             | datetime            | NO   |     | 0000-00-00 00:00:00 |                |
-- | post_date_gmt         | datetime            | NO   |     | 0000-00-00 00:00:00 |                |
-- | post_content          | longtext            | NO   |     | NULL                |                |
-- | post_title            | text                | NO   |     | NULL                |                |
-- | post_excerpt          | text                | NO   |     | NULL                |                |
-- | post_status           | varchar(20)         | NO   |     | publish             |                |
-- | comment_status        | varchar(20)         | NO   |     | open                |                |
-- | ping_status           | varchar(20)         | NO   |     | open                |                |
-- | post_password         | varchar(255)        | NO   |     |                     |                |
-- | post_name             | varchar(200)        | NO   | MUL |                     |                |
-- | to_ping               | text                | NO   |     | NULL                |                |
-- | pinged                | text                | NO   |     | NULL                |                |
-- | post_modified         | datetime            | NO   |     | 0000-00-00 00:00:00 |                |
-- | post_modified_gmt     | datetime            | NO   |     | 0000-00-00 00:00:00 |                |
-- | post_content_filtered | longtext            | NO   |     | NULL                |                |
-- | post_parent           | bigint(20) unsigned | NO   | MUL | 0                   |                |
-- | guid                  | varchar(255)        | NO   |     |                     |                |
-- | menu_order            | int(11)             | NO   |     | 0                   |                |
-- | post_type             | varchar(20)         | NO   | MUL | post                |                |
-- | post_mime_type        | varchar(100)        | NO   |     |                     |                |
-- | comment_count         | bigint(20)          | NO   |     | 0                   |                |
-- +-----------------------+---------------------+------+-----+---------------------+----------------+

INSERT INTO wordpress_db.wp_posts
(
	-- Primary Key
	ID,
	-- Mandatory Cells
	post_title,
	post_content,
	post_excerpt,
	to_ping,
	pinged,
	post_content_filtered
	-- Optional Cells
)
VALUES
(
	-- Primary Key
	23,
	-- Mandatory Cells
	'Docker Default Post',
	'This post has been generated during docker container initialisitation.<br>
	Feel free to add some comments to this.<br>
	Additionally you can create new posts using the <a href="wp-admin/" target="_blank">dashboard</a>',
	'Added post',
	NOW(),
	NOW(),
	''
	-- Optional Cells
)
ON DUPLICATE KEY UPDATE post_title = 'Unique Docker Default Post';

-- wp_comments
-- +----------------------+---------------------+------+-----+---------------------+----------------+
-- | Field                | Type                | Null | Key | Default             | Extra          |
-- +----------------------+---------------------+------+-----+---------------------+----------------+
-- | comment_ID           | bigint(20) unsigned | NO   | PRI | NULL                | auto_increment |
-- | comment_post_ID      | bigint(20) unsigned | NO   | MUL | 0                   |                |
-- | comment_author       | tinytext            | NO   |     | NULL                |                |
-- | comment_author_email | varchar(100)        | NO   | MUL |                     |                |
-- | comment_author_url   | varchar(200)        | NO   |     |                     |                |
-- | comment_author_IP    | varchar(100)        | NO   |     |                     |                |
-- | comment_date         | datetime            | NO   |     | 0000-00-00 00:00:00 |                |
-- | comment_date_gmt     | datetime            | NO   | MUL | 0000-00-00 00:00:00 |                |
-- | comment_content      | text                | NO   |     | NULL                |                |
-- | comment_karma        | int(11)             | NO   |     | 0                   |                |
-- | comment_approved     | varchar(20)         | NO   | MUL | 1                   |                |
-- | comment_agent        | varchar(255)        | NO   |     |                     |                |
-- | comment_type         | varchar(20)         | NO   |     | comment             |                |
-- | comment_parent       | bigint(20) unsigned | NO   | MUL | 0                   |                |
-- | user_id              | bigint(20) unsigned | NO   |     | 0                   |                |
-- +----------------------+---------------------+------+-----+---------------------+----------------+

INSERT INTO wordpress_db.wp_comments
(
	-- Primary Key
	comment_ID,
	-- Mandatory Cells
	comment_author,
	comment_content,
	-- Optional Cells
	comment_post_ID,
	comment_approved,
	comment_date
)
VALUES
(
	2,
	'Docker',
	'Hello there.',
	23,
	'1',
	NOW()
)
ON DUPLICATE KEY UPDATE comment_author = 'Docker';
