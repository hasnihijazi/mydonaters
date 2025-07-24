package com.mydonaters.servlets;

import com.mydonaters.dao.PaymentDAO;
import com.mydonaters.dao.PaymentDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/processPayment")
public class PaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer donationId = (Integer) session.getAttribute("pendingDonationId");

        if (donationId == null) {
            response.sendRedirect("member_donation.jsp?error=noDonation");
            return;
        }

        try {
            String amountStr = request.getParameter("donationAmount");
            if (amountStr == null || amountStr.trim().isEmpty()) {
                response.sendRedirect("member_payment.jsp?error=emptyAmount");
                return;
            }

            double amount = Double.parseDouble(amountStr);

            PaymentDAO paymentDAO = new PaymentDAOImpl();
            boolean updated = paymentDAO.updatePaymentAmount(donationId, amount);

            if (updated) {
                session.removeAttribute("pendingDonationId");
                session.removeAttribute("pendingDonorName");
                session.removeAttribute("pendingDonationItems");
                response.sendRedirect("member_donation.jsp?success=payment");
            } else {
                response.sendRedirect("member_payment.jsp?error=updateFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("member_payment.jsp?error=invalid");
        }
    }
}
