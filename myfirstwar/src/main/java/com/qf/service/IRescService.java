package com.qf.service;

import com.qf.entity.Resc;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/5.
 * @Version 1.0
 */
public interface IRescService {

    List<Resc> getRescInfo();

    void addOrUpdateResc(Resc resc);

    List<Resc> getRescByRid(Integer rid);

    void deleteRescById(Integer rescId);
}
