<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원 메인 페이지</title>
</head>
<body>
<h3>회원 메인 페이지</h3>
<sec:authentication property="name"/>님 반갑습니다.<br><br>

<a href="<c:url value='/board/inputForm' />">새글쓰기</a><br>
<a href="<c:url value='/board/listPage'/>">글 리스트 보기</a><br>
<a href="<c:url value='/sec/logout'/>">로그아웃</a>
</body>
</html>