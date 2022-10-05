<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String admin_Session = (String)session.getAttribute("uId_Session"); 
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
 	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="UTF-8">
		<title>Document</title>
		<link rel="shortcut icon" href="#">
		<link rel="stylesheet" href="/style/style.css">
		<script src="/source/jquery-3.6.0.min.js"></script>
		<script src="/script/script.js"></script>		
</head>
<body>
	<div id="wrap">
		<!-- 헤더템플릿 -->
				<% if (admin_Session != null) { %>
			        <a href="/login/logout.jsp">Logout</a>
            		|
            		<a href="#">Product</a>
            		|
            		<a href="#">Recipe</a>
            		|
            		<a href="#">CS</a>
            		|
            		<a href="/admin/memberList.jsp">Member</a>
            	<% } %>
        <!-- 헤더템플릿 -->
            		
		<main id="main">
			
		</main>
	
	</div>
</body>
</html>