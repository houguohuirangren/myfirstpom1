package com.qf.controller;

import com.qf.entity.Role;
import com.qf.service.IRoleService;
import com.qf.ssm.interceptor.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/5.
 * @Version 1.0
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    IRoleService roleService;

    @RequestMapping("/getRoleInfo")
    public String getRoleInfo(Page page, Model model) {
        List<Role> roleInfo = roleService.getRoleInfo();
        model.addAttribute("roles", roleInfo);
        return "roleInfo";
    }

    @RequiresPermissions("/role/addOrupdateRole")
    @RequestMapping("/addOrupdateRole")
    public String addOrupdateRole(Role role) {
        roleService.addOrupdateRole(role);
        return "redirect:getRoleInfo";
    }

    @RequestMapping("/getAllRoleAjax")
    @ResponseBody
    public List<Role> getAllRoleAjax(Integer eid) {
        List<Role> roleInfo = roleService.getRoleInfoAjax(eid);
        return roleInfo;
    }

    @RequiresPermissions("/role/updateRoleByEid")
    @RequestMapping("/updateRoleByEid")
    public String updateRoleByEid(Integer eid, Integer[] rids) {
        roleService.updateRoleByEid(eid, rids);
        return "redirect:/emp/getempInfo";
    }


    @RequestMapping("/updateMyRescAjax")
    @ResponseBody
    public String updateMyRescAjax(Integer rid, Integer[] reids) {
        int i = roleService.updateMyResc(rid, reids);
        return String.valueOf(i);
    }
    @RequiresPermissions("/role/deleteRoleById")
    @RequestMapping("/deleteRoleById/{roleId}")
    public String deleteRoleById(@PathVariable Integer roleId) {
        roleService.deleteRoleById(roleId);
        return "redirect:/role/getRoleInfo";
    }

}
