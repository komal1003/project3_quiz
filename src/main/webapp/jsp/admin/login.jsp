<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<title>Admin Login</title>

<style>
/* RESET */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: "Arial", sans-serif;
}

/* BACKGROUND */
body, html {
    height: 100%;
    background: linear-gradient(135deg, #ffffff, #f5f5f5);
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* HEADER */
header {
    width: 100%;
    background: #ffffff;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 15px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 3px solid #2f7c5e;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 10;
}

header .logo {
    font-size: 26px;
    font-weight: bold;
    color: #2f7c5e;
}

header .nav-links a.back-btn {
    padding: 6px 14px;
    background: #2f7c5e;
    color: white;
    border-radius: 20px;
    font-weight: 600;
    text-decoration: none;
    transition: 0.3s ease, transform 0.3s ease;
    margin-left: 10px;
}

header .nav-links a.back-btn:hover {
    background: #215d45;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}

/* LOGIN BOX */
.login-box {
    width: 420px;
    background: #ffffff;
    padding: 40px 35px;
    border-radius: 16px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    text-align: center;
    animation: fadeIn 0.6s ease;
    margin-top: 300px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.login-box:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 28px rgba(0,0,0,0.18);
}

/* Heading */
.login-box h2 {
    font-size: 30px;
    color: #2f7c5e;
    font-weight: bold;
    margin-bottom: 8px;
}

.login-box p {
    color: #555;
    margin-bottom: 25px;
    font-size: 15px;
}

/* INPUTS */
input[type="text"],
input[type="password"] {
    width: 100%;
    padding: 14px;
    border: 1.5px solid #cde6d5;
    border-radius: 10px;
    margin-bottom: 18px;
    font-size: 16px;
    transition: 0.3s ease, box-shadow 0.3s ease;
}

input:focus {
    outline: none;
    border-color: #2f7c5e;
    box-shadow: 0 0 12px rgba(47,124,94,0.35);
}

/* BUTTON */
button {
    width: 100%;
    padding: 14px;
    background: #2f7c5e;
    border: none;
    border-radius: 30px;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}

button:hover {
    background: #215d45;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 6px 14px rgba(0,0,0,0.2);
}

/* ERROR BOX */
.error {
    background: #fddede;
    color: #dc3545;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 18px;
    border-left: 5px solid #dc3545;
    text-align: left;
    font-size: 14px;
    opacity: 0;
    animation: fadeIn 0.5s forwards;
}

/* Animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Responsive */
@media (max-width: 600px) {
    .login-box {
        width: 90%;
        padding: 30px 20px;
    }

    button {
        font-size: 16px;
    }
}
</style>




</head>

<body>

<header>
    <div class="logo">ONLINE QUIZ</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/jsp/user/login.jsp" class="back-btn">User Login</a>
        <a href="${pageContext.request.contextPath}/jsp/user/home.jsp" class="back-btn">Back to Home</a>
    </div>
</header>

<div class="login-box">
    <h2>Admin Login</h2>
    <p>Access the admin dashboard and manage the portal</p>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/admin/login" method="post" autocomplete="off">
        <input type="text" name="username" placeholder="Email" required autofocus />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
    </form>
</div>

</body>
</html>
