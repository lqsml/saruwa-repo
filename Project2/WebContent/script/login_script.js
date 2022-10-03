
$(function() {

	/* 폼실행 엔터키 이벤트 처리 */
	$(window).keydown(function() {
		let code = event.keyCode;
		if (code == 13) return false;
	});

	/* 폼실행 엔터키 이벤트 처리 */
	$(window).keyup(function() {
		let code = event.keyCode;
		//alert("code : " + code);
		if (code == "13") fnLoginSbm();
	});

	// 로그인 버튼 
	$("button#loginBtn").click(function() {

		let uId = $("#uId").val().trim();
		$("#uId").val(uId);
		let uPw = $("#uPw").val().trim();
		$("#uPw").val(uPw);

		if (uId == "") {
			alert("아이디를 입력하세요.");
			$("#uId").focus();
			return;
		} else if (uPw == "") {
			alert("비밀번호를 입력하세요.");
			$("#uPw").focus();
			return;
		} else {
			$("form#loginFrm").attr("action", "/login/loginProc.jsp").submit();
		}


	});
	



});