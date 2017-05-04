package org.dodream.join;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/sec/")
public class UserAuthController {
	
	@Autowired
	UserAuthService svc;
	
	@RequestMapping("join")
	public String join(){
		return "login/userJoinForm";
	}
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	@ResponseBody
	public boolean join(UserAuthVO user){
		boolean result = svc.join(user);
        return result;
	}
	
	@RequestMapping(value="check", method=RequestMethod.POST)
	@ResponseBody
	public String check(@RequestParam("id") String id){
		String result = svc.check(id);
        return result;
	}
	
	@RequestMapping("adminMain")
	public String adminMain(){
		return "sec/adminMain";
	}
	
	@RequestMapping("userMain")
	public String userMain(){
		return "sec/userMain";
	}
}