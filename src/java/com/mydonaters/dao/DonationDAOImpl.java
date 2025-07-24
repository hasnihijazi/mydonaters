package com.mydonaters.dao;

import com.mydonaters.beans.Donation;
import com.mydonaters.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DonationDAOImpl implements DonationDAO {

    @Override
    public int addDonation(Donation donation) throws SQLException {
        int generatedId = -1;
        String sql = "INSERT INTO donations (member_id, donation_date, items, remarks, payment_amount) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, donation.getMemberId());
            stmt.setString(2, donation.getDonationDate());
            stmt.setString(3, donation.getItems());
            stmt.setString(4, donation.getRemarks());
            stmt.setDouble(5, donation.getPaymentAmount());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
        }
        return generatedId;
    }
    
    @Override
    public List<Donation> getAllDonations() {
    List<Donation> list = new ArrayList<>();
    String sql = "SELECT d.*, m.MEMBER_FULLNAME FROM donations d " +
                 "LEFT JOIN member m ON d.member_id = m.member_id";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Donation donation = new Donation();
            donation.setDonationId(rs.getInt("donation_id"));
            donation.setDonationDate(rs.getString("donation_date"));
            donation.setItems(rs.getString("items"));
            donation.setRemarks(rs.getString("remarks"));
            donation.setPaymentAmount(rs.getDouble("payment_amount"));
            donation.setMemberId(rs.getInt("member_id"));

            String donorName = rs.getString("MEMBER_FULLNAME");
            if (donorName == null || donorName.trim().isEmpty()) {
                donorName = rs.getString("donor_name");
            }
            donation.setDonorName(donorName);

            list.add(donation);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
    }

    
    @Override
    public boolean updateDonation(int donationId, String items, String remarks) {
        String sql = "UPDATE donations SET items = ?, remarks = ? WHERE donation_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, items);
            stmt.setString(2, remarks);
            stmt.setInt(3, donationId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteDonation(int donationId) {
        String sql = "DELETE FROM donations WHERE donation_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, donationId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public Donation getDonationById(int donationId) throws SQLException {
        Donation donation = null;

        String sql = "SELECT d.*, m.MEMBER_FULLNAME " +
                     "FROM donations d " +
                     "LEFT JOIN member m ON d.MEMBER_ID = m.MEMBER_ID " +
                     "WHERE d.donation_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, donationId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                donation = new Donation();
                donation.setId(rs.getInt("donation_id"));
                donation.setMemberId(rs.getInt("member_id"));
                donation.setDonationDate(rs.getString("donation_date"));
                donation.setItems(rs.getString("items"));
                donation.setRemarks(rs.getString("remarks"));
                donation.setPaymentAmount(rs.getDouble("payment_amount"));

                String donorName = rs.getString("MEMBER_FULLNAME");
                if (donorName == null || donorName.trim().isEmpty()) {
                    donorName = rs.getString("donor_name");
                }
                donation.setDonorName(donorName);
            }
        }

        return donation;
    }

}