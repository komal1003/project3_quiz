<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Quiz Portal</title>

<style>
/* ---------- RESET ---------- */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* ---------- BODY ---------- */
body {
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    color: #2b2b2b;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* ---------- HEADER ---------- */
header {
    background: #ffffff;
    padding: 18px 64px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #e1e4e1;
}

/* Logo */
header .logo {
    font-size: 26px;
    font-weight: 700;
    color: #1f6f8c;
    letter-spacing: 0.4px;
}

/* Navigation */
header .nav-links {
    display: flex;
    align-items: center;
}

header .nav-links a {
    color: #355f74;
    text-decoration: none;
    margin-left: 26px;
    font-weight: 600;
    transition: color 0.25s ease;
}

header .nav-links a:hover {
    color: #1f6f8c;
}

/* ---------- ADMIN BUTTON ---------- */
.admin-btn {
    padding: 7px 18px;
    background: #1f6f8c;
    color: #ffffff !important;
    border-radius: 22px;
    font-size: 14px;
    transition: background 0.25s ease;
}

.admin-btn:hover {
    background: #185c6c;
}

/* ---------- DROPDOWN ---------- */
.dropdown {
    position: relative;
    margin-left: 26px;
}

/* Dropdown Button */
.dropbtn {
    padding: 7px 18px;
    background: #e6f0fc;
    color: #1f6f8c;
    border: 1px solid #cfe2fa;
    border-radius: 22px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.25s ease;
}

.dropbtn:hover {
    background: #d8ebf4;
}

/* Dropdown Content */
.dropdown-content {
    display: none;
    position: absolute;
    top: 44px;
    right: 0;
    background: #ffffff;
    min-width: 180px;
    border-radius: 12px;
    padding: 6px 0;
    box-shadow: 0 10px 24px rgba(0, 0, 0, 0.08);
    overflow: hidden;
    z-index: 10;
}

.dropdown-content a {
    color: #355f74;
    padding: 12px 20px;
    display: block;
    font-weight: 500;
    transition: background 0.2s ease, padding-left 0.2s ease;
}

.dropdown-content a:hover {
    background: #f1f6fc;
    padding-left: 26px;
}

/* Show dropdown */
.dropdown:hover .dropdown-content {
    display: block;
}

/* ---------- MAIN CONTAINER ---------- */
.container {
    flex: 1;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    padding: 80px 24px;
    flex-wrap: wrap;
}

/* ---------- WELCOME SECTION ---------- */
.welcome-section {
    flex: 1;
    text-align: center;
    max-width: 50%;
}

.welcome-section h1 {
    font-size: 44px;
    margin-bottom: 18px;
    color: #1f3f56;
    font-weight: 700;
}

.welcome-section p {
    font-size: 17px;
    line-height: 1.7;
    color: #555f7b;
}

/* ---------- AD BANNER ---------- */
.ad-banner {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    max-width: 50%;
}

.ad-banner img {
    max-width: 100%;
    height: auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
</style>


</head>

<body>

<header>
    <div class="logo">ONLINE QUIZ</div>

    <div class="nav-links">
    
        <!-- Admin Login (Highlighted Button) -->
        <a href="${pageContext.request.contextPath}/jsp/admin/login.jsp" class="admin-btn">Admin Login</a>

        <!-- Dropdown for Login / Signup -->
        <div class="dropdown">
            <button class="dropbtn">Login / Signup ▾</button>

            <div class="dropdown-content">
                <a href="${pageContext.request.contextPath}/jsp/user/login.jsp">User Login</a>
                <a href="${pageContext.request.contextPath}/jsp/user/register.jsp">User Signup</a>
            </div>
        </div>

    </div>
</header>

<div class="container">
    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1>Welcome</h1>
        <p>Challenge your mind with our interactive quizzes and test your knowledge daily!</p>
    </div>

    <!-- Ad Banner -->
    <div class="ad-banner">
        <img src="https://tse3.mm.bing.net/th/id/OIP.2xElATslkAVO2yMfyx1YjQHaHa?rs=1&pid=ImgDetMain&o=7&rm=3" alt="Quiz">
    </div>
</div>

</body>
</html>
