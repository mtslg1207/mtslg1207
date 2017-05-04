<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE htm>
<html>
<head>
<meta charset="EUC-KR">
<title>�� �� ������</title>
<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script>
<script type="text/javascript">
$(function(){
	$('#replForm').hide();
});

function showRepl(){
	$("#replForm").toggle();
}

function saveRepl(){
	if(!confirm('����� ���� �Ͻðڽ��ϱ�?')) return false;
	var param = $('#replForm').serialize();
	$.ajax({
		url : "repl",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res){
				alert("�ۼ��Ͻ� ����� ���������� �����߽��ϴ�.");
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
	if(!confirm('������ ���� �����Ͻðڽ��ϱ�?')) return false;
	var param = $('#deleteForm').serialize();
	$.ajax({
		url : "delete",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res){
				alert("���� �����߽��ϴ�.");
				location.href = "listPage?page=1";		
			}
			else{
				alert("����� �޸� ���� ������ �� �����ϴ�.");
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
<h2>�� �� ������</h2>
<div style="border:1px solid black; padding: 10px 10px 10px 10px; margin-right:1000px;">
�� ��ȣ : ${recentRead.bbs.num} <br>
���� : ${recentRead.bbs.title} <br>
���� : ${recentRead.bbs.contents} <br>
�ۼ��� : ${recentRead.bbs.author} <br>
</div>
<hr>
<div style="border:1px solid black; padding: 10px 10px 10px 10px; margin-right:1000px;">
<h3>���ε�� ���� ����</h3>
<c:forEach var="file" items="${recentRead.file}">
���ϸ� : <span style="border:1px solid black;">${file.saveName}</span>
<a href="javascript:download('${file.saveName}');">�ٿ�ε�</a><br>
</c:forEach>

<form id="downloadForm" action="download" method="post">
    <input type="hidden" name="filename" id="filename"><br>
</form>
</div>
<p>


<sec:authorize access="isAuthenticated()">
<a href="edit?num=${recentRead.bbs.num}">[�� ����]</a>
	<sec:authorize access="hasAuthority('USER_ADMIN')">
	<a href="javascript:boardDelete()">[����]</a>
	</sec:authorize>	
<a href="javascript:showRepl();">[��� ����]</a>
</sec:authorize>

<br><a href="listPage">[�� ����Ʈ ����]</a>

<form id="deleteForm" action="delete" method="post">
    <input type="hidden" name="num" value="${recentRead.bbs.num}">
    <input type="hidden" name="author" value="${userID}">
</form>

<form id="replForm" onsubmit="return saveRepl();">
<div style="border: 1px dotted black; padding: 10px 10px 10px 10px; margin-right:1000px;" >
	<input type="hidden" name="ref" value="${recentRead.bbs.num}">
	��� ���� : <input type="text" name="title" value="Re:${recentRead.bbs.title}"><br>
	��� ���� : <br><textarea name="contents">${recentRead.bbs.contents}</textarea><br>
	��� �ۼ��� : ${userID}<input type="hidden" name="author" value="${userID}"><br>
	<button type="submit">����</button> <button type="reset">���</button>
</div>
</form>
</body>
</html>