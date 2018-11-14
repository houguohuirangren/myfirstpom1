package com.qf.service.Impl;

import com.qf.dao.EmpMapper;
import com.qf.entity.Emp;
import com.qf.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/2.
 * @Version 1.0
 */
@Service
public class EmpServiceImpl implements IEmpService {
    @Autowired
    EmpMapper empMapper;

    @Override
    public List<Emp> getempInfo() {
        return empMapper.getempInfo();
    }

    @Override
    public void addOrUpdateEmp(Emp emp) {
        if (emp.getId()==null){
            empMapper.insert(emp);
        }else {
            empMapper.updateByPrimaryKeySelective(emp);
        }
    }

    @Override
    public void deleteEmpById(Integer empId) {
        empMapper.deleteByPrimaryKey(empId);
    }

    @Override
    public Emp login(String email, String password) {
        return empMapper.login(email,password);
    }

    @Override
    public Emp getEmpByEmail(String email) {
        return empMapper.getEmpByEmail(email);
    }

    @Override
    public  List<Emp> getempInfoAjax(String keyword,Integer eid) {
        return empMapper.getempInfoAjax(keyword,eid);
    }

    @Override
    public List<Map<String,Integer>> countempBydept() {
        return empMapper.countempBydept();
    }

    @Override
    public List<Map<String, Integer>> countsexByempAjax() {
        return empMapper.countsexByempAjax();
    }
}
