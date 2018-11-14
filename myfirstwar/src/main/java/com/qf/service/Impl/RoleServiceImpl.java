package com.qf.service.Impl;

import com.qf.dao.RoleMapper;
import com.qf.entity.Role;
import com.qf.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/5.
 * @Version 1.0
 */
@Service
public class RoleServiceImpl implements IRoleService {
    @Autowired
    RoleMapper roleMapper;
    @Override
    public List<Role> getRoleInfo() {

        return roleMapper.getRoleInfo();
    }

    @Override
    public void addOrupdateRole(Role role) {
        if (role.getId()==null){
            roleMapper.insert(role);
        }else {
            roleMapper.updateByPrimaryKeySelective(role);
        }
    }

    @Override
    public List<Role> getRoleInfoAjax(Integer eid) {

        return roleMapper.getRoleInfoAjax(eid);
    }

    @Override
    public void updateRoleByEid(Integer eid, Integer[] rids) {
        //先删除之前的角色
        roleMapper.deleteRoleByEid(eid);
        //添加角色
        roleMapper.addRoleByEidAndRid(eid,rids);
    }

    @Override
    public int updateMyResc(Integer rid, Integer[] reids) {
        roleMapper.deleteRescByRid(rid);

        roleMapper.addMyRescByReids(rid ,reids);
        return 1;
    }

    @Override
    public void deleteRoleById(Integer roleId) {
        roleMapper.deleteByPrimaryKey(roleId);
    }
}
