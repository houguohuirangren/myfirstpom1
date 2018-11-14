package com.qf.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.UUID;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/2.
 * @Version 1.0
 */
@Controller
@RequestMapping("/img")
public class imgController {
    @Value("${uploadpath}")
    private String uploadpath;

    @RequestMapping("/uploadImg")
    @ResponseBody
    public String uploadImg(MultipartFile file){

        InputStream inputStream=null;
        String path=null;
        FileOutputStream outputStream=null;
        try {
            inputStream = file.getInputStream();
            path=uploadpath+ UUID.randomUUID().toString();
            outputStream=new FileOutputStream(path);
            IOUtils.copy(inputStream, outputStream);
            return "{\"uploadpath\":\"" + path + "\"}";
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (inputStream!=null){
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (outputStream!=null){
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return null;
    }


    @RequestMapping("/getImg")
    public  void getImg(String imgpath, HttpServletResponse response){
        System.out.println(imgpath);
        FileInputStream inputStream=null;
        OutputStream outputStream=null;

        try {
            inputStream=new FileInputStream(imgpath);
            outputStream= response.getOutputStream();
            IOUtils.copy(inputStream, outputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (inputStream!=null){
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (outputStream!=null){
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
