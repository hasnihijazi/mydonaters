package com.mydonaters.dao;

import com.mydonaters.beans.Donation;
import com.mydonaters.util.DBUtil;
import static com.mydonaters.util.DBUtil.getConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAOImpl implements DashboardDAO {

    public String getMemberName(int memberId) {
    String name = null;
    try (Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT MEMBER_FULLNAME FROM member WHERE MEMBER_ID = ?")) {
        stmt.setInt(1, memberId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            name = rs.getString("MEMBER_FULLNAME");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return name;
    }

    @Override
    public int getTotalMembers() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM member");
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int getTotalItemDonations() {
        String sql = "SELECT items FROM donations WHERE items IS NOT NULL";
        int total = 0;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String itemsStr = rs.getString("items");
                if (itemsStr != null && !itemsStr.trim().isEmpty()) {
                    // Cari nombor dalam tanda kurung (contoh: (2), (1))
                    java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\\((\\d+)\\)");
                    java.util.regex.Matcher matcher = pattern.matcher(itemsStr);
                    while (matcher.find()) {
                        int qty = Integer.parseInt(matcher.group(1));
                        total += qty;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    @Override
    public double getTotalPaymentAmount() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT SUM(payment_amount) FROM donations");
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getDouble(1) : 0.0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        }
    }

    @Override
    public List<Donation> getRecentDonations() {
        List<Donation> list = new ArrayList<>();
        String sql = "SELECT d.*, m.MEMBER_FULLNAME FROM donations d " +
             "JOIN member m ON d.MEMBER_ID = m.MEMBER_ID " +
             "ORDER BY d.donation_id DESC LIMIT 5";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Donation d = new Donation();
                d.setDonorName(rs.getString("MEMBER_FULLNAME"));
                d.setDonationId(rs.getInt("donation_id"));
                d.setMemberId(rs.getInt("member_id"));
                d.setDonationDate(rs.getString("donation_date"));
                d.setItems(rs.getString("items"));
                d.setRemarks(rs.getString("remarks"));
                d.setPaymentAmount(rs.getDouble("payment_amount"));
                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
}
