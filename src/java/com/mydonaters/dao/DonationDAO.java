package com.mydonaters.dao;

import com.mydonaters.beans.Donation;
import java.sql.SQLException;
import java.util.List;

public interface DonationDAO {
    int addDonation(Donation donation) throws SQLException;
    List<Donation> getAllDonations();
    boolean updateDonation(int donationId, String items, String remarks);
    boolean deleteDonation(int donationId);
    Donation getDonationById(int donationId) throws SQLException;
}
