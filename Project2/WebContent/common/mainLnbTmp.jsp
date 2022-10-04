<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("UTF-8");

String gnbParam = "";
if (request.getParameter("gnbParam") != null) {
	gnbParam = request.getParameter("gnbParam");
}

%>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LNB Template</title>
<link rel="stylesheet" href="/style/style_Template.css">
<script src="/script/jquery-3.6.0.min.js"></script>
<script src="/script/script_Template.js"></script>
</head>
<body>
   <nav id="mainLNB">
        <hr class="sepLine">

		<ul id="lnbMainMenu">		 
    	<% if (gnbParam.equals("myPage")) {%>
            <li class="lnbMainLi"><a href="#">스크랩한 게시물</a></li>
            <li class="lnbMainLi"><a href="#">장바구니</a></li>
			<li class="lnbMainLi"><a href="#">주문내역</a></li>
			<li class="lnbMainLi"><a href="mypage/infoMod.jsp">회원정보수정</a></li>
			<li class="lnbMainLi"><a href="mypage/memberQuit.jsp">회원탈퇴</a></li>

		<% } else if(gnbParam.equals("store")) { %> 		     		 
            <li class="lnbMainLi"><a href="">베이커리&#47;떡&#47;간식</a></li>
            <li class="lnbMainLi"><a href="">반찬&#47;냉장&#47;김치</a></li>
            <li class="lnbMainLi"><a href="">건강식품</a></li>
            <li class="lnbMainLi"><a href="">정육&#47;계란</a></li>
            <li class="lnbMainLi"><a href="">간편식&#47;조리식품</a></li>
            <li class="lnbMainLi"><a href="">음료&#47;커피&#47;차</a></li>
            <li class="lnbMainLi"><a href="">채소&#47;과일</a></li>
            <li class="lnbMainLi"><a href="">면류&#47;장류&#47;조미료</a></li>
            <li class="lnbMainLi"><a href="">과일청&#47;잼</a></li>
            <li class="lnbMainLi"><a href="">수산&#47;해산&#47;건어물</a></li>
            <li class="lnbMainLi"><a href="">견과&#47;쌀</a></li>
            <li class="lnbMainLi"><a href="">영유아 전용</a></li>
            <li class="lnbMainLi"><a href="">비건</a></li>
            <li class="lnbMainLi"><a href="">전통주</a></li>

    	<% } else if(gnbParam.equals("recipe")) {%>  		     		 
            <li class="lnbMainLi"><a href="">메인요리</a></li>
            <li class="lnbMainLi"><a href="">밑반찬</a></li>
            <li class="lnbMainLi"><a href="">간식</a></li>
            <li class="lnbMainLi"><a href="">간단요리</a></li>
            <li class="lnbMainLi"><a href="">초대요리</a></li>
            <li class="lnbMainLi"><a href="">채식</a></li>
            <li class="lnbMainLi"><a href="">한식</a></li>
            <li class="lnbMainLi"><a href="">양식</a></li>
            <li class="lnbMainLi"><a href="">일식</a></li>
            <li class="lnbMainLi"><a href="">중식</a></li>
            <li class="lnbMainLi"><a href="">퓨전</a></li>
            <li class="lnbMainLi"><a href="">분식</a></li>
            <li class="lnbMainLi"><a href="">안주</a></li>
            <li class="lnbMainLi"><a href="">베이킹</a></li>

    	<% } else if(gnbParam.equals("community")) { %>  		     		 
            <li class="gnbSubLi"><a href="">자주 묻는 질문</a></li>
            <li class="gnbSubLi"><a href="">1:1 문의 게시판</a></li>
            <li class="gnbSubLi"><a href="">자유 게시판</a></li>
    	<% } %>   		 		
		</ul>
        <hr class="sepLine">
	</nav>
</body>
</html>