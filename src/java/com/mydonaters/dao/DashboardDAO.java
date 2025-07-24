package com.mydonaters.dao;

import com.mydonaters.beans.Donation;

import java.util.List;

public interface DashboardDAO {
    String getMemberName(int memberId);
    int getTotalMembers();
    int getTotalItemDonations();
    double getTotalPaymentAmount();
    List<Donation> getRecentDonations();
}
