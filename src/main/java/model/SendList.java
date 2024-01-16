package model;

import java.io.IOException;
import java.util.ArrayList;

import dto.BookBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SendList {
	public static void sendList(HttpServletRequest request, HttpServletResponse response, String message)
			throws ServletException, IOException {
		//本の一覧を取得
		ArrayList<BookBean> bookList = SelectBookList.selectBookList();
		if(bookList == null) {
			message = "本の一覧の取得に失敗しました";
		}

		request.setAttribute("bookList", bookList);
		request.setAttribute("message", message);

		String view = "/WEB-INF/views/list.jsp";
		request.getRequestDispatcher(view).forward(request, response);
	}

}
