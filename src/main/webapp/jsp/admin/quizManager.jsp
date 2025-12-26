<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*, java.util.List" %>
<%@ page isELIgnored="false"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
    Quiz editQuiz = (Quiz) request.getAttribute("quiz"); // if editing
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quiz Manager - Quiz App</title>
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
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    color: #222;
}

/* Sidebar */
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

.sidebar a:hover {
    background-color: #21515d; /* Darker emerald on hover */
    transform: translateX(3px);
}

.sidebar a.active {
    background-color: #21455d;
}

.sidebar .logout-btn {
    background-color: #35dc4b; /* Error red */
    text-align: center;
    font-weight: bold;
    font-size: 16px;
    padding: 12px;
    border-radius: 6px;
    transition: 0.25s;
}

.sidebar .logout-btn:hover {
    background-color: #2ab03c;
}

/* Main content */
.main-content {
    flex: 1;
    padding: 40px;
    background-color: #ffffff;
    border-radius: 12px;
    overflow-x: auto;
}

/* Header */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header h1 {
    font-size: 30px;
    color: #1f6f8c;
}

/* Edit form */
.edit-form {
    background: #e6f0fc; /* light blue/neutral */
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 30px;
}

.edit-form input[type=text] {
    width: 300px;
    padding: 10px;
    margin-right: 20px;
    border-radius: 6px;
    border: 1px solid #cfe2fa; /* subtle blue border */
    font-size: 16px;
}

.edit-form button {
    padding: 10px 20px;
    border-radius: 8px;
    border: none;
    background-color: #1f6f8c;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    transition: 0.25s;
}

.edit-form button:hover {
    background-color: #185c6c;
}

/* Table styling */
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 12px; /* vertical spacing between rows */
    font-size: 16px;
}

thead th {
    text-align: left;
    padding: 12px 20px;
    background: #2f6d7c;
    color: white;
    font-weight: 700;
    border-radius: 8px 8px 0 0;
}

tbody td {
    padding: 14px 20px;
    vertical-align: middle;
    color: #333;
    background: #e6f2ec; /* light emerald row background */
    border-radius: 6px;
}

/* Action buttons container */
.action-buttons {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

/* Buttons */
.btn {
    padding: 6px 12px;
    border-radius: 6px;
    font-weight: 600;
    font-size: 14px;
    border: none;
    cursor: pointer;
    text-decoration: none;
    white-space: nowrap;
    transition: 0.25s;
}

.btn-edit {
    background-color: #1f6f8c;
    color: #fff;
}
.btn-edit:hover {
    background-color: #185c6c;
}

.btn-view {
    background-color: #4fc3f7;
    color: #fff;
}
.btn-view:hover {
    background-color: #29b6f6;
}

.btn-delete {
    background-color: #dc3545;
    color: #fff;
}
.btn-delete:hover {
    background-color: #b02a37;
}

/* Responsive */
@media (max-width: 768px) {
    .sidebar {
        width: 220px;
        padding: 20px;
    }
    .edit-form input[type=text] {
        width: 100%;
        margin-bottom: 10px;
    }
    .action-buttons {
        flex-direction: column;
        gap: 6px;
    }
}
</style>

</head>
<body>
    <aside class="sidebar">
        <div>
            <div class="logo">QUIZ APP</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager" class="menu-item active">Quiz Manager</a>
            <a href="${pageContext.request.contextPath}/admin/questionList" class="menu-item">Question Manager</a>
            <a href="${pageContext.request.contextPath}/admin/addQuestion" class="menu-item">Add Question</a>
            <a href="${pageContext.request.contextPath}/admin/createQuiz" class="menu-item">Create Quiz</a>
        </div>
        <a href="${pageContext.request.contextPath}/jsp/user/home.jsp" class="logout-btn">Logout</a>
    </aside>

    <main class="main-content">
        <div class="header">
            <h1>Quiz Manager</h1>
        </div>

        <% if(editQuiz != null){ %>
        <div class="edit-form">
            <form action="${pageContext.request.contextPath}/admin/quizManager" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="quizId" value="<%= editQuiz.getQuizId() %>">
                <label>Quiz Title:</label>
                <input type="text" name="quizTitle" value="<%= editQuiz.getQuizTitle() %>" required>
                <label>Category:</label>
                <input type="text" name="category" value="<%= editQuiz.getCategory() %>" required>
                <button type="submit">Update Quiz</button>
            </form>
        </div>
        <% } %>

        <table>
            <thead>
                <tr>
                    <th>Sr No.</th>
                    <th>Quiz Title</th>
                    <th>Category</th>
                    <th>Created At</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% if(quizzes != null && !quizzes.isEmpty()){
                    int srNo = 1;
                    for(Quiz quiz: quizzes){ %>
                        <tr>
                            <td><%= srNo++ %></td>
                            <td><%= quiz.getQuizTitle() %></td>
                            <td><%= quiz.getCategory() %></td>
                            <td><%= quiz.getCreatedAt() %></td>
                            <td>
                                <div class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/admin/quizManager?action=view&quizId=<%= quiz.getQuizId() %>" class="btn btn-view">View</a>
                                    <a href="${pageContext.request.contextPath}/admin/quizManager?action=edit&quizId=<%= quiz.getQuizId() %>" class="btn btn-edit">Edit</a>
                                    <form action="${pageContext.request.contextPath}/admin/quizManager" method="post" onsubmit="return confirm('Delete this quiz?');" style="display:inline;">
                                        <input type="hidden" name="quizId" value="<%= quiz.getQuizId() %>">
                                        <input type="hidden" name="action" value="delete">
                                        <button type="submit" class="btn btn-delete">Delete</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                <% } } else { %>
                    <tr><td colspan="5" style="text-align:center;">No quizzes found</td></tr>
                <% } %>
            </tbody>
        </table>
    </main>
</body>
</html>
