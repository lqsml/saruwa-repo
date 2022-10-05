<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="pack_Product.ProductBean"%>
<%
//session 연결
String uId_Session = (String)session.getAttribute("uId_Session");
// String uId = (String)session.getAttribute("uId");
%>
<jsp:useBean id="pMgr" class="pack_Product.ProductMgr" scope="page" />

<%
request.setCharacterEncoding("UTF-8");
int prodNum = Integer.parseInt(request.getParameter("pNum"));

String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");

//목록으로 돌아가기 (현재 페이지)
String nowPage = request.getParameter("nowPage");

//조회수 증가
pMgr.upCount(prodNum);
//productList.jsp에서 클릭한 게시글번호 데이터 가져오기
ProductBean Pbean = pMgr.Pboard(prodNum);

int pNum = Pbean.getpNum();
String pCode = Pbean.getpCode();
String pName = Pbean.getpName();
int pOrigPrice = Pbean.getpOrigPrice();
int pDiscountR = Pbean.getpDiscountR();
String pDivi = Pbean.getpDivi();
int pSellPrice = Pbean.getpSellPrice();
int pQuan = Pbean.getpQuan();
String pTM = Pbean.getpTM();
String pSysImg = Pbean.getpSysImg();
int pReadCnt = Pbean.getpReadCnt();
String pContent = Pbean.getpContent();

session.setAttribute("Pbean", Pbean);
//세션 저장
%>
<!-- 카테고리 /  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="#">
<title>상품 상세보기</title>
<link rel="stylesheet" href="/style/style_Reset.css" />
<link rel="stylesheet" href="/style/style_Template.css" />
<link rel="stylesheet" href="/style/style.css" />
<script src="/source/jquery-3.6.0.min.js"></script>
<script src="/script/script_Template.js"></script>
<script src="/script/find_script.js"></script>
<script src="/script/script_product.js"></script>
</head>
<body>

	<!--  헤더 템플릿 -->
	<%@ include file="/Common/headerTmp.jsp"%>
	<!--  헤더 템플릿 -->

	<main id="main" class="dFlex">
		<div id="lnb">
			<!--  메인 LNB 템플릿 시작 -->
			<%@ include file="/Common/mainLnbTmp.jsp"%>
			<!--  메인 LNB 템플릿 끝 -->
		</div>

		<!-- contents 영역 시작 -->
		<div id="contents" class="bbsProduct">

			<h2><%=pName%></h2>
			<span>조회수 : <%=pReadCnt%></span>
			<div id="productInfo">
				<p>
					상품 코드 :
					<%=pCode%></p>
				<p><%=pTM%></p>
				<p>
					가격 :
					<%=pOrigPrice%>원
				</p>
				<p>
					할인율
					<%=pDiscountR%></p>
				<p>
					판매가 :<%=pSellPrice%></p>
				<br />
			</div>
			<!-- div#productInfo -->

			<div id="selectCtgArea">
				<%=pDivi%>
			</div>
			<!-- div#pDivi -->

			<br />

			<hr />
			<div id="contentsArea">
				<%=pContent%>
			</div>
			<div id="btnArea">
				<button type="button"
					onclick="location.href='/product/productList.jsp'">목록보기</button>
				<% if (uId_Session.equals(uId))  {  %>
				<button type="button" id="DelContent">삭제</button>
				<button type="button" id="UpContent">수정</button>
				<%} %>
			</div>
			<!-- div#btnArea -->

		</div>
		<!-- contents 영역 끝 -->
	</main>
	<!--  footer 템플릿 -->
	<%@ include file="/Common/footerTmp.jsp"%>
	<!--  footer템플릿 -->
</body>
</html>