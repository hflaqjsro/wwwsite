<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>

<%
request.setCharacterEncoding("UTF-8");

String rcTitle=request.getParameter("rcTitle");
String deadline=request.getParameter("deadline");
String progress=request.getParameter("progress");
String address1=request.getParameter("address1");
String address2=request.getParameter("address2");
String career=request.getParameter("career");
String education=request.getParameter("education");
String emptype=request.getParameter("emptype");
String occupation=request.getParameter("occupation");
String title=request.getParameter("title");
String position=request.getParameter("position");
String salary=request.getParameter("salary");
String dept=request.getParameter("dept");
String prefer=request.getParameter("prefer");


Connection con = null; // 데이터 베이스와 연결을 위한 객체 
PreparedStatement pstmt = null; // SQL 문을 데이터베이스에 보내기위한 객체

//1. JDBC Driver Class
String driver="oracle.jdbc.driver.OracleDriver";
		
//2. 데이터베이스 연결 정보
String url="jdbc:oracle:thin:@localhost:1521:xe";
String user="scott", pwd="tiger";

String SQL1 = "INSERT INTO recruit ";
//RCNUM   |CNUM    |RCTITLE  |DEADLINE           |PROGRESS|ADDRESS1   |ADDRESS2 |CAREER|EDUCATION|EMPTYPE|OCCUPATION|TITLE|POSITION|SALARY|DEPT       |PREFER     |String SQL1 = "insert into resume ";
String SQL2 = "values('rc'||trim(to_char(recruit_SEQ.nextval,'000000')), ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?)";
// x rcNum
// 1 cNum
// 2 rcTitle
// 3 deadline
// 4 progress
// 5 address1
// 6 address2
// 7 career
// 8 education
// 9 emptype
// 10 occupation
// 11 title
// 12 position
// 13 salary
// 14 dept
// 15 prefer



try {
	
	//1. JDBC 드라이버 로딩
	Class.forName(driver);

	//2. Connection 생성 
	con = DriverManager.getConnection(url, user, pwd);
	
	// 3. PreParedStatement 객체 생성, 객체 생성시 SQL 문장 저장 
	pstmt = con.prepareStatement(SQL1+SQL2); 
	// 4. pstmt.set<데이터타입>(? 순서, 값) ex).setString(), .setInt ... 
	//pstmt.setString(1, ""); 
	pstmt.setString(1, "cm000001"); 
	pstmt.setString(2, rcTitle); 
	pstmt.setString(3, deadline);
	pstmt.setString(4, progress); 
	pstmt.setString(5, address1); 
	pstmt.setString(6, address2); 
	pstmt.setString(7, career); 
	pstmt.setString(8, education); 
	pstmt.setString(9, emptype); 
	pstmt.setString(10, occupation); 
	pstmt.setString(11, title); 
	pstmt.setString(12, position); 
	pstmt.setString(13, salary); 
	pstmt.setString(14, dept); 
	pstmt.setString(15, prefer); 
	
	
	// 5. SQL 문장을 실행하고 결과를 리턴 - SQL 문장 실행 후, 변경된 row 수 int type 리턴 
	int r = pstmt.executeUpdate(); 
	
}catch (ClassNotFoundException e) {
	e.printStackTrace();
}catch (Exception e) {
	// TODO: handle exception
	e.printStackTrace();
}finally {
	//사용순서와 반대로 close 함 
	if (pstmt != null) {
		try {
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		} if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
}
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		alert("등록 완료!");
		document.location.href="recruitList.jsp";	
	</script>
</body>
</html>