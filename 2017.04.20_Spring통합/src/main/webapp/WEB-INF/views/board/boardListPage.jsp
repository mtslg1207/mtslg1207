<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 리스트</title>
<style type="text/css">
a {text-decoration: none; color:blue; }
</style>
<script src="<c:url value='/resources/jquery-2.2.4.min.js'/>"></script>
<script src="<c:url value='/resources/jquery.bootpag.min.js'/>"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script>
function listSearch(){
	var param = $('#searchForm').serialize();
	$.ajax({
		url : 'search',
		method : 'post',
		data : param,
		dataType : 'json',
		success : function(res){
			$('#boardList').empty();
			for(var i=0 ; i<res.length ; i++){ 
				var div= $("<div style='display:table-row;'></div>");
				var span = $("<span style='display:table-cell; border:1px solid black;'>"+res[i].num+"</span>");
				div.append(span);
				span = $("<span style='display:table-cell; border:1px solid black;'>"+
	     		      	 "<a href='read?num="+res[i].num+"'>"+res[i].title+"</a></span>");
				div.append(span);
				span = $("<span style='display:table-cell; border:1px solid black;'>"+res[i].contents+"</span>");
				div.append(span);
				span = $("<span style='display:table-cell; border:1px solid black;'>"+res[i].author+"</span>");
				div.append(span);
// 				span = $("<span style='display:table-cell; border:1px solid black;'>"+res[i].fname+"</span>");
// 				div.append(span);
				
				$('#boardList').append(div);    
	     	}
		},
		error(xhr, status, err){
			alert(err);
		}
	});
	return false;
}

$(function(){
   $('#page-selection').bootpag({
        total: ${b.pageBean.totalPages},
        page: ${b.pageBean.currPage},   
        maxVisible: 3, 
        leaps: true,
        firstLastUse: true,
        first: '←',
        last: '→',
        wrapClass: 'pagination',
        activeClass: 'active',
        disabledClass: 'disabled',
        nextClass: 'next',
        prevClass: 'prev',
        lastClass: 'last',
        firstClass: 'first'
    }).on("page", function(event, num){
  		location.href="listPage?page="+num;
	});
});
</script>
</head>

<body><p>
현재 페이지/총페이지수/총 글수( ${b.pageBean.currPage} / ${b.pageBean.totalPages} / ${b.pageBean.rows} )<p>
${b.page} / ${b.totalPages}<br>
<div class="row" style="display:table-row;">
	<span style="display:table-cell; border:1px solid black;">글 번호</span>
	<span style="display:table-cell; border:1px solid black;">글 제목</span>
	<span style="display:table-cell; border:1px solid black;">내용</span>
	<span style="display:table-cell; border:1px solid black;">작성자</span>
<!-- 	<span style="display:table-cell; border:1px solid black;">파일명</span> -->
</div>

<div id="boardList">
<c:forEach var="b" items="${b.list}">
  <div class="row" style="display:table-row;">
	<span style='display:table-cell; border:1px solid black;'>${b.num}</span> 
	<span style='display:table-cell; border:1px solid black;'>
		<a href="read?num=${b.num}">${b.title}</a></span> 
	<span style='display:table-cell; border:1px solid black;'>${b.contents}</span> 
	<span style='display:table-cell; border:1px solid black;'>${b.author}</span> 
<%-- 	<span style='display:table-cell; border:3px solid black;'>${b.file}</span> --%>
  </div>
</c:forEach>
</div>

<hr>
<sec:authorize access="isAuthenticated()">
<a href="inputForm">[새글 쓰기]</a>
</sec:authorize>
<%-- ${e.pageBean.navStr} --%>
<div id="page-selection"></div>

<form id="searchForm" onsubmit="return listSearch();">
 <select name="category">
 	<option value="title" selected>제목</option>
 	<option value="author">작성자</option>
 	<option value="contents">내용</option>
 </select>
 <input type="text" name="keyword">
 <button type="submit">검색</button>
</form>

<sec:authorize access="! isAuthenticated()">
    <a href="<c:url value='/sec/dbIndex' />">게시판 첫 화면가기</a>
</sec:authorize>

<sec:authorize access="hasAuthority('USER_ADMIN')">
   	<a href="<c:url value='/sec/adminMain' />">[관리자 메인페이지 가기]</a>
</sec:authorize>

<sec:authorize access="hasAuthority('USER')">
    <a href="<c:url value='/sec/userMain' />">[회원 메인페이지 가기]</a>
</sec:authorize>
</body>
</html>