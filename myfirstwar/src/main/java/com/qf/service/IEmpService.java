package com.qf.service;

import com.qf.entity.Emp;

import java.util.List;
import java.util.Map;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/2.
 * @Version 1.0
 */
public interface IEmpService {

    List<Emp> getempInfo();

    void addOrUpdateEmp(Emp emp);

    void deleteEmpById(Integer empId);

    Emp login(String email, String password);

    Emp getEmpByEmail(String email);

    List<Emp> getempInfoAjax(String keyword,Integer eid);

    List<Map<String,Integer>> countempBydept();

    List<Map<String, Integer>> countsexByempAjax();
}
