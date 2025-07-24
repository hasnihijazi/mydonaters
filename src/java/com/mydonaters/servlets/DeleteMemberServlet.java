package com.mydonaters.servlets;

import com.mydonaters.dao.MemberDAO;
import com.mydonaters.dao.MemberDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/delete_member")
public class DeleteMemberServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);

            MemberDAO dao = new MemberDAOImpl();
            dao.softDeleteMember(id);
        }

        response.sendRedirect("member_detail");
    }
}
