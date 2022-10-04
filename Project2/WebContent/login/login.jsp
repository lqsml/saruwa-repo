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
		<title>로그인</title>
		<link rel="shortcut icon" href="#">
		<link rel="stylesheet" href="/style/style_Test.css">
		<script src="/source/jquery-3.6.0.min.js"></script>
		<script src="/script/login_script.js"></script>		
		<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	
	
		<!-- 헤더템플릿 -->
		<iframe src="/common/headerTmp.jsp" frameborder="0" scrolling="no"></iframe>
		<!-- 헤더템플릿 -->
		
	<div id="wrap" class="loginWrap">
		<main id="main" class="d-flex">
		
			<h1>로그인</h1>
			
			<form id="loginFrm" name="loginFrm">			
				<div id="loginArea">
					<table id="inputTbl">
						<tbody>
							<tr>
								<th>
									아이디								
								</th>
								<td>
									<input type="text" name="uId" id="uId">								
								</td>
							</tr>
							<tr>
								<th>
									비밀번호								
								</th>
								<td>
									<input type="password" name="uPw" id="uPw">								
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">							
									<button type="button" id="loginBtn">로그인</button>
								</td>
							</tr>						
						</tfoot>
					</table>
					

				</div>
				<!-- loginArea -->
				
				<div id="findArea">
					<a href="/find/findId.jsp">아이디 찾기</a>
					<span>|</span>
					<a href="/find/findPw.jsp">비밀번호 찾기</a>
					<span>|</span>
					<a href="/join/join.jsp">회원가입</a>

				</div>
				<!-- findArea -->
			</form>
		</main>	
	</div>
	<!-- div#wrap -->
		<iframe id="iframeFooter" src="/common/footerTmp.jsp" frameborder="0" scrolling="no"></iframe>
</body>
</html>