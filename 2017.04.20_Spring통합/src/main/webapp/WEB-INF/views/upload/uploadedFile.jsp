<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 결과</title>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script>
function download(fname){
	$('#filename').val(fname);
	$('#downloadForm').submit();
}
</script>
</head>
<body>
<h2>업로드된 파일 정보</h2>
<c:forEach var="file" items="${uploadVO.file}">
파일명 : <span style="border:1px solid black;">${file.originalFilename}</span>
<a href="javascript:download('${file.originalFilename}');">다운로드</a><br>
</c:forEach>
설 명 : ${uploadVO.desc} <br>

<form id="downloadForm" action="download" method="post">
    <input type="hidden" name="filename" id="filename"><br>
<!--     <input type="submit" value="DOWNLOAD"><br> -->
</form>
<a href="uploadForm">첫화면으로</a>
</body>
</html>