package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import dao.DatabaseConnection;
import dao.GeneralDao;
import dto.BookBean;

public class SelectBook {

	//全ての本を取得する
	public static BookBean selectBook(BookBean bookItem) {
			StringBuilder sb = new StringBuilder();

				sb.append("SELECT "			);
				sb.append(	"* " 			);
				sb.append("FROM "			);
				sb.append(	"BOOK "			);
				sb.append("WHERE "			);
				sb.append(	"JAN_CD= ? ;"	);

				final String SQL = sb.toString();

				BookBean book = new BookBean();
				List<Object> params = Arrays.asList(bookItem.getJanCd());
				//SQL接続
				try (Connection conn = DatabaseConnection.getConnection();
					 ResultSet rs = GeneralDao.executeQuery(conn, SQL, params)) {
							while(rs.next()) {
								book.setJanCd(rs.getString("JAN_CD"));
								book.setIsbnCd(rs.getString("ISBN_CD"));
								book.setBookNm(rs.getString("BOOK_NM"));
								book.setBookKana(rs.getString("BOOK_KANA"));
								book.setPrice(rs.getInt("PRICE"));
								book.setIssueDate(rs.getDate("ISSUE_DATE").toLocalDate());
							}
				} catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
				return null;
				}

		return book;
	}
}
