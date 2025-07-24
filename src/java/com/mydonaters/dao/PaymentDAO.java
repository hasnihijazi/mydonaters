package com.mydonaters.dao;

import java.sql.SQLException;

public interface PaymentDAO {
    boolean updatePaymentAmount(int donationId, double amount) throws SQLException;
}
