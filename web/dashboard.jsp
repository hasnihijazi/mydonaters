<%@ page import="com.mydonaters.beans.Donation, java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (session == null || isAdmin == null || !isAdmin) {
        response.sendRedirect("index");
        return;
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Donnaters | Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="side-menu">
        <div class="brand-name">
            <div style="display: flex; align-items: center;">
                <img src="images/donnaterslogo.png" alt="Brand Logo" style="width: 100px; height: 100px; margin-right: 10px;">
            </div>
        </div>
        <ul>
            <li><a href="dashboard" style="color: inherit;"><span>Dashboard</span></a></li>
            <li><a href="member_detail" style="color: inherit;"><span>Members</span></a></li>
            <li><a href="DonationListServlet" style="color: inherit;"><span>Donation</span></a></li>
            <li><a href="LogoutServlet" style="color: inherit;"><span>Logout</span></a></li>
        </ul>
    </div>

    <div class="container">
        <div class="header">
            <div class="nav">
                <div class="search">
                    <input type="text" placeholder="Search..">
                    <button type="submit">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <div class="content">
            <div class="cards">
                <div class="card">
                    <div class="box">
                        <h1><c:out value="${totalMembers}"/></h1>
                        <h3>Members</h3>
                    </div>
                    <div class="icon-case">
                        <img src="images/schools.png" alt="">
                    </div>
                </div>

                <div class="card">
                    <div class="box">
                        <h1><c:out value="${totalItemDonations}"/></h1>
                        <h3>Items Donation</h3>
                    </div>
                    <div class="icon-case">
                        <img src="images/schools.png" alt="">
                    </div>
                </div>

                <div class="card">
                    <div class="box">
                        <h1><fmt:formatNumber value="${totalPaymentDonations}" type="number" minFractionDigits="2" /></h1>
                        <h3>Payments Donation (RM)</h3>
                    </div>
                    <div class="icon-case">
                        <img src="images/schools.png" alt="">
                    </div>
                </div>

                <div class="card">
                    <div class="box">
                        <h1>Thank You!</h1>
                        <h3>For your Donation</h3>
                    </div>
                    <div class="icon-case">
                        <img src="images/schools.png" alt="">
                    </div>
                </div>
            </div>

            <div class="content-2" style="display: flex; flex-wrap: wrap; gap: 20px;">
                <!-- Left: Recent Donations Table -->
                <div class="recent-payments" style="flex: 2;">
                    <div class="title">
                        <h2>Recent Donations</h2>
                    </div>
                    <table>
                        <tr>
                            <th>Name</th>
                            <th>Item Donation</th>
                            <th>Payment Donation (RM)</th>
                            <th>Option</th>
                        </tr>
                        <c:forEach var="donation" items="${recentDonations}">
                            <tr>
                                <td><c:out value="${donation.donorName}" /></td>
                                <td><c:out value="${donation.items}" /></td>
                                <td><fmt:formatNumber value="${donation.paymentAmount}" type="number" minFractionDigits="2" /></td>
                                <td><a href="DonationListServlet" class="btn">View</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>

                <!-- Right: Chart -->
                <div class="new-students" style="flex: 1; padding: 20px;">
                    <div class="title">
                        <h2>Donation Chart</h2>
                    </div>
                    <canvas id="donationChart" style="width: 100%; max-height: 300px;"></canvas>
                </div>
            </div>
        </div>
    </div>
<script>
    const ctx = document.getElementById('donationChart').getContext('2d');
    const donationChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Members', 'Item Donations', 'Payments (RM)'],
            datasets: [{
                label: 'Dashboard Summary',
                data: [
                    ${totalMembers}, 
                    ${totalItemDonations}, 
                    ${totalPaymentDonations}
                ],
                backgroundColor: [
                    'rgba(75, 192, 192, 0.6)',
                    'rgba(255, 159, 64, 0.6)',
                    'rgba(153, 102, 255, 0.6)'
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            }
        }
    });
</script>
</body>
</html>
