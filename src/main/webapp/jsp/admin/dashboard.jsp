<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*"%>
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
<title>Dashboard - Quiz App</title>
<style>
/* RESET */
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

.sidebar a:hover {
    background-color: #21455d; /* Darker emerald on hover */
    transform: translateX(3px);
}

.sidebar a.active {
    background-color: #214a5d;
}

.sidebar .logout-btn {
    background-color: #35dc51; /* Error red */
    text-align: center;
    font-weight: bold;
    font-size: 16px;
    padding: 12px;
    border-radius: 6px;
    transition: 0.25s;
}

.sidebar .logout-btn:hover {
    background-color: #2ab035;
}

/* MAIN CONTENT */
.main-content {
    flex: 1;
    padding: 40px;
    background-color: #ffffff;
    border-radius: 12px;
    margin-left: 20px; /* space from sidebar */
    display: flex;
    flex-direction: column;
}

/* HEADER */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header h1 {
    font-size: 32px;
    color: #2f6d7c;
    font-weight: bold;
}

/* WELCOME TEXT */
.welcome {
    font-size: 28px;
    color: #2f6d7c;
    font-weight: bold;
    margin-bottom: 25px;
}

/* STATS GRID */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background-color: #e6f2ec; /* light emerald/neutral */
    padding: 25px;
    border-radius: 10px;
    text-align: center;
    transition: 0.25s ease, transform 0.25s ease;
}

.stat-card:hover {
    background-color: #d6e8df;
    transform: translateY(-4px);
}

.stat-card h3 {
    font-size: 16px;
    color: #555;
    margin-bottom: 10px;
}

.stat-card .number {
    font-size: 28px;
    font-weight: bold;
    color: #2f667c;
}

/* TABLE CONTAINER */
.table-container {
    background-color: #f1f7f3; /* very light emerald */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    margin-top: 20px;
}

.table-container h2 {
    font-size: 22px;
    margin-bottom: 10px;
    color: #2f5d7c;
}

.table-container p {
    font-size: 16px;
    color: #555;
    margin-bottom: 15px;
}

/* TABLE STYLING */
table {
    width: 100%;
    border-collapse: collapse;
}

thead {
    background-color: #2f707c;
    color: white;
}

th, td {
    padding: 12px 15px;
    text-align: left;
}

tbody tr:nth-child(even) {
    background-color: #e6f2ec;
}

tbody tr:hover {
    background-color: #d6e8df;
    transform: scale(1.01);
}

/* RESPONSIVE */
@media (max-width: 900px) {
    body {
        flex-direction: column;
    }

    .sidebar {
        width: 100%;
        flex-direction: row;
        overflow-x: auto;
    }

    .main-content {
        margin-left: 0;
        margin-top: 20px;
        border-radius: 8px;
        padding: 20px;
    }

    .stats-grid {
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    }
}
</style>

</head>
<body>
    <aside class="sidebar">
        <div>
            <div class="logo">QUIZ APP</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
                class="active">Dashboard</a> 
            <a href="${pageContext.request.contextPath}/admin/quizManager">Quiz Manager</a> 
            <a href="${pageContext.request.contextPath}/admin/questionList">Question Manager</a> 
            <a href="${pageContext.request.contextPath}/admin/addQuestion">Add Question</a> 
            <a href="${pageContext.request.contextPath}/admin/createQuiz">Create Quiz</a>
        </div>
        <a href="${pageContext.request.contextPath}/jsp/user/home.jsp"
            class="logout-btn">Logout</a>
    </aside>

    <main class="main-content">
        <div class="header">
            <h1>Dashboard</h1>
            <div class="welcome">
                Welcome, <%=admin.getFullName() != null ? admin.getFullName() : admin.getUsername()%>!
            </div>
        </div>

        <section class="stats-grid">
            <div class="stat-card">
                <h3>Total Quiz</h3>
                <div class="number"><%=request.getAttribute("totalQuiz") != null ? request.getAttribute("totalQuiz") : "0"%></div>
            </div>
            <div class="stat-card">
                <h3>Total Questions</h3>
                <div class="number"><%=request.getAttribute("totalQuestions") != null ? request.getAttribute("totalQuestions") : "0"%></div>
            </div>
            <div class="stat-card">
                <h3>Total Users</h3>
                <div class="number"><%=request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0"%></div>
            </div>
        </section>

        <section class="table-container">
            <h2>Tables</h2>
            <p>Navigate to Quiz Manager or Question Manager to view detailed tables.</p>
        </section>
    </main>
</body>
</html>
