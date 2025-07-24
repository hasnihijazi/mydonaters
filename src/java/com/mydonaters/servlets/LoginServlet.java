package com.mydonaters.servlets;

import com.mydonaters.beans.Member;
import com.mydonaters.dao.MemberDAO;
import com.mydonaters.dao.MemberDAOImpl;
import com.mydonaters.util.DBUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    private MemberDAO memberDAO;

    @Override
    public void init() {
        memberDAO = new MemberDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Admin login
        if ("admin".equals(username) && "password".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("isAdmin", true);
            response.sendRedirect("dashboard");
            return;
        }

        // Member login using DAO
        Member member = memberDAO.login(username, password);
        if (member != null) {
            HttpSession session = request.getSession();
            session.setAttribute("member", member);
            session.setAttribute("memberId", member.getId());
            response.sendRedirect("member_donation.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}


