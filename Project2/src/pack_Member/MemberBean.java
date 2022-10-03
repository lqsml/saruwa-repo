package pack_Member;

public class MemberBean {

	private String uId;
	private String uPw;
	private String uName;
	private String uEmail;
	private String uPhone;
	private String uZipcode;
	private String uAddr;
	private String[] FaveFood;
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public String getuPw() {
		return uPw;
	}
	public void setuPw(String uPw) {
		this.uPw = uPw;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getuEmail() {
		return uEmail;
	}
	public void setuEmail(String uEmail) {
		this.uEmail = uEmail;
	}
	public String getuPhone() {
		return uPhone;
	}
	public void setuPhone(String uPhone) {
		this.uPhone = uPhone;
	}
	public String getuZipcode() {
		return uZipcode;
	}
	public void setuZipcode(String uZipcode) {
		this.uZipcode = uZipcode;
	}
	public String getuAddr() {
		return uAddr;
	}
	public void setuAddr(String uAddr) {
		this.uAddr = uAddr;
	}
	public String[] getFaveFood() {
		return FaveFood;
	}
	public void setFaveFood(String[] faveFood) {
		FaveFood = faveFood;
	}
}
