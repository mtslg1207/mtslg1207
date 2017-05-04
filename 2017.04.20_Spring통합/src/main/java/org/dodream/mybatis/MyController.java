package org.dodream.mybatis;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sec/")
public class MyController {
	
	@RequestMapping("logout")
	public String logout(){
		return "login/logout";
	}
	
	@RequestMapping("dbIndex")
	public String dbIndex(){
		return "login/index";
	}
	
	@RequestMapping("login")
	public String login(){
		return "login/loginForm";
	}
}