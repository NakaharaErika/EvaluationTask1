package model;

import dto.BookBean;

public class CheckParam {

	//全ての本を取得する
	public static BookBean checkParam(BookBean newBook, String price) {
		String cleanedPrice = price.replaceAll(",", "");
		int processedPrice = -1;

	    // 金額の処理
	    if (!cleanedPrice.isEmpty() && cleanedPrice.matches("\\d+")) {
	        processedPrice = Integer.parseInt(cleanedPrice);
	    }
		newBook.setPrice(processedPrice);
		return newBook;
	}
}
