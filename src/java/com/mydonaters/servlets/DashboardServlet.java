package com.mydonaters.servlets;

import com.mydonaters.beans.Donation;
import com.mydonaters.dao.DashboardDAO;
import com.mydonaters.dao.DashboardDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("isAdmin") == null || !(Boolean) session.getAttribute("isAdmin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            DashboardDAO dashboardDAO = new DashboardDAOImpl();

            int totalMembers = dashboardDAO.getTotalMembers();
            int totalItems = dashboardDAO.getTotalItemDonations();
            double totalPayments = dashboardDAO.getTotalPaymentAmount();
            List<Donation> recentDonations = dashboardDAO.getRecentDonations();

            request.setAttribute("totalMembers", totalMembers);
            request.setAttribute("totalItemDonations", totalItems);
            request.setAttribute("totalPaymentDonations", totalPayments);
            request.setAttribute("recentDonations", recentDonations);

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
