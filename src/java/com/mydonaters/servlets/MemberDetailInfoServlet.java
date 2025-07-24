package com.mydonaters.servlets;

import com.mydonaters.beans.Member;
import com.mydonaters.dao.MemberDAO;
import com.mydonaters.dao.MemberDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/MemberDetailInfoServlet")
public class MemberDetailInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("member_detail.jsp");
            return;
        }

        int memberId;
        try {
            memberId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("member_detail.jsp");
            return;
        }

        MemberDAO dao = new MemberDAOImpl();
        Member member = dao.getMemberById(memberId);

        if (member != null) {
            request.setAttribute("member", member);

            String mode = request.getParameter("mode");
            if ("edit".equalsIgnoreCase(mode)) {
                request.getRequestDispatcher("member_edit.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("member_detail_info.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("member_detail.jsp");
        }
    }
}
