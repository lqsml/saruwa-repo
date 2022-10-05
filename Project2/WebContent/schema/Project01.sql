############Project01###############
###########################

create database Project01;
#drop database Project01;

use Project01;

##### 회원정보 테이블#########
create table UserInfo(
uNum         int               auto_increment    unique,
uId              varchar(200)    primary key    comment '아이디', 
uPw           varchar(200)    not null    comment '비밀번호', 
uName         varchar(200)    not null    comment '이름(실명)', 
uEmail         varchar(200)    not null    comment '이메일', 
uPhone        nchar(13)         not null    comment '휴대폰번호', 
address      varchar(200)      not null    comment '주소', 
zipcode       int                     not null    comment '우편번호', 
faveFood      char(10)                    null        comment '선호음식(select)', 
sa             int                   null        comment '선택약관동의여부',
joinTM      datetime         not null,
status         int            not null
);

alter table UserInfo comment '회원정보 테이블';

insert into UserInfo (uId, uPw, uName, uEmail, uPhone, zipcode, address, joinTM, status)
			 values ('sample', '1234', '샘플', 'sample@gmail.com', '010-1234-5678', '12345', '서울시', now(), 1);

### 관리자 아이디 
insert into UserInfo (uId, uPw, uName, uEmail, uPhone, zipcode, address, joinTM, status) 
            values ('admin', '1234', '관리자', 'admin@gmail.com', '010-1234-5678', '12345', '서울시', now(), 0);
                

desc UserInfo;

select * from UserInfo order by uNum desc;
#drop table UserInfo;

####### 상품 테이블 ########
create table Products(
pNum             int             not null    auto_increment unique comment '번호',
uId            nchar(100)      , 
pCode           nchar(100)       not null    primary key comment '상품고유번호', 
pName           NCHAR(100)       not null    comment '상품명', 
pOrigPrice      int                not null    comment '상품가격', 
pDiscountR     int              not null    comment '할인율', 
pDivi           nchar(50)              not null    comment '분류', 
pSellPrice      int             not null    comment'',
pQuan          int             null        DEFAULT 1 comment'상품수량',
pTM            date             not null    comment '업로드시간',
pOrigImg      varchar(100)    null        comment '원본 파일이름',
pSysImg         varchar(100)    null       comment '시스템파일이름',
pSize         int             null        comment '파일용량',
pReadCnt      int             not null,
pContent      text          not null    comment'내용'
);
#drop table Products;
alter table Products comment '상품 테이블';

desc Products;

insert into Products (pCode, pName, pOrigPrice, pDiscountR, pDivi, pSellPrice, pQuan, pTM,  pSysImg, pOrigImg, pSize, pReadCnt, pContent)
values ('k136','마라샹궈', 123, 123, 1, 123, 12, now(), 'qwer', 'qwer', 1234, 0,'asdfkjklasjfkalsjdkflj');

select * from Products order by pNum desc;

####레시피 게시판
create table Recipe(
rNum       int             not null    auto_increment comment '번호', 
uId        varchar(100)    not null    comment '아이디', 
rTitle     varchar(100)    not null    comment '게시글 제목', 
rContent   text            not null    comment '게시글 내용', 
rViewNum   int             not null    comment '조회수', 
rUploadTM  date            not null    comment '업로드시간', 
rRef         int         not null,
rPos         int         not null,
rDepth      int         not null,
rOrigFile  varchar(100)    not null    comment '원본 파일이름', 
rSysFile   varchar(100)    not null    comment '파일이름', 
rFileSize  int            null        comment '파일용량', 
PRIMARY KEY (rNum)
);

alter table Recipe comment '레시피 게시판';

alter table Recipe
    add constraint FK_Recipe_uId_UserInfo_uId foreign key (uId)
   references UserInfo (uId) on update restrict on delete restrict;


#### 문의사항 게시판 #######
create table QT(
qNum       int             not null    auto_increment comment '번호', 
uId        varchar(100)    not null    comment '아이디', 
#uName     varchar(100)   not null  comment '작성자 이름',
qTitle     varchar(100)    not null    comment '게시글 제목', 
qContent   text            not null   comment '게시글 내용',
qRef         int            not null,
qPos         int            not null,
qDepth      int            not null,
qUploadTM  date            not null    comment '업로드시간', 
PRIMARY KEY (qNum, uId)
);

alter table QT comment '문의사항(1:1) 게시판';

alter table QT
   add constraint FK_QT_uId_UserInfo_uId foreign key (uId)
   references UserInfo (uId) on update restrict on delete restrict;

#alter table QT
  # add constraint FK_QT_uName_UserInfo_uName foreign key (uName)
   # references UserInfo (uName) on update restrict on delete restrict;




######장바구니 테이블##############
create table Cart(
 cNum   int    not null    auto_increment comment '번호', 
 pCode  nchar(100)    not null    comment '상품고유번호', 
 cQua   int   null        DEFAULT 1 comment '상품수량', 
 PRIMARY KEY (cNum)
);

alter table Cart comment '장바구니 테이블';

alter table Cart
    add constraint FK_Cart_pCode_Products_pCode foreign key (pCode)
    references Products (pCode) on update restrict on delete restrict;
 
 
 
 
 
 #########찜목록##########
 create table Heart(
hNum  int                      not null    auto_increment comment '번호', 
rNum  int                      not null    DEFAULT 1 comment '레시피 게시판 번호', 
uId   varchar(100)       not null        comment '아이디', 
     PRIMARY KEY (hNum, rNum)
);

alter table heart comment '찜 테이블';

alter table heart
    add constraint FK_heart_rNum_Recipe_rNum foreign key (rNum)
   references Recipe (rNum) on update restrict on delete restrict;

alter table heart
    add constraint FK_heart_uId_UserInfo_uId foreign key (uId)
    references UserInfo (uId) on update restrict on delete restrict;



###########FAQ 게시판#############
create table Faq(
fNum         int             auto_increment unique,
uId            varchar(100)      not null ,
#uName     varchar(100)   not null  comment '작성자 이름',
fTitle         varchar(100)      not null,
fContent   text                  not null
);

alter table Faq
   add constraint FK_Faq_uId_UserInfo_uId foreign key (uId) references UserInfo(uId)
    on update restrict on delete restrict;

#desc Faq;


insert into Faq value(1,'하하','asdf','asdf',now());
insert into Faq value(2,'하하','aㅁㄴㅇㄹdf','asdf',now());

select * from Faq order by fNum desc;