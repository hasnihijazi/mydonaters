package com.mydonaters.beans;

public class Donation {

    private int donationId;
    private int memberId;
    private String donationDate;
    private String items;
    private String remarks;
    private double paymentAmount;
    private String donorName;

    public Donation() {
    }

    public Donation(int donationId, int memberId, String donationDate, String items, String remarks, double paymentAmount) {
        this.donationId = donationId;
        this.memberId = memberId;
        this.donationDate = donationDate;
        this.items = items;
        this.remarks = remarks;
        this.paymentAmount = paymentAmount;
    }

    public int getDonationId() {
        return donationId;
    }

    public void setDonationId(int donationId) {
        this.donationId = donationId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public String getDonationDate() {
        return donationDate;
    }

    public void setDonationDate(String donationDate) {
        this.donationDate = donationDate;
    }

    public String getItems() {
        return items;
    }

    public void setItems(String items) {
        this.items = items;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public double getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }
    
    public String getDonorName() { 
        return donorName; 
    }
    
    public void setDonorName(String donorName) { 
        this.donorName = donorName; 
    }

    @Override
    public String toString() {
        return "Donation{" +
                "donationId=" + donationId +
                ", memberId=" + memberId +
                ", donationDate='" + donationDate + '\'' +
                ", items='" + items + '\'' +
                ", remarks='" + remarks + '\'' +
                ", paymentAmount=" + paymentAmount +
                '}';
    }

    public void setId(int id) {
        this.donationId = id;
    }

}
