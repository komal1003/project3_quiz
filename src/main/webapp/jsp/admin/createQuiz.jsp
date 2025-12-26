<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*,java.util.List"%>
<%@ page isELIgnored="false"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    // Load ALL questions from backend
    List<Question> questions = (List<Question>) request.getAttribute("questions");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Create Quiz - Quiz App</title>

<style>
/* BASIC RESET */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    display: flex;
    min-height: 100vh;
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    color: #222;
}

/* SIDEBAR */
.sidebar {
    width: 260px;
    background-color: #1f6f8c; /* Updated to match home page */
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

.sidebar a:hover { background-color: #214a5d; }
.sidebar a.active { background-color: #214a5d; }

.sidebar .logout-btn {
    background-color: #28a745; /* Emerald logout */
    text-align: center;
    font-weight: bold;
    font-size: 16px;
    padding: 12px;
    transition: 0.25s;
}

.sidebar .logout-btn:hover { background-color: #1e7e34; }

/* MAIN CONTENT */
.main-content {
    flex: 1;
    padding: 40px;
    background-color: #ffffff;
    border-radius: 12px;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header h1,
.welcome {
    font-size: 30px;
    color: #2f537c; /* Emerald headers */
    font-weight: bold;
}

/* FORM CONTAINER */
.form-container {
    background-color: #f1f9f5; /* light neutral background */
    padding: 25px;
    border-radius: 12px;
}

.form-group {
    margin-bottom: 20px;
}

label {
    font-weight: bold;
    margin-bottom: 8px;
    display: block;
}

input[type=text], select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 16px;
    transition: 0.25s;
}

input:focus, select:focus { border-color: #2f647c; outline: none; }

/* QUESTION LIST */
.question-list {
    background: white;
    border: 1px solid #ccc;
    padding: 15px;
    max-height: 350px;
    overflow-y: auto;
    border-radius: 8px;
}

.question-item {
    display: none; /* hidden until category matches */
    align-items: center;
    gap: 10px;
    padding: 10px;
    border: 1px solid #ddd;
    margin-bottom: 8px;
    border-radius: 6px;
}

/* BUTTONS */
.btn {
    width: 100%;
    padding: 16px;
    background-color: #1f6f8c;
    border: none;
    border-radius: 8px;
    color: white;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.25s;
}

.btn:hover { background-color: #185c6c; }

/* ALERTS */
.success, .error {
    padding: 14px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-weight: bold;
}

.success {
    background-color: #d4edda;
    color: #155724;
}

.error {
    background-color: #f8d7da;
    color: #721c24;
}
</style>


<script>
// ⭐ FRONT-END CATEGORY FILTER ⭐
function filterQuestions() {
    let category = document.getElementById("categoryInput").value.trim().toLowerCase();
    let items = document.getElementsByClassName("question-item");

    for (let item of items) {
        let cat = item.getAttribute("data-category").toLowerCase();

        if (category !== "" && cat === category) {
            item.style.display = "flex";
        } else {
            item.style.display = "none";
        }
    }
}
</script>

</head>

<body>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div>
        <div class="logo">QUIZ APP</div>

        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/quizManager">Quiz Manager</a>
        <a href="${pageContext.request.contextPath}/admin/questionList">Question Manager</a>
        <a href="${pageContext.request.contextPath}/admin/addQuestion">Add Question</a>
        <a href="${pageContext.request.contextPath}/admin/createQuiz" class="active">Create Quiz</a>
    </div>

    <a href="${pageContext.request.contextPath}/jsp/user/home.jsp" class="logout-btn">Logout</a>
</aside>


<!-- MAIN CONTENT -->
<main class="main-content">

    <div class="header">
        <h1>Create Quiz</h1>
        <div class="welcome">
            Welcome, <%= admin.getFullName() != null ? admin.getFullName() : admin.getUsername() %>!
        </div>
    </div>

    <% if(request.getAttribute("success")!=null){ %>
        <div class="success"><%=request.getAttribute("success")%></div>
    <% } %>

    <% if(request.getAttribute("error")!=null){ %>
        <div class="error"><%=request.getAttribute("error")%></div>
    <% } %>

    <div class="form-container">

        <form action="${pageContext.request.contextPath}/admin/createQuiz" method="post">

            <div class="form-group">
                <label>Quiz Title</label>
                <input type="text" name="quizTitle" required>
            </div>

            <div class="form-group">
                <label>Category (Type to filter questions)</label>
                <input type="text" id="categoryInput" name="category" onkeyup="filterQuestions()" required>
            </div>

            <div class="form-group">
                <label>Select Questions</label>

                <div class="question-list">
                    <% if (questions == null || questions.isEmpty()) { %>
                        <div>No questions available.</div>
                    <% } else {
                        for (Question q : questions) { %>

                            <div class="question-item" data-category="<%= q.getCategory() %>">
                                <input type="checkbox" name="questions" value="<%=q.getQuestionId()%>">
                                <label><%= q.getQuestionText() %></label>
                            </div>

                    <% } } %>
                </div>
            </div>

            <button class="btn" type="submit">Create Quiz</button>

        </form>

    </div>

</main>

</body>
</html>
