<%@page import="pack_Member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String uId_Session = (String)session.getAttribute("uId_Session"); 
%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr"/>
<jsp:useBean id="mBean" class="pack_Member.MemberBean"/>
<jsp:setProperty name="mBean" property="*"/>
<%
boolean modRes = mMgr.modifyInfo(mBean, uId_Session);
%>

<script>
<% if(modRes){ %>
	alert("회원정보 수정이 완료되었습니다.");
	location.href="/index.jsp";
<% } else{ %>
	alert("회원정보 수정 처리 중 문제가 발생헀습니다. 고객센터로 문의주세요.");
	history.back();
<% } %>

</script>
