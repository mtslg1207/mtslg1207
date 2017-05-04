package org.dodream.join;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
 
@Service
public class CustomUserDetailsService implements UserDetailsService
{
    @Autowired
    private UserAuthDAO dao;
     
//    @Override
    public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException
    {
        User user = dao.getUserDetails(id);
        if(user==null) throw new UsernameNotFoundException("["+id+"] 이름으로 검색된 결과가 없습니다");
        if(user.getAuthorities().size()==0)
            throw new UsernameNotFoundException("["+id+"] 이용자는 아무런 권한이 없습니다");
        return user;
    }
}