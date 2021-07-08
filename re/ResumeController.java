package javaexp.a00_exp.teamP_05;



public class ResumeController {
	ResumeService rsService = new ResumeService();

	public String getResumeData(Member m, Model d) {
		d.addAttribute("이력서 조회", rsService.getResumeData(m));	

		Resume rs = rsService.getResumeData(m);
		
		System.out.println("--------------------");
		System.out.println("rsNum: "+rs.getRsNum());
		System.out.println("pNum: "+rs.getpNum());
		System.out.println("rsTitle: "+rs.getRsTitle());
		System.out.println("email: "+rs.getEmail());
		System.out.println("mobile: "+rs.getMobile());
		System.out.println("address1: "+rs.getAddress1());

		System.out.println("--------------------");
		return "회원정보 요약 출력";
	}
	
	public String setResumeData(Member m, String rsNum, String rsTitle, 
			String email, String mobile,String address1, Model d) {
		
		d.addAttribute("이력서 생성", rsService.setResumeData(m, rsNum, rsTitle, email, mobile, address1));	

		//임의로 출력하면...
		System.out.println("--------------------");
		System.out.println("이력서 생성 완료!");
		System.out.println("--------------------");

		return "호출화면";
	}
}

