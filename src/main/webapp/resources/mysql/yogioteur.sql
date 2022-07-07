USE SCOTT;

-- MEMBER
--DROP TABLE IF EXISTS MEMBER_LOG;
--DROP TABLE IF EXISTS SIGN_OUT_MEMBER;
--DROP TABLE IF EXISTS MEMBER;

CREATE TABLE MEMBER_LOG (
    MEMBER_LOG_NO	BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	MEMBER_ID	    VARCHAR(32)	NOT NULL,
	SIGN_UP     	DATE   -- 로그인 일시
);

CREATE TABLE SIGN_OUT_MEMBER (
	SIGN_OUT_NO	BIGINT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
	MEMBER_NO	BIGINT	NOT NULL,           
	ID	        VARCHAR(32) NOT NULL UNIQUE,
	NAME	    VARCHAR(80),
	EMAIL	    VARCHAR(100),
    AGREE_STATE	BIGINT,         -- 동의여부
    SIGN_IN	    DATE,     		-- 가입일
	SIGN_OUT	DATE 			-- 탈퇴일
);

CREATE TABLE MEMBER (
	MEMBER_NO	        BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	MEMBER_NAME 	    VARCHAR(80)	NOT NULL,
	MEMBER_EMAIL	    VARCHAR(100)	NOT NULL UNIQUE,
	MEMBER_ID	        VARCHAR(32)	NOT NULL UNIQUE,
	MEMBER_PW	        VARCHAR(64)	NOT NULL,
	MEMBER_PHONE	    VARCHAR(30),
	MEMBER_BIRTH	    VARCHAR(20),
    MEMBER_GENDER       VARCHAR(20),
    MEMBER_PROMO_ADD    VARCHAR(20),  -- 광고수신여부 
    MEMBER_POST_CODE    VARCHAR(20),  -- 우편번호
    MEMBER_ROAD_ADDR    VARCHAR(300), -- 주소
	AGREE_STATE	        INT,
	SIGN_IN	    		DATE
);

ALTER TABLE MEMBER_LOG ADD CONSTRAINT MEMBER_LOG_MEMBER_FK
    FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID) 
          ON DELETE CASCADE;

-- 트리거
DELIMITER $$
	CREATE TRIGGER SIGN_OUT_TRIGGER
    AFTER DELETE
    ON MEMBER
    FOR EACH ROW
	BEGIN
		INSERT INTO SIGN_OUT_MEMBER
			(MEMBER_NO, ID, NAME, EMAIL, AGREE_STATE, SIGN_IN)
		VALUES
			(OLD.MEMBER_NO, OLD.MEMBER_ID, OLD.MEMBER_NAME, OLD.MEMBER_EMAIL, OLD.AGREE_STATE, OLD.SIGN_IN);
	END $$
DELIMITER ;


-- NAVER_MEMBER
--DROP TABLE IF EXISTS NAVER_MEMBER_LOG;
--DROP TABLE IF EXISTS NAVER_MEMBER;

CREATE TABLE NAVER_MEMBER (
	NAVER_NO BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,	
    NAVER_ID  VARCHAR(80),
    NAVER_NAME VARCHAR(50),
    NAVER_EMAIL   VARCHAR(50),
    NAVER_GENDER  VARCHAR(20),
    NAVER_PHONE   VARCHAR(30)  
);

CREATE TABLE NAVER_MEMBER_LOG (
	NAVER_NO BIGINT,
    NAVER_LOG_DATE DATE
);

ALTER TABLE NAVER_MEMBER_LOG ADD CONSTRAINT NAVER_MEMBER_LOG_NAVER_MEMBER_FK
    FOREIGN KEY(NAVER_NO) REFERENCES NAVER_MEMBER(NAVER_NO) 
          ON DELETE CASCADE;


-- RESERVATION
--DROP TABLE IF EXISTS RESERVATION;
--DROP TABLE IF EXISTS PAYMENTS;
--DROP TABLE IF EXISTS PRICE;

CREATE TABLE RESERVATION
(
    RESER_NO VARCHAR(15) NOT NULL PRIMARY KEY,
    MEMBER_NO BIGINT NOT NULL,
    ROOM_NO BIGINT NOT NULL,
    RESER_CHECKIN VARCHAR(10),
    RESER_CHECKOUT VARCHAR(10),
    RESER_PEOPLE INT NOT NULL,
    RESER_FOOD INT,
    RESER_STATUS INT NOT NULL,
    RESER_REQUEST VARCHAR(50)
);

CREATE TABLE PRICE
(
    PRICE_NO VARCHAR(15),
    TOTAL_PRICE INT,
    ROOM_PRICE INT,
    FOOD_PRICE INT,
    TIP_PRICE INT
);

CREATE TABLE PAYMENTS
(
    RESER_NO VARCHAR(15) NOT NULL,
    IMP_UID VARCHAR(100) NOT NULL,
    RESPONSE VARCHAR(10),
    AMOUNT INT
);

ALTER TABLE RESERVATION ADD CONSTRAINT RESERVATION_MEMBER_FK
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO);

ALTER TABLE PRICE ADD CONSTRAINT PRICE_FK
    FOREIGN KEY(PRICE_NO) REFERENCES RESERVATION(RESER_NO)
        ON DELETE CASCADE; 


-- ROOM
-- DROP TABLE IF EXISTS IMAGE;
-- DROP TABLE IF EXISTS ROOM;
-- DROP TABLE IF EXISTS ROOM_TYPE;

CREATE TABLE ROOM_TYPE (
	RT_NO	BIGINT	NOT NULL PRIMARY KEY,
	RT_TYPE	VARCHAR(30)	NOT NULL,
	RT_MAX	BIGINT	NOT NULL
);

CREATE TABLE ROOM (
	ROOM_NO BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	RT_NO	BIGINT	NOT NULL,
	ROOM_NAME	VARCHAR(300)	NOT NULL,
	ROOM_STATUS	INT	NOT NULL,
	ROOM_CHECKIN	DATE	NULL,
	ROOM_CHECKOUT	DATE	NULL,
    ROOM_PRICE INT NOT NULL
);

CREATE TABLE IMAGE (
	IMAGE_NO BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ROOM_NO	BIGINT NOT NULL,
	IMAGE_PATH	VARCHAR(300) NOT NULL,
	IMAGE_SAVED	VARCHAR(40) NOT NULL,
	IMAGE_ORIGIN VARCHAR(300) NOT NULL
);

ALTER TABLE RESERVATION ADD CONSTRAINT RESERVATION_ROOM_FK
	FOREIGN KEY (ROOM_NO) REFERENCES ROOM (ROOM_NO)
		ON DELETE CASCADE;

ALTER TABLE ROOM ADD CONSTRAINT ROOM_ROOM_TYPE_FK
	FOREIGN KEY (RT_NO)	REFERENCES ROOM_TYPE (RT_NO)
		ON DELETE CASCADE;

ALTER TABLE IMAGE ADD CONSTRAINT IMAGE_ROOM_FK
	FOREIGN KEY (ROOM_NO) REFERENCES ROOM (ROOM_NO)
		ON DELETE CASCADE;

INSERT INTO ROOM_TYPE(RT_NO, RT_TYPE, RT_MAX)
VALUES (1, 'SINGLE', 1);
INSERT INTO ROOM_TYPE(RT_NO, RT_TYPE, RT_MAX)
VALUES (2, 'DOUBLE', 2);
INSERT INTO ROOM_TYPE(RT_NO, RT_TYPE, RT_MAX)
VALUES (3, 'TWIN', 2);


-- QNA
-- DROP TABLE IF EXISTS QNA_REPLY;
-- DROP TABLE IF EXISTS QNA;

CREATE TABLE QNA
(
    QNA_NO BIGINT NOT NULL AUTO_INCREMENT,
    MEMBER_ID VARCHAR(32) NOT NULL,
    MEMBER_NAME VARCHAR(100) NOT NULL,
    QNA_TITLE VARCHAR(100) NOT NULL,
    QNA_CONTENT VARCHAR(1500),
    QNA_HIT INT ,
    QNA_CREATED DATETIME,
    QNA_MODIFIED DATETIME,
    CONSTRAINT QNA_PK PRIMARY KEY(QNA_NO)
);

CREATE TABLE QNA_REPLY
(
    QNA_REPLY_NO BIGINT NOT NULL AUTO_INCREMENT,
    QNA_NO BIGINT NOT NULL,
    MEMBER_ID VARCHAR(32) NOT NULL,
    MEMBER_NAME VARCHAR(100) NOT NULL,
    QNA_REPLY_TITLE VARCHAR(100),
    QNA_REPLY_CONTENT VARCHAR(1500),
    QNA_REPLY_CREATED DATETIME,
    QNA_REPLY_STATE INT,
    QNA_REPLY_DEPTH INT,
    QNA_REPLY_GROUP_NO BIGINT,
    QNA_REPLY_GROUP_ORD INT,
    CONSTRAINT QNA_REPLY_NO_PK PRIMARY KEY(QNA_REPLY_NO)
);

ALTER TABLE QNA_REPLY 
	ADD CONSTRAINT QNA_REPLY_QNA_FK
		FOREIGN KEY(QNA_NO) REFERENCES QNA(QNA_NO)
			ON DELETE CASCADE;


-- REVIEW
-- DROP TABLE IF EXISTS RE_IMAGE;
-- DROP TABLE IF EXISTS REVIEW_REPLY;
-- DROP TABLE IF EXISTS REVIEW;

CREATE TABLE REVIEW
(
    REVIEW_NO BIGINT NOT NULL AUTO_INCREMENT,
    MEMBER_ID VARCHAR(32) NOT NULL,
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


-- FAQ
-- DROP TABLE IF EXISTS FAQ;

CREATE TABLE FAQ
(
    FAQ_NO BIGINT NOT NULL AUTO_INCREMENT,
    FAQ_TITLE VARCHAR(50),
    FAQ_CONTENT VARCHAR(1500),
    FAQ_CREATED DATETIME,
    CONSTRAINT FAQ_PK PRIMARY KEY(FAQ_NO)
);
 
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (1,'체크인과 체크아웃 시간은 언제입니까?','체크인 시간은 14:00이며, 체크아웃시간은 11:00입니다',NOW());
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (2,'예약 취소는 언제까지 가능한가요?','일반 예약은 체크인 하루전 14:00시 이전까지 연락주시면 별도의 요금 지불 없이 취소 가능합니다.',NOW());
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (3,'호텔 객실 내에서 인터넷 사용이 가능 한가요?','YOGIOTERU호텔에서는 전 객실 내에서 유선, 무선 인터넷 사용이 무료로 이용 가능 합니다.',NOW());
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (4,'주차는 어디서 해야하나요?','호텔 내부의 지하주차장(지하3층 ~지하 7층)이 별도로 마련되어 있습니다.',NOW());
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (5,'레스토랑 운영시간은 어떻게 되나요?','조식 6:30~10:00, 중식 11:00~14:00, 석식 17:00~20:00 로 운영되고 있습니다',NOW());
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (6,'대관 및 행사 문의','대관 및 행사에 대한 문의는 010-1234-5678으로 전화주시면 자세한 안내를 도와드리겠습니다',NOW());
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (7,'외부 배달 음식을 주문해도 되나요?','호텔 규정 상 외부 배달 음식은 주문하실 수 없습니다',NOW());
    
COMMIT;