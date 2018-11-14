package com.qf.service;

import com.qf.entity.Role;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/5.
 * @Version 1.0
 */
public interface IRoleService {
    List<Role> getRoleInfo();

    void addOrupdateRole(Role role);

    List<Role> getRoleInfoAjax(Integer eid);

    void updateRoleByEid(Integer eid, Integer[] rids);

    int updateMyResc(Integer rid, Integer[] reids);

    void deleteRoleById(Integer roleId);
}
