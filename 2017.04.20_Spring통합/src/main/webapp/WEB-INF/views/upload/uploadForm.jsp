<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>파일 업로드 폼</title>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<style>
.errorMsg {color: red;}
</style>
<script>
var i = 1;
$(function(){
  $('#bt1').on('click',function(){
	$('#div1').append("<input type='file' name='file["+(i++)+"]'>");
	$('#div1').append("<br>");
   });   
});
</script>
</head>
<body>
  <form:form method="post" enctype="multipart/form-data" modelAttribute="uploadVO" action="fileUpload"> 
   업로드할 파일 선택: <br>
  <input type="file" name="file[0]"><br>
  <div id="div1"></div>
  <form:errors path="file" cssClass="errorMsg"/><br>
    설명 : <input type="text" name="desc" value="업로드"><br>
  <button type="button" id="bt1">파일 추가</button><br>
  <input type="submit" value="전 송"> 
  </form:form> 
</body> 
</html>