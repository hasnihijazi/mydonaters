<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/member_detail_info.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <title>Member Details</title>
</head>
<body>
    <div class="side-menu">
        <div class="brand-name">
            <div style="display: flex; align-items: center;">
                <img src="images/donnaterslogo.png" alt="Brand Logo" style="width: 100px; height: 100px; margin-right: 10px;">
            </div>
        </div>
        <ul>
            <li><a href="dashboard.html" style="color: inherit;"><span>Dashboard</span></a></li>
            <li><a href="member_detail.html" style="color: inherit;"><span>Members</span></a></li>
            <li><a href="admin_donation.html" style="color: inherit;"><span>Donation</span></a></li>
            <li><a href="login.html" style="color: inherit;"><span>Logout</span></a></li>
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
                <div class="member-details">
                    <div class="title">
                        <h2>Member Details</h2>
                    </div>
                    <div class="member-info">
                        <h3>Personal Information</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <label>Member ID</label>
                                <span>${member.id}</span>
                            </div>
                            <div class="info-item">
                                <label>Full Name</label>
                                <span>${member.fullName}</span>
                            </div>
                            <div class="info-item">
                                <label>IC Number</label>
                                <span>${member.ic}</span>
                            </div>
                            <div class="info-item">
                                <label>Date of Birth</label>
                                <span>${member.dob}</span>
                            </div>
                            <div class="info-item">
                                <label>Gender</label>
                                <span>${member.gender}</span>
                            </div>
                            <div class="info-item">
                                <label>Age</label>
                                <span>${member.age}</span>
                            </div>
                            <div class="info-item">
                                <label>Contact Number</label>
                                <span>${member.contact}</span>
                            </div>
                            <div class="info-item">
                                <label>Email</label>
                                <span>${member.email}</span>
                            </div>
                        </div>

                        <div style="margin-top: 20px;">
                            <h3>Address Information</h3>
                            <div class="info-item" style="margin-top: 15px;">
                                <label>Full Address</label>
                                <span>${member.address}</span>
                            </div>
                        </div>

                        <div style="margin-top: 20px;">
                            <h3>Membership Information</h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <label>Register Date</label>
                                    <span>${member.dob}</span>
                                </div>
                            </div>
                        </div>
                        <div style="margin-top: 30px;">
                            <a href="member_detail" class="btn" style="background-color: #555; color: white; padding: 10px 20px; border-radius: 4px; text-decoration: none;">
                                Back to Member List
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
