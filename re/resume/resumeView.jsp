<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td:first-child{
	text-align:center;
}
</style>
<link href="../common/header.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String rsNum=request.getParameter("rsNum");
//response.sendRedirect("resumeView.jsp?rsNum="+rsNum);
String rsTitle="";
String profileImage="";
String pname="";
String birth="";
String age="";
String address1="";
String address2="";
String email="";
String mobile="";
String tel="";
String education="", career="", salary="", occupation="";



Connection con = null; // 데이터 베이스와 연결을 위한 객체
Statement stmt = null; // SQL 문을 데이터베이스에 보내기위한 객체
ResultSet rs = null; // SQL 질의에 의해 생성된 테이블을 저장하는 객체
// 1. JDBC Driver Class
String driver = "oracle.jdbc.driver.OracleDriver";

// 2. 데이터베이스 연결 정보
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "scott", pwd = "tiger";

// 데이터베이스 PW
String SQL1 = "SELECT rsTitle, profileImage, pname, to_char(birth,'YYYY-MM-DD') birth ,TRUNC(MONTHS_BETWEEN(SYSDATE, p.birth)/12) age, email, tel, mobile, address1, address2, b.estr education, c.cStr career, d.sStr salary, e.ostr occupation ";
String SQL2 = "FROM resume a INNER JOIN education b ON a.education=b.enum INNER JOIN CAREER c ON  a.career=c.cnum INNER JOIN salary d ON a.salary=d.snum INNER JOIN occupation e ON  a.occupation=e.onum inner JOIN personal p ON a.pNum=p.pNum "; 
String SQL3 = "WHERE a.rsNum='"+rsNum+"'";
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
		rsTitle = rs.getString("rsTitle");
		profileImage=rs.getString("profileImage");
		pname = rs.getString("pname");
		birth = rs.getString("birth");
		age = rs.getString("age");
		address1 = rs.getString("address1");
		address2 = rs.getString("address2");
		email = rs.getString("email");
		mobile = rs.getString("mobile");
		tel = rs.getString("tel");
		education = rs.getString("education");
		career= rs.getString("career");
		salary= rs.getString("salary");
		occupation = rs.getString("occupation");
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
	<h2> 이력서 상세 </h2>
	<hr>

		<table width="600" border=1 align="center" cellspacing="0" cellpadding="5" class="write">
			<tr>
				<td colspan="2" align="center"> <%=rsTitle%> </td>
			</tr>
			<tr>
				<td>사진</td>
				<td><%=profileImage%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=pname%></td>
			</tr>
			<tr>
				<td>생년월일(나이)</td>
				<td><%=birth%> (<%=age%>세)</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=email%></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><%=mobile%></td>
			</tr>
			<tr>
				<td>주소</td>
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
				<td>희망 연봉</td>
				<td><%=salary%></td>
			</tr>
			<tr>
				<td>희망 직종</td>
				<td><%=occupation%></td>
			</tr>
		</table>
		<br>
		<div align="center">
			<button id="editResume" onclick=editResume("<%=rsNum%>") class="btn">수정</button>
			<button id="deleteResume" onclick=deleteResume("<%=rsNum%>") class="btn">삭제</button>
		</div>
	</section>
<%@include file ="../common/footer.jsp" %>
</body>
<script type="text/javascript">
function editResume(rsNum){
	location.href="resumeEdit.jsp?rsNum="+rsNum;
}
function deleteResume(rsNum){
	if(confirm("이 이력서를 삭제하시겠습니까?")==true){
		location.href="resumeView_delete.jsp?rsNum="+rsNum;
	}
}

</script>
</html>