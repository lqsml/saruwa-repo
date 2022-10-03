<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
   		<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>회원가입</title>
		<link rel="shortcut icon" href="#">
		<link rel="stylesheet" href="/style/style.css">
		<script src="/source/jquery-3.6.0.min.js"></script>
		<script src="/script/script_Join.js"></script>		
</head>
<body>
	<h1>회원가입</h1>
	<div id="wrap">

		<!-- 헤더 영역 시작 -->

		<!-- 헤더 영역 끝  -->

		<main id="main">
			<form name="joinFrm" id="joinFrm">
				<table id="joinFrmTbl">
					<tbody>
						<tr>
							<th class="req">아이디</th>
							<td><input type="text" name="uId" id="uId" maxlength="20"
								autofocus >
								<button type="button" id="idChkBtn">중복확인</button></td>
							<td><span>영어 대소문자, 숫자 조합, 5~20</span></td>
						</tr>
						<tr>
							<th class="req">비밀번호</th>
							<td>
								<input type="text" name="uPw" id="uPw" maxlength="20">
							</td>
							<td><span>영어 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자</span></td>
						</tr>
						<tr>
							<th class="req">비밀번호 확인</th>
							<td>
								<input type="password" name="upwRe" id="upwRe" maxlength="20">
							</td>
							<td>
								<span id="upwChk">여기에 일치하지 않음 표시</span>
							</td>
						</tr>
						<tr>
							<th class="req">이름</td>
							<td>
								<input type="text" id="uName" name="uName">
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th class="req">이메일</th>
							<td>
	    							<input type="text" id="uEmail_01"
    									maxlength="20" size="7">
    								<span>@</span>
    								<input type="text" id="uEmail_02"
    									maxlength="40" size="10">
    									
    								<select id="emailDomain" class="frmDropMenu">
    									<option value="">직접입력</option>
    									<option>naver.com</option>
    									<option>gmail.com</option>
    								</select>
    								
    								<button type="button" id="emailAuthBtn" class="frmBtn">인증코드받기</button>
    								
    								<!--  이메일 인증 영역 시작 : Authentication Code 인증코드-->
    								<div id="emailAuthArea">           
    									<span>인증코드 입력</span>
    									<input type="text" id="emailAuth" size="25">
    									<button type="button" class="frmBtn">인증하기</button>
    								</div>
    								<!-- div#emailAuthArea -->
    											
    								<input type="hidden" name="uEmail" id="uEmail">
    								
    							</td>
    							<td>&nbsp;</td>
						</tr>
						<tr>
							<th class="req">휴대폰 번호</th>
							<td>
								<input type="text" id="uPhone_01" maxlength="3" size="3">
								<span>-</span>
								<input type="text" id="uPhone_02" maxlength="4" size="4">
								<span>-</span>
								<input type="text" id="uPhone_03" maxlength="4" size="4">
							</td>
							<td></td>
							
						</tr>
						<tr>
							<th class="req">우편번호</th>
    							<td>    								
    								<input type="text" name="uZipcode" id="uZipcode"
    								maxlength="7" size="7" readonly>
    								<button type="button" id="findZipBtn" class="frmBtn">우편번호찾기</button>
    							</td>
    							<td>
    								<span>우편번호 찾기 버튼을 클릭하세요.</span>
    							</td>
						</tr>
						<tr>
							<th class="req">주소</th>
    							<td>    								
    								<input type="text" name="uAddr" id="uAddr"
    								maxlength="100" size="50">
    							</td>
    							<td>&nbsp;</td>
						</tr>
						<tr>
							<th>선호 음식</th>
							<td>
								<label> 
									<input type="checkbox" name="FaveFood" value="한식"> 한식	
								</label>
								<label> 
									<input type="checkbox" name="FaveFood" value="양식"> 양식	
								</label>
								<label> 
									<input type="checkbox" name="FaveFood" value="일식"> 일식	
								</label>
								<label> 
									<input type="checkbox" name="FaveFood" value="중식"> 중식	
								</label>
								<label> 
									<input type="checkbox" name="FaveFood" value="분식"> 분식	
								</label>
								
							</td>
						</tr>

					</tbody>
					<tfoot>
						<tr>
							<td colspan="3">
								<button type="button" id="joinSbmBtn" class="frmBtn">회원가입</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</form>
		</main>

	</div>
</body>
</html>