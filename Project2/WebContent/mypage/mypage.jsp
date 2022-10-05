<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String uId_Session = (String)session.getAttribute("uId_Session"); 
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
 	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="UTF-8">
		<title>Document</title>
		<link rel="shortcut icon" href="#">
		<link rel="stylesheet" href="/style/style_MyPage.css">
		<script src="/source/jquery-3.6.0.min.js"></script>
		<script src="/script/script.js"></script>		
</head>
<body>
	<div id="wrap">
	
		<!-- 헤더템플릿 -->
		<jsp:include page="/common/headerTmp.jsp"/>
		<!-- 헤더템플릿 -->
		
		<main id="main" class="dFLex">
			
			<div id="lnbArea">
				<ul>
					<li><a href="/mypage/infoMod.jsp">회원 정보 수정</a></li>
					<li><a href="#">게시물 스크랩</a></li>
					<li><a href="#">찜 목록</a></li>
					<li><a href="#">1:1 질문</a></li>
					<li><a href="/mypage/memberQuit.jsp">회원 탈퇴</a></li>
				</ul>
			</div>
			<!-- div#lnbArea -->
			
		</main>
		<!-- main#main -->
	</div>
	<!-- div#wrap -->
</body>
</html>