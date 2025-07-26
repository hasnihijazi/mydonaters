<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyDonnaters - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/auth.css">
</head>
<body>
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <div class="auth-card shadow">
          <div class="auth-card-header text-center">
            <img src="images/donnaterslogo.png" alt="MyDonnaters Logo" class="mb-2" style="max-height: 100px;">
            <h3 class="mt-2">Welcome to MyDonnaters</h3>
            <p>Please login to continue</p>
          </div>
          <div class="auth-form">
            <form id="loginForm" action="LoginServlet" method="POST">
              <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" class="form-control" name="username" required>
              </div>
              <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" class="form-control" name="password" required>
              </div>
              <button type="submit" class="btn btn-danger">Login</button>
              <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                <div class="alert alert-danger" role="alert">
                  <%= error %>
                </div>
              <% } %>
            </form>
            <div class="mt-3 text-center">
              <p>Don't have an account? <a href="register.jsp">Register here</a></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
    <%
    String logout = request.getParameter("logout");
    if ("success".equals(logout)) {
    %>
    <div class="alert alert-success" style="background-color: #d4edda; padding: 10px; color: #155724; border: 1px solid #c3e6cb; margin-bottom: 15px; border-radius: 5px;">
        You have successfully logged out.
    </div>
    <%
        }
    %>
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
