package com.qf.realm;

import com.qf.entity.Emp;
import com.qf.entity.Resc;
import com.qf.service.IEmpService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/6.
 * @Version 1.0
 */
@Component
public class MyRealm extends AuthorizingRealm {
    @Autowired
    IEmpService empService;

    /***
     * 权限授权管理
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //获取登陆者的信息
        Emp emp = (Emp) principals.getPrimaryPrincipal();
        List<Resc> rescs=emp.getRescs();
        SimpleAuthorizationInfo simpleAuthorizationInfo=new SimpleAuthorizationInfo();
        for (Resc resc : rescs) {
            if (resc.getRpath()!=null&&resc.getRpath()!=""){
                simpleAuthorizationInfo.addStringPermission(resc.getRpath());

            }
        }
        return simpleAuthorizationInfo;
    }


    /***
     * 认证操作
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String email = (String) authenticationToken.getPrincipal();
        Emp emp = empService.getEmpByEmail(email);
        AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(emp, emp.getPassword(), this.getName());
        return authenticationInfo;
    }
}
