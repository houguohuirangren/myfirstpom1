package com.qf.service.Impl;

import com.qf.dao.RescMapper;
import com.qf.entity.Resc;
import com.qf.service.IRescService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/5.
 * @Version 1.0
 */
@Service
public class RescServiceImpl implements IRescService {
    @Autowired
    RescMapper rescMapper;
    @Override
    public List<Resc> getRescInfo() {

        return rescMapper.getRescInfo();
    }

    @Override
    public void addOrUpdateResc(Resc resc) {
        if (resc.getId()!=null){
            rescMapper.updateByPrimaryKeySelective(resc);
        }else {
            rescMapper.insert(resc);
        }
    }

    @Override
    public List<Resc> getRescByRid(Integer rid) {
        return rescMapper.getRescByRid(rid);
    }

    @Override
    public void deleteRescById(Integer rescId) {
        rescMapper.deleteByPrimaryKey(rescId);
    }


}
