package com.mydonaters.servlets;

import com.mydonaters.beans.Donation;
import com.mydonaters.dao.DonationDAO;
import com.mydonaters.dao.DonationDAOImpl;
import com.mydonaters.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet(name = "DonationServlet", urlPatterns = {"/DonationServlet"})
public class DonationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            int memberId = (int) session.getAttribute("memberId");
            String donationDate = request.getParameter("donationDate");
            String[] itemsArray = request.getParameterValues("items");
            String remarks = request.getParameter("remarks");
            String addPayment = request.getParameter("addPayment");

            // Build item summary with quantity
            Map<String, String> itemNames = new LinkedHashMap<>();
            itemNames.put("Food", "qty_Food");
            itemNames.put("Water", "qty_Water");
            itemNames.put("Medical Kits", "qty_Medical");
            itemNames.put("Clothes", "qty_Clothes");
            itemNames.put("Shoes", "qty_Shoes");
            itemNames.put("Bedsheet", "qty_Bedsheet");
            itemNames.put("Others", "qty_Others");

            StringBuilder itemSummaryBuilder = new StringBuilder();
            String items = "";

            if (itemsArray != null && itemsArray.length > 0) {
                List<String> itemList = new ArrayList<>();

                for (String item : itemsArray) {
                    String qtyParam = itemNames.get(item);
                    if (qtyParam != null) {
                        String qtyStr = request.getParameter(qtyParam);
                        if (qtyStr != null && !qtyStr.isEmpty()) {
                            itemList.add(item + " (" + qtyStr + ")");
                        } else {
                            itemList.add(item); // no qty given
                        }
                    } else {
                        itemList.add(item);
                    }
                }

                items = String.join(", ", itemList);
                itemSummaryBuilder.append(items);
            }

            // Build Donation bean
            Donation donation = new Donation();
            donation.setMemberId(memberId);
            donation.setDonationDate(donationDate);
            donation.setItems(items);
            donation.setRemarks(remarks);
            donation.setPaymentAmount(0.0);

            // Insert into DB
            DonationDAO donationDAO = new DonationDAOImpl();
            int generatedDonationId = donationDAO.addDonation(donation);

            // If user chose to add payment
            if ("yes".equalsIgnoreCase(addPayment) && generatedDonationId > 0) {
                // Get member's name from DB
                String memberName = DBUtil.getMemberName(memberId);

                session.setAttribute("pendingDonationId", generatedDonationId);
                session.setAttribute("pendingDonorName", memberName);
                session.setAttribute("pendingDonationItems", itemSummaryBuilder.toString());

                response.sendRedirect("member_payment.jsp");
            } else {
                response.sendRedirect("member_donation.jsp?success=true");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("member_donation.jsp?success=false");
        }
    }
}
