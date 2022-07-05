USE SCOTT;  -- 지금부터 spring 스키마에서 작업한다.

DROP TABLE IF EXISTS FAQ;

CREATE TABLE FAQ
(
    FAQ_NO BIGINT NOT NULL AUTO_INCREMENT,
    FAQ_TITLE VARCHAR(50),
    FAQ_CONTENT VARCHAR(1500),
    FAQ_CREATED DATETIME,
    CONSTRAINT FAQ_PK PRIMARY KEY(FAQ_NO)
);
 



