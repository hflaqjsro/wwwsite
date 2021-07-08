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
String[][] recruit=new String[5][10]; //한 페이지에 이력서 5개까지 출력, 각 항목당 9개 값 출력.


Connection con = null; // 데이터 베이스와 연결을 위한 객체
Statement stmt = null; // SQL 문을 데이터베이스에 보내기위한 객체
ResultSet rs = null; // SQL 질의에 의해 생성된 테이블을 저장하는 객체
// 1. JDBC Driver Class
String driver = "oracle.jdbc.driver.OracleDriver";

// 2. 데이터베이스 연결 정보
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "scott", pwd = "tiger";

// 데이터베이스 PW
String SQL1 = "SELECT rcNum, cm.cname cname, rcTitle, address1, b.estr education, c.cStr career, d.sStr salary, e.ostr occupation, et.ETSTR emptype, j.JTSTR title ";
String SQL2 = "FROM recruit a INNER JOIN education b ON a.education=b.enum INNER JOIN CAREER c ON  a.career=c.cnum INNER JOIN salary d ON a.salary=d.snum INNER JOIN occupation e ON  a.occupation=e.onum ";
String SQL3 = "INNER JOIN EMPTYPE et ON a.EMPTYPE = et.ETNUM INNER JOIN JOBTITLE j ON a.TITLE = j.JTNUM  inner JOIN company cm ON a.cNum=cm.cNum "; 
String SQL4 = "WHERE a.cNum='cm000001' order by rcNum desc";
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
	rs = stmt.executeQuery(SQL1+SQL2+SQL3+SQL4);
	// 5. ResultSet에 저장된 데이터 얻기 - 결과가 2개 이상
	
	for(int i=0; rs.next(); i++){
		recruit[i][0]= rs.getString("rcNum");
		recruit[i][1]= rs.getString("cname");
		recruit[i][2]= rs.getString("rcTitle");
		recruit[i][3]= rs.getString("address1");
		recruit[i][4]= rs.getString("career");
		recruit[i][5]= rs.getString("education");
		recruit[i][6]= rs.getString("emptype");
		recruit[i][7]= rs.getString("title");
		recruit[i][8]= rs.getString("salary");
		recruit[i][9]= rs.getString("occupation");
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
	<h2> 채용공고 목록 </h2>
	<div align="right"> <button id="writeRecruit" onclick="writeRecruit()">채용공고 작성</button></div>
	<hr>
	<div id="recruitList">
	<ol>
	<div id="rec01">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5" class="write">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td><%=recruit[0][1] %></td>
				<td colspan="3" align="center"> <%=recruit[0][2]%> </td>
				<td rowspan="3" align="center"> 
					<button onclick=rcView1("<%=recruit[0][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td colspan="2"><%=recruit[0][3]%></td>
				<td><%=recruit[0][7]%></td>
				<td><%=recruit[0][6]%></td>
			</tr>
			<tr>
				<td><%=recruit[0][5]%></td>
				<td><%=recruit[0][4]%></td>
				<td><%=recruit[0][8]%></td>
				<td><%=recruit[0][9]%></td>
			</tr>
		</table>
	</li>
	</div>
		<br>
		<br>
	<div id="rec02">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td><%=recruit[1][1] %></td>
				<td colspan="3" align="center"> <%=recruit[1][2]%> </td>
				<td rowspan="3" align="center"> 
					<button onclick=rcView1("<%=recruit[1][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td colspan="2"><%=recruit[1][3]%></td>
				<td><%=recruit[1][7]%></td>
				<td><%=recruit[1][6]%></td>
			</tr>
			<tr>
				<td><%=recruit[1][5]%></td>
				<td><%=recruit[1][4]%></td>
				<td><%=recruit[1][8]%></td>
				<td><%=recruit[1][9]%></td>
			</tr>
		</table>
	</li>
	</div>
		<br>
		<br>
	<div id="rec03">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td><%=recruit[2][1] %></td>
				<td colspan="3" align="center"> <%=recruit[2][2]%> </td>
				<td rowspan="3" align="center"> 
					<button onclick=rcView1("<%=recruit[2][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td colspan="2"><%=recruit[2][3]%></td>
				<td><%=recruit[2][7]%></td>
				<td><%=recruit[2][6]%></td>
			</tr>
			<tr>
				<td><%=recruit[2][5]%></td>
				<td><%=recruit[2][4]%></td>
				<td><%=recruit[2][8]%></td>
				<td><%=recruit[2][9]%></td>
			</tr>
		</table>
	</li>
	</div>
		<br>
		<br>
	<div id="rec04">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td><%=recruit[3][1] %></td>
				<td colspan="3" align="center"> <%=recruit[3][2]%> </td>
				<td rowspan="3" align="center"> 
					<button onclick=rcView1("<%=recruit[3][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td colspan="2"><%=recruit[3][3]%></td>
				<td><%=recruit[3][7]%></td>
				<td><%=recruit[3][6]%></td>
			</tr>
			<tr>
				<td><%=recruit[3][5]%></td>
				<td><%=recruit[3][4]%></td>
				<td><%=recruit[3][8]%></td>
				<td><%=recruit[3][9]%></td>
			</tr>
		</table>
	</li>
	</div>
		<br>
		<br>
	<div id="rec05">
	<li>
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5">
			<col width=30%>
			<col width=15%>
			<col width=20%>
			<col width=20%>
			<col width=15%>
			<tr>
				<td><%=recruit[4][1] %></td>
				<td colspan="3" align="center"> <%=recruit[4][2]%> </td>
				<td rowspan="3" align="center"> 
					<button onclick=rcView1("<%=recruit[4][0]%>")>상세</button>
				</td>
			</tr>
			<tr>
				<td colspan="2"><%=recruit[4][3]%></td>
				<td><%=recruit[4][7]%></td>
				<td><%=recruit[4][6]%></td>
			</tr>
			<tr>
				<td><%=recruit[4][5]%></td>
				<td><%=recruit[4][4]%></td>
				<td><%=recruit[4][8]%></td>
				<td><%=recruit[4][9]%></td>
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

if("<%=recruit[0][0]%>"=="null"){
	var rec01 = document.querySelector("#rec01");
	rec01.innerHTML="";
}
if("<%=recruit[1][0]%>"=="null"){
	var rec02 = document.querySelector("#rec02");
	rec02.innerHTML="";
}
if("<%=recruit[2][0]%>"=="null"){
	var rec03 = document.querySelector("#rec03");
	rec03.innerHTML="";
}
if("<%=recruit[3][0]%>"=="null"){
	var rec04 = document.querySelector("#rec04");
	rec04.innerHTML="";
}
if("<%=recruit[4][0]%>"=="null"){
	var rec05 = document.querySelector("#rec05");
	rec05.innerHTML="";
}


function writeRecruit() {
	location.href="writeRecruit.jsp";
}
function rcView1(rcNum) {
	location.href="recruitView.jsp?rcNum="+rcNum;
}

</script>
</html>