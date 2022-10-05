<%@page import="pack_Product.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- 
 <jsp:useBean id="mMgr" class="pack_Member.MemberMgr" scope="page" />
 --%>
<%
String uId_Session = (String)session.getAttribute("uId_Session"); 
%>

<%@ page import="pack_Product.ProductBean, java.util.Vector"%>

<jsp:useBean id="pMgr" class="pack_Product.ProductMgr" scope="page" />

<%
request.setCharacterEncoding("UTF-8");


///////페이징 관련 속성 값 시작////////
int totalRecord = 0; 
int numPerPage = 9;
int pagePerBlock = 9;
int totalPage = 0;         
int totalBlock = 0;          


int nowPage = 1; 
int nowBlock = 1; 

int start = 0;
int end = 9;

int listSize = 0;



String keyField = "";
String keyWord = "";
						
if (request.getParameter("keyWord") != null) {
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}
						
if (request.getParameter("nowPage") != null) {
	nowPage = Integer.parseInt(request.getParameter("nowPage"));
	start = (nowPage * numPerPage) - numPerPage;
	end = numPerPage;            
}


totalRecord = pMgr.getTotalCount(keyField, keyWord);   

totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);


Vector<ProductBean> pList = null;

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="#">
<title>상품 목록</title>
<link rel="stylesheet" href="/style/style_Common.css">
<link rel="stylesheet" href="/style/style_Template.css">
<link rel="stylesheet" href="/style/style_BBS.css">
<script src="/source/jquery-3.6.0.min.js"></script>
<script src="/script/script_Template.js"></script>
<script src="/script/find_script.js"></script>
<script src="/script/script_product.js"></script>
</head>

<body>
	<div id="wrap">

		<!--  헤더 템플릿 -->
		<%@ include file="/Common/headerTmp.jsp"%>
		<!--  헤더 템플릿 -->

		<main id="main" class="dFlex">
			<div id="lnb">
				<!--  메인 LNB 템플릿 시작 -->
				<%@ include file="/Common/mainLnbTmp.jsp"%>
				<!--  메인 LNB 템플릿 끝 -->
			</div>


			<!-- 실제 작업 영역 시작 -->
			<div id="contents" class="bbsList">

				<%
				String prnType = "";
				if (keyWord.equals("null") || keyWord.equals("")) {
					prnType = "전체 게시글";
				} else {
					prnType = "검색 결과";
				}
			%>

				<div id="pageInfo" class="dFlex">
					<span><%=prnType %> : <%=totalRecord%> 개 </span> <span>페이지 :
						<%=nowPage + " / " + totalPage%></span>
				</div>

				<table id="boardList">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>원가</th>
							<th>할인율</th>
							<th>판매가</th>
							<th>조회수</th>
						</tr>
						<tr>
							<td colspan="6" class="spaceTd"></td>
						</tr>
					</thead>
					<tbody>



						<%
			pList = pMgr.contentList(keyField, keyWord, start, end);  // DB에서 데이터 불러오기
			listSize = pList.size();			
			
				if (pList.isEmpty()) {
					
				%>
						<tr>
							<td colspan="6"><%="게시물이 없습니다." %></td>
						</tr>
						<%
					
				} else {
					
				%>
						<%
					for (int i=0; i<numPerPage; i++) {		
						
						if(i==listSize) break;
						
						ProductBean Pbean = pList.get(i);
						
						int pNum = Pbean.getpNum();
						String pName = Pbean.getpName();
						int pDiscountR = Pbean.getpDiscountR();
						int pOrigPrice = Pbean.getpOrigPrice();
						int pSellPrice = Pbean.getpSellPrice();
						int pReadCnt = Pbean.getpReadCnt();
				%>
						<tr class="prnTr" onclick="productContent('<%=pNum%>', '<%=nowPage%>')">
						<td><%=pNum %></td>
						<td><%=pName %></td>
						<td><%=pOrigPrice %></td>
						<td><%=pDiscountR %></td>
						<td><%=pSellPrice %></td>
						<td><%=pReadCnt %></td>
							<%
					}
				}
					%>
						
						<tr id="listBtnArea">
							<td colspan="2">
								<% if (uId_Session == null) { %>
								<button type="button" id="loginAlertBtn" class="listBtnStyle">글쓰기</button>
								<% } else { %>
								<button type="button" id="writeBtn" class="listBtnStyle">글쓰기</button>
								<% } %>
							</td>

							<td colspan="3">

								<form name="searchFrm" class="dFlex" id="searchFrm">

									<div>
										<select name="keyField" id="keyField">
											<option value="pName"
												<% if(keyField.equals("pName")) out.print("selected"); %>>제
												목</option>
											<option value="pContent"
												<% if(keyField.equals("pContent")) out.print("selected"); %>>내
												용</option>
										</select>
									</div>
									<div>
										<input type="text" name="keyWord" id="keyWord" id="keyWord"
											size="20" maxlength="30" value="<%=keyWord%>">
									</div>
									<div>
										<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
									</div>

								</form> <input type="hidden"
								id="pKeyField" value="<%=keyField%>"> <input
								type="hidden" id="pKeyWord" value="<%=keyWord%>"> <!-- 검색결과 유지용 매개변수 데이터끝 -->

							</td>
						</tr>
						<!-- tr#listBtnArea -->

						<tr id="listPagingArea">

							<!-- 페이징 시작 -->
							<td colspan="5" id="pagingTd">
								<%
				int pageStart = (nowBlock - 1 ) * pagePerBlock + 1;
							
				int pageEnd = (nowBlock < totalBlock) ? 
												pageStart + pagePerBlock - 1 :  totalPage;
				                                        
				
							
				if (totalPage != 0) {
					   
				%> <% if (nowBlock>1) {%> <span
								class="moveBlockArea"
								onclick="moveBlock('<%=nowBlock-1%>', '<%=pagePerBlock%>')">
									&lt; </span> <% } else { %> <span class="moveBlockArea"></span> <% } %> <!-- 페이지 나누기용 페이지 번호 출력 시작  -->
								<% 
					
					
					                                 
						for (   ; pageStart<=pageEnd; pageStart++){ %>
							<% if (pageStart == nowPage) {   %>
							<span class="nowPageNum"><%=pageStart %></span> 
							<% } else {   %> <span class="pageNum"
								onclick="movePage('<%=pageStart %>')"> <%=pageStart %>
								</span> 
							<% } // End If%>
							<% }// End For%>
						
						<% if (totalBlock>nowBlock) { %>
								<span class="moveBlockArea"
								onclick="moveBlock('<%=nowBlock+1%>', '<%=pagePerBlock%>')">
								&gt; </span>
						 <%} else { 
									%> <span class="moveBlockArea"></span> <% }%>
			<% }else {
					out.print("<b>[ Paging Area ]</b>"); // End if
				}
				%>

							</td>
						</tr>

					</tbody>
				</table>


			</div>
			<!-- 실제 작업 영역 끝 -->

		</main>
		<!--  main#main  -->

		<!--  footer 템플릿 -->
		<%@ include file="/Common/footerTmp.jsp"%>
		<!--  footer템플릿 -->

	</div>
	<!-- div#wrap -->

</body>

</html>