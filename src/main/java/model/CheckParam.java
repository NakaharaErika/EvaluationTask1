package model;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.format.ResolverStyle;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;

public class CheckParam {
	//Excel上の値をString型にする
	public static String checkString(Cell cell) {
	    if (cell == null) {
	        return null;
	    }

	    String newCell;
	    switch (cell.getCellType()) {
	        case STRING:
	            newCell = cell.getStringCellValue();
	            break;
	        case NUMERIC:
	        	newCell = new DecimalFormat("#").format(cell.getNumericCellValue());
	            break;
	        default:
	            newCell = "";
	            break;
	    }
	    return newCell;
	}

	//Excel上の値をint型にする
	public static int checkInt(Cell cell) {
	    if (cell == null) {
	        return -1; // セルがnullの場合は-1を返します
	    }

	    int processedValue = -1;
	    switch (cell.getCellType()) {
	        case STRING:
	            if (cell.getStringCellValue().matches("\\d+")) {
	                processedValue = Integer.parseInt(cell.getStringCellValue());
	            }
	            break;
	        case NUMERIC:
	            processedValue = (int) cell.getNumericCellValue();
	            break;
	        default:
	            break;
	    }
	    return processedValue;
	}

	public static LocalDate checkDate(Cell cell) {
	    if (cell == null) {
	        return null;
	    }

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	    try {
	        if (cell.getCellType() == CellType.STRING) {
	            String dateStr = cell.getStringCellValue();
	            return LocalDate.parse(dateStr, formatter);
	        } else if (DateUtil.isCellDateFormatted(cell)) {
	            Date javaDate = cell.getDateCellValue();
	            return javaDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	        }
	    } catch (DateTimeParseException e) {
	        return null; // 解析に失敗した場合は無効な日付として扱う
	    }
	    return null;
	}



	public static int checkPrice(String price) {
		String cleanedPrice = price.replaceAll(",", "");
		int processedPrice = -1;

	    // 金額の処理
	    if (!cleanedPrice.isEmpty() && cleanedPrice.matches("\\d+")) {
	        processedPrice = Integer.parseInt(cleanedPrice);
	    }
		return processedPrice;
	}

	public static LocalDate checkDate(String dateStr) {
	    if (dateStr == null || dateStr.isEmpty()) {
	        return null;
	    }

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd").withResolverStyle(ResolverStyle.STRICT);
	    try {
	        return LocalDate.parse(dateStr, formatter);
	    } catch (DateTimeParseException e) {
	        return null;
	    }
	}
}
