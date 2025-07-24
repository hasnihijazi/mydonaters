package com.mydonaters.servlets;

import com.mydonaters.beans.Member;
import com.mydonaters.dao.MemberDAO;
import com.mydonaters.dao.MemberDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditMemberServlet")
public class EditMemberServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String ic = request.getParameter("ic");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        int age = Integer.parseInt(request.getParameter("age"));

        Member member = new Member();
        member.setId(id);
        member.setFullName(fullName);
        member.setIc(ic);
        member.setDob(dob);
        member.setGender(gender);
        member.setContact(contact);
        member.setEmail(email);
        member.setAddress(address);
        member.setAge(age);

        MemberDAO dao = new MemberDAOImpl();
        dao.updateMember(member);

        response.sendRedirect("member_detail");
    }
}
