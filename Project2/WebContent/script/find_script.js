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

	// 아이디 찾기 
	$("button#findIdBtn").click(function() {

		let uName = $("#uName").val().trim();
		$("#uName").val(uName);
		let uEmail = $("#uEmail").val().trim();
		$("#uEmail").val(uEmail);

		if (uName == "") {
			alert("이름을 입력하세요.")
			return;
		} else if (uEmail == "") {
			alert("이메일을 입력하세요.");
			$("#uEmail").focus();
			return;
		} else {

			let url = "/find/findIdProc.jsp?uName=" + uName + "&uEmail=" + uEmail;
			let nickName = "아이디 찾기 팝업";

			let w = screen.width;
			let popWidth = 480;
			let leftPos = (w - popWidth) / 2; // left Position 팝업창 왼쪽 시작위치

			let h = screen.height;
			let popHeight = 320;
			let topPos = (h - popHeight) / 2;


			let prop = "width=" + popWidth + ", height=" + popHeight;
			prop += ", left=" + leftPos + ", top=" + topPos;
			window.open(url, nickName, prop);
		}

	});
	// 비밀번호 찾기 
	$("button#findPwBtn").click(function() {

		let uName = $("#uName").val().trim();
		$("#uName").val(uName);
		let uId = $("#uId").val().trim();
		$("#uId").val(uId);
		let uEmail = $("#uEmail").val().trim();
		$("#uEmail").val(uEmail);

		if (uName == "") {
			alert("이름을 입력하세요.")
			return;
		} else if (uId == "") {
			alert("아이디를 입력하세요.");
			$("#uId").focus();
			return;
		} else if (uEmail == "") {
			alert("이메일을 입력하세요.");
			$("#uEmail").focus();
			return;
		} else {

			let url = "/find/findPwProc.jsp?uName=" + uName + "&uId=" + uId + "&uEmail=" + uEmail;
			let nickName = "비밀번호 찾기 팝업";

			let w = screen.width;
			let popWidth = 480;
			let leftPos = (w - popWidth) / 2; // left Position 팝업창 왼쪽 시작위치

			let h = screen.height;
			let popHeight = 320;
			let topPos = (h - popHeight) / 2;


			let prop = "width=" + popWidth + ", height=" + popHeight;
			prop += ", left=" + leftPos + ", top=" + topPos;
			window.open(url, nickName, prop);
		}

	});
	// 아이디찾기 팝업창 비밀번호 찾기 버튼 
	$("button#popFindPwBtn").click(function(){
		opener.location.href="/find/findPw.jsp";
		window.close();
	});
	
	// 찾기 팝업 닫기 버튼
	$("button.locLoginBtn").click(function() {
		opener.location.href="/login/login.jsp";
		window.close();
	});
	$("button.locFindIdBtn").click(function() {
		opener.location.href="/login/login.jsp";
		window.close();
	});


});