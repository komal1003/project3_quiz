<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*" %>
<%@ page isELIgnored="false"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Add Question - Quiz App</title>
   <style>
/* Basic reset */
* {
    margin: 0; 
    padding: 0; 
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    display: flex;
    min-height: 100vh;
    background-color: #f5f5f5; /* neutral background */
    color: #222;
}

/* Sidebar */
.sidebar {
    width: 260px;
    background-color: #2f7c5e; /* Emerald primary */
    color: white;
    display: flex;
    flex-direction: column;
    padding: 25px;
    justify-content: space-between;
}
.sidebar .logo {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 30px;
}
.sidebar a {
    display: block;
    text-decoration: none;
    color: white;
    padding: 12px 18px;
    margin-bottom: 12px;
    border-radius: 6px;
    font-size: 16px;
    transition: 0.25s;
}
.sidebar a:hover { background-color: #215d45; }
.sidebar a.active { background-color: #215d45; }
.sidebar .logout-btn {
    background-color: #28a745; /* Emerald logout */
    text-align: center;
    font-weight: bold;
    font-size: 16px;
    padding: 12px;
    transition: 0.25s;
}
.sidebar .logout-btn:hover { background-color: #1e7e34; }

/* Main content */
.main-content {
    flex: 1;
    padding: 40px;
    background-color: #ffffff;
    overflow-y: auto;
    border-radius: 12px;
}

h2 {
    font-size: 28px;
    font-weight: bold;
    color: #2f7c5e; /* Emerald header */
    margin-bottom: 30px;
}

/* Alerts */
.success, .error {
    padding:14px 18px;
    border-radius:8px;
    margin-bottom:24px;
    font-weight:bold;
}
.success { background:#d4edda; color:#155724; }
.error { background:#f8d7da; color:#721c24; }

/* Form container */
.form-container {
    background:#f1f9f5; /* light neutral background */
    padding:25px 30px;
    border-radius:12px;
    max-width:1200px;
    margin:0 auto;
}

.form-group { margin-bottom:15px; }
label { display:block; font-weight:bold; margin-bottom:8px; font-size:16px; }
input[type=text], textarea, select {
    width:100%;
    padding:12px 15px;
    border:1px solid #ccc;
    border-radius:8px;
    font-size:16px;
    transition: 0.25s;
}
input:focus, textarea:focus, select:focus { border-color:#2f7c5e; outline:none; }
textarea { resize:vertical; min-height:80px; font-family:inherit; }

/* Buttons */
.btn {
    width:100%;
    padding:14px;
    font-size:18px;
    font-weight:bold;
    background:#2f7c5e; /* Emerald button */
    color:#fff;
    border:none;
    border-radius:8px;
    cursor:pointer;
    transition: 0.25s;
}
.btn:hover { background:#215d45; }

/* Responsive */
@media(max-width:768px){
    .sidebar { width:220px; padding:20px; }
    .form-container { padding:20px; height:auto; overflow:auto; }
}
</style>

</head>
<body>
    <aside class="sidebar">
        <div>
            <div class="logo">QUIZ APP</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager">Quiz Manager</a>
            <a href="${pageContext.request.contextPath}/admin/questionList">Question Manager</a>
            <a href="${pageContext.request.contextPath}/admin/addQuestion" class="active">Add Question</a>
            <a href="${pageContext.request.contextPath}/admin/createQuiz">Create Quiz</a>
        </div>
        <a href="${pageContext.request.contextPath}/jsp/user/home.jsp" class="logout-btn">Logout</a>
    </aside>

    <main class="main-content">
        <h2>Add New Question</h2>

        <% if(request.getAttribute("success")!=null){ %>
            <div class="success"><%= request.getAttribute("success") %></div>
        <% } %>
        <% if(request.getAttribute("error")!=null){ %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/addQuestion" method="post">
                <div class="form-group">
                    <label for="questionText">Question</label>
                    <textarea id="questionText" name="questionText" required></textarea>
                </div>
                <div class="form-group">
                    <label for="option1">Option 1</label>
                    <input type="text" id="option1" name="option1" required>
                </div>
                <div class="form-group">
                    <label for="option2">Option 2</label>
                    <input type="text" id="option2" name="option2" required>
                </div>
                <div class="form-group">
                    <label for="option3">Option 3</label>
                    <input type="text" id="option3" name="option3" required>
                </div>
                <div class="form-group">
                    <label for="option4">Option 4</label>
                    <input type="text" id="option4" name="option4" required>
                </div>
                <div class="form-group">
                    <label for="correctOption">Correct Option</label>
                    <select id="correctOption" name="correctOption" required>
                        <option value="">Select Correct Option</option>
                        <option value="1">Option 1</option>
                        <option value="2">Option 2</option>
                        <option value="3">Option 3</option>
                        <option value="4">Option 4</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="category">Category</label>
                    <input type="text" id="category" name="category" placeholder="e.g., SCIENCE" required>
                </div>
                <button type="submit" class="btn">Add Question</button>
            </form>
        </div>
    </main>
</body>
</html>
