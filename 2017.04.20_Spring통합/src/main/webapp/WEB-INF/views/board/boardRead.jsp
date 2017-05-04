<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE htm>
<html>
<head>
<meta charset="utf-8">
<title>글 상세 페이지</title>
<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script>
<script type="text/javascript">
$(function(){
	$('#replForm').hide();
});

function showRepl(){
	$("#replForm").toggle();
}

function saveRepl(){
	if(!confirm('댓글을 저장 하시겠습니까?')) return false;
	var param = $('#replForm').serialize();
	$.ajax({
		url : "repl",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res){
				alert("작성하신 댓글을 정상적으로 저장했습니다.");
				location.href="listPage?page=1";			
			}
		},
		error : function(xhr, status, err){
			alert(err);
		}
	});
	return false;
}

function boardDelete(){
	if(!confirm('정말로 글을 삭제하시겠습니까?')) return false;
	var param = $('#deleteForm').serialize();
	$.ajax({
		url : "delete",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res){
				alert("글을 삭제했습니다.");
				location.href = "listPage?page=1";		
			}
			else{
				alert("댓글이 달린 글은 삭제할 수 없습니다.");
			}
		},
		error : function(xhr, status, err){
			alert(err);
		}
	});
	return false;
}

function download(fname){
	$('#filename').val(fname);
	$('#downloadForm').submit();
}
</script>
</head>

<body>
<h2>글 상세 페이지</h2>
<div style="border:1px solid black; padding: 10px 10px 10px 10px; margin-right:1000px;">
글 번호 : ${read.bbs.num} <br>
제목 : ${read.bbs.title} <br>
내용 : ${read.bbs.contents} <br>
작성자 : ${read.bbs.author} <br>
</div>
<hr>
<div style="border:1px solid black; padding: 10px 10px 10px 10px; margin-right:1000px;">
<h3>업로드된 파일 정보</h3>
<c:forEach var="file" items="${read.file}">
파일명 : <span style="border:1px solid black;">${file.saveName}</span>
<a href="javascript:download('${file.saveName}');">다운로드</a><br>
</c:forEach>

<form id="downloadForm" action="download" method="post">
    <input type="hidden" name="filename" id="filename"><br>
</form>
</div>
<p>


<sec:authorize access="isAuthenticated()">
<a href="edit?num=${read.bbs.num}">[글 수정]</a>
	<sec:authorize access="hasAuthority('USER_ADMIN')">
	<a href="javascript:boardDelete()">[삭제]</a>
	</sec:authorize>	
<a href="javascript:showRepl();">[댓글 쓰기]</a>
</sec:authorize>

<br><a href="listPage">[글 리스트 보기]</a>

<form id="deleteForm" action="delete" method="post">
    <input type="hidden" name="num" value="${read.bbs.num}">
    <input type="hidden" name="author" value="${read.bbs.author}">
</form>

<form id="replForm" onsubmit="return saveRepl();">
<div style="border: 1px dotted black; padding: 10px 10px 10px 10px; margin-right:1000px;" >
	<input type="hidden" name="ref" value="${read.bbs.num}">
	답글 제목 : <input type="text" name="title" value="Re:${read.bbs.title}"><br>
	답글 내용 : <br><textarea name="contents">${read.bbs.contents}</textarea><br>
	답글 작성자 : ${read.bbs.author}<input type="hidden" name="author" value="${read.bbs.author}"><br>
	<button type="submit">저장</button> <button type="reset">취소</button>
</div>
</form>
</body>
</html>