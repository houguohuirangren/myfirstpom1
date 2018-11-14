package com.qf.controller;

import com.qf.entity.Resc;
import com.qf.service.IRescService;
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
@RequestMapping("/resc")
public class RescController {
    @Autowired
    IRescService rescService;

    @RequestMapping("/getRescInfo")
    public String getRescInfo(Page page, Model model) {
        List<Resc> list = rescService.getRescInfo();
        model.addAttribute("rescs", list);
        return "rescInfo";
    }

    @RequestMapping("/getRoleInfoByPidajax")
    @ResponseBody
    public List<Resc> getRoleInfoByPidajax() {
        List<Resc> list = rescService.getRescInfo();
        return list;
    }

    @RequiresPermissions("/resc/addOrUpdateResc")
    @RequestMapping("/addOrUpdateResc")
    public String addOrUpdateResc(Resc resc) {
        rescService.addOrUpdateResc(resc);
        return "redirect:getRescInfo";

    }

    @RequestMapping("/getRescByRidAjax")
    @ResponseBody
    public List<Resc> getRescByRidAjax(Integer rid) {
        List<Resc> list = rescService.getRescByRid(rid);

        return list;

    }
    @RequiresPermissions("/resc/deleteRescById")
    @RequestMapping("/deleteRescById/{rescId}")
    public String deleteRescById(@PathVariable Integer rescId) {
        rescService.deleteRescById(rescId);
        return "redirect:/resc/getRescInfo";

    }




}
