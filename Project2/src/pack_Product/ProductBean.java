package pack_Product;

public class ProductBean {
	
	private int pNum =0;
	private String pCode =null;
	private String pName =null;
	private int pOrigPrice =0; //원가
	private int pDiscountR =0;  //할인율
	private int pDivi =0;		//카테고리
	private int pSellPrice =0;  //판매가
	private int pQuan =0;		//재고량
	private String pTM =null;
	private String pOrigImg =null;
	private String pSysImg =null;
	private int pSize =0;
	private int pReadCnt =0;
	private String pContent = null;
	
	
	public String getpContent() {
		return pContent;
	}
	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	public int getpReadCnt() {
		return pReadCnt;
	}
	public void setpReadCnt(int pReadCnt) {
		this.pReadCnt = pReadCnt;
	}
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public String getpCode() {
		return pCode;
	}
	public void setpCode(String pCode) {
		this.pCode = pCode;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getpOrigPrice() {
		return pOrigPrice;
	}
	public void setpOrigPrice(int pOrigPrice) {
		this.pOrigPrice = pOrigPrice;
	}
	public int getpDiscountR() {
		return pDiscountR;
	}
	public void setpDiscountR(int pDiscountR) {
		this.pDiscountR = pDiscountR;
	}
	public int getpDivi() {
		return pDivi;
	}
	public void setpDivi(int pDivi) {
		this.pDivi = pDivi;
	}
	public int getpSellPrice() {
		return pSellPrice;
	}
	public void setpSellPrice(int pSellPrice) {
		this.pSellPrice = pSellPrice;
	}
	public int getpQuan() {
		return pQuan;
	}
	public void setpQuan(int pQuan) {
		this.pQuan = pQuan;
	}
	public String getpTM() {
		return pTM;
	}
	public void setpTM(String pTM) {
		this.pTM = pTM;
	}
	public String getpOrigImg() {
		return pOrigImg;
	}
	public void setpOrigImg(String pOrigImg) {
		this.pOrigImg = pOrigImg;
	}
	public String getpSysImg() {
		return pSysImg;
	}
	public void setpSysImg(String pSysImg) {
		this.pSysImg = pSysImg;
	}
	public int getpSize() {
		return pSize;
	}
	public void setpSize(int pSize) {
		this.pSize = pSize;
	}

}
