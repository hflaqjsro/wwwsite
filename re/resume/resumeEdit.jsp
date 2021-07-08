<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<%
String rsNum=request.getParameter("rsNum");
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
String SQL1 = "SELECT rsTitle, profileImage, pname, to_char(birth,'YYYY-MM-DD') birth ,TRUNC(MONTHS_BETWEEN(SYSDATE, p.birth)/12) age, email, tel, mobile, address1, address2, education, career, salary, occupation ";
String SQL2 = "FROM resume a inner JOIN personal p ON a.pNum=p.pNum "; 
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
		//education = rs.getString("education");
		//career= rs.getString("career");
		//salary= rs.getString("salary");
		//occupation = rs.getString("occupation");
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
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="validate.js" ></script> 
<link href="writeForm.css" rel="stylesheet" type="text/css">
<link href="../common/header.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@include file ="../common/header.jsp" %>
<section>
	<h2> 이력서 수정 </h2>
	<hr>
		<form method="post" onsubmit="return validate();" action="resumeEdit_update.jsp?rsNum=<%=rsNum %>" name="write">
		<table width="650" border=1 align="center" cellspacing="0" cellpadding="5" class="write">
			<col width="150">
			<col width="500">
			<tr>
				<td colspan="2" align="center"> 이력서 입력 </td>
			</tr>
			<tr>
				<td>이력서 제목<span id="required">*</span></td>
				<td><input type="text" id="rsTitle" name="rsTitle" size=30 style="width:450px;" value=<%=rsTitle %>></td>
			</tr>
			<tr>
				<td>사진</td>
				<td><input type="file" accept="image/*" id="fileInput">
					<input type='button' value='확인' onclick='getFilePath()'>
					<br>경로: <a name="profileImage" id="previewText"><%=profileImage %> </a>
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=pname %></td>
			</tr>
			<tr>
				<td>생년월일(나이)</td>
				<td><%=birth%> (<%=age%>세)</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="tel" size=11 value=<%=tel %>>
				<span style = " font-size:9px; color: green;">하이픈(-) 제외하고 입력</span>
				</td>
				
			</tr>
			<tr>
				<td>휴대전화번호<span id="required">*</span></td>
				<td><input type="text" name="mobile" size=11 value="<%=mobile%>">
				<span style = " font-size:9px; color: green;">하이픈(-) 제외하고 입력</span>
				</td>
			</tr>
			<tr>
				<td>주소<span id="required">*</span></td>
				<td><input type="text" id="roadAddress" name="address1" size=50 placeholder="도로명주소" onclick="execDaumPostcode()" readonly > 
					<span id="guide"
						style="color: #999; display: none"></span> 
					<br>
					<input type="text"
						id="detailAddress" name="address2" size=50 placeholder="상세주소"> 
					<script
						src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
					</script>
					<script>
						//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
						function execDaumPostcode() {
							new daum.Postcode(
									{
										oncomplete : function(data) {
											// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

											// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
											// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
											var roadAddr = data.roadAddress; // 도로명 주소 변수
											var extraRoadAddr = ''; // 참고 항목 변수

											// 법정동명이 있을 경우 추가한다. (법정리는 제외)
											// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											if (data.bname !== ''
													&& /[동|로|가]$/g
															.test(data.bname)) {
												extraRoadAddr += data.bname;
											}
											// 건물명이 있고, 공동주택일 경우 추가한다.
											if (data.buildingName !== ''
													&& data.apartment === 'Y') {
												extraRoadAddr += (extraRoadAddr !== '' ? ', '
														+ data.buildingName
														: data.buildingName);
											}
											// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											if (extraRoadAddr !== '') {
												extraRoadAddr = ' ('+ extraRoadAddr + ')';
											}

											// 주소 정보를 해당 필드에 넣는다.
											document.getElementById("roadAddress").value = roadAddr;
										}
									}).open();
						}
					</script></td>
			</tr>
			<tr>
				<td>이메일<span id="required">*</span></td>
				<td><input type="text" name="email" size=30 value="<%=email%>"></td>
			</tr>
			<tr>
				<td>최종 학력<span id="required">*</span></td>
				<td id="edu">
					<input type="radio" name="education" value="1">초등학교 졸업<br>
					<input type="radio" name="education" value="2">중학교 졸업<br>
					<input type="radio" name="education" value="3" id="test">고등학교 졸업<br>
					<input type="radio" name="education" value="4">대학교 졸업 이상<br>				
				</td>
			</tr>
			<tr>
				<td>경력<span id="required">*</span></td>
				<td id="car">
					<input type="radio" name="career" value="1">신입<br>
					<input type="radio" name="career" value="2">1~3년<br>
					<input type="radio" name="career" value="3">4~6년<br>
					<input type="radio" name="career" value="4">7~9년<br>
					<input type="radio" name="career" value="5">10~15년<br>
					<input type="radio" name="career" value="6">16~20년<br>				
				</td>
			</tr>
			<tr>
				<td>희망 연봉<span id="required">*</span></td>
				<td id="sal">
					<input type="radio" name="salary" value="1">회사 내규에 따름<br>
					<input type="radio" name="salary" value="2">~ 2천<br>
					<input type="radio" name="salary" value="3">2천 ~ 3천<br>
					<input type="radio" name="salary" value="4">3천 ~ 4천<br>
					<input type="radio" name="salary" value="5">4천 ~ 5천<br>
					<input type="radio" name="salary" value="6">5천 ~ 6천<br>
					<input type="radio" name="salary" value="7">6천 이상<br>
					<input type="radio" name="salary" value="8">면접 후 결정<br>
				</td>
			</tr>
			<tr>
				<td>희망 직종<span id="required">*</span></td>
				<td id="occ"><select id="occupation" name="occupation">
						<option value="">직종 선택</option>
						<option value="100">서비스업</option>
						<option value="200">금융업</option>
						<option value="300">IT/정보통신</option>
						<option value="400">판매유통</option>
						<option value="500">제조생산</option>
						<option value="600">교육</option>
						<option value="700">건설</option>
						<option value="800">의료/제약</option>
						<option value="900">미디어/예술</option>
				</select></td>
			</tr>				
			<tr>
				<td colspan="2" align="center"><input type=submit value="수정확인" class="btn2"></td>
			</tr>
		</table>
	</form>
	</section>
<%@include file ="../common/footer.jsp" %>
</body>
<script type="text/javascript">
var previewText = document.querySelector("#previewText");
function getFilePath() {
	//input file 태그.
	var file = document.getElementById('fileInput');
	//파일 경로.
	var filePath = file.value;
	previewText.innerHTML=filePath;
}

</script>
<!--    Jquery 말을 안듣네......
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js">
var education=<%=education %>;
$('input[name="education"][value="'+<%=education %>+'"]').prop("checked",true);
alert($('input[name="education"][value="'+<%=education %>+'"]').val());
</script>
 -->
</html>