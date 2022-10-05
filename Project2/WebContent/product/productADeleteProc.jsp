<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="pack_Product.ProductBean"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="pMgr" class="pack_Product.ProductMgr"/>

<%
String nowPage = request.getParameter("nowPage");
String pNum = request.getParameter("pNum");
int numParam = Integer.parseInt(pNum);

String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");

ProductBean Pbean = (ProductBean)session.getAttribute("Pbean");
int exeCnt = pMgr.delateProduct(numParam);

String url = "/product/productList.jsp?nowPage="+nowPage;
url += "&keyField="+keyField;
url += "&keyWord="+keyWord;
%>
<script>
alert("삭제되었습니다!");
location.href = "<%=url%>";
</script>