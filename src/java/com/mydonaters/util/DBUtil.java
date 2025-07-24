package com.mydonaters.util;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.mydonaters.beans.Donation;

public class DBUtil {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydonaters";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
    public static Connection getConnection() throws SQLException {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        throw new SQLException("MySQL JDBC Driver not found", e);
    }

        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public static String getMemberName(int memberId) {
        String name = null;
        try (Connection conn = getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT MEMBER_FULLNAME FROM member WHERE MEMBER_ID = ?")) {
            stmt.setInt(1, memberId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                name = rs.getString("MEMBER_FULLNAME");
            }
        } catch (Exception e) {
        }
        return name;
    }                                                                                                                      

}
