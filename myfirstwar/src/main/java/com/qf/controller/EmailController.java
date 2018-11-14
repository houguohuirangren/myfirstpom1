package com.qf.controller;

import com.qf.entity.EmailInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/7.
 * @Version 1.0
 */
@Controller
@RequestMapping("/email")
public class EmailController {
    @Autowired
    JavaMailSender javaMailSender;

    @RequestMapping("/senEmail")
    public String sendEmail(final EmailInfo emailInfo) throws MessagingException {
        //创建一封邮件
        MimeMessage mimeMessage=javaMailSender.createMimeMessage();
        //初始化一个邮件辅助对象
        MimeMessageHelper mimeMessageHelper=new MimeMessageHelper(mimeMessage,true);
        //设置发送方
        /*mimeMessageHelper.setFrom("sheep15779753295@163.com");*/
        mimeMessageHelper.setText(emailInfo.getEmailContent(),true);
        mimeMessageHelper.setTo(emailInfo.getRecivePesonal());
        mimeMessageHelper.setSubject(emailInfo.getEmailTitle());
        mimeMessageHelper.addAttachment(emailInfo.getEmailFile().getOriginalFilename(), new InputStreamSource() {
            @Override
            public InputStream getInputStream() throws IOException {
                return emailInfo.getEmailFile().getInputStream();
            }
        });
        javaMailSender.send(mimeMessage);
        return "sendemail";
    }
}
