package com.qf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/1.
 * @Version 1.0
 */
@Controller
public class PageController {
    @RequestMapping("/getToPage/{pageName}")
    public String returnPage(@PathVariable String pageName){

        return pageName;
    }
}
