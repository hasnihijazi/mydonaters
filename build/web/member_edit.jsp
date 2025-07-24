<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mydonaters.beans.Member" %>
<%
    Member member = (Member) request.getAttribute("member");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/member_detail_info.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <title>Edit Member</title>
</head>
<body>
    <div class="side-menu">
        <!-- same side-menu -->
        <div class="brand-name">
            <div style="display: flex; align-items: center;">
                <img src="images/donnaterslogo.png" alt="Brand Logo" style="width: 100px; height: 100px; margin-right: 10px;">
            </div>
        </div>
        <ul>
            <li><a href="dashboard" style="color: inherit;"><span>Dashboard</span></a></li>
            <li><a href="member_detail" style="color: inherit;"><span>Members</span></a></li>
            <li><a href="admin_donation2" style="color: inherit;"><span>Donation</span></a></li>
            <li><a href="LogoutServlet" style="color: inherit;"><span>Logout</span></a></li>
        </ul>
    </div>

    <div class="container">
        <div class="header">
            <div class="nav">
                <div class="user">
                    <!-- same icons -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bell"><path d="..."/></svg>
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person"><path d="..."/></svg>
                    <div class="img-case"></div>
                </div>
            </div>
        </div>

        <div class="content">
            <div class="content-2">
                <div class="member-details">
                    <div class="title">
                        <h2>Edit Member Details</h2>
                    </div>
                    <form method="post" action="UpdateMemberServlet">
                        <input type="hidden" name="id" value="${member.id}" />
                        <div class="member-info">
                            <h3>Personal Information</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <label>Full Name</label>
                                    <input type="text" name="fullName" value="${member.fullName}" required />
                                </div>
                                <div class="info-item">
                                    <label>IC Number</label>
                                    <input type="text" name="ic" value="${member.ic}" required />
                                </div>
                                <div class="info-item">
                                    <label>Date of Birth</label>
                                    <input type="date" name="dob" value="${member.dob}" required />
                                </div>
                                <div class="info-item">
                                    <label>Gender</label>
                                    <select name="gender" required>
                                        <option value="Male" ${member.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${member.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>
                                <div class="info-item">
                                    <label>Age</label>
                                    <input type="number" name="age" value="${member.age}" required />
                                </div>
                                <div class="info-item">
                                    <label>Contact Number</label>
                                    <input type="text" name="contact" value="${member.contact}" required />
                                </div>
                                <div class="info-item">
                                    <label>Email</label>
                                    <input type="email" name="email" value="${member.email}" required />
                                </div>
                            </div>

                            <div style="margin-top: 20px;">
                                <h3>Address Information</h3>
                                <div class="info-item" style="margin-top: 15px;">
                                    <label>Full Address</label>
                                    <textarea name="address" required style="width: 100%; height: 80px;">${member.address}</textarea>
                                </div>
                            </div>

                            <div style="margin-top: 30px;">
                                <button type="submit" class="btn" style="background-color: green;">Save Changes</button>
                                <button href="member_detail" class="btn" style="background-color: #555;">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
