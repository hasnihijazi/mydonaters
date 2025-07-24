package com.mydonaters.servlets;

import com.mydonaters.dao.DonationDAO;
import com.mydonaters.dao.DonationDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteDonationServlet")
public class DeleteDonationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int donationId = Integer.parseInt(request.getParameter("donationId"));

        DonationDAO dao = new DonationDAOImpl();
        boolean success = dao.deleteDonation(donationId);

        response.sendRedirect("DonationListServlet" + (success ? "?delete=success" : "?delete=failed"));
    }
}
