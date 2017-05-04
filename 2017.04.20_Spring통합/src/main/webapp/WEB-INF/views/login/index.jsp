<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
</head>

<body>
<h3>게시판 메인 페이지 입니다.</h3>

<div style="border:2px solid teal; padding:3px; height:100px;">
<sec:authorize access="hasAuthority('USER_ADMIN')">
   	<a href="<c:url value='/sec/adminMain' />">관리자 메인</a><br>
</sec:authorize>

<sec:authorize access="hasAuthority('USER')">
    <a href="<c:url value='/sec/userMain' />">회원 메인</a><br>
</sec:authorize>

<sec:authorize access="! isAuthenticated()">
<a href="<c:url value='/board/listPage' />">게스트</a><br>
</sec:authorize>

<sec:authorize access="! isAuthenticated()">
    <a href="<c:url value='/sec/login' />">로그인</a><br>
    <a href="<c:url value='/sec/join' />">회원가입</a><br>
</sec:authorize>
 
<sec:authorize access="isAuthenticated()">
    <a href="<c:url value='/sec/logout' />">로그아웃</a><br>
</sec:authorize>
</div>
</body>
</html>