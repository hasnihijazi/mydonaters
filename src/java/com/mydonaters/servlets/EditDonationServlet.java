package com.mydonaters.servlets;

import com.mydonaters.dao.DonationDAO;
import com.mydonaters.dao.DonationDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditDonationServlet")
public class EditDonationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String donationIdStr = request.getParameter("donationId");
        String items = request.getParameter("items");
        String remarks = request.getParameter("remarks");

        DonationDAO dao = new DonationDAOImpl();

        try {
            int donationId = Integer.parseInt(donationIdStr);

            boolean success = dao.updateDonation(donationId, items, remarks);

            if (success) {
                response.sendRedirect("DonationListServlet?update=success");
            } else {
                response.sendRedirect("admin_edit_donation.jsp?donationId=" + donationId + "&update=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_donation.jsp?update=error");
        }
    }
}
