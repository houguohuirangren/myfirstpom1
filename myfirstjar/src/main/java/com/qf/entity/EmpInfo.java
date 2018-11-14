package com.qf.entity;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/7.
 * @Version 1.0
 */
public class EmpInfo {

    private List<Info> suggestions;

    public List<Info> getSuggestions() {
        return suggestions;
    }

    public void setSuggestions(List<Info> suggestions) {
        this.suggestions = suggestions;
    }

    public static class Info{
        private String value;
        private String data;

        public String getData() {
            return data;
        }

        public void setData(String data) {
            this.data = data;
        }

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }
    }
}
