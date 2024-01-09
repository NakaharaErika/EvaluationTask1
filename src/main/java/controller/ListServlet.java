package controller;

import java.io.IOException;
import java.util.ArrayList;

import dto.BookBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.SelectBookList;

@WebServlet("/list")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ListServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//メッセージを取得
		String message = request.getParameter("message");

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
