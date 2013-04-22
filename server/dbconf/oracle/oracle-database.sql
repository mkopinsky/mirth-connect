CREATE TABLE SCHEMA_INFO (VERSION NUMBER(10));

CREATE SEQUENCE EVENT_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE TABLE EVENT
	(ID NUMBER(10) NOT NULL PRIMARY KEY,
	DATE_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	NAME CLOB NOT NULL,
	EVENT_LEVEL VARCHAR(40) NOT NULL,
	OUTCOME VARCHAR(40) NOT NULL,
	ATTRIBUTES CLOB,
	USER_ID NUMBER(10) NOT NULL,
	IP_ADDRESS VARCHAR(40));

CREATE TABLE CHANNEL
	(ID CHAR(36) NOT NULL PRIMARY KEY,
	NAME VARCHAR(40) NOT NULL,
	NEXT_METADATA_ID NUMBER(10) NOT NULL,
	DESCRIPTION CLOB,
	IS_ENABLED CHAR(1),
	VERSION VARCHAR(40),
	REVISION NUMBER(10),
	LAST_MODIFIED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	SOURCE_CONNECTOR CLOB,
	DESTINATION_CONNECTORS CLOB,
	PROPERTIES CLOB,
	PREPROCESSING_SCRIPT CLOB,
	POSTPROCESSING_SCRIPT CLOB,
	DEPLOY_SCRIPT CLOB,
	SHUTDOWN_SCRIPT CLOB);

CREATE TABLE CHANNEL_TAGS (
	CHANNEL_ID CHAR(36) NOT NULL,
	TAG VARCHAR(255) NOT NULL,
	CONSTRAINT CHANNEL_TAGS_PKEY PRIMARY KEY (channel_id, tag)
);

CREATE TABLE SCRIPT
	(GROUP_ID VARCHAR(40) NOT NULL,
	ID VARCHAR(40) NOT NULL,
	SCRIPT CLOB,
	PRIMARY KEY(GROUP_ID, ID));

CREATE SEQUENCE PERSON_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE TABLE PERSON
	(ID NUMBER(10) NOT NULL PRIMARY KEY,
	USERNAME VARCHAR(40) NOT NULL,
	FIRSTNAME VARCHAR(40),
	LASTNAME VARCHAR(40),
	ORGANIZATION VARCHAR(255),
	EMAIL VARCHAR(255),
	PHONENUMBER VARCHAR(40),
	DESCRIPTION VARCHAR(255),
	LAST_LOGIN TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	GRACE_PERIOD_START TIMESTAMP DEFAULT NULL,
	LOGGED_IN CHAR(1) NOT NULL);

CREATE TABLE PERSON_PASSWORD
	(PERSON_ID NUMBER(10) NOT NULL REFERENCES PERSON(ID) ON DELETE CASCADE,
	PASSWORD VARCHAR(256) NOT NULL,
	PASSWORD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE ALERT
	(ID CHAR(36) NOT NULL PRIMARY KEY,
	NAME VARCHAR(40) NOT NULL,
	IS_ENABLED CHAR(1) NOT NULL,
	EXPRESSION CLOB,
	TEMPLATE CLOB,
	SUBJECT VARCHAR(998));
	
CREATE TABLE CODE_TEMPLATE
	(ID VARCHAR(255) NOT NULL PRIMARY KEY,
	NAME VARCHAR(40) NOT NULL,
	CODE_SCOPE VARCHAR(40) NOT NULL,
	CODE_TYPE VARCHAR(40) NOT NULL,
	TOOLTIP VARCHAR(255),
	CODE CLOB);
	
CREATE TABLE CHANNEL_ALERT
	(CHANNEL_ID CHAR(36) NOT NULL,
	ALERT_ID CHAR(36) NOT NULL REFERENCES ALERT(ID) ON DELETE CASCADE);

CREATE TABLE ALERT_EMAIL
	(ALERT_ID CHAR(36) NOT NULL REFERENCES ALERT(ID) ON DELETE CASCADE,
	EMAIL VARCHAR(255) NOT NULL);

CREATE SEQUENCE CONFIGURATION_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE TABLE CONFIGURATION
	(CATEGORY VARCHAR(255) NOT NULL,
	NAME VARCHAR(255) NOT NULL,
	VALUE CLOB);

INSERT INTO PERSON (ID, USERNAME, LOGGED_IN) VALUES (PERSON_SEQUENCE.NEXTVAL, 'admin', '0');

INSERT INTO PERSON_PASSWORD (PERSON_ID, PASSWORD) VALUES(1, 'YzKZIAnbQ5m+3llggrZvNtf5fg69yX7pAplfYg0Dngn/fESH93OktQ==');

INSERT INTO SCHEMA_INFO (VERSION) VALUES (10);

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'update.url', 'http://updates.mirthcorp.com');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'update.enabled', '1');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'stats.enabled', '1');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'firstlogin', '1');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'server.resetglobalvariables', '1');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'smtp.timeout', '5000');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'smtp.auth', '0');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'smtp.secure', '0');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'server.maxqueuesize', '0');

COMMIT;
