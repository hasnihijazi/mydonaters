package com.mydonaters.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mydonaters.beans.Member;
import com.mydonaters.util.DBUtil;
import java.util.ArrayList;
import java.util.List;

public class MemberDAOImpl implements MemberDAO {

    @Override
    public Member login(String username, String password) {
        Member member = null;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM member WHERE MEMBER_USERNAME = ? AND MEMBER_PASSWORD = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        member = new Member();
                        member.setId(rs.getInt("MEMBER_ID"));
                        member.setFullName(rs.getString("MEMBER_FULLNAME"));
                        member.setUsername(rs.getString("MEMBER_USERNAME"));
                        member.setPassword(rs.getString("MEMBER_PASSWORD"));
                        member.setIc(rs.getString("MEMBER_IC"));
                        member.setDob(rs.getString("MEMBER_DOB"));
                        member.setGender(rs.getString("MEMBER_GENDER"));
                        member.setContact(rs.getString("MEMBER_CONTACT"));
                        member.setEmail(rs.getString("MEMBER_EMAIL"));
                        member.setAddress(rs.getString("MEMBER_ADDRESS"));
                        member.setAge(rs.getInt("MEMBER_AGE"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return member;
    }

    @Override
    public boolean registerMember(Member member) {
        String sql = "INSERT INTO member (MEMBER_FULLNAME, MEMBER_USERNAME, MEMBER_PASSWORD, MEMBER_IC, MEMBER_DOB, MEMBER_GENDER, MEMBER_AGE, MEMBER_CONTACT, MEMBER_EMAIL, MEMBER_ADDRESS) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, member.getFullName());
            stmt.setString(2, member.getUsername());
            stmt.setString(3, member.getPassword());
            stmt.setString(4, member.getIc());
            stmt.setString(5, member.getDob());
            stmt.setString(6, member.getGender());
            stmt.setInt(7, member.getAge());
            stmt.setString(8, member.getContact());
            stmt.setString(9, member.getEmail());
            stmt.setString(10, member.getAddress());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public List<Member> getAllActiveMembers() {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT * FROM member WHERE is_deleted = FALSE";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("MEMBER_ID"));
                member.setFullName(rs.getString("MEMBER_FULLNAME"));
                member.setUsername(rs.getString("MEMBER_USERNAME"));
                member.setPassword(rs.getString("MEMBER_PASSWORD"));
                member.setIc(rs.getString("MEMBER_IC"));
                member.setDob(rs.getString("MEMBER_DOB"));
                member.setGender(rs.getString("MEMBER_GENDER"));
                member.setContact(rs.getString("MEMBER_CONTACT"));
                member.setEmail(rs.getString("MEMBER_EMAIL"));
                member.setAddress(rs.getString("MEMBER_ADDRESS"));
                member.setAge(rs.getInt("MEMBER_AGE"));

                members.add(member);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return members;
    }
    
    @Override
    public void updateMember(Member member) {
        String sql = "UPDATE member SET MEMBER_FULLNAME=?, MEMBER_IC=?, MEMBER_DOB=?, MEMBER_GENDER=?, MEMBER_CONTACT=?, MEMBER_EMAIL=?, MEMBER_ADDRESS=?, MEMBER_AGE=? WHERE MEMBER_ID=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, member.getFullName());
            stmt.setString(2, member.getIc());
            stmt.setString(3, member.getDob());
            stmt.setString(4, member.getGender());
            stmt.setString(5, member.getContact());
            stmt.setString(6, member.getEmail());
            stmt.setString(7, member.getAddress());
            stmt.setInt(8, member.getAge());
            stmt.setInt(9, member.getId());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void softDeleteMember(int id) {
        String sql = "UPDATE member SET is_deleted = TRUE WHERE MEMBER_ID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public Member getMemberById(int id) {
        Member member = null;
        String sql = "SELECT * FROM member WHERE MEMBER_ID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                member = new Member();
                member.setId(rs.getInt("MEMBER_ID"));
                member.setFullName(rs.getString("MEMBER_FULLNAME"));
                member.setUsername(rs.getString("MEMBER_USERNAME"));
                member.setPassword(rs.getString("MEMBER_PASSWORD"));
                member.setIc(rs.getString("MEMBER_IC"));
                member.setDob(rs.getString("MEMBER_DOB"));
                member.setGender(rs.getString("MEMBER_GENDER"));
                member.setAge(rs.getInt("MEMBER_AGE"));
                member.setContact(rs.getString("MEMBER_CONTACT"));
                member.setEmail(rs.getString("MEMBER_EMAIL"));
                member.setAddress(rs.getString("MEMBER_ADDRESS"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return member;
    }

}
