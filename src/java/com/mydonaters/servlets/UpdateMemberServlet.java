package com.mydonaters.servlets;

import com.mydonaters.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateMemberServlet")
public class UpdateMemberServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String ic = request.getParameter("ic");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        int age = Integer.parseInt(request.getParameter("age"));
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE member SET MEMBER_FULLNAME=?, MEMBER_IC=?, MEMBER_DOB=?, MEMBER_GENDER=?, MEMBER_AGE=?, MEMBER_CONTACT=?, MEMBER_EMAIL=?, MEMBER_ADDRESS=? WHERE MEMBER_ID=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, ic);
            stmt.setString(3, dob);
            stmt.setString(4, gender);
            stmt.setInt(5, age);
            stmt.setString(6, contact);
            stmt.setString(7, email);
            stmt.setString(8, address);
            stmt.setInt(9, id);

            stmt.executeUpdate();

            response.sendRedirect("member_detail");

        } catch (SQLException e) {
            response.sendRedirect("error.jsp");
        }
    }
}
