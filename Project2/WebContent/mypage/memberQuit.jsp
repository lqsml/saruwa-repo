<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String uId_Session = (String)session.getAttribute("uId_Session"); 
%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr"/>
<jsp:useBean id="mBean" class="pack_Member.MemberBean"/>
<%
mBean = mMgr.getMemberData(uId_Session);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link rel="shortcut icon" href="#">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/style/style.css">
<script src="/source/jquery-3.6.0.min.js"></script>
<script src="/script/join_script.js"></script>
</head>
<body>
	<div id="wrap">

		<!-- 헤더 영역 시작 -->
		<jsp:include page="/Common/headerTmp.jsp"/>
		<!-- 헤더 영역 끝  -->
		<h1>회원 탈퇴</h1>
		<hr>
		<main id="main">
			<form name="quitFrm" id="quitFrm">
				<div id="quitArea" >
					<div id="infoInput" class="d-flex">
						<p>회원 탈퇴를 위해 아이디와 비밀번호를 입력해주세요.</p>
						<div id="uIdInput">
							아이디 <input type="text" name="uId" id="uId">						
						</div>
						<div id="uPwInput">
							비밀번호 <input type="password" name="uPw" id="uPw">						
						</div>
					</div> 
					<div id="btnArea">
						<button type="button" id="quitBtn">회원 탈퇴</button>
					</div>
				</div>
			</form>
		</main>

	</div>
</body>
</html>