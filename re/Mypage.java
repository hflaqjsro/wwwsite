package javaexp.a00_exp.teamP_05;

import java.util.Scanner;

public class Mypage {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ResumeController rsCon = new ResumeController();
		
		Member member = new Member("pm000001");
		Model m = new Model();
		Scanner sc1 = new Scanner(System.in);

		System.out.println("========이력서 입력========");
		String rsNum, rsTitle, email, mobile, address1;
		
		System.out.print("rsNum: ");
		rsNum = sc1.nextLine();
		System.out.print("rsTitle: ");
		rsTitle = sc1.nextLine();
		System.out.print("email: ");
		email = sc1.nextLine();
		System.out.print("mobile: ");
		mobile = sc1.nextLine();
		System.out.print("address1: ");
		address1 = sc1.nextLine();
		
		
		
		rsCon.setResumeData(member, rsNum, rsTitle, email, mobile, address1, m);
		System.out.println("============================\n");
		
		System.out.println("======== 이력서 조회 ========");
		rsCon.getResumeData(member, m);
		System.out.println("============================\n");
		
		sc1.close();
	}

}
