package javaexp.a00_exp.teamP_05;

public class Resume {
	String rsNum;
	String pNum;
	String rsTitle;
	String address1;
	String email;
	String mobile;
	
	public Resume(String pNum) {
		super();
		this.pNum = pNum;
	}
	
	public String getRsNum() {
		return rsNum;
	}
	public String getpNum() {
		return pNum;
	}
	public String getRsTitle() {
		return rsTitle;
	}
	public String getAddress1() {
		return address1;
	}
	public String getEmail() {
		return email;
	}
	public void setRsNum(String rsNum) {
		this.rsNum = rsNum;
	}
	
	public void setRsTitle(String rsTitle) {
		this.rsTitle = rsTitle;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
}
