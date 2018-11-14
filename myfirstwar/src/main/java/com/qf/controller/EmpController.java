package com.qf.controller;

import com.qf.entity.Emp;
import com.qf.entity.EmpInfo;
import com.qf.service.IEmpService;
import com.qf.service.IRoleService;
import com.qf.ssm.controller.BaseController;
import com.qf.ssm.interceptor.Page;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/2.
 * @Version 1.0
 */
@Controller
@RequestMapping("/emp")
@SessionAttributes("emp")
public class EmpController extends BaseController {
    @Autowired
    IEmpService empService;
    @Autowired
    IRoleService roleService;

    @RequestMapping("/getempInfo")
    public String getempInfo(Page page, Model model) {
        List<Emp> emps = empService.getempInfo();
        model.addAttribute("emps", emps);
        return "empInfo";
    }
    @RequiresPermissions("/emp/addOrUpdateEmp")
    @RequestMapping("/addOrUpdateEmp")
    public String addOrUpdateEmp(Emp emp) {
        empService.addOrUpdateEmp(emp);
        return "redirect:getempInfo";
    }

    @RequestMapping("/deleteEmpById/{empId}")
    public String deleteEmpById(@PathVariable Integer empId) {
        empService.deleteEmpById(empId);
        return "redirect:/emp/getempInfo";
    }


    @RequestMapping("/login")
    public String login(String email, String password, Model model) {


        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
            UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(email, password);
            try {
                subject.login(usernamePasswordToken);
            } catch (AuthenticationException e) {
                model.addAttribute("mess", 1);
                return "login";
            }

        }
        Emp emp = (Emp) subject.getPrincipal();
        model.addAttribute("emp", emp);
        return "index";
    }

    @RequestMapping("/getempInfoAjax")
    @ResponseBody
    public EmpInfo getempInfoAjax(String keyword, @SessionAttribute("emp")Emp emp) {
        List<Emp> list= empService.getempInfoAjax(keyword,emp.getId());
        EmpInfo empInfo = new EmpInfo();
        List<EmpInfo.Info> list1=new ArrayList<>();
        for (Emp emp1 : list) {
            System.out.println(emp1);
            EmpInfo.Info info = new EmpInfo.Info();
            info.setValue(emp1.getName()+"("+emp1.getEmail()+")");
            info.setData(emp1.getEmail());
            list1.add(info);
        }
        empInfo.setSuggestions(list1);

        return empInfo;
    }
    @RequestMapping("/countsexByempAjax")
    @ResponseBody
    public List<Map<String,Integer>> countsexByempAjax() {
        List<Map<String,Integer>> list= empService.countsexByempAjax();

        return list;
    }

    @RequestMapping("/register")
    public String register(Emp emp,Model model) {

        empService.addOrUpdateEmp(emp);
        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
            UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(emp.getEmail(), emp.getPassword());
            try {
                subject.login(usernamePasswordToken);
            } catch (AuthenticationException e) {
                model.addAttribute("mess", 1);
                return "login";
            }

        }
        Emp empinfo = (Emp) subject.getPrincipal();
        model.addAttribute("emp",empinfo);
        return "index";

    }





}
