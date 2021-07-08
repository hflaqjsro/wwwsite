<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입 결과</h2>
	<h3>이름 : ${param.pname}</h3>
	<h3>아이디 : ${param.id}</h3>
	<h3>비밀번호 : ${param.pw}</h3>
	<h3>메일 : ${param.fullMail}</h3>
	<h3>휴대폰 : ${param.fullHp}</h3>
	<h3>주소 : ${param.add}</h3>
</body>
</html>