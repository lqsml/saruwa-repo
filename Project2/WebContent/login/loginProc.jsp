<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="mMgr" class="pack_Member.MemberMgr"/>

<%
request.setCharacterEncoding("UTF-8");
String uId = request.getParameter("uId");
String uPw = request.getParameter("uPw");
boolean loginRes = mMgr.memberLogin(uId, uPw);
int status = mMgr.chkStatus(uId, uPw);

%>

<script>
<% if(loginRes){ 
	session.setAttribute("uId_Session", uId);
		if(status == 1){
%>
			location.href = "/index.jsp";
<%
		} else if (status == 0){
%>
			location.href = "/admin/admIndex.jsp";
<%
		}
%>
	
<% } else if (!loginRes){ %>
	alert("아이디 또는 비밀번호를 확인해주세요.");
	location.href = "/login/login.jsp";
<% } %>

</script>