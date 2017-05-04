<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!-- <html> -->
<!-- <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"> -->
<%-- <script src="<c:url value='/bootstrap.css'/>"></script> --%>
<%-- <script src="<c:url value='/bootstrap.min.css'/>"></script> --%>
<%-- <script src="<c:url value='/bootstrap-theme.min.css'/>"></script> --%>
<%-- <script src="<c:url value='/bootstrap-theme.css'/>"></script> --%>
<%-- <script src="<c:url value='/stylish-portfolio.css'/>"></script> --%>
<!-- <body> -->
<!-- <h2>게시판</h2> -->
<!-- <a href="sec/dbIndex">게시판 홈</a> -->
<!-- </body> -->
<!-- </html> -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-2.2.4s.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 상단 네비게이션 바 -->
<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <!-- 브라우저가 좁아졋을때 나오는 버튼(클릭시 메뉴출력) -->
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="<c:url value='/board/listPage' />">게스트</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
<!--             <li class="active"><a href="sec/dbIndex">게시판 홈</a></li> -->
<%--             <li><a href="<c:url value='/sec/login' />">로그인</a></li> --%>
<%--             <li><a href="<c:url value='/sec/logout' />">로그아웃</a></li> --%>
          	<sec:authorize access="hasAuthority('USER_ADMIN')">
   				<li><a href="<c:url value='/sec/adminMain' />">관리자 메인</a></li><br>
			</sec:authorize>
			
			<sec:authorize access="hasAuthority('USER')">
			    <li><a href="<c:url value='/sec/userMain' />">회원 메인</a></li><br>
			</sec:authorize>
			
			<sec:authorize access="! isAuthenticated()">
			    <li class="active"><a href="<c:url value='/sec/login' />">로그인</a></li><br>
			</sec:authorize>
			
			<sec:authorize access="! isAuthenticated()">
			    <li><a href="<c:url value='/sec/join' />">회원가입</a></li><br>
			</sec:authorize>
			 
			<sec:authorize access="isAuthenticated()">
			    <li><a href="<c:url value='/sec/logout' />">로그아웃</a></li><br>
			</sec:authorize>
          </ul>
        </div>
      </div>
</div>
<div class="container">
      <div style="margin-top: 100px;">
        <h1>INDEX</h1>
        <p class="lead">index 페이지입니다</p>
      </div>
</div>
</body>
</html>
