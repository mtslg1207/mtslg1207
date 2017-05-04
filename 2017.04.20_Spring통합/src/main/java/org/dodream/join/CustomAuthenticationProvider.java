package org.dodream.join;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
  
public class CustomAuthenticationProvider implements AuthenticationProvider
{
    @Autowired
    private CustomUserDetailsService userService;
     
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
   
//    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException
    {
        String user_id = (String)authentication.getPrincipal();   
        String user_pw = (String)authentication.getCredentials();
        
        System.out.printf("사용자 로그인정보: %s \n", user_id + "/" + user_pw);
         
        User user = (User) userService.loadUserByUsername(user_id);
        System.out.printf("사용자 DB 정보: %s \n", user.getUsername() + "/" + user.getPassword());
 
        // 화면에서 입력한 이용자의 비밀s번호(평문)와 DB에서 가져온 이용자의 암호화된 비밀번호를 비교한다
        if(! passwordEncoder.matches(user_pw, user.getPassword())){
            throw new BadCredentialsException("Bad credentials");
        }  
        return new UsernamePasswordAuthenticationToken(user_id, user_pw, user.getAuthorities());
    }
     
//    @Override
    public boolean supports(Class<?> authentication)
    {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}