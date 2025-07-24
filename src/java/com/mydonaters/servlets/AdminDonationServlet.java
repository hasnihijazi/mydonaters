package com.mydonaters.servlets;

import com.mydonaters.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AdminDonationServlet")
public class AdminDonationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String donorName = request.getParameter("donorName");
        String donationDateStr = request.getParameter("donationDate");
        String remark = request.getParameter("others_remarks");

        // Handle optional amount
        String amountStr = request.getParameter("amount");
        double paymentAmount = 0.0;
        if (amountStr != null && !amountStr.trim().isEmpty()) {
            try {
                paymentAmount = Double.parseDouble(amountStr);
            } catch (NumberFormatException e) {
                paymentAmount = 0.0;
            }
        }

        // Build items string
        String[] selectedItems = request.getParameterValues("items");
        StringBuilder itemsBuilder = new StringBuilder();

        if (selectedItems != null) {
            for (String item : selectedItems) {
                String key = item.replaceAll("\\s+", "");
                String qtyParam = "qty_" + key;
                String qtyStr = request.getParameter(qtyParam);

                if (qtyStr != null && !qtyStr.trim().isEmpty()) {
                    itemsBuilder.append(item).append(" (").append(qtyStr).append("), ");
                }
            }
        }

        String items = itemsBuilder.toString();
        if (items.endsWith(", ")) {
            items = items.substring(0, items.length() - 2);
        }

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO donations (donor_name, donation_date, items, remarks, payment_amount, member_id, donated_by_admin) " +
                         "VALUES (?, ?, ?, ?, ?, NULL, TRUE)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, donorName);
            stmt.setDate(2, java.sql.Date.valueOf(donationDateStr));
            stmt.setString(3, items);
            stmt.setString(4, remark);
            stmt.setDouble(5, paymentAmount);

            stmt.executeUpdate();
            response.sendRedirect("DonationListServlet?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("DonationListServlet?success=true");
        }
    }
}
