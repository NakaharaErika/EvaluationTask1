package model;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.DatabaseConnection;
import dao.GeneralDao;
import dto.BookBean;
import dto.BookProcessing;

public class InsertBookBulk {

	//書籍を更新する
	public static BookProcessing insertBookBulk(BookProcessing result) {
			StringBuilder sb = new StringBuilder();

				sb.append("INSERT INTO "													);
				sb.append(	"BOOK " 														);
				sb.append(	"(JAN_CD, ISBN_CD, BOOK_NM, BOOK_KANA, PRICE, ISSUE_DATE, "		);
				sb.append(	"CREATE_DATETIME, UPDATE_DATETIME)"								);
				sb.append("VALUES "															);
				sb.append("(?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, NULL);"					);

				final String SQL = sb.toString();
				List<Object> params = new ArrayList<>();
				//SQL接続
				try (Connection conn = DatabaseConnection.getConnection()){
					for(BookBean book : result.getSuccessfulEntries()) {
						try {
							params.clear();
							params.add(book.getJanCd());
							params.add(book.getIsbnCd());
							params.add(book.getBookNm());
							params.add(book.getBookKana());
							params.add(book.getPrice());
							params.add(book.getIssueDate());

							GeneralDao.executeUpdate(conn, SQL, params);

						} catch (SQLException e) {
							e.printStackTrace();
							result.addErrorEntry(book.getJanCd());
						}
					}
				} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
					return null;
				}

		return result;
	}
}
