<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<title>User Login - Quiz Portal</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Inter', Arial, sans-serif;
}

/* Background */
body, html {
    height: 100%;
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
}

/* Header */
header {
    background: #ffffff;
    box-shadow: 0 2px 10px rgba(0,0,0,0.06);
    padding: 16px 48px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #e1e4e1;
}

header .logo {
    font-size: 26px;
    font-weight: 700;
    color: #1f6f5c;
}

/* Back Button */
header .nav-links a.back-btn {
    padding: 7px 18px;
    background: #1f6f8c;
    color: #ffffff;
    border-radius: 22px;
    font-weight: 600;
    text-decoration: none;
    transition: background 0.25s ease;
}

header .nav-links a.back-btn:hover {
    background: #185c6c;
}

/* Login Container */
.login-container {
    width: 600px;
    max-width: 90%;
    background: #ffffff;
    border-radius: 16px;
    padding: 52px 42px;
    box-shadow: 0 14px 32px rgba(0,0,0,0.08);
    text-align: center;
    margin: 160px auto;
    animation: fadeIn 0.6s ease;
}

/* Heading */
.login-container h2 {
    color: #1f3f36;
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 8px;
}

.login-container p {
    margin-bottom: 26px;
    font-size: 16px;
    color: #555f5b;
}

/* Form Inputs */
.form-group {
    text-align: left;
    margin-bottom: 22px;
}

label {
    display: block;
    font-weight: 600;
    margin-bottom: 6px;
    color: #2b2b2b;
}

input[type="email"],
input[type="password"] {
    width: 100%;
    padding: 14px;
    border: 1.5px solid #cfe2da;
    border-radius: 12px;
    font-size: 16px;
    transition: all 0.25s ease;
}

input:focus {
    border-color: #1f6f5c;
    outline: none;
    box-shadow: 0 0 0 3px rgba(31, 111, 92, 0.15);
}

/* Button */
button {
    width: 100%;
    padding: 14px;
    font-size: 18px;
    font-weight: 700;
    background: #1f6f8c;
    color: #ffffff;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    transition: background 0.25s ease;
}

button:hover {
    background: #185c6c;
}

/* Success/Error */
.error, .success {
    padding: 12px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
    font-weight: 600;
    color: #ffffff;
}

.error {
    background: #d64545;
    border-left: 5px solid #a83232;
}

.success {
    background: #2f8f83;
    border-left: 5px solid #1f6f5c;
}

/* Links */
.links {
    margin-top: 22px;
    font-size: 15px;
}

.links a {
    color: #1f6f5c;
    font-weight: 600;
    text-decoration: underline;
}

/* Animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Responsive */
@media (max-width: 720px) {
    .login-container {
        padding: 34px 22px;
        margin: 120px auto;
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
        <a href="${pageContext.request.contextPath}/jsp/user/home.jsp" class="back-btn">← Back to Home</a>
    </div>
</header>

<div class="login-container">
    <h2>User Login</h2>
    <p>Login to get started!</p>

    <% if (request.getAttribute("success") != null) { %>
        <div class="success"><%= request.getAttribute("success") %></div>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/user/login" method="post">
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" placeholder="username@gmail.com" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="••••••••" required>
        </div>

        <button type="submit">Sign In</button>
    </form>

    <div class="links">
        <a href="${pageContext.request.contextPath}/jsp/user/register.jsp">Not registered?</a>
    </div>
</div>

</body>
</html>
