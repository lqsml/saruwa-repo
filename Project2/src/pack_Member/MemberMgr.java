package pack_Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import pack_DBCP.DBConnectionMgr;

public class MemberMgr {

	private Connection objConn = null;
	private Statement objStmt = null;
	private PreparedStatement objPstmt = null;
	private ResultSet objRS = null;
	private DBConnectionMgr objPool = null;

	// 아이디 중복 검사
	public boolean checkID(String id) {
		boolean chkRes = false; // 거짓이면 사용 가능

		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();

			String sql = "select count(*) from UserInfo where uId = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, id);
			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				int cnt = objRS.getInt(1);
				if (cnt == 1)
					chkRes = true;
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return chkRes;
	}

	// 회원가입
	public boolean memberJoin(MemberBean mBean) {

		boolean joinRes = false;

		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();

			String sql = "insert into UserInfo ";
			sql += "(uId, uPw, uName, uEmail, uPhone, zipcode, address, faveFood, sa, joinTM, status) ";
			sql += "values (?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";

			objPstmt = objConn.prepareStatement(sql);

			objPstmt.setString(1, mBean.getuId());
			objPstmt.setString(2, mBean.getuPw());
			objPstmt.setString(3, mBean.getuName());
			objPstmt.setString(4, mBean.getuEmail());
			objPstmt.setString(5, mBean.getuPhone());
			objPstmt.setString(6, mBean.getZipcode());
			objPstmt.setString(7, mBean.getAddress());

			String[] faveFood = mBean.getFaveFood();
			String[] foodName = { "한식", "양식", "일식", "중식", "분식" };
			char[] foodCode = { '0', '0', '0', '0', '0' };
			for (int i = 0; i < faveFood.length; i++) {
				for (int j = 0; j < foodName.length; j++) {
					if (faveFood[i].equals(foodName[j])) {
						foodCode[j] = '1';
					}
				}
			}
			objPstmt.setString(8, new String(foodCode));
			objPstmt.setInt(9, mBean.getSa());
			objPstmt.setInt(10, mBean.getStatus());

			int rowCnt = objPstmt.executeUpdate();

			if (rowCnt == 1) {
				joinRes = true;
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

		return joinRes;
	}

	// 로그인
	public boolean memberLogin(String uId, String uPw) {
		boolean loginRes = false; 

		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();
			
			String sql = "select count(*) from UserInfo where uId = ? and uPw = ?";
			objPstmt = objConn.prepareStatement(sql);

			objPstmt.setString(1, uId);
			objPstmt.setString(2, uPw);
			objRS = objPstmt.executeQuery();

			if (objRS.next()) {

				int recordCnt = objRS.getInt(1);
				if (recordCnt == 1) loginRes = true;

			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return loginRes;
	}
	public int chkStatus(String uId, String uPw) { // 0 이 관리자, 1 은 일반회원, -1 은 없는 정보
		
		int status = -1;
		
		try {
			
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();
			
			String sql = "select status from UserInfo where uId = ? and uPw = ?";
			objPstmt = objConn.prepareStatement(sql);
			
			objPstmt.setString(1, uId);
			objPstmt.setString(2, uPw);
			objRS = objPstmt.executeQuery();
			
			if (objRS.next()) {
				status = objRS.getInt("status");
			}
			
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}
		
		return status;
	}

	// 아이디 찾기
	public String IDFind(String uName, String uEmail) {
		String uId = null;

		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();

			String sql = "select uId from UserInfo where uName = ? and uEmail = ?";
			objPstmt = objConn.prepareStatement(sql);

			objPstmt.setString(1, uName);
			objPstmt.setString(2, uEmail);
			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				uId = objRS.getString("uId");
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return uId;
	}

	// 비밀번호 찾기
	public String PWFind(String uName, String uId, String uEmail) {
		String uPw = null;

		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();

			String sql = "select uPw from UserInfo where uName = ? and uId = ? and uEmail = ?";
			objPstmt = objConn.prepareStatement(sql);

			objPstmt.setString(1, uName);
			objPstmt.setString(2, uId);
			objPstmt.setString(3, uEmail);
			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				uPw = objRS.getString("uPw");
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return uPw;
	}

	// 회원 정보 가져오기
	public MemberBean getMemberData(String id) {

		MemberBean mBean = new MemberBean();

		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();

			String sql = "select uId, uPw, uName, uEmail, uPhone, zipcode, address, faveFood, sa";
			sql += " from UserInfo where uId = ?";
			objPstmt = objConn.prepareStatement(sql);

			objPstmt.setString(1, id);
			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				mBean.setuId(objRS.getString("uId"));
				mBean.setuPw(objRS.getString("uPw"));
				mBean.setuName(objRS.getString("uName"));
				mBean.setuEmail(objRS.getString("uEmail"));
				mBean.setuPhone(objRS.getString("uPhone"));
				mBean.setZipcode(objRS.getString("zipcode"));
				mBean.setAddress(objRS.getString("address"));

				String[] faveFoodAry = new String[5];
				String faveFood = objRS.getString("faveFood");
				faveFoodAry = faveFood.split("");
				mBean.setFaveFood(faveFoodAry);
				mBean.setSa(objRS.getInt("sa"));

			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return mBean;
	}

	// 회원 정보 수정
	public boolean modifyInfo(MemberBean mBean, String id) {
		boolean modRes = false;
	
		
		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();

			String sql = "update UserInfo set ";
			sql += "uPw = ?, uEmail =?, uPhone = ?, zipcode = ?, address = ?, faveFood = ?, sa = ?  ";
			sql += "where uId = ?";

			objPstmt = objConn.prepareStatement(sql);

			objPstmt.setString(1, mBean.getuPw());
			objPstmt.setString(2, mBean.getuEmail());
			objPstmt.setString(3, mBean.getuPhone());
			objPstmt.setString(4, mBean.getZipcode());
			objPstmt.setString(5, mBean.getAddress());

			String[] faveFood = mBean.getFaveFood();
			String[] foodName = { "한식", "양식", "일식", "중식", "분식" };
			char[] foodCode = { '0', '0', '0', '0', '0' };
			for (int i = 0; i < faveFood.length; i++) {
				for (int j = 0; j < foodName.length; j++) {
					if (faveFood[i].equals(foodName[j])) {
						foodCode[j] = '1';
					}
				}
			}
			objPstmt.setString(6, new String(foodCode));
			objPstmt.setInt(7, mBean.getSa());
			objPstmt.setString(8, id);

			int rowCnt = objPstmt.executeUpdate();

			if (rowCnt == 1)  modRes = true;
			
			} catch (Exception e) {
				System.out.println("Exception : " + e.getMessage());
			} finally {
				objPool.freeConnection(objConn, objPstmt);
			}
		
		return modRes;
		
	}
	
	// 회원 탈퇴
	public boolean memberQuit(String id) {
		boolean quitRes = false;
		
		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();

			String sql = "delete from UserInfo where uId = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, id);
			
			int rowCnt = objPstmt.executeUpdate();

			if (rowCnt == 1)  quitRes = true;
			

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
		
		return quitRes;
	}

	
	
}
