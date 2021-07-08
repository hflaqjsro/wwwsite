package javaexp.a00_exp.teamP_05;

public class ResumeService {
	ResumeDao rsDao = new ResumeDao();

	public Resume getResumeData(Member m) {

		return rsDao.getResumeData(m);
	}
	
	public String setResumeData(Member m, String rsNum, String rsTitle, 
								String email, String mobile,String address1) {
		
		rsDao.setResumeData(m, rsNum, rsTitle, email, mobile, address1);
		return "변경 성공!";
	}

}
