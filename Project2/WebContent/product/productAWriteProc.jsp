<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="pMgr" class="pack_Product.ProductMgr" scope="page"/>
<jsp:useBean id="pBean" class="pack_Product.ProductBean"/>
<%
pMgr.insertProductInfo(request);
response.sendRedirect("/product/productList.jsp");
//목록으로 갈까? 아님 바로 read.jsp로 갈까??!?!?!
%>