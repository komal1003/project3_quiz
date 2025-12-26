<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Register - Quiz Portal</title>
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
    padding: 15px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #e1e4e1;
}

/* Header text and back button (keep as is) */
header .logo {
    font-size: 26px;
    font-weight: bold;
    color: #1f6f5c;
}
header .nav-links a.back-btn {
    padding: 6px 14px;
    background: #1f6f5c;
    color: white;
    border-radius: 20px;
    font-weight: 600;
    text-decoration: none;
    transition: 0.3s ease;
}
header .nav-links a.back-btn:hover {
    background: #185c4c;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(31,111,92,0.3);
}

/* Register Container */
.register-container {
    width: 500px;
    max-width: 90%;
    background: #ffffff;
    border-radius: 16px;
    padding: 50px 40px;
    box-shadow: 0 12px 28px rgba(0,0,0,0.08);
    text-align: center;
    margin: 150px auto;
    animation: fadeIn 0.7s ease;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.register-container:hover {
    transform: translateY(-3px);
    box-shadow: 0 18px 36px rgba(0,0,0,0.12);
}

/* Heading */
.register-container h2 {
    color: #1f3f36;
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 10px;
    text-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.register-container p {
    margin-bottom: 25px;
    font-size: 16px;
    color: #555f5b;
}

/* Form Inputs */
.form-group {
    text-align: left;
    margin-bottom: 20px;
}
label {
    display: block;
    font-weight: 600;
    margin-bottom: 5px;
    color: #2b2b2b;
}
input[type="text"],
input[type="email"],
input[type="password"] {
    width: 100%;
    padding: 14px;
    border: 1.5px solid #cfe2da;
    border-radius: 12px;
    font-size: 16px;
    transition: all 0.3s ease;
}
input:focus {
    border-color: #1f6f5c;
    outline: none;
    box-shadow: 0 0 0 4px rgba(31,111,92,0.15);
    transform: scale(1.02);
}

/* Button */
button {
    width: 100%;
    padding: 14px;
    font-size: 18px;
    font-weight: 700;
    background-color: #1f6f8c;
    color: #fff;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 6px 14px rgba(31,111,92,0.2);
}
button:hover {
    background-color: #185c6c;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 8px 18px rgba(31,111,92,0.25);
}

/* Success/Error messages */
.error, .success {
    padding: 12px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
    font-weight: 600;
    color: white;
    animation: fadeIn 0.5s ease;
}
.error {
    background: #d64545;
    border-left: 5px solid #a83232;
}
.success {
    background: #2f8f83;
    border-left: 5px solid #1f6f5c;
}

/* Login link */
.login-link {
    margin-top: 20px;
    font-size: 15px;
}
.login-link a {
    color: #1f6f5c;
    font-weight: 600;
    text-decoration: underline;
    transition: color 0.25s ease;
}
.login-link a:hover {
    color: #185c4c;
}

/* Animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Responsive */
@media (max-width: 600px) {
    .register-container {
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
    <div class="logo">ONLINE QUIZ PORTAL</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/jsp/user/home.jsp" class="back-btn">← Back to Home</a>
    </div>
</header>

<div class="register-container">
    <h2>Create Account</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
        <div class="success"><%= request.getAttribute("success") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/user/register" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required />
        </div>

        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required />
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required />
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required />
        </div>

        <button type="submit">Register</button>
    </form>

    <div class="login-link">
        <h3>
            <a href="${pageContext.request.contextPath}/jsp/user/login.jsp">Login here!</a>
        </h3>
    </div>
</div>

</body>
</html>
