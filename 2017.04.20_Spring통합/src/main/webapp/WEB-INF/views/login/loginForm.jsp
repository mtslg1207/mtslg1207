<%@ page contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인 폼</title>
<style>
body {font-size: 20px;  color: teal;}
form {border:2px dotted teal; padding:3px; width:300px;}
a {font-size:20px; color:teal;}
</style>
</head>
<body>
<h3>로그인 폼 </h3> 
<c:if test="${param.error==true }">
    로그인 실패
</c:if>
<form action="<c:url value='/sec/dbIndex' />" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
ID : <input type="text" name="userid"  value="SMITH_ADMIN"><br>
PWD : <input type="password" name="userpwd"  value="7369"><br>
<button type="submit" >로그인</button>
</form>

<a href="<c:url value='/sec/dbIndex'/>">이전으로</a>
</body>
</html>