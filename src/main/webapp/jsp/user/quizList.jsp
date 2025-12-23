<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*, java.util.List" %>
<%@ page isELIgnored="false"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login");
        return;
    }
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz List - Quiz Portal</title>

<style>
* { margin: 0; padding: 0; box-sizing: border-box; }

/* ---------- BODY ---------- */
body {
    font-family: 'Inter', Arial, sans-serif;
    background: #f7f8f7;  /* Light neutral background */
    color: #2b2b2b;
    padding-bottom: 40px;
}

/* ---------- NAVBAR ---------- */
.navbar {
    background: #1f6f5c;  /* Emerald */
    padding: 15px 40px;
    display: flex;
    justify-content: flex-end;
}

.navbar a {
    color: #e6f0ec;  /* Light text on emerald */
    text-decoration: none;
    font-size: 15px;
    font-weight: 600;
    margin-left: 20px;
    transition: all 0.25s ease;
}

.navbar a:hover {
    color: #ffffff;
    transform: translateY(-2px);
}

/* ---------- PAGE CONTAINER ---------- */
.container {
    max-width: 1100px;
    margin: 40px auto;
    padding: 0 20px;
}

h1 {
    font-size: 32px;
    font-weight: 800;
    margin-bottom: 30px;
    color: #1f3f36;
}

/* ---------- QUIZ GRID ---------- */
.quiz-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 25px;
}

/* ---------- QUIZ CARD ---------- */
.quiz-card {
    background: #ffffff;
    padding: 25px;
    border-radius: 16px;
    border: 1px solid #d8ebe4;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    cursor: pointer;
}

.quiz-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(31,111,92,0.15); /* subtle emerald shadow */
    border-color: #1f6f5c;
}

/* Category Badge */
.quiz-category {
    background: #e6f0ec;  /* Light emerald */
    color: #1f6f5c;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 700;
    width: fit-content;
    margin-bottom: 15px;
    transition: background 0.3s ease;
}

.quiz-card:hover .quiz-category {
    background: #d8ebe4;
}

/* Card Title */
.quiz-card h3 {
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 20px;
    color: #1f3f36;
}

/* Start Button */
.btn-start {
    background: #1f6f5c;  /* Emerald */
    color: white;
    padding: 12px 28px;
    border-radius: 25px;
    text-decoration: none;
    font-weight: 700;
    margin-top: auto;
    text-align: center;
    transition: all 0.25s ease;
}

.btn-start:hover {
    background: #185c4c;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 6px 14px rgba(31,111,92,0.25);
}

/* No quizzes message */
.no-quizzes {
    text-align: center;
    margin-top: 60px;
    font-size: 18px;
    color: #555f5b;
}

/* Responsive */
@media (max-width: 720px) {
    h1 {
        font-size: 28px;
    }
    .btn-start {
        padding: 10px 22px;
        font-size: 16px;
    }
}
</style>


</head>

<body>

    <!-- NAVBAR -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/jsp/user/home.jsp">Logout</a>
    </nav>

    <!-- CONTENT -->
    <div class="container">
        <h1>Available Quizzes</h1>

        <% if (quizzes != null && !quizzes.isEmpty()) { %>

            <div class="quiz-grid">
                <% for (Quiz quiz : quizzes) { %>
                    <div class="quiz-card">
                        <span class="quiz-category"><%= quiz.getCategory() %></span>

                        <h3><%= quiz.getQuizTitle() %></h3>

                        <a href="${pageContext.request.contextPath}/user/attemptQuiz?quizId=<%= quiz.getQuizId() %>"
                           class="btn-start">Start Quiz</a>
                    </div>
                <% } %>
            </div>

        <% } else { %>

            <p class="no-quizzes">No quizzes available at the moment.</p>

        <% } %>

    </div>

</body>
</html>
