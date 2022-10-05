############Project01###############
###########################

create database Project01;
#drop database Project01;
use Project01;

########관리자 테이블##########
CREATE TABLE manager(
mgrID  VARCHAR(200)    NOT NULL    COMMENT '관리자아이디', 
mgrPW  VARCHAR(200)    NOT NULL    COMMENT '관리자비밀번호', 
     PRIMARY KEY (mgrID)
);

ALTER TABLE manager COMMENT '관리자 테이블';
desc manager;




##### 회원정보 테이블#########
CREATE TABLE UserInfo(
uNum 			int				NOT NULL UNIQUE AUTO_INCREMENT  COMMENT '번호',
uId       		 VARCHAR(200)    NOT NULL    COMMENT '아이디', 
uPw       	 VARCHAR(200)    NOT NULL    COMMENT '비밀번호', 
uName     	 VARCHAR(200)    NOT NULL    COMMENT '이름(실명)', 
uEmail     	 VARCHAR(200)    NOT NULL    COMMENT '이메일', 
uPhone		  NCHAR(13)			NOT NULL    COMMENT '휴대폰번호', 
zipcode   	 VARCHAR(200)       NOT NULL    COMMENT '우편번호', 
address   	 VARCHAR(200)   	NOT NULL    COMMENT '주소', 
faveFood  	VARCHAR(200)                      COMMENT '선호음식(select)', 
sa      		 int           				        COMMENT '선택약관동의여부', 
joinTM		datetime				NOT NULL		,
status		int						NOT NULL	COMMENT '회원 상태',
     PRIMARY KEY (uId)
);


### 관리자 아이디 
insert into UserInfo (uId, uPw, uName, uEmail, uPhone, zipcode, address, joinTM, status) 
				values ('admin', '1234', '관리자', 'admin@gmail.com', '010-1234-5678', '12345', '서울시', now(), 0);
                

ALTER TABLE UserInfo COMMENT '회원정보 테이블';

desc UserInfo;

select * from UserInfo order by uNum desc;
drop table UserInfo;



####### 상품 테이블 ########
CREATE TABLE Products(
pNum       		INT         		 NOT NULL    AUTO_INCREMENT unique comment '번호', 
pCode     		nchar(100)     NOT NULL    primary key COMMENT '상품고유번호', 
pName     		NCHAR(100)    NOT NULL    COMMENT '상품명', 
pOrigPrice      INT       	  	 NOT NULL    COMMENT '상품가격', 
pDiscountR  	INT       		   NOT NULL    COMMENT '할인율', 
pDivi       	INT       		   NOT NULL    COMMENT '분류', 
pSellPrice		INT					NOT NULL   COMMENT'',
pQuan 			INT    				NULL        DEFAULT 1 COMMENT'상품수량',
pTM				date            NOT NULL    COMMENT '업로드시간',
pOrigImg		VARCHAR(100)    NOT NULL    COMMENT '원본 파일이름',
pSysImg			VARCHAR(100)    NOT NULL    COMMENT '시스템 파일이름',
pSize			INT             NULL        COMMENT '파일용량',
pReadCnt		INT					NOT NULL,
pContent		text				NOT NULL COMMENT'내용'
);
#drop table Products;
ALTER TABLE Products COMMENT '상품 테이블';

desc Products;


####레시피 게시판
CREATE TABLE Recipe(
rNum       INT             NOT NULL    AUTO_INCREMENT COMMENT '번호', 
uId        VARCHAR(100)    NOT NULL    COMMENT '아이디', 
rTitle     VARCHAR(100)    NOT NULL    COMMENT '게시글 제목', 
rContent   text            NOT NULL    COMMENT '게시글 내용', 
rViewNum   int             NOT NULL    COMMENT '조회수', 
rUploadTM  date            NOT NULL    COMMENT '업로드시간', 
rOrigFile  VARCHAR(100)    NOT NULL    COMMENT '원본 파일이름', 
rSysFile   VARCHAR(100)    NOT NULL    COMMENT '파일이름', 
rFileSize  int             NULL        COMMENT '파일용량', 
PRIMARY KEY (rNum)
);

ALTER TABLE Recipe COMMENT '레시피 게시판';

ALTER TABLE Recipe
    ADD CONSTRAINT FK_Recipe_uId_UserInfo_uId FOREIGN KEY (uId)
	REFERENCES UserInfo (uId) ON DELETE RESTRICT ON UPDATE RESTRICT;



#### 문의사항 게시판 #######
CREATE TABLE QT(
qNum       INT             NOT NULL    AUTO_INCREMENT COMMENT '번호', 
uId        VARCHAR(100)    NOT NULL    COMMENT '아이디', 
qTitle     VARCHAR(100)    NOT NULL    COMMENT '개시글 제목', 
qContent   text            NOT NULL    COMMENT '게시글 내용', 
qUploadTM  date            NOT NULL    COMMENT '업로드시간', 
PRIMARY KEY (qNum, uId)
);

ALTER TABLE QT COMMENT '문의사항(1:1) 게시판';

ALTER TABLE QT
   ADD CONSTRAINT FK_QT_uId_UserInfo_uId FOREIGN KEY (uId)
   REFERENCES UserInfo (uId) ON DELETE RESTRICT ON UPDATE RESTRICT;




######장바구니 테이블##############
CREATE TABLE Cart(
 cNum   INT    NOT NULL    AUTO_INCREMENT COMMENT '번호', 
 pCode  nchar(100)    NOT NULL    COMMENT '상품고유번호', 
 cQua   INT    NULL        DEFAULT 1 COMMENT '상품수량', 
 PRIMARY KEY (cNum)
);

ALTER TABLE Cart COMMENT '장바구니 테이블';

ALTER TABLE Cart
    ADD CONSTRAINT FK_Cart_pCode_Products_pCode FOREIGN KEY (pCode)
    REFERENCES Products (pCode) ON DELETE RESTRICT ON UPDATE RESTRICT;
 
 
 
 
 
 #########찜목록##########
 CREATE TABLE heart(
hNum  INT            			 NOT NULL    AUTO_INCREMENT COMMENT '번호', 
rNum  INT             			NOT NULL    DEFAULT 1 COMMENT '레시피 게시판 번호', 
uId   VARCHAR(100)    	NOT NULL        COMMENT '아이디', 
     PRIMARY KEY (hNum, rNum)
);

ALTER TABLE heart COMMENT '찜 테이블';

ALTER TABLE heart
    ADD CONSTRAINT FK_heart_rNum_Recipe_rNum FOREIGN KEY (rNum)
	REFERENCES Recipe (rNum) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE heart
    ADD CONSTRAINT FK_heart_uId_UserInfo_uId FOREIGN KEY (uId)
    REFERENCES UserInfo (uId) ON DELETE RESTRICT ON UPDATE RESTRICT;




##########문의사항 댓글기능##########
CREATE TABLE comment_QT(
cQTNum      INT             			NOT NULL    AUTO_INCREMENT COMMENT '번호', 
uId         VARCHAR(100)    		NOT NULL        COMMENT '아이디', 
cQTDate     VARCHAR(100)    	NOT NULL        COMMENT '작성일', 
cQTContent  VARCHAR(100)    NOT NULL        COMMENT '작성글', 
qNum        INT             NOT NULL        COMMENT '부모글 번호', 
PRIMARY KEY (cQTNum)
);

ALTER TABLE comment_QT COMMENT '문의사항 댓글 기능';

ALTER TABLE comment_QT
    ADD CONSTRAINT FK_comment_QT_uId_UserInfo_uId FOREIGN KEY (uId)
    REFERENCES UserInfo (uId) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE comment_QT
    ADD CONSTRAINT FK_comment_QT_qNum_QT_qNum FOREIGN KEY (qNum)
	REFERENCES QT (qNum) ON DELETE RESTRICT ON UPDATE RESTRICT;





##########레시피 댓글기능##########
CREATE TABLE comment_R(
cRNum      INT             NOT NULL    AUTO_INCREMENT COMMENT '번호', 
uId       	 VARCHAR(100)    NOT NULL    COMMENT '아이디', 
cRDate     VARCHAR(100)    NOT NULL    COMMENT '작성일', 
cRContent  VARCHAR(100)    NOT NULL    COMMENT '작성글', 
rNum       INT             NOT NULL    COMMENT '부모글 번호', 
PRIMARY KEY (cRNum)
);

ALTER TABLE comment_R COMMENT '레시피 댓글 기능';

ALTER TABLE comment_R
    ADD CONSTRAINT FK_comment_R_uId_UserInfo_uId FOREIGN KEY (uId)
    REFERENCES UserInfo (uId) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE comment_R
    ADD CONSTRAINT FK_comment_R_rNum_Recipe_rNum FOREIGN KEY (rNum)
	REFERENCES Recipe (rNum) ON DELETE RESTRICT ON UPDATE RESTRICT;