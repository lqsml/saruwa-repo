package pack_BBS;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack_DBCP.DBConnectionMgr;

public class BoardMgr {

	private DBConnectionMgr objPool;
	
	Connection 			objConn 		= 		null;
	PreparedStatement 	objPstmt 		= 		null;
	Statement			objStmt 		= 		null;
	ResultSet 			objRS 			= 		null;

	public BoardMgr() {
		try {
			objPool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		}

	}
	

/*  게시판 입력(/bbs/postProc.jsp) 시작  */
	public void insertBoard(HttpServletRequest req) {

		String sql = null;
		MultipartRequest multi = null;
		int fileSize = 0;
		String fileName = null;

		try {
			objConn = objPool.getConnection();
			sql = "select max(num) from tblBoard";
			objPstmt = objConn.prepareStatement(sql);
			objRS = objPstmt.executeQuery();

			int ref = 1; // 답변글 작성용, 원본글의 글번호(num)와 일치
			if (objRS.next())
				ref = objRS.getInt(1) + 1;
			// 현재 DB tblBoard에 데이터가 3개(num 컬럼에 1, 2, 3)가
			// 있다고 가정하면 max(num)는 3을 반환함. 
			// 그러므로 새 글번호를 참조하는 DB의 컬럼 ref는 4가 됨.

			File file = new File(SAVEFOLER);

			if (!file.exists())
				file.mkdirs();

			multi = new MultipartRequest(req, SAVEFOLER, maxSize, encType, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("fileName") != null) {
				fileName = multi.getFilesystemName("fileName");
				fileSize = (int) multi.getFile("fileName").length();
			}
			String content = multi.getParameter("content");

			if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}

			sql = "insert into tblBoard (";
			sql += "uId, uName, subject, content, ref, pos, depth, ";
			sql += "regTM, ip, readCnt, fileName, fileSize) values (";
			sql += "?, ?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?)";

			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, multi.getParameter("uId"));
			objPstmt.setString(2, multi.getParameter("uName"));
			objPstmt.setString(3, multi.getParameter("subject"));
			objPstmt.setString(4, content);
			objPstmt.setInt(5, ref);
			objPstmt.setString(6, multi.getParameter("ip"));
			objPstmt.setString(7, fileName);
			objPstmt.setInt(8, fileSize);
			objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

	}
	/*  게시판 입력(/bbs/postProc.jsp) 끝  */
	
	


	/*  게시판 리스트 출력 (/bbs/list.jsp) 시작    */
	public Vector<BoardBean> getBoardList(String keyField, String keyWord, int start, int end) {

		Vector<BoardBean> vList = new Vector<>();
		String sql = null;

		try {
			objConn = objPool.getConnection();
			
			
			if (keyWord.equals("null") || keyWord.equals("")) {
				// 검색어가 없을 경우
				sql = "select * from tblBoard "
						+ "order by ref desc, pos asc limit ?, ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, start);
				objPstmt.setInt(2, end);
			} else {
				// 검색어가 있을 경우
				sql = "select * from tblBoard "
						+ "where "+ keyField +" like ? "
						+ "order by ref desc, pos asc limit ?, ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%"+keyWord+"%");
				objPstmt.setInt(2, start);
				objPstmt.setInt(3, end);				
			}
			
			
			objRS = objPstmt.executeQuery();

			while (objRS.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(objRS.getInt("num"));
				bean.setuName(objRS.getString("uName"));
				bean.setSubject(objRS.getString("subject"));
				bean.setPos(objRS.getInt("pos"));
				bean.setRef(objRS.getInt("ref"));
				bean.setDepth(objRS.getInt("depth"));
				bean.setRegTM(objRS.getString("regTM"));
				bean.setReadCnt(objRS.getInt("readCnt"));
				vList.add(bean);
			}
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return vList;
	}


	/*  게시판 리스트 출력(/bbs/list.jsp) 끝  */

	

	/* 총 게시물 수(/bbs/list.jsp) 시작  */
	public int getTotalCount(String keyField, String keyWord) {

		String sql = null;
		int totalCnt = 0;

		try {
			objConn = objPool.getConnection();
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblBoard";
				objPstmt = objConn.prepareStatement(sql);
			} else {
				sql = "select count(*) from tblBoard ";
				sql += "where "+keyField+" like ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%" + keyWord + "%");
			}

			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				totalCnt = objRS.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return totalCnt;
	}
	/* 총 게시물 수(/bbs/list.jsp) 끝  */
	

	
	
	
	/* 게시판 뷰페이지 조회수 증가 시작 (/bbs/read.jsp, 내용보기 페이지) */
	public void upCount(int num) {
		String sql = null;

		try {
			objConn = objPool.getConnection();
			sql = "update tblBoard set readCnt = readCnt+1 where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

	}
	/* 게시판 뷰페이지 조회수 증가 끝 (/bbs/read.jsp, 내용보기 페이지) */
	
	

	/*	상세보기 페이지 게시글 출력 시작 (/bbs/read.jsp, 내용보기 페이지) */
	public BoardBean getBoard(int num) {
		String sql = null;

		BoardBean bean = new BoardBean();
		try {
			objConn = objPool.getConnection(); 
			sql = "select * from tblBoard where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				bean.setNum(objRS.getInt("num"));
				bean.setuId(objRS.getString("uId"));
				bean.setuName(objRS.getString("uName"));
				bean.setSubject(objRS.getString("subject"));
				bean.setContent(objRS.getString("content"));
				bean.setPos(objRS.getInt("pos"));
				bean.setRef(objRS.getInt("ref"));
				bean.setDepth(objRS.getInt("depth"));
				bean.setRegTM(objRS.getString("regTM"));
				bean.setReadCnt(objRS.getInt("readCnt"));
				bean.setFileName(objRS.getString("fileName"));
				bean.setFileSize(objRS.getInt("fileSize"));
				bean.setIp(objRS.getString("ip"));
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return bean;
	} 
	/*	상세보기 게시글 출력 끝 (/bbs/read.jsp, 내용보기 페이지) */

	
	/*
	public static void main(String[] args) {
		System.out.println(len);
	}
	*/

	
	/* 상세보기 페이지 파일다운로드 시작 (/bbs/read.jsp) */
	public static int len;
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {
		String fileName = req.getParameter("fileName"); // 다운로드할 파일 매개변수명 일치
		try {
			File file = new File(UtilMgr.con(SAVEFOLER + File.separator + fileName));

			byte[] b = new byte[(int) file.length()];
			res.setHeader("Accept-Ranges", "bytes");
			String strClient = req.getHeader("User-Agent");
			res.setContentType("application/smnet;charset=utf-8");
			res.setHeader("Content-Disposition", "attachment;fileName=" + fileName + ";");

			out.clear();
			out = pageContext.pushBody();

			if (file.isFile()) {
				BufferedInputStream fIn = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream fOuts = new BufferedOutputStream(res.getOutputStream());
				int read = 0;
				while ((read = fIn.read(b)) != -1) {
					fOuts.write(b, 0, read);
				}
				fOuts.close();
				fIn.close();

			}

		} catch (Exception e) {
			System.out.println("파일 처리 이슈 : " + e.getMessage());
		}

	}

	/* 상세보기 페이지 파일다운로드 끝 (/bbs/read.jsp) */
	
	

	/* 게시글 삭제(/bbs/delete.jsp) 시작 */
	public int deleteBoard(int num) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();

			//////////// 게시글의 파일 삭제 시작 ///////////////
			sql = "select fileName from tblBoard where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRS = objPstmt.executeQuery();

			if (objRS.next() && objRS.getString(1) != null) {
				if (!objRS.getString(1).equals("")) {
					String fName = objRS.getString(1);
					String fileSrc = SAVEFOLER + "/" + fName;
					File file = new File(fileSrc);

					if (file.exists())  file.delete(); // 파일 삭제 실행

				}
			}
			//////////// 게시글의 파일 삭제 끝 ///////////////

			//////////// 게시글 삭제 시작 ///////////////
			sql = "delete from tblBoard where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			exeCnt = objPstmt.executeUpdate();
			//////////// 게시글 삭제 끝 ///////////////

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return exeCnt;
	}

	/* 게시글 삭제(/bbs/delete.jsp) 끝 */

	

	/* 게시글 수정페이지 (/bbs/updateProc.jsp) 시작 */
	public int updateBoard(BoardBean bean) {
		String sql = null;
		int exeCnt = 0;

		try {
			objConn = objPool.getConnection();
			sql = "update tblBoard set subject=?, content=? where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getSubject());
			objPstmt.setString(2, bean.getContent());
			objPstmt.setInt(3, bean.getNum());
			exeCnt = objPstmt.executeUpdate();
			// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	}

	/* 게시글 수정페이지 (/bbs/updateProc.jsp) 끝 */
		
	

	/* 게시글 답변 페이지 (/bbs/replyProc.jsp) 시작 */
	public int replyBoard(BoardBean bean) {

		String sql = null;
		int cnt = 0;
	

		try {
			objConn = objPool.getConnection(); 

			sql = "insert into tblBoard (";
			sql += "uId, uName, content, subject, ";
			sql += "ref, pos, depth,  ";
			sql += "regTM, readCnt, ip) values (";
			sql += "?, ?, ?, ?, ?, ?, ?, now(), 0, ?)";

			int depth = bean.getDepth() + 1;
			int pos = bean.getPos() + 1;
			
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuId());
			objPstmt.setString(2, bean.getuName());
			objPstmt.setString(3, bean.getContent());
			objPstmt.setString(4, bean.getSubject());
			objPstmt.setInt(5, bean.getRef());
			objPstmt.setInt(6, pos);
			objPstmt.setInt(7, depth);
			objPstmt.setString(8, bean.getIp());
			cnt = objPstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return cnt;  
	}
	/* 게시글 답변 페이지 (/bbs/replyProc.jsp) 끝 */
	
	

	/* 답변글 끼어들기 시작 (/bbs/replyProc.jsp) */
	public int replyUpBoard(int ref, int pos) {

		String sql = null;
		int cnt = 0;		

		try {
			objConn = objPool.getConnection();

			//////////// 게시글의 포지션 증가 시작 ///////////////
			sql = "update tblBoard set pos = pos + 1 ";
			sql += "where ref = ? and pos > ?";
			
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, ref);
			objPstmt.setInt(2, pos);
			cnt = objPstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

		
		return cnt;
	}	
	/* 답변글 끼어들기 끝 (/bbs/replyProc.jsp) */
	

}
