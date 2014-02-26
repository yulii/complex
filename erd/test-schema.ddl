SET SESSION FOREIGN_KEY_CHECKS=0;


/* Create Tables */

CREATE TABLE article
(
	id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	user_id int(11) unsigned NOT NULL,
	title varchar(255) NOT NULL,
	description text NOT NULL,
	status char(3) DEFAULT 'DRF' NOT NULL,
	deleted_at datetime,
	created_at datetime NOT NULL,
	updated_at datetime NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE article_tag
(
	id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	article_id bigint(20) unsigned NOT NULL,
	tag_id bigint(20) unsigned NOT NULL,
	created_at datetime NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE tag
(
	id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	name varchar(31) NOT NULL,
	created_at datetime NOT NULL,
	updated_at datetime NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE user
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	email varchar(255) NOT NULL,
	password varchar(255) NOT NULL,
	status char(3) DEFAULT 'REG' NOT NULL,
	created_at datetime NOT NULL,
	updated_at datetime NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE user_profile
(
	id int(11) unsigned NOT NULL AUTO_INCREMENT,
	user_id int(11) unsigned NOT NULL UNIQUE,
	name varchar(31) NOT NULL,
	summary text,
	created_at datetime NOT NULL,
	updated_at datetime NOT NULL,
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE article_tag
	ADD FOREIGN KEY (article_id)
	REFERENCES article (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE article_tag
	ADD FOREIGN KEY (tag_id)
	REFERENCES tag (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE article
	ADD FOREIGN KEY (user_id)
	REFERENCES user (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE user_profile
	ADD FOREIGN KEY (user_id)
	REFERENCES user (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



