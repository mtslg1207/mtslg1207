<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE htm>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정 페이지</title>
<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script>
<script>
function boardUpdate(){
	var param = $('#updateForm').serialize();
	$.ajax({
		url : 'update',
		method : 'post',
		data : param,
		dataType : 'json',
		success : function(res){
			if(res){
				alert('수정을 성공하였습니다.');
				location.href="listPage?page=1";
			}
			else{
				alert('본인글만 수정할 수 있습니다.');
				location.href = "listPage?page=1";
			}
		},
		error : function(xhr, status, err){
			alert(err);
		}
	});
	return false;
}
</script>
</head>

<body>
<h2>글 수정 페이지</h2>
<form id="updateForm" method="post" onsubmit="return boardUpdate();">  
 <input type="hidden" name="num" value="${boardRead.num}">
 <input type="hidden" name="author" value="${userID}">
글 번호 : ${boardRead.num } <br>
제목 : <input type="text" name="title" value="${boardRead.title }"> <br>
내용 : <input type="text" name="contents" value="${boardRead.contents }"> <br>
작성자 : ${boardRead.author}
<p>
<button type="submit">변경사항 적용</button> 
</form>  
<a href="listPage">리스트로 가기</a>
</body>
</html>