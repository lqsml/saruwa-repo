<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer template</title>
<link rel="stylesheet" href="/style/style_Template.css">
<script src="/script/jquery-3.6.0.min.js"></script>
<script src="/script/script_Template.js"></script>
</head>
<body>
    <hr class="sepLine">
	<footer id="footer" class="dFlex">
        <div id="footer-left">
            <div id="csInfo">
                <h1>고객센터</h1>
                <button class="csButton" onclick="location.href='/bbs/qnaList.jsp'">1:1 문의 게시판</button>
                <button class="csButton" id="click">채널톡 상담</button>
                <p id="click">
                    운영시간&nbsp;&nbsp;9:00~18:00 (주말,공휴일 제외)
                </p>
                <p>
                    전화상담&nbsp;&nbsp;1234-1234
                </p>
            </div>
            <!-- div#csInfo -->
        </div>
        <!-- footer-left -->
        <div id="footer-right">
            <div id="corpInfo">
                <h1>프로젝트 SARUWA</h1>
                <p>김성하 신미애 이승민</p> 
                <p>전화 : 1234-1234</p>
                <p>주소 : 서울시 서대문구 신촌로 141 은하빌딩 201호</p>
            </div>
            <!-- div#corpInfo -->
            <div id="copyright">
                &copy; SARUWA CORP.ALL RIGHTS RESERVED
            </div>
        </div>
        <!-- footer-right -->
        <div id="footer-logo">
        	<img src="../images/logo-saruwa.png" alt="logo" style="width: 200px;">
        </div>
    </footer>
    <!-- footer#footer -->
</body>
</html>