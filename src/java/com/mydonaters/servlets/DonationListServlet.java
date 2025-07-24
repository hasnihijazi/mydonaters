package com.mydonaters.servlets;

import com.mydonaters.beans.Donation;
import com.mydonaters.dao.DonationDAO;
import com.mydonaters.dao.DonationDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DonationListServlet")
public class DonationListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DonationDAO dao = new DonationDAOImpl();
        List<Donation> donationList;
        donationList = dao.getAllDonations();

        request.setAttribute("donations", donationList);
        request.getRequestDispatcher("admin_donation.jsp").forward(request, response);
    }
}
