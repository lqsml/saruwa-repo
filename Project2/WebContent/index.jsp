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
	<title>MainPage</title>
	<link rel="shortcut icon" href="#">
	<link rel="stylesheet" href="/style/style_Test.css">
	<script src="/source/jquery-3.6.0.min.js"></script>
</head>
<body>
	
		<!-- 헤더템플릿 -->
		<iframe src="/common/headerTmp.jsp" frameborder="0" scrolling="no"></iframe>
		<!-- 헤더템플릿 -->
	
	<div id="wrap">
		<main id="main">
		
		</main>
	</div>
	
		<!-- 푸터템플릿 -->
		<iframe src="/common/footerTmp.jsp" frameborder="0" scrolling="no"></iframe>
		<!-- 푸터템플릿 -->	
</body>
</html>