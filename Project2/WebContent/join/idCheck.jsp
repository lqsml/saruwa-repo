<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr"/>
<%
request.setCharacterEncoding("UTF-8");
String uId = request.getParameter("uId");
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
 	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="UTF-8">
		<title>아이디 중복 체크</title>
		<link rel="shortcut icon" href="#">
		<link rel="stylesheet" href="/style/style.css">
		<script src="/source/jquery-3.6.0.min.js"></script>
		<script src="/script/join_script.js"></script>	
</head>
<body>
	<div id="wrap_Popup">
		<h1><%= uId %></h1>
		<span>
		<%
		boolean chkRes = mMgr.checkID(uId);
		String btnCont = null;
		
		if(chkRes){
			out.print("는 존재하는 ID 입니다. 다른 아이디를 입력해주세요.");
			btnCont = "닫기";
		} else{
			out.print("는 사용 가능한 ID 입니다.");
			btnCont = "사용";
		}
		%>
		</span>
		<hr>
		<div id="popUpBtnArea">
			<button type="button" id="closeBtn" class="chkIdPopupBtn"><%= btnCont %></button>
		</div>
	
	</div>
</body>
</html>