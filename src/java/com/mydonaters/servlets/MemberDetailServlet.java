package com.mydonaters.servlets;

import com.mydonaters.beans.Member;
import com.mydonaters.dao.MemberDAO;
import com.mydonaters.dao.MemberDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/member_detail")
public class MemberDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Boolean isAdmin = (session != null) ? (Boolean) session.getAttribute("isAdmin") : null;

        if (isAdmin == null || !isAdmin) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            MemberDAO dao = new MemberDAOImpl();
            List<Member> members;
            members = dao.getAllActiveMembers();

            request.setAttribute("members", members);
            request.getRequestDispatcher("member_detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
