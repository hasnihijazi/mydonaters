<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyDonnaters - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/auth.css">
</head>
<body>
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="auth-card shadow">
          <div class="auth-card-header text-center">
            <img src="images/donnaterslogo.png" alt="MyDonnaters Logo" class="mb-2" style="max-height: 100px;">
            <h3 class="mt-2">Create Your Account</h3>
            <p>Join MyDonnaters today</p>
          </div>
          <div class="auth-form">
            <form id="registerForm" action="RegisterServlet" method="POST">
              <div class="row">
                <div class="col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" class="form-control" name="MEMBER_FULLNAME" required>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control" name="MEMBER_USERNAME" required>
                  </div>
                </div>
              </div>
              
              <div class="row">
                <div class="col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" class="form-control" name="MEMBER_PASSWORD" required>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" name="MEMBER_PASSWORD_CONFIRM" required>
                  </div>
                </div>
              </div>
              
              <div class="row">
                <div class="col-md-6">
                  <div class="mb-3">
                    <label class="form-label">IC Number</label>
                    <input type="text" class="form-control" name="MEMBER_IC" required>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Date of Birth</label>
                    <input type="date" class="form-control" name="MEMBER_DOB" required>
                  </div>
                </div>
              </div>
              
              <div class="row">
                <div class="col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Gender</label>
                    <select class="form-control" name="MEMBER_GENDER" required>
                      <option value="">Select Gender</option>
                      <option value="Male">Male</option>
                      <option value="Female">Female</option>
                    </select>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="mb-3">
                    <label class="form-label">Age</label>
                    <input type="number" class="form-control" name="MEMBER_AGE" required>
                  </div>
                </div>
              </div>
              
              <div class="mb-3">
                <label class="form-label">Contact Number</label>
                <input type="tel" class="form-control" name="MEMBER_CONTACT" required>
              </div>
              
              <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="MEMBER_EMAIL" required>
              </div>
              
              <div class="mb-3">
                <label class="form-label">Address</label>
                <textarea class="form-control" name="MEMBER_ADDRESS" rows="3" required></textarea>
              </div>
              
              <button type="submit" class="btn btn-danger">Register</button>
                
              <% 
                String message = (String) request.getAttribute("message");
                if (message != null) {
                    out.println("<div class='success-message'>" + message + "</div>");
                }
                String error = (String) request.getAttribute("error");
                if (error != null) {
                    out.println("<div class='error-message'>" + error + "</div>");
                }
                %>
            </form>
            <div class="mt-3 text-center">
              <p>Already have an account? <a href="index.jsp">Login here</a></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
