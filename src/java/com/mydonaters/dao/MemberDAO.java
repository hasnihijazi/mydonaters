package com.mydonaters.dao;
import com.mydonaters.beans.Member;
import java.util.List;

public interface MemberDAO {
    Member login(String username, String password);
    boolean registerMember(Member member);
    public List<Member> getAllActiveMembers();
    void updateMember(Member member);
    void softDeleteMember(int id);
    Member getMemberById(int id);
}

