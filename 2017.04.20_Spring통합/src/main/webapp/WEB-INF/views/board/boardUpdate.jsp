<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE htm>
<html>
<head>
<meta charset="EUC-KR">
<title>�� �� ������</title>
</head>

<body>
<h2>�� �� ������</h2>
<form style="border:2px dotted teal; padding:3px; width:300px;">
�۹�ȣ : ${boardUpdate.num} <br>
���� : ${boardUpdate.title} <br>
���� : ${boardUpdate.contents} <br>
�ۼ��� : ${boardUpdate.author} <br>
</form>

<a href="listPage">����Ʈ�� ����</a>
</body>
</html>