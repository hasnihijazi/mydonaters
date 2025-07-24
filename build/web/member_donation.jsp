<%@ page import="java.net.URLEncoder" %>
<%
    if (session == null || session.getAttribute("memberId") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/member_donation.css">
    <title>Donate Items</title>
</head>
<body>
    <% if ("true".equals(success)) { %>
    <script>
        alert("Your donation has been submitted successfully!");
    </script>
    <% } %>
  <div class="side-menu">
    <div class="brand-name">
      <img src="images/donnaterslogo.png" alt="Logo" style="width: 100%; max-width: 180px;">
    </div>
    <ul>
      <li>
        <a href="member_donation.jsp">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16" style="margin-right: 10px;">
            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
          </svg>
          <span>Donation</span>
        </a>
      </li>
      <li>
        <a href="LogoutServlet">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 16 16" style="margin-right: 10px;">
            <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
            <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
          </svg>
          <span>Logout</span>
        </a>
      </li>
    </ul>
  </div>

  <div class="container">
    <div class="header">
        <div class="user">
            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
                <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6"/>
            </svg>
            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
            </svg>
        </div>
    </div>

    <div class="content">
      <div class="donation-form">
        <h2>Make a Donation</h2>
        <form id="memberDonationForm" action="DonationServlet" method="POST">
          <div class="form-group">
            <label for="donationDate">Donation Date</label>
            <input type="date" id="donationDate" name="donationDate" required>
          </div>

          <fieldset>
            <legend>Select Items to Donate</legend>

            <!-- Items -->
            <div class="item-row">
              <div class="item-checkbox">
                <input type="checkbox" id="food" name="items" value="Food">
                <label for="food">Food</label>
              </div>
              <input type="number" class="quantity-input" placeholder="Qty" name="qty_Food" min="1">
            </div>

            <div class="item-row">
              <div class="item-checkbox">
                <input type="checkbox" id="water" name="items" value="Water">
                <label for="water">Water</label>
              </div>
              <input type="number" class="quantity-input" placeholder="Qty" name="qty_Water" min="1">
            </div>

            <div class="item-row">
              <div class="item-checkbox">
                <input type="checkbox" id="medical" name="items" value="Medical Kits">
                <label for="medical">Medical Kits</label>
              </div>
              <input type="number" class="quantity-input" placeholder="Qty" name="qty_Medical" min="1">
            </div>

            <div class="item-row">
              <div class="item-checkbox">
                <input type="checkbox" id="clothes" name="items" value="Clothes">
                <label for="clothes">Clothes</label>
              </div>
              <input type="number" class="quantity-input" placeholder="Qty" name="qty_Clothes" min="1">
            </div>

            <div class="item-row">
              <div class="item-checkbox">
                <input type="checkbox" id="shoes" name="items" value="Shoes">
                <label for="shoes">Shoes</label>
              </div>
              <input type="number" class="quantity-input" placeholder="Qty" name="qty_Shoes" min="1">
            </div>

            <div class="item-row">
              <div class="item-checkbox">
                <input type="checkbox" id="bedsheet" name="items" value="Bedsheet">
                <label for="bedsheet">Bedsheet</label>
              </div>
              <input type="number" class="quantity-input" placeholder="Qty" name="qty_Bedsheet" min="1">
            </div>

            <div class="item-row">
              <div class="item-checkbox">
                <input type="checkbox" id="others" name="items" value="Others">
                <label for="others">Other Items</label>
              </div>
              <input type="number" class="quantity-input" placeholder="Qty" name="qty_Others" min="1">
            </div>

            <div class="form-group" style="margin-top: 10px;">
              <input type="text" placeholder="Please specify other items" name="remarks">
            </div>

             <div class="form-group radio-group">
                <p>Do you want to add payment?</p>
                <label><input type="radio" name="addPayment" value="yes"> Yes</label>
                <label><input type="radio" name="addPayment" value="no" checked> No</label>
            </div>
          </fieldset>

          <div class="submit-btn">
            <button type="submit" id="submitBtn" class="btn">Submit</button>
          </div>
        </form>
      </div>
    </div>
  </div>

<script>
 
    const radios = document.querySelectorAll('input[name="addPayment"]');
    const submitBtn = document.getElementById('submitBtn');

    radios.forEach(radio => {
        radio.addEventListener('change', () => {
            if (radio.value === 'yes') {
                submitBtn.textContent = 'Proceed to Payment';
            } else {
                submitBtn.textContent = 'Submit';
            }
        });
    });
</script>
</body>
</html>
