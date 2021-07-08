<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../common/header.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
/*
String rsTitle="";
String education="", career="", salary="", occupation="";
*/
String[][] resume=new String[5][6]; //한 페이지에 이력서 5개까지 출력, 각 항목당 5개 값 출력.


Connection con = null; // 데이터 베이스와 연결을 위한 객체
Statement stmt = null; // SQL 문을 데이터베이스에 보내기위한 객체
ResultSet rs = null; // SQL 질의에 의해 생성된 테이블을 저장하는 객체
// 1. JDBC Driver Class
String driver = "oracle.jdbc.driver.OracleDriver";

// 2. 데이터베이스 연결 정보
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "scott", pwd = "tiger";

// 데이터베이스 PW
String SQL1 = "SELECT rsNum, rsTitle, b.estr education, c.cStr career, d.sStr salary, e.ostr occupation ";
String SQL2 = "FROM resume a INNER JOIN education b ON a.education=b.enum INNER JOIN CAREER c ON  a.career=c.cnum INNER JOIN salary d ON a.salary=d.snum INNER JOIN occupation e ON  a.occupation=e.onum inner JOIN personal p ON a.pNum=p.pNum "; 
String SQL3 = "WHERE a.pNum='pm000001' order by rsNum desc";
try {
	// 1. JDBC 드라이버 로딩
	Class.forName(driver);
	// 2. Connection 객체 생성
	con = DriverManager.getConnection(url, user, pwd);

	// DB 연결
	// 3. Statement 객체 생성
	stmt = con.createStatement();
	// 4. SQL 문장을 실행하고 결과를 리턴
	// stmt.excuteQuery(SQL) : select
	// stmt.excuteUpdate(SQL) : insert, update, delete ..
	rs = stmt.executeQuery(SQL1+SQL2+SQL3);
	// 5. ResultSet에 저장된 데이터 얻기 - 결과가 2개 이상
	
	for(int i=0; rs.next(); i++){
		resume[i][0]= rs.getString("rsNum");
		resume[i][1]= rs.getString("rsTitle");
		resume[i][2]= rs.getString("education");
		resume[i][3]= rs.getString("career");
		resume[i][4]= rs.getString("salary");
		resume[i][5]= rs.getString("occupation");
		if(i+1>=5) break;
	}
} catch (SQLException e) {
	System.out.println("SQL Error : " + e.getMessage());
} catch (ClassNotFoundException e1) {
	System.out.println("[JDBC Connector Driver 오류 : " + e1.getMessage() + "]");
} finally { // 사용순서와 반대로 close 함
	if (rs != null) {
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if (stmt != null) {
		try {
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if (con != null) {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}


%>
<%@include file ="../common/header.jsp" %>
	<section>
	<h2> 이력서 목록 </h2>
	<div align="right"> <button id="writeResume" onclick="writeResume()">이력서 작성</button></div>
	<hr>
	<div id="resumeList">
	<ol>
	<div id="res01">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5" class="write">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td colspan="4" align="center"> <%=resume[0][1]%> </td>
				<td rowspan="2" align="center"> 
				<button onclick=rsView1("<%=resume[0][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td><%=resume[0][2]%></td>
				<td><%=resume[0][3]%></td>
				<td><%=resume[0][4]%></td>
				<td><%=resume[0][5]%></td>
			</tr>
		</table>
	</li>
	</div>
		<br>
		<br>
	<div id="res02">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5" class="write">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td colspan="4" align="center"> <%=resume[1][1]%> </td>
				<td rowspan="2" align="center"> 
				<button onclick=rsView1("<%=resume[1][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td><%=resume[1][2]%></td>
				<td><%=resume[1][3]%></td>
				<td><%=resume[1][4]%></td>
				<td><%=resume[1][5]%></td>
			</tr>
		</table>
	</li>
	</div>
		<br>
		<br>
	<div id="res03">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5" class="write">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td colspan="4" align="center"> <%=resume[2][1]%> </td>
				<td rowspan="2" align="center"> 
				<button onclick=rsView1("<%=resume[2][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td><%=resume[2][2]%></td>
				<td><%=resume[2][3]%></td>
				<td><%=resume[2][4]%></td>
				<td><%=resume[2][5]%></td>
			</tr>
		</table>
	</li>
	</div>
		<br>
		<br>
	<div id="res04">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5" class="write">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td colspan="4" align="center"> <%=resume[3][1]%> </td>
				<td rowspan="2" align="center"> 
				<button onclick=rsView1("<%=resume[3][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td><%=resume[3][2]%></td>
				<td><%=resume[3][3]%></td>
				<td><%=resume[3][4]%></td>
				<td><%=resume[3][5]%></td>
			</tr>
		</table>
	</li>
	</div>
		<br>
		<br>
	<div id="res05">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5" class="write">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td colspan="4" align="center"> <%=resume[4][1]%> </td>
				<td rowspan="2" align="center"> 
				<button onclick=rsView1("<%=resume[4][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td><%=resume[4][2]%></td>
				<td><%=resume[4][3]%></td>
				<td><%=resume[4][4]%></td>
				<td><%=resume[4][5]%></td>
			</tr>
		</table>
	</li>
	</div>
	</ol>
	</div>
	<hr>
	</section>
	<%@include file ="../common/footer.jsp" %>
</body>
<script type="text/javascript">

if("<%=resume[0][0]%>"=="null"){
	var res01 = document.querySelector("#res01");
	res01.innerHTML="";
}
if("<%=resume[1][0]%>"=="null"){
	var res02 = document.querySelector("#res02");
	res02.innerHTML="";
}
if("<%=resume[2][0]%>"=="null"){
	var res03 = document.querySelector("#res03");
	res03.innerHTML="";
}
if("<%=resume[3][0]%>"=="null"){
	var res04 = document.querySelector("#res04");
	res04.innerHTML="";
}
if("<%=resume[4][0]%>"=="null"){
	var res05 = document.querySelector("#res05");
	res05.innerHTML="";
}

function writeResume() {
	location.href="writeResume.jsp";
}
function rsView1(rsNum) {
	location.href="resumeView.jsp?rsNum="+rsNum;
}

</script>
</html>