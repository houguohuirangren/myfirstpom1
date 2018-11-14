package com.qf.controller;

import com.qf.entity.Dept;
import com.qf.service.IDeptService;
import com.qf.service.IEmpService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/1.
 * @Version 1.0
 */
@Controller
@RequestMapping("/dept")
public class DeptController extends BaseController {
    @Autowired
    IDeptService deptService;
    @Autowired
    IEmpService empService;
    @RequestMapping("/getdeptInfo")
    public String getDeptInfo(Page page, ModelMap map){
        List<Dept> depts = deptService.getdeptInfo();
        map.put("deptList", depts);



        return "deptInfo";
    }

    @RequestMapping("/listajax")
    @ResponseBody
    public List<Dept> listajax( ){
        List<Dept> depts = deptService.getdeptInfo();

        return depts;
    }
    @RequiresPermissions("/dept/addOrDept")
    @RequestMapping("/addOrDept")
    public String addOrDept(Dept dept ){
        deptService.addDept(dept);
        return "redirect:getdeptInfo";
    }

    @RequestMapping("/deleteDeptById/{deptId}")
    public String deleteDeptById(@PathVariable Integer deptId){
        deptService.deleteDeptById(deptId);
        return "redirect:/dept/getdeptInfo";
    }

    @RequestMapping("/countempAjax")
    @ResponseBody
    public List<Map<String,Integer>> countemp(){

        List<Map<String,Integer>> list=empService.countempBydept();
        return list;
    }


}
