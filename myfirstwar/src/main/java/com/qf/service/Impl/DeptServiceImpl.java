package com.qf.service.Impl;

import com.qf.dao.DeptMapper;
import com.qf.entity.Dept;
import com.qf.service.IDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/1.
 * @Version 1.0
 */
@Service
public class DeptServiceImpl implements IDeptService {
    @Autowired
    DeptMapper deptMapper;

    @Override
    public List<Dept> getdeptInfo() {
        return deptMapper.getDeptInfo();
    }

    @Override
    public void addDept(Dept dept) {
        if (dept.getId() == null) {
            deptMapper.insert(dept);
        }else {
            deptMapper.updateByPrimaryKeySelective(dept);
        }
    }

    @Override
    public void deleteDeptById(Integer deptId) {
        deptMapper.deleteDeptById(deptId);
    }

    @Override
    public void addOrUpdateDept(List<Dept> depts) {
        for (Dept dept : depts) {
            System.out.println(dept);
        }
        deptMapper.addOrUpdateDept(depts);
    }
}
