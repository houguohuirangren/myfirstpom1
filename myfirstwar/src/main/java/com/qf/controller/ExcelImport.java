package com.qf.controller;

import com.qf.MyUtil.ExcelLeadingUtil;
import com.qf.entity.Dept;
import com.qf.service.IDeptService;
import com.qf.MyUtil.ExcelexportUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/9.
 * @Version 1.0
 */
@Controller
public class ExcelImport {
    @Autowired
    IDeptService deptService;


    @RequestMapping("/DeptexcelImport")
    public void excelImport(HttpServletResponse response) throws Exception {
        List<String> deptCoumn=new ArrayList<>();
        deptCoumn.add("id");
        deptCoumn.add("dname");
        deptCoumn.add("pname");
        deptCoumn.add("createtime");
        deptCoumn.add("deptinfo");
        List<Dept> depts = deptService.getdeptInfo();
        String [] headers=new String[]{"id","dname","pname","createtime","deptinfo"};
        ExcelexportUtil.exportExcel(response, "部门表", headers,depts , deptCoumn);
    }
    @RequestMapping("/DeptexcelLeading")
    public void DeptexcelLeading(MultipartFile excelFile,HttpServletResponse response){
        response.setContentType("text/html;charset=utf-8");
        try {
            List<Dept> depts = ExcelLeadingUtil.ExcelLeading(excelFile, response, Dept.class);
            deptService.addOrUpdateDept(depts);
            response.getWriter().write("导入成功");
        } catch (IllegalAccessException | IOException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        }

    }


}
