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
	BCryptPasswordEncoder passwordEncoder; //���� �������Ͽ� ������ ���
	
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
//        //�����ͺ��̽����� ������ �̿��� ����
//        UserDetails userDetails = dao.getUserDetails(userId);
//        if (userDetails==null) throw new UsernameNotFoundException("������ ������ ã�� �� �����ϴ�.");
//        return userDetails;
//    }
}