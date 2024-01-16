package model;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.DatabaseConnection;
import dao.GeneralDao;

public class DeleteBook {

	public static ArrayList<String> deleteBook(String[] bookStatus) {
	    StringBuilder sb = new StringBuilder();

	    sb.append("DELETE FROM ");
	    sb.append("BOOK ");
	    sb.append("WHERE ");
	    sb.append("JAN_CD = ?;");

	    final String SQL = sb.toString();
	    ArrayList<String> falseRows = new ArrayList<>();

	    try (Connection conn = DatabaseConnection.getConnection()) {
	        for (String book : bookStatus) {
	            try {
	                List<Object> params = new ArrayList<>();
	                params.add(book);
	                if (GeneralDao.executeUpdate(conn, SQL, params) == 0) {
	                    falseRows.add(book);
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	                falseRows.add(book);
	            }
	        }
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	        return null;
	    }

	    return falseRows;
	}
}
