<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>

<%
request.setCharacterEncoding("UTF-8");

String rsNum=request.getParameter("rsNum");


Connection con = null; // 데이터 베이스와 연결을 위한 객체 
PreparedStatement pstmt = null; // SQL 문을 데이터베이스에 보내기위한 객체

//1. JDBC Driver Class
String driver="oracle.jdbc.driver.OracleDriver";
		
//2. 데이터베이스 연결 정보
String url="jdbc:oracle:thin:@localhost:1521:xe";
String user="scott", pwd="tiger";

String SQL1 = "delete from resume ";
String SQL2 = "where rsNum ='"+rsNum+"'";


try {
	
	//1. JDBC 드라이버 로딩
	Class.forName(driver);

	//2. Connection 생성 
	con = DriverManager.getConnection(url, user, pwd);
	
	// 3. PreParedStatement 객체 생성, 객체 생성시 SQL 문장 저장 
	pstmt = con.prepareStatement(SQL1+SQL2); 
	
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
		alert("삭제 완료!");
		document.location.href="resumeList.jsp";	
	</script>
</body>
</html>