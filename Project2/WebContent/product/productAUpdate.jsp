<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="pack_Product.ProductBean"%>
<% //session 연결(유지)
String uId_Session = (String)session.getAttribute("uId_Session"); 
%>
<jsp:useBean id="pMgr" class="pack_Product.ProductMgr" scope="page" />

<%
request.setCharacterEncoding("UTF-8");
int numParam = Integer.parseInt(request.getParameter("pNum"));

//목록으로 돌아가기 (현재 페이지)
String nowPage = request.getParameter("nowPage");

//조회수 증가
pMgr.upCount(numParam);
//productList.jsp에서 클릭한 게시글번호 데이터 가져오기
ProductBean Pbean = pMgr.Pboard(numParam);

int pNum = Pbean.getpNum();
String pCode = Pbean.getpCode();
String pName = Pbean.getpName();
int pOrigPrice = Pbean.getpOrigPrice();
int pDiscountR = Pbean.getpDiscountR();
int pDivi = Pbean.getpDivi();
int pSellPrice = Pbean.getpSellPrice();
int pQuan = Pbean.getpQuan();
String pTM = Pbean.getpTM();
String pSysImg = Pbean.getpSysImg();
int pSize = Pbean.getpSize();
int pReadCnt = Pbean.getpReadCnt();
String pContent = Pbean.getpContent();

%>
<!-- 카테고리 /  -->
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="/style/style_Reset.css" />
<link rel="stylesheet" href="/style/style_Template.css" />
<link rel="stylesheet" href="/style/style.css" />
<title>상품 게시글 수정하기</title>
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

		<!-- contents 영역 시작 -->
		<div id="contents" class="bbsList">
			<form id="updateFrm" action="productAUpdateProc.jsp">
				<div id="lnb">
					<!--  메인 LNB 템플릿 시작 -->
					<%@ include file="/Common/mainLnbTmp.jsp"%>
					<!--  메인 LNB 템플릿 끝 -->
				</div>
				<h2>
					<input type="text" name="pName" value="<%=pName %>"
						 />
				</h2>
				<span>조회수 : <%=pReadCnt %></span>
				<div id="productInfo">
					<p>
						상품 코드 : <input type="text" name="pCode" value="<%=pCode %>"
							 />
					</p>
					<p>
						상품 수량 : <input type="number"  name="pQuan"
							value="<%=pQuan %>" />
					</p>
					<p>
						가격 : <input type="number" name="pOrigPrice" 
							value="<%=pOrigPrice %>" />원
					</p>
					<p>
						할인율 <input type="number" name="pDiscountR"
							value="<%=pDiscountR %>" />%
					</p>
					<p>
						판매가 :<input type="number" name="pSellPrice"
							value="<%=pSellPrice %>" />
					</p>

					<br />

					<!-- 상품이미지 -->

				</div>
				<!-- div#productInfo -->

				<div id="selectCtgArea">
					<select name="pDivi" id="pDivi">
						<option value="<%=pDivi%>"></option>
						<option value="2">베이커리/떡/간식</option>
						<option value="3">반찬/냉장/김치</option>
						<option value="4">건강식품</option>
						<option value="5">정육/계란</option>
						<option value="6">간편식/조리식품</option>
						<option value="7">음료/커피/차</option>
						<option value="8">채소/과일</option>
						<option value="9">면류/장류/조미료</option>
						<option value="10">과일청/잼</option>
						<option value="11">수산/해산/건어물</option>
						<option value="12">견과/쌀</option>
						<option value="13">영유아 전용</option>
						<option value="14">비건</option>
						<option value="15">전통주</option>
					</select>
				</div>
				<!-- div#pDivi -->

				<br />

				<hr />
				<div id="contentsArea">
					<textarea name="pContent" id="pContent" cols="30" rows="10"><%=pContent %></textarea>
				</div>
				<div id="btnArea">
					<button type="button"
						onclick="location.href='/product/productList.jsp'">목록보기</button>
					<button type="submit" id="updateBtn">수정하기</button>

				</div>
				<!-- contents 영역 끝 -->

				<input type="hidden" name="pNum" value="<%=pNum %>" id="pNum">
			</form>
		</div>
		<!-- div#btnArea -->

	</main>
	<!--  footer 템플릿 -->
	<%@ include file="/Common/footerTmp.jsp"%>
	<!--  footer템플릿 -->
</body>
</html>