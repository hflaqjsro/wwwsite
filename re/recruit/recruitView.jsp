<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../common/header.css" rel="stylesheet" type="text/css">
<style type="text/css">
td:first-child{
	text-align:center;
}

</style>
</head>
<body>
<%
String rcNum=request.getParameter("rcNum");

String cname="";
String email="";
String mobile="";

String rcTitle="";
String deadline="";
String progress="";
String address1="";
String address2="";
String career="";
String education="";
String emptype="";
String occupation="";
String title="";
String position="";
String salary="";
String dept="";
String prefer="";



Connection con = null; // 데이터 베이스와 연결을 위한 객체
Statement stmt = null; // SQL 문을 데이터베이스에 보내기위한 객체
ResultSet rs = null; // SQL 질의에 의해 생성된 테이블을 저장하는 객체
// 1. JDBC Driver Class
String driver = "oracle.jdbc.driver.OracleDriver";

// 2. 데이터베이스 연결 정보
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "scott", pwd = "tiger";

// 데이터베이스 PW
String SQL1 = "SELECT rctitle, to_char(deadline, 'yyyy-mm-dd') deadline, pg.pgstr progress, ";
SQL1+="c.cStr career, e.ostr occupation, b.estr education, et.ETSTR emptype, j.JTSTR title, j2.JPSTR position, d.SSTR salary, ";
SQL1+="dept, prefer, address1, address2, cname, cmail, chp ";
String SQL2 = "FROM recruit a INNER JOIN education b ON a.education=b.enum INNER JOIN CAREER c ON  a.career=c.cnum INNER JOIN salary d ON a.salary=d.snum INNER JOIN occupation e ON  a.occupation=e.onum ";
SQL2+="INNER JOIN EMPTYPE et ON a.EMPTYPE = et.ETNUM INNER JOIN JOBTITLE j ON a.TITLE = j.JTNUM INNER JOIN JOBPOSITION j2 ON a.POSITION= j2.JPNUM INNER JOIN PROGRESS pg ON a.PROGRESS =pg.pgnum inner JOIN company cm ON a.cNum=cm.cNum ";
String SQL3 = "WHERE a.rcNum='"+rcNum+"'";
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
	while (rs.next()) {
		cname = rs.getString("cname");
		email = rs.getString("cmail");
		mobile = rs.getString("chp");
		
		rcTitle = rs.getString("rcTitle");
		deadline = rs.getString("deadline");
		progress = rs.getString("progress");
		address1 = rs.getString("address1");
		address2 = rs.getString("address2");
		career= rs.getString("career");
		education = rs.getString("education");
		emptype = rs.getString("emptype");
		occupation = rs.getString("occupation");
		title= rs.getString("title");
		position= rs.getString("position");
		salary= rs.getString("salary");
		dept= rs.getString("dept");
		prefer= rs.getString("prefer");
		
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
		<table width="600" border=1 align="center" cellspacing="0" cellpadding="10" class="write">
			<tr>
				<td colspan="2" align="center"> <%=rcTitle%> </td>
			</tr>
			<tr>
				<td>기업 이름</td>
				<td><%=cname%></td>
			</tr>
			
			<tr>
				<td>공고 마감일</td>
				<td><%=deadline %>
				</td>
			</tr>
			<tr>
				<td>상태</td>
				<td><%=progress %></td>
			</tr>
			<tr>
				<td>근무지 주소</td>
				<td><%=address1%>,<br><%=address2%></td>
			</tr>
			<tr>
				<td>최종학력</td>
				<td><%=education%></td>
			</tr>
			<tr>
				<td>경력</td>
				<td><%=career%></td>
			</tr>
			<tr>
				<td>고용형태</td>
				<td><%=emptype%></td>
			</tr>
			<tr>
				<td>직종</td>
				<td><%=occupation%></td>
			</tr>
			<tr>
				<td>직급</td>
				<td><%=title%></td>
			</tr>
			<tr>
				<td>직책</td>
				<td><%=position%></td>
			</tr>
			<tr>
				<td>연봉</td>
				<td><%=salary%></td>
			</tr>
			<tr>
				<td>직무설명</td>
				<td><%=dept%></td>
			</tr>
			<tr>
				<td>우대조건</td>
				<td><%=prefer%></td>
			</tr>
			<tr>
				<td>담당자 연락처</td>
				<td>이메일: <%=email%>
					<br>전화번호: <%=mobile%></td>
			</tr>
		</table>
		
		<br>
		<div align="center">
			<button id="deleteResume" onclick=deleteRecruit("<%=rcNum%>") class="btn">삭제</button>
		</div>
	</section>
<%@include file ="../common/footer.jsp" %>
</body>
<script type="text/javascript">

function deleteRecruit(rcNum){
	if(confirm("이 공고를 삭제하시겠습니까?")==true){
		location.href="recruitView_delete.jsp?rcNum="+rcNum;
	}
}

</script>
</html>