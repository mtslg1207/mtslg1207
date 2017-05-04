<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script>
<script>
function checkID(){
	if($("#uid").val()==""){
		alert("아이디를 입력해주세요"); return;
	}
	var param={};
	param.id= $("#uid").val();
	$.ajax({
		url : "check",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.ok){
				alert("사용 가능한 아이디 입니다.");
			}
			else{
				alert("이미 사용중인 아이디입니다.");
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}

function userJoin(){
	var param = $('#joinForm').serialize();
	$.ajax({
		url : 'join',
		method : 'post',
		data : param,
		dataType : 'json',
		success : function(res){
			if(res){
				alert('회원 가입 성공');
				location.href="dbIndex";
			}
			else{
				alert('회원 가입 실패(중복되는 아이디입니다.)');
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
<h3>회원가입 입력란</h3>
<div id=div1 style="border: 1px solid black;">
<form id="joinForm" onsubmit="return userJoin();">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
ID : <input type="text" id="uid" name="userid" value="SMITH"> 
<button type="button" onclick="checkID()">중복검사</button><br>
PWD : <input type="password" name="userpwd" value="7369"> <br>
이름 : <input type="text" name="userName" value="이정협"> <br>
<button type="submit">저장</button>
</form>
</div>
</body>
</html>