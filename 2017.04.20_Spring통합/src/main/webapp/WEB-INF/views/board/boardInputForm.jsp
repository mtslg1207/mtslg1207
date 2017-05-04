<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script>
<title>글 입력 폼</title>
<style>  
body {font-size: 20px;  color: teal;}  
td {font-size: 15px;  color: black;  width: 100px;  height: 22px;  text-align: left;} 
.heading {font-size: 18px;  color: white;  font: bold;  background-color: orange;  border: thick;}  
</style> 
<script>
var i = 1;
$(function(){
  $('#bt1').on('click',function(){
	$('#div1').append("<input type='file' name='file["+(i++)+"]'><br>");
   });   
});
</script>
</head>  

<body>  
<h2>글 입력 폼 </h2>
<form:form method="post" action="recent" modelAttribute="BbsVO" enctype="multipart/form-data">
제목 : <input type="text" name="title" value="제목_입력란"><br>
내용 : <input type="text" name="contents" value="내용_입력란"><br>
작성자 : ${sessionScope.userID} <input type="hidden" name="author" value="${sessionScope.userID}"><br>
<hr>
업로드할 파일 선택:
	<input type="file" name="file[0]"><br>
	<div id="div1"></div>
<%-- 	<form:errors path="file" cssClass="errorMsg"/><br> --%>
	<button type="button" id="bt1">파일 추가</button><br>
<hr>
<button type="submit">저장</button> <button type="reset">취소</button>
</form:form> 

<a href="listPage">리스트 보기</a>
</body>  
</html>