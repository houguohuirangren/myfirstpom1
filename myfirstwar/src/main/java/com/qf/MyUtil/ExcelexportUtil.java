package com.qf.MyUtil;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletResponse;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/9.
 * @Version 1.0
 */

public class ExcelexportUtil {
    private static final Logger log = LoggerFactory.getLogger(ExcelexportUtil.class);

    /**
     * 导出功能
     * 注意：泛型T类字段名和containBean集合里字段名字的一致性
     *
     * @param response
     * @param title       表名
     * @param headers     表头
     * @param list        数据集
     * @param containBean 数据集类型字段
     * @param <T>
     * @throws Exception
     */
    public static <T> void exportExcel(HttpServletResponse response, String title, String[] headers, List<T> list, List<String> containBean) throws Exception {
        //创建一个表
        HSSFWorkbook workbook = null;
        try {

            workbook = new HSSFWorkbook();
            //创建一个sheet,一个表中可以有多个sheet，给上表的标题
            HSSFSheet sheet = workbook.createSheet(title);
            //创建第一行，放表头数据
            HSSFRow row = sheet.createRow(0);
            /*创建第一行表头*/
            for (short i = 0; i < headers.length; i++) {
                //创建格子，根据i,注意：这里是0格子，在表中是第一列
                HSSFCell cell = row.createCell(i);
                //这里是将数据给表头，使用HSSFRichTextString,可以对字体设置
                HSSFRichTextString text = new HSSFRichTextString(headers[i]);
                //将数据放入格子中
                cell.setCellValue(text);
                //这里便是创建表头，然后第一行的一个一个格子去创建，在每个格子里面赋值
            }
            //将准备好的数据拿出来遍历
            Iterator<T> it = list.iterator();
            //指定一个下标，因为迭代器没有下标
            int index = 0;
            //数据开始遍历
            while (it.hasNext()) {
                index++;
                //因为第一行已经放了表头，所以这里应该从第二行开始
                row = sheet.createRow(index);
                //拿到目标对象，我们需要里面的数据
                T t = (T) it.next();
                /*反射得到字段*/
                Field[] fields = t.getClass().getDeclaredFields();
                /*如果需要匹配*/
                //这里使用的CollectionUtils工具，判断该数据类型字段是否为空
                if (CollectionUtils.isNotEmpty(containBean)) {
                    //先循环类型字段
                    for (int j = 0; j < containBean.size(); j++) {
                        //嵌套数据实体类中的字段
                        for (int i = 0; i < fields.length; i++) {
                            //拿到当前实体类属性对象
                            Field field = fields[i];
                            //假如当前属性对象的名称跟类型字段一样，则按照一一对应插入
                            if (!field.getName().equals(containBean.get(j)))
                                //跳过当前循环
                                continue;
                            /*给每一列set值*/
                            setCellValue(t, field, row, j);
                        }
                    }
                } else {
                    //假如类型字段为空，就按照顺序一个一个插入
                    for (int i = 0; i < fields.length; i++) {
                        Field field = fields[i];
                        setCellValue(t, field, row, i);
                    }
                }
            }
            /*application/vnd.ms-excel告诉浏览器要下载的是个excel*/
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            /*请求头设置，Content-Disposition为下载标识，attachment标识以附件方式下载*/
            response.addHeader("Content-Disposition", "attachment;filename=" + new String((title).getBytes(), "ISO8859-1") + ".xls");
            workbook.write(response.getOutputStream());
        } finally {
            if (workbook != null) {
                workbook.close();
            }
        }
    }

    /**
     * 设置每一行中的列
     *
     * @param t 当前有数据的对象
     * @param field 需要我们根据字段类型插入的字段对象
     * @param row 当前行
     * @param index 当前行的第几列
     * @param <T>
     */
    private static <T> void setCellValue(T t, Field field, HSSFRow row, int index) {
        //创建一个格子，表示在当前行的第几列
        HSSFCell cell = row.createCell(index);
        //调用方法，获得与该类型对象对象的值
        Object value = invoke(t, field);
        String textValue = null;
        if (value != null) {
            //判断该值类型是不是Date的子类
            if (value instanceof Date) {
                //将该值格式成时间格式
                Date date = (Date) value;
                textValue = DateFormatUtils.format(date, "yyyy-MM-dd HH:mm:ss");
            } else {

                //不然就当作字符串输出
                textValue = value.toString();
            }
        }
        if (textValue != null) {
            //将值放入该格子
            cell.setCellValue(textValue);
        }
    }

    /**
     * 反射映射数据集字段
     *
     * @param t  当前含有数据的对象
     * @param field  字段对象
     * @param <T>
     * @return
     */
    private static <T> Object invoke(T t, Field field) {
        try {
            //得到该字段的名称
            String fieldName = field.getName();
            //引入PropertyDescriptor，这里我们可以得到即使没有设置set,get方法的公有方法，也可以拿到该属性
            PropertyDescriptor pd = new PropertyDescriptor(fieldName, t.getClass());
            //获取用于读取私有属性值的方法
            Method method = pd.getReadMethod();
            //执行该方法，放回的值便是我们需要的数据
            return method.invoke(t);
        } catch (Exception e) {
            return null;
        }
    }

}
