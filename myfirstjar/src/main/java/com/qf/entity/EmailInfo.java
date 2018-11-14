package com.qf.entity;

import org.springframework.web.multipart.MultipartFile;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/7.
 * @Version 1.0
 */
public class EmailInfo {

    private String recivePesonal;

    private String emailTitle;

    private MultipartFile emailFile;

    private String emailContent;

    public String getRecivePesonal() {
        return recivePesonal;
    }

    public void setRecivePesonal(String recivePesonal) {
        this.recivePesonal = recivePesonal;
    }

    public String getEmailTitle() {
        return emailTitle;
    }

    public void setEmailTitle(String emailTitle) {
        this.emailTitle = emailTitle;
    }

    public MultipartFile getEmailFile() {
        return emailFile;
    }

    public void setEmailFile(MultipartFile emailFile) {
        this.emailFile = emailFile;
    }

    public String getEmailContent() {
        return emailContent;
    }

    public void setEmailContent(String emailContent) {
        this.emailContent = emailContent;
    }

    @Override
    public String toString() {
        return "EmailInfo{" +
                "recivePesonal='" + recivePesonal + '\'' +
                ", emailTitle='" + emailTitle + '\'' +
                ", emailFile='" + emailFile + '\'' +
                ", emailContent='" + emailContent + '\'' +
                '}';
    }
}
