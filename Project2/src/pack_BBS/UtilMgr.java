package pack_BBS;

public class UtilMgr {
	
	public static String replace(String str, String pattern, String replace) {
		
		int s = 0, e = 0;
		StringBuffer result = new StringBuffer();
		
		while ((e = str.indexOf(pattern, s)) >= 0) {
			      // 지역변수 e의 값이 0보다 크면 true, 즉 1이상이면 true
			
			      result.append(str.substring(s, e));
			      result.append(replace);
			      s = e + pattern.length();
			      
		}
		result.append(str.substring(s));
		
		// "가BC가나다".indexOf("가", 1) =>  3
		//  0 123 4 5    
		//  "가BC가나다".indexOf("가", 0) => 0
		//   
		return result.toString();
	}   // replace( )
	
	public static String con(String path) {
		String str = null;
		
		try {
			str = new String(path.getBytes("8859_1"), "UTF-8");
			             // String 생성자가 매개변수를 2개 가질 때
			             // 1번째 매개변수는 입력받는 데이터(=외부파일)의 인코딩
			             // 2번째 매개변수는 해당 데이터(=외부파일)에 적용할 인코딩
			             // 결론! 관련 파일과 경로명이 깨지지 않도록 만듬
		} catch(Exception e) {
			System.out.println("파일 입출력 이슈 : " + e.getMessage());
		}
		
		
		return str;
	}

}
