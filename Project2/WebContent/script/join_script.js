$(function(){
	
	/* /////////////////////////// 회원가입 /////////////////////////// */
	
	/* ////////////////// 이용약관 ////////////////// */
	// 전체 체크 버튼
	$("div#chkAllArea input#chkAll").click(function(){
		
		let chkToF = $(this).prop("checked");
		$("input.usingAgreeChk").prop("checked", chkToF);
		
	});
	// 역방향 전체 체크 버튼
	$("input.usingAgreeChk").click(function(){
		let chkToF = false;				
		let chk0 =$(".joinAgree .termArea").eq(0).find("input").prop("checked");
		let chk1 =$(".joinAgree .termArea").eq(1).find("input").prop("checked");
		let chk2 =$(".joinAgree .termArea").eq(2).find("input").prop("checked");
		
		if (chk0 && chk1 && chk2) {
			chkToF = true;    // 3개의 약관 모두 체크 되었을 때 실행됨.
		}
		
		$(".joinAgree input#chkAll").prop("checked", chkToF);
	});
	

	/* ////////////////// 회원가입 유효성 검사 시작 ////////////////// */
	
	// 아이디 유효성 검사 
	$("button#idChkBtn").click(function(){
		let uId = $("input#uId").val().trim();
		/*console.log(uId.length);*/
		$("input#uId").val(uId);
		
		let regExp = /[^a-z|A-Z|0-9]/g; // 정규표현식
		let rExpRes = regExp.test(uId); // 정규표현식 결과
		
		if (uId == "") {    // 전체 공백 체크
			
			alert("아이디를 입력해주세요");
			$("#uId").focus();
			
		} else if (uId.length < 5) {    // 글자수 체크
		
			alert("아이디는 최소 5글자 이상입니다.");
			$("#uId").focus().val("");
			
		} else if (rExpRes) {    // 정규표현식 체크
		
			alert("영어대/소문자, 숫자 조합만 가능합니다.");
			$("#uId").focus().val("");
			
		} else {
			let url = "/join/idCheck.jsp?uId=" + uId;
			let nickName = "아이디 중복체크 팝업";
			let w = screen.width;    
			let popWidth = 480;
			let leftPos = (w - popWidth) / 2; // left Position 팝업창 왼쪽 시작위치
	
			let h = screen.height;    
			let popHeight = 320;
			let topPos = (h - popHeight) / 2; 		
			
	
			let prop = "width="+ popWidth +", height="+ popHeight;
				  prop += ", left=" + leftPos + ", top=" + topPos; 
			window.open(url, nickName, prop);
			// 아이디 중복검사 → 팝업 or 아이디 힌트 지운 위치에 표시
		} 
		
	});
	
	// 아이디 중복검사 팝업 닫기 버튼
	$("button.chkIdPopupBtn").click(function(){
		window.close();
		let reInputuId = $("button.chkIdPopupBtn").prop("text", "닫기");
		
		if(reInputuId){
			opener.joinFrm.uId.focus();
		}
		
	});
	
	// 비밀번호 유효성 검사
	$("#uPw").keyup(function(){
		
		// 비밀번호 양식 확인
		let uPw = $("#uPw").val();
		let num = uPw.search(/[0-9]/g);
		let eng = uPw.search(/[a-z]/ig);
		let spe = uPw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		if(uPw.length < 8){
			$("span#uPwPattern").text("비밀번호는 8자리 이상 입력 가능합니다.");
			/*alert("비밀번호는 8자리 이상 입력 가능합니다.");*/
			return false;
		} else if(uPw.search(/\s/) != -1){
			$("span#uPwPattern").text("비밀번호는 공백 없이 입력해주세요.");
			/*alert("비밀번호는 공백 없이 입력해주세요.");*/
			return false;
		} else if(num < 0 || eng < 0 || spe < 0){
			$("span#uPwPattern").text("영문자/숫자/특수문자를 혼합하여 입력해주세요.");
			/*alert("영문자/숫자/특수문자를 혼합하여 입력해주세요.");*/
			return false;
		} else{
			$("span#uPwPattern").text("");
			return true;
		}
	});
	$("#uPwRe").keyup(function(){
		
		// 비밀번호, 비밀번호확인 값 일치
		let uPw = $("#uPw").val();
		let uPwRe = $("#uPwRe").val();
		
		if(uPw != uPwRe){
			$("span#uPwChk").text("비밀번호가 일치하지 않습니다.");
		} else{
			$("span#uPwChk").text("비밀번호가 일치합니다.");
		}
		
	});
	
	// 이름 유효성 검사
	$("input#uName").keyup(function(){
		
		let uName = $("#uName").val().trim();
		
		let regExp = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 정규표현식
		let rExpRes = regExp.test(uName); // 정규표현식 결과
		
		if(uName == ""){
			$("span#uNameChk").text("이름을 입력해주세요.");
		} else if(!rExpRes){
			$("span#uNameChk").text("한글만 입력하세요.");
		} else{
			$("span#uNameChk").text("");
		}
		
	});
	// 이메일 도메인 자동입력
	$("select#emailDomain").change(function(){
		
		let emailDomain = $(this).val().trim();
		$("input#uEmail_02").val(emailDomain);
		if(emailDomain == ""){
			$("input#uEmail_02").focus();
		} 
		
	});
	
	// 휴대폰 번호 유효성 검사
		$("button#phoneAuthBtn").click(function(){
		
		let uPhone_01 = $("input#uPhone_01").val().trim();
		let uPhone_02 = $("input#uPhone_02").val().trim();
		let uPhone_03 = $("input#uPhone_03").val().trim();
		
		if(uPhone_01 == ""){
			alert("번호를 확인해주세요.");
			$("#uPhone_01").focus();
		} else if(uPhone_02 == ""){
			alert("번호를 확인해주세요.");
			$("#uPhone_02").focus();
		} else if(uPhone_03 == ""){
			alert("번호를 확인해주세요.");
			$("#uPhone_03").focus();
		} else {
			$("div#phoneAuthArea").attr("class", "");
		}
	});
	/* ////////////////// 회원가입 유효성 검사 끝 ////////////////// */
	
	/* ////////////////// 회원가입 전송 ////////////////// */
	$("#joinSbmBtn").click(function(){
		fnJoinSbm();
	});
	
		/* 폼실행 엔터키 이벤트 처리 */
	$(window).keydown(function(){
		let code = event.keyCode;
		if (code == 13) return false;
	});
	
	/* 폼실행 엔터키 이벤트 처리 */
	$(window).keyup(function(){		
		let code = event.keyCode;
		//alert("code : " + code);
		if (code == 13) fnJoinSbm();
    });
	
	// 회원 가입 버튼
	function fnJoinSbm(){
		let uId = $("#uId").val().trim();
		$("#uId").val(uId);
		let uPw = $("#uPw").val().trim();
		$("#uPw").val(uPw);
		let uPwRe = $("#uPwRe").val().trim();
		let uName = $("#uName").val().trim();
		$("#uName").val(uName);
		let uEmail_01 = $("#uEmail_01").val().trim();
		let uEmail_02 = $("#uEmail_02").val().trim();
		$("#uEmail").val(uEmail_01 + "@" + uEmail_02);
		let uPhone_01 = $("#uPhone_01").val().trim();
		let uPhone_02 = $("#uPhone_02").val().trim();
		let uPhone_03 = $("#uPhone_03").val().trim();
		$("#uPhone").val(uPhone_01 + "-" + uPhone_02 + "-" + uPhone_03);
		
		let chkReq0 = $(".joinAgree .termArea").eq(0).find("input").prop("checked"); // 필수 체크 확인
		let chkReq1 = $(".joinAgree .termArea").eq(1).find("input").prop("checked"); // 필수 체크 확인
		
		// 쇼핑정보 수신 동의
		let saToF = $("input#sa").prop("checked");
		
		if (chkReq0 == false) {
			alert("이용약관 동의를 체크해주세요");
			$(".joinAgree .termArea").eq(0).find("input").css({"outline": "1px solid #08f"});
			$(".joinAgree .termArea").eq(0).find("input").focus();
			return;
		} else if(chkReq1 == false) {			
			alert("개인정보 수집 및 이용 동의를 체크해주세요");
			$(".joinAgree .termArea").eq(1).find("input").css({"outline": "1px solid #08f"});
			$(".joinAgree .termArea").eq(1).find("input").focus();
			return;
		} else if (uId == "") {
			alert("아이디를 입력해주세요.");
			$("#uId").focus();
			return;
		} else if (uPw == "") {
			alert("비밀번호를 입력해주세요.");
			$("#uPw").focus();
			return;
		} else if (uPwRe == "" || uPw != uPwRe) {
			alert("비밀번호 일치여부를 확인해주세요.");
			$("#uPwRe").focus();
			return;
		} else if (uName == "") {
			alert("이름을 입력해주세요.");
			$("#uName").focus();
			return;
		} else if (uEmail_01 == "") {
			alert("이메일 주소를 입력해주세요.");
			$("#uEmail_01").focus();
			return;
		} else if (uEmail_02 == "") {
			alert("이메일 주소를 입력해주세요.");
			$("#uEmail_02").focus();
			return;
		} else if(!saToF){
			$("input#sa").val("0");
		} else {
			let chkSbmTF = confirm("회원가입하시겠습니까?");
			if (chkSbmTF) {
				$("#joinFrm").attr("action", "/join/joinProc.jsp").submit();
			}
		}
	};
	
	// 회원 정보 수정
	$("button#modBtn").click(function(){
		fnModSbm();
	});
	
	function fnModSbm(){
		let uPw = $("#uPw").val().trim();
		$("#uPw").val(uPw);
		let uPwRe = $("#uPwRe").val().trim();
		let uEmail_01 = $("#uEmail_01").val().trim();
		let uEmail_02 = $("#uEmail_02").val().trim();
		$("#uEmail").val(uEmail_01 + "@" + uEmail_02);
		let uPhone_01 = $("#uPhone_01").val().trim();
		let uPhone_02 = $("#uPhone_02").val().trim();
		let uPhone_03 = $("#uPhone_03").val().trim();
		$("#uPhone").val(uPhone_01 + "-" + uPhone_02 + "-" + uPhone_03);
		// 쇼핑정보 수신 동의
		
		if (uPw == "") {
			alert("비밀번호를 입력해주세요.");
			$("#uPw").focus();
			return;
		} else if (uPwRe == "" || uPw != uPwRe) {
			alert("비밀번호 일치여부를 확인해주세요.");
			$("#uPwRe").focus();
			return;
		} else if (uEmail_01 == "") {
			alert("이메일 주소를 입력해주세요.");
			$("#uEmail_01").focus();
			return;
		} else if (uEmail_02 == "") {
			alert("이메일 주소를 입력해주세요.");
			$("#uEmail_02").focus();
			return;
		} else {
			let chkSbmTF = confirm("회원 정보를 수정하시겠습니까?");
			if (chkSbmTF) {
				$("#modFrm").attr("action", "/mypage/infoModProc.jsp").submit();
			}
		}
	}
	
	// 회원 탈퇴
	$("button#quitBtn").click(function(){
		let uId = $("#uId").val().trim();
		$("#uId").val(uId);
		let uPw = $("#uPw").val().trim();
		$("#uPw").val(uPw);
		
		if (uId == "") {
			alert("아이디를 입력해주세요.");
			$("#uId").focus();
			return;
		} else if (uPw == "") {
			alert("비밀번호를 입력해주세요.");
			$("#uPw").focus();
			return;
		} else {
			let chkSbmTF = confirm("회원탈퇴하시겠습니까?");
			if (chkSbmTF) {
				$("#quitFrm").attr("action", "/mypage/memberQuitProc.jsp").submit();
			}
		}
	});
	

	
});