<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="wrap">
		<div class="title"> 
			<h2>아이디 찾기 결과</h2>
		</div>
		<div class="show">
			
		</div>
	</div>
</body>
<script type="text/javascript">
	var wrap = document.querySelector(".wrap");
	var title = document.querySelector(".title");
	var show = document.querySelector(".show");
	var h2 = document.querySelector("h2");
	
	wrap.style.width = "400px";
	wrap.style.height="330px";
	wrap.style.backgroundColor="yellow";
	title.style.width ="100%";
	title.style.height="100px";
	title.style.backgroundColor="#2E6FAB";
	show.style.width="100%";
	show.style.height="230px";
	show.style.backgroundColor="#F1F4F8";
	h2.style.margin="0px";
	h2.style.padding="50px 10px";
	h2.style.color="white";
	
</script>
</html>