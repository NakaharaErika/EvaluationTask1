package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import dao.DatabaseConnection;
import dao.GeneralDao;
import dto.BookBean;

public class SelectBookList {

	//全ての本を取得する
	public static ArrayList<BookBean> selectBookList() {
			StringBuilder sb = new StringBuilder();

				sb.append("SELECT "		);
				sb.append(	"* " 		);
				sb.append("FROM "		);
				sb.append(	"BOOK; "	);

				final String SQL = sb.toString();

				ArrayList<BookBean> bookList = new ArrayList<>();
				List<Object> params = Arrays.asList();
				//SQL接続
				try (Connection conn = DatabaseConnection.getConnection();
					 ResultSet rs = GeneralDao.executeQuery(conn, SQL, params)) {

							while(rs.next()) {
								BookBean book = new BookBean();
								book.setJanCd(rs.getString("JAN_CD"));
								book.setIsbnCd(rs.getString("ISBN_CD"));
								book.setBookNm(rs.getString("BOOK_NM"));
								book.setBookKana(rs.getString("BOOK_KANA"));
								book.setPrice(rs.getInt("PRICE"));
								book.setIssueDate(rs.getDate("ISSUE_DATE"));
								book.setCreateDate(rs.getTimestamp("CREATE_DATETIME"));
								book.setUpdateDate(rs.getTimestamp("UPDATE_DATETIME"));

								bookList.add(book);
							}
				} catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
				return null;
				}

		return bookList;
	}
}
