package pack_Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import pack_DBCP.DBConnectionMgr;

public class AdminMgr {
	
	private Connection objConn = null;
	private Statement objStmt = null;
	private PreparedStatement objPstmt = null;
	private ResultSet objRS = null;
	private DBConnectionMgr objPool = null;
	
	public List<AdminBean> memberList(){
		
		List<AdminBean> objList = null;
		
		try {

			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();

			String sql = "select uNum, uId, uPw, uName, uEmail, uPhone, zipcode, address, faveFood, joinTM, sa ";
					sql += "from UserInfo order by uNum desc";
					
			objStmt = objConn.createStatement();
			objRS = objStmt.executeQuery(sql);
			
			AdminBean adBean = null;
			objList = new Vector<AdminBean>();
			
			while(objRS.next()){
				
				adBean = new AdminBean();
				
				adBean.setuNum(objRS.getInt("uNum"));
				adBean.setuId(objRS.getString("uId"));
				adBean.setuPw(objRS.getString("uPw"));
				adBean.setuName(objRS.getString("uName"));
				adBean.setuEmail(objRS.getString("uEmail"));
				adBean.setuPhone(objRS.getString("uPhone"));
				adBean.setZipcode(objRS.getString("zipcode"));
				adBean.setAddress(objRS.getString("address"));
				String[] faveFoodAry = new String[5];
				String faveFood = objRS.getString("faveFood");
				faveFoodAry = faveFood.split("");
				adBean.setFaveFood(faveFoodAry);
				adBean.setJoinTM(objRS.getString("joinTM"));
				adBean.setSa(objRS.getInt("sa"));
				
				objList.add(adBean);
				
			}
			
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objStmt, objRS);
		}
		
		return objList;
		
	}

}
