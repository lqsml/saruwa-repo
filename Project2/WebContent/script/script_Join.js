$(function(){
	
	/* /////////////////////////// 회원가입 /////////////////////////// */
	
	
	/* ////////////////// 회원가입 유효성 검사 시작 ////////////////// */
	
	
	$("button#idChkBtn").click(function(){
		let uId = $("input#uId").val().trim();
		/*console.log(uId.length);*/
		$("#uId").val(uId);
		
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
			
		} 
		
		
		
		
	});
	/* ////////////////// 회원가입 유효성 검사 끝 ////////////////// */
});