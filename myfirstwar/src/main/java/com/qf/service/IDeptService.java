package com.qf.service;

import com.qf.entity.Dept;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/1.
 * @Version 1.0
 */
public interface IDeptService {
    List<Dept> getdeptInfo();

    void addDept(Dept dept);

    void deleteDeptById(Integer deptId);

    void addOrUpdateDept(List<Dept> depts);
}
