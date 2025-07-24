package com.mydonaters.dao;

import com.mydonaters.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PaymentDAOImpl implements PaymentDAO {

    @Override
    public boolean updatePaymentAmount(int donationId, double amount) throws SQLException {
        String sql = "UPDATE donations SET payment_amount = ? WHERE donation_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, amount);
            stmt.setInt(2, donationId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }
}
