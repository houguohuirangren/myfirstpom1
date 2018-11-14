package com.qf.MyUtil;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author LWW
 * @Time Created by Enzo Cotter on 2018/11/9.
 * @Version 1.0
 */
public class ExcelLeadingUtil {
    public static <T> List<T> ExcelLeading(MultipartFile file, HttpServletResponse response, Class<T> object) throws IllegalAccessException, InstantiationException {

        List<T> objectlist = new ArrayList<>();
        String stffuer = file.getOriginalFilename();
        Workbook workbook = null;
        if (stffuer.endsWith(".xls")) {//03版的excel
            try {
                workbook = new HSSFWorkbook(file.getInputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }

        } else if (stffuer.endsWith(".xlsx")) {
            try {
                workbook = new XSSFWorkbook(file.getInputStream());
                //07版
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            try {
                response.getWriter().write("您上传的文件格式不正确");
                return null;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
            Sheet sheet = workbook.getSheetAt(i);
            if (sheet == null) {
                continue;
            }
            Row headrow = sheet.getRow(0);
            short cellNum = headrow.getLastCellNum();
            List<String> types = new ArrayList<>();
            for (short j = 0; j < cellNum; j++) {
                Cell cell = headrow.getCell(j);
                String name = cell.getStringCellValue();
                types.add(name);
            }
            Field[] fields = object.getDeclaredFields();


            int rowNum = sheet.getLastRowNum();


            for (int j = 1; j < rowNum + 1; j++) {
                T t = object.newInstance();
                Row row = sheet.getRow(j);
                short lastCellNum = row.getLastCellNum();
                for (short z = 0; z < lastCellNum; z++) {

                    for (Field field : fields) {
                        field.setAccessible(true);
                        if (types.get(z).equals(field.getName())) {
                            try {
                                try {
                                    parsenum(row, z, field, t);
                                } catch (InstantiationException e) {
                                    e.printStackTrace();
                                }
                            } catch (IllegalAccessException e) {
                                e.printStackTrace();
                            }
                        }
                    }


                }
                objectlist.add(t);
            }


        }
        try {
            file.getInputStream().close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return objectlist;
    }

    private static <T> void parsenum(Row row, short z, Field field, T t) throws IllegalAccessException, InstantiationException {
        HSSFCell cell = (HSSFCell) row.getCell(z);

        if (field.getType() == Date.class) {
            if (cell!=null){
                field.set(t, cell.getDateCellValue());
                return;
            }else {
                field.set(t, null);
                return;
            }

        }
       if (cell != null) {
            cell.setCellType(Cell.CELL_TYPE_STRING);
        }
        if (field.getType() == String.class) {
            field.set(t, cell.getStringCellValue());
        }
        else if (field.getType() == Integer.class) {
            field.set(t, Integer.parseInt(cell.getStringCellValue()));
        } else if (field.getType() == Double.class) {
            field.set(t, Double.parseDouble(cell.getStringCellValue()));
        }
    }
}
