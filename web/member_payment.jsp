<%@ page import="java.net.URLEncoder" %>
<%
    if (session == null || session.getAttribute("memberId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String success = request.getParameter("success");
    String donorName = (String) session.getAttribute("pendingDonorName");
    String donatedItems = (String) session.getAttribute("pendingDonationItems");
    Integer donationId = (Integer) session.getAttribute("pendingDonationId");
%>

<% if ("payment".equals(success)) { %>
<script>alert("Your payment has been recorded successfully!");</script>
<% } %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment | Donnaters</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/member_payment.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="side-menu">
        <div class="brand-name">
            <img src="images/donnaterslogo.png" alt="Logo" style="width: 100%; max-width: 180px;">
        </div>
        <ul>
            <li><a href="member_donation.jsp">Donation</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </div>

    <div class="container">
        <div class="header">
            <div class="user">
                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person">
                    <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4"/>
                </svg>
            </div>
        </div>

        <div class="content">
            <div class="payment-container">
                <div class="payment-header">
                    <h1>Complete Your Donation</h1>
                    <p>Thank you for your generosity. Please complete your payment below.</p>
                </div>

                <form action="processPayment" method="POST">
                    <!-- Amount Input -->
                    <div class="form-group">
                        <label for="donation-amount">Enter Donation Amount (RM)</label>
                        <input type="number" id="donation-amount" name="donationAmount" placeholder="e.g. 50.00" step="0.01" min="0" required oninput="updateDonationAmount()">
                    </div>

                    <!-- Hidden donationId -->
                    <input type="hidden" name="donationId" value="<%= donationId != null ? donationId : "" %>">

                    <!-- Summary -->
                    <div class="payment-summary">
                        <h3>Donation Summary</h3>
                        <div style="display: flex; justify-content: space-between; margin-top: 15px;">
                            <div>
                                <p><strong>Donor:</strong> <%= donorName != null ? donorName : "Unknown" %></p>
                                <p><strong>Items:</strong> <%= donatedItems != null ? donatedItems : "None" %></p>
                            </div>
                            <div style="text-align: right;">
                                <p><strong>Total Amount:</strong></p>
                                <h2 id="display-amount" style="color: #f05462;">RM 0.00</h2>
                            </div>
                        </div>
                    </div>

                    <!-- Fake payment method UI -->
                    <div class="payment-details">
                        <h3>Card Details</h3>

                        <div class="form-group">
                            <label for="card-number">Card Number</label>
                            <input type="text" id="card-number" placeholder="1234 5678 9012 3456">
                        </div>

                        <div style="display: flex; gap: 20px;">
                            <div class="form-group" style="flex: 1;">
                                <label for="expiry-date">Expiry Date</label>
                                <input type="text" id="expiry-date" placeholder="MM/YY">
                            </div>
                            <div class="form-group" style="flex: 1;">
                                <label for="cvv">CVV</label>
                                <input type="text" id="cvv" placeholder="123">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="card-name">Name on Card</label>
                            <input type="text" id="card-name" placeholder="John Doe">
                        </div>

                        <button class="btn-pay" type="submit">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Update visible amount on input
        function updateDonationAmount() {
            const input = document.getElementById('donation-amount');
            const display = document.getElementById('display-amount');
            let value = parseFloat(input.value);
            display.textContent = 'RM ' + (!isNaN(value) ? value.toFixed(2) : '0.00');
        }

        // Optional: Format credit card number
        document.getElementById('card-number').addEventListener('input', function () {
            let val = this.value.replace(/\D/g, '').replace(/(.{4})/g, '$1 ').trim();
            this.value = val;
        });

        // Optional: Format expiry date
        document.getElementById('expiry-date').addEventListener('input', function () {
            let val = this.value.replace(/\D/g, '');
            if (val.length > 2) {
                val = val.substring(0, 2) + '/' + val.substring(2, 4);
            }
            this.value = val;
        });
    </script>
</body>
</html>
