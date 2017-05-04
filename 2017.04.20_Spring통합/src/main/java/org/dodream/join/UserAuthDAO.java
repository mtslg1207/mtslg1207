package org.dodream.join;

import java.sql.*;
import java.util.*;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Repository;

@Repository
public class UserAuthDAO {
	@Autowired
    DataSource dataSource;
	
//	private Connection conn;
//	private PreparedStatement pstmt;
//	private ResultSet rs;
//
//	// 데이터베이스 연결관련정보를 문자열로 선언
//	private String jdbc_driver = "oracle.jdbc.OracleDriver";
//	private String db_url = "jdbc:oracle:thin:@localhost:1521:xe";
//
//	// DB 연결 기능
//	private Connection getConn(){
//		try {
//			Class.forName(jdbc_driver);
//			conn = DriverManager.getConnection(db_url,"scott","TIGER");	
////			Context initCtx = new InitialContext();    
////			Context envCtx = (Context) initCtx.lookup("java:comp/env");    
////		 	DataSource ds = (DataSource) envCtx.lookup("jdbc/myoracle");    
////		 	Connection conn = ds.getConnection();
//			return conn;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return null;
//	}
	
	public boolean joinUser(UserAuthVO user){
		Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = dataSource.getConnection();
            String sql = "INSERT INTO MEMBER VALUES (?,?,?,1,'USER')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserid());
			pstmt.setString(2, user.getUserpwd());
			pstmt.setString(3, user.getUserName());
			int rows = pstmt.executeUpdate();
			
			if(rows>0){
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
                if(conn!=null) conn.close();
                if(pstmt!=null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
		}
		return false;
	}
	
	public UserAuthVO getUser(UserAuthVO user)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = dataSource.getConnection();
            String sql = "SELECT * FROM member WHERE USERID=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserid());
             
            rs = pstmt.executeQuery();
            if(rs.next()){
                UserAuthVO u = new UserAuthVO();
                u.setUserid(rs.getString("USERID"));
                u.setUserpwd(rs.getString("PASSWORD"));
                u.setEnabled(rs.getString("ENABLE").charAt(0));
                u.setAuthority(rs.getString("AUTHORITY"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally{
                try {
                    if(conn!=null) conn.close();
                    if(pstmt!=null) pstmt.close();
                    if(rs!=null) rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
        }
        return null;
    }
 
    public User getUserDetails(String userId)
    {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = dataSource.getConnection();
            String sql = "SELECT * FROM member WHERE USERID=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
             
            rs = pstmt.executeQuery();
            if(rs.next()){
                String id = rs.getString("USERID");
                String pwd = rs.getString("PASSWORD");
                String authority = rs.getString("AUTHORITY");
                
                SimpleGrantedAuthority role = new SimpleGrantedAuthority(authority);
                List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
                roles.add(role);
                 
                return new User(id, pwd, roles);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally{
                try {
                    if(conn!=null) conn.close();
                    if(pstmt!=null) pstmt.close();
                    if(rs!=null) rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
        }
        return null;
    }
    
    public boolean check(String userId)
    {
    	Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        conn = dataSource.getConnection();
	        String sql = "SELECT * FROM member WHERE USERID=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userId);
	        
	        rs = pstmt.executeQuery();
	        if(rs.next()){
	        	return true;
	        }
    	} catch (SQLException e) {
    		e.printStackTrace();
    	} finally{
            try {
                if(conn!=null) conn.close();
                if(pstmt!=null) pstmt.close();
                if(rs!=null) rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
    	}
	    return false;
    }
//	private void closeAll(){
//		try{
//			if(rs != null) rs.close();
//			if(pstmt != null) pstmt.close();
//			if(conn != null) conn.close();
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//	}
}