package org.dodream.join;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserAuthService {
	
	@Autowired
    UserAuthDAO dao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder; //서블릿 설정파일에 빈으로 등록
	
	public boolean join(UserAuthVO user){
        boolean idc = dao.check(user.getUserid());
        if(idc == true){
        	return false;
        }
        else{
	        String encodedPwd = passwordEncoder.encode(user.getUserpwd());
	        user.setUserpwd(encodedPwd);
	        boolean joinResult = dao.joinUser(user);
	        return joinResult;
        }
	}
	
	public String check(String id) {
		boolean idc = dao.check(id);
		JSONObject jObj = new JSONObject();
		if(idc){
			jObj.put("ok", false);
		}
		else{
			jObj.put("ok", true);
		}
		return jObj.toJSONString();
	}
//	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
//        //데이터베이스에서 가져온 이용자 정보
//        UserDetails userDetails = dao.getUserDetails(userId);
//        if (userDetails==null) throw new UsernameNotFoundException("접속자 정보를 찾을 수 없습니다.");
//        return userDetails;
//    }
}