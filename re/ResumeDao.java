package javaexp.a00_exp.teamP_05;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


public class ResumeDao {

	public Resume getResumeData(Member m) {
		Resume resumeData= new Resume(m.getNum());
		
		Connection con = null; // 데이터 베이스와 연결을 위한 객체
		Statement stmt = null; // SQL 문을 데이터베이스에 보내기위한 객체
		ResultSet rs = null; // SQL 질의에 의해 생성된 테이블을 저장하는 객체
		// 1. JDBC Driver Class
		String driver = "oracle.jdbc.driver.OracleDriver";

		// 2. 데이터베이스 연결 정보
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott", pwd = "tiger";

		// 데이터베이스 PW
		String SQL = "SELECT * FROM resume where pNum='"+m.getNum()+"' order by rsNum";
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
			rs = stmt.executeQuery(SQL);
			// 5. ResultSet에 저장된 데이터 얻기 - 결과가 2개 이상
			while (rs.next()) {
				int i=0;
				resumeData.setRsNum(rs.getString("rsNum"));
				resumeData.setRsTitle(rs.getString("rsTitle"));
				resumeData.setAddress1(rs.getString("address1"));
				resumeData.setEmail(rs.getString(5));
				resumeData.setMobile(rs.getString("mobile"));
				
				System.out.println(i+". --------------------");
				System.out.println("rsNum: "+resumeData.getRsNum());
				System.out.println("pNum: "+resumeData.getpNum());
				System.out.println("rsTitle: "+resumeData.getRsTitle());
				System.out.println("email: "+resumeData.getEmail());
				System.out.println("mobile: "+resumeData.getMobile());
				System.out.println("address1: "+resumeData.getAddress1());
				
			}
			// 5. ResultSet에 저장된 데이터 얻기 - 결과가 1개
			// if(rs.next()) {
			//
			// }
			// else {
			//
			// }
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
		
		
		return resumeData;
	}
	
	public String setResumeData(Member m, String rsNum, String rsTitle, 
								String email, String mobile,String address1) {
		
		Connection con = null; // 데이터 베이스와 연결을 위한 객체 
		PreparedStatement pstmt = null; // SQL 문을 데이터베이스에 보내기위한 객체
		
		//1. JDBC Driver Class
		String driver="oracle.jdbc.driver.OracleDriver";
				
		//2. 데이터베이스 연결 정보
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String user="scott", pwd="tiger";
		
		String SQL = "insert into resume(rsNum, pNum, rsTitle, email, mobile, address1) values(?, ?, ?, ?, ?,?)";

		
		
		int i=0;
		try {
			
			//1. JDBC 드라이버 로딩
			Class.forName(driver);
		
			//2. Connection 생성 
			con = DriverManager.getConnection(url, user, pwd);
			
			// 3. PreParedStatement 객체 생성, 객체 생성시 SQL 문장 저장 
			pstmt = con.prepareStatement(SQL); 
			// 4. pstmt.set<데이터타입>(? 순서, 값) ex).setString(), .setInt ... 
			pstmt.setString(1, rsNum); 
			pstmt.setString(2, m.getNum()); 
			pstmt.setString(3, rsTitle); 
			pstmt.setString(4, email);
			pstmt.setString(5, mobile); 
			pstmt.setString(6, address1); 
			
			
			// 5. SQL 문장을 실행하고 결과를 리턴 - SQL 문장 실행 후, 변경된 row 수 int type 리턴 
			pstmt.executeUpdate(); 

			
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
		
		return "저장 성공";
		
	}
}
