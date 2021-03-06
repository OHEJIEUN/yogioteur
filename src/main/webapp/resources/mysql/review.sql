CREATE TABLE REVIEW
(
    REVIEW_NO BIGINT NOT NULL AUTO_INCREMENT,
    MEMBER_ID VARCHAR(500) NOT NULL,
    MEMBER_NAME VARCHAR(100) NOT NULL,
    RT_TYPE	  VARCHAR(30)		NOT NULL,
    ROOM_NAME	VARCHAR(30)		NOT NULL,
    REVIEW_TITLE VARCHAR(100) NOT NULL,
    REVIEW_CONTENT VARCHAR(1500),
    REVIEW_CREATED DATETIME,
    REVIEW_MODIFIED DATETIME,
    REVIEW_REV_NO INT,
    CONSTRAINT REVIEW_PK PRIMARY KEY(REVIEW_NO)
);
CREATE TABLE REVIEW_REPLY
(
    REPLY_NO BIGINT NOT NULL AUTO_INCREMENT,
    REVIEW_NO BIGINT NOT NULL,
    REPLY_CONTENT VARCHAR(1500) NOT NULL,
    REPLY_CREATED DATETIME,
    REPLY_MODIFIED DATETIME,
	CONSTRAINT REVIEW_REPLY_PK PRIMARY KEY(REPLY_NO)
);

CREATE TABLE RE_IMAGE
(
    RE_IMAGE_NO BIGINT NOT NULL AUTO_INCREMENT,
    REVIEW_NO BIGINT NOT NULL,
    RE_IMAGE_PATH VARCHAR(300),
    RE_IMAGE_SAVED VARCHAR(40),
    RE_IMAGE_ORIGIN VARCHAR(300),
	CONSTRAINT RE_IMAGE PRIMARY KEY(RE_IMAGE_NO)
);

ALTER TABLE REVIEW_REPLY 
    ADD CONSTRAINT REVIEW_REPLY_REVIEW_FK 
		FOREIGN KEY(REVIEW_NO) REFERENCES REVIEW(REVIEW_NO) 
				ON DELETE CASCADE;
        
ALTER TABLE RE_IMAGE
    ADD CONSTRAINT RE_IMAGE_REVIEW_FK 
		FOREIGN KEY(REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
			ON DELETE CASCADE;