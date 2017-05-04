<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE htm>
<html>
<head>
<meta charset="EUC-KR">
<title>글 상세 페이지</title>
</head>

<body>
<h2>글 상세 페이지</h2>
<form style="border:2px dotted teal; padding:3px; width:300px;">
글번호 : ${boardUpdate.num} <br>
제목 : ${boardUpdate.title} <br>
내용 : ${boardUpdate.contents} <br>
작성자 : ${boardUpdate.author} <br>
</form>

<a href="listPage">리스트로 가기</a>
</body>
</html>