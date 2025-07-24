<%@ page import="java.util.List" %>
<%@ page import="com.mydonaters.beans.Donation" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (session == null || isAdmin == null || !isAdmin) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Donation> donations = (List<Donation>) request.getAttribute("donations");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/admin_donation.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <title>My Donnaters</title>
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
                <div class="user">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
                        <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6"/>
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                        <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
                    </svg>
                    <div class="img-case"></div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="content-2">
                <div class="recent-payments">
                    <div class="title">
                        <h2>Donation Details</h2>
                        <button id="addDonationBtn" class="btn">Add Donation +</button>
                    </div>
                    <div style="padding: 0 25px 10px 25px; display: flex; justify-content: flex-end;">
                        <input type="text" id="searchInput" placeholder="Search donation..." style="padding: 8px; width: 250px; border: 1px solid #ccc; border-radius: 4px;">
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Donor Name</th>
                                <th>Donation Date</th>
                                <th>Item Donated</th>
                                <th>Quantity</th>
                                <th>Amount (RM)</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                           <%
                                int count = 1;
                                if (donations != null) {
                                    for (Donation d : donations) {
                            %>
                                <tr>
                                    <td><%= count++ %></td>
                                    <td><%= d.getDonorName() %></td>
                                    <td><%= d.getDonationDate() %></td>
                                    <td><%= d.getItems() %></td>
                                    <td><%= (d.getItems() != null) ? d.getItems().replaceAll("[^0-9]+", " ").trim().split(" ").length : "-" %></td>
                                    <td class="amount"><%= String.format("%.2f", d.getPaymentAmount()) %></td>
                                    <td>
                                       <a href="admin_edit_donation.jsp?donationId=<%= d.getDonationId() %>" class="btn btn-primary btn-sm">Edit</a>
                                        <form action="DeleteDonationServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this donation?');">
                                            <input type="hidden" name="donationId" value="<%= d.getDonationId() %>">
                                            <button type="submit" class="btn" style="background: #999;">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
     <div class="modal" id="donationModal" tabindex="-1" aria-labelledby="donationModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
         <form id="donationForm" action="AdminDonationServlet" method="post">
            <div class="modal-header">
              <h5 class="modal-title" id="donationModalLabel">Add Donation</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
              <!-- Donor Name -->
              <div class="mb-3">
                <label for="donorName" class="form-label">Donor Name</label>
                <input type="text" class="form-control" id="donorName" name="donorName" required>
              </div>

              <!-- Donation Date -->
              <div class="mb-3">
                <label for="donationDate" class="form-label">Donation Date</label>
                <input type="date" class="form-control" id="donationDate" name="donationDate" required>
              </div>

              <!-- Items -->
              <fieldset class="mb-3">
                <legend>Items to Donate</legend>
                <div class="row g-3">
                  <div class="col-md-6">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="itemFood" name="items" value="Food">
                      <label class="form-check-label" for="itemFood">Food</label>
                    </div>
                    <input type="number" class="form-control" name="qty_Food" placeholder="Quantity" min="1">
                  </div>

                  <div class="col-md-6">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="itemWater" name="items" value="Water">
                      <label class="form-check-label" for="itemWater">Water</label>
                    </div>
                    <input type="number" class="form-control" name="qty_Water" placeholder="Quantity" min="1">
                  </div>

                  <div class="col-md-6">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="itemMedical" name="items" value="Medical Kits">
                      <label class="form-check-label" for="itemMedical">Medical Kits</label>
                    </div>
                    <input type="number" class="form-control" name="qty_Medical" placeholder="Quantity" min="1">
                  </div>

                  <div class="col-md-6">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="itemClothes" name="items" value="Clothes">
                      <label class="form-check-label" for="itemClothes">Clothes</label>
                    </div>
                    <input type="number" class="form-control" name="qty_Clothes" placeholder="Quantity" min="1">
                  </div>

                  <div class="col-md-6">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="itemShoes" name="items" value="Shoes">
                      <label class="form-check-label" for="itemShoes">Shoes</label>
                    </div>
                    <input type="number" class="form-control" name="qty_Shoes" placeholder="Quantity" min="1">
                  </div>

                  <div class="col-md-6">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="itemBedSheets" name="items" value="bed Sheets">
                      <label class="form-check-label" for="itemBedSheets">Bed Sheets</label>
                    </div>
                    <input type="number" class="form-control" name="qty_bedSheets" placeholder="Quantity" min="1">
                  </div>

                  <!-- Other Item -->
                  <div class="col-md-12">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="itemOther" name="items" value="other">
                      <label class="form-check-label" for="itemOther">Other</label>
                    </div>
                    <div class="d-flex gap-2 mt-1">
                      <input type="text" class="form-control" name="others_remarks" placeholder="Remarks (e.g. Toys, Blankets)">
                      <input type="number" class="form-control" name="qty_Others" placeholder="Quantity" min="1">
                    </div>
                  </div>
                </div>
              </fieldset>

              <!-- Payment -->
              <div class="mb-3">
                <label for="amount" class="form-label">Amount (RM) <span class="text-muted">(Optional)</span></label>
                <input type="number" step="0.01" class="form-control" id="amount" name="amount" placeholder="e.g. 100.00">
              </div>
            </div>

            <div class="modal-footer">
              <button type="submit" class="btn btn-primary">Submit</button>
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script>
        // Modal functionality
       const modal = document.getElementById("donationModal");
       const btn = document.getElementById("addDonationBtn");
       const cancelBtn = modal.querySelector(".btn.btn-secondary");
       const closeBtn = modal.querySelector(".btn-close");


       btn.onclick = function() {
            modal.style.display = "block";
       }

        // Close modal when X is clicked
       cancelBtn.onclick = function() {
            modal.style.display = "none";
        };
        
        closeBtn.onclick = function() {
            modal.style.display = "none";
        };
    
        // Close modal when clicking outside of it
        window.onclick = function(event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        }
    
        // Change submit button text based on payment selection
        paymentRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                if (this.value === 'yes') {
                    submitBtn.textContent = 'Proceed to Payment';
                } else {
                    submitBtn.textContent = 'Submit';
                }
            });
        });
    </script>
</body>
</html>
