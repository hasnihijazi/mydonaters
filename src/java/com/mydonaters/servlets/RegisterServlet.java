package com.mydonaters.servlets;

import com.mydonaters.beans.Member;
import com.mydonaters.dao.MemberDAO;
import com.mydonaters.dao.MemberDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    private MemberDAO memberDAO;

    @Override
    public void init() throws ServletException {
        memberDAO = new MemberDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("MEMBER_FULLNAME");
        String username = request.getParameter("MEMBER_USERNAME");
        String password = request.getParameter("MEMBER_PASSWORD");
        String confirm = request.getParameter("MEMBER_PASSWORD_CONFIRM");
        String ic = request.getParameter("MEMBER_IC");
        String dob = request.getParameter("MEMBER_DOB");
        String gender = request.getParameter("MEMBER_GENDER");
        String ageStr = request.getParameter("MEMBER_AGE");
        String contact = request.getParameter("MEMBER_CONTACT");
        String email = request.getParameter("MEMBER_EMAIL");
        String address = request.getParameter("MEMBER_ADDRESS");

        int age = 0;
        try {
            age = Integer.parseInt(ageStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid age format.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Password and confirmation do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Member member = new Member();
        member.setFullName(fullname);
        member.setUsername(username);
        member.setPassword(password);
        member.setIc(ic);
        member.setDob(dob);
        member.setGender(gender);
        member.setAge(age);
        member.setContact(contact);
        member.setEmail(email);
        member.setAddress(address);

        boolean success = memberDAO.registerMember(member);
        if (success) {
            request.setAttribute("message", "Registration successful! Please log in.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
