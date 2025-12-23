<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*, java.util.List" %>
<%@ page isELIgnored="false"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    List<Question> questions = quiz.getQuestions();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quiz Detail - Quiz App</title>
   <style>
/* Reset & base */
* { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
body { display: flex; min-height: 100vh; background: #f5f5f5; color: #222; }

/* Sidebar */
.sidebar {
    width: 260px;
    background-color: #2f7c5e; /* Emerald primary */
    color: white;
    display: flex;
    flex-direction: column;
    padding: 25px;
    justify-content: flex-start;
}
.logo {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 30px;
}
.menu-item {
    display: block;
    text-decoration: none;
    color: white;
    padding: 12px 18px;
    margin-bottom: 12px;
    border-radius: 6px;
    font-size: 16px;
    transition: 0.25s;
}
.menu-item:hover { 
    background-color: #215d45; /* darker emerald hover */
    transform: translateX(3px);
}
.menu-item.active { background-color: #215d45; }

/* Main content */
.main-content {
    flex: 1;
    padding: 40px;
    background-color: #ffffff;
    border-radius: 12px;
    overflow-x: auto;
}

/* Header */
.quiz-header h2 {
    font-size: 30px;
    font-weight: bold;
    color: #2f7c5e; /* Emerald heading */
    margin-bottom: 20px;
}

/* Info */
.quiz-info p {
    font-size: 18px;
    color: #555;
    margin-bottom: 15px;
}

/* Table */
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 12px;
    font-size: 16px;
}

thead th {
    background-color: #e6f2ec; /* light emerald/neutral */
    padding: 12px 18px;
    text-align: left;
    font-weight: bold;
    color: #2f7c5e; /* emerald header text */
    border-radius: 8px 8px 0 0;
}

tbody td {
    padding: 14px 18px;
    vertical-align: middle;
    color: #555;
    background-color: #f1f9f5; /* light neutral row background */
    border-radius: 6px;
    transition: 0.2s;
}

tbody td:first-child { 
    font-weight: bold; 
    color: #2f7c5e; 
    width: 50px; 
}

tbody tr:hover td {
    background-color: #d6ede1; /* subtle highlight on hover */
}

/* Responsive */
@media (max-width: 768px) {
    body { flex-direction: column; }
    .sidebar { width: 100%; flex-direction: row; overflow-x: auto; }
    .logo { margin-bottom: 0; margin-right: 20px; font-size: 20px; }
    .menu-item { margin-right: 10px; margin-bottom: 0; padding: 10px 14px; font-size: 14px; }
    .main-content { padding: 20px; }
    table { font-size: 14px; }
    thead th, tbody td { padding: 10px 12px; }
}
</style>

</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo">QUIZ APP</div>
       <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager" class="menu-item active">Quiz Manager</a>
            <a href="${pageContext.request.contextPath}/admin/questionList" class="menu-item">Question Manager</a>
            <a href="${pageContext.request.contextPath}/admin/addQuestion" class="menu-item">Add Question</a>
            <a href="${pageContext.request.contextPath}/admin/createQuiz" class="menu-item">Create Quiz</a>
    </aside>

    <!-- Main content -->
    <main class="main-content">
        <div class="quiz-header">
            <h2>Quiz Detail</h2>
        </div>

        <div class="quiz-info">
            <p><strong>Quiz Title:</strong> <%= quiz.getQuizTitle() %></p>
            <p><strong>Category:</strong> <%= quiz.getCategory() %></p>
        </div>

        <h3>Question List</h3>
        <table>
            <thead>
                <tr>
                    <th>Sr No.</th>
                    <th>Question</th>
                    <th>Option 1</th>
                    <th>Option 2</th>
                    <th>Option 3</th>
                    <th>Option 4</th>
                    <th>Answer</th>
                </tr>
            </thead>
            <tbody>
                <% if (questions != null && !questions.isEmpty()) {
                    int srNo = 1;
                    for (Question q : questions) {
                        String[] options = {q.getOption1(), q.getOption2(), q.getOption3(), q.getOption4()};
                        String answer = options[q.getCorrectOption() - 1];
                %>
                <tr>
                    <td><%= srNo++ %></td>
                    <td><%= q.getQuestionText() %></td>
                    <td><%= q.getOption1() %></td>
                    <td><%= q.getOption2() %></td>
                    <td><%= q.getOption3() %></td>
                    <td><%= q.getOption4() %></td>
                    <td><%= answer %></td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="7" style="text-align:center; padding: 30px 0; color: #555;">No questions found</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </main>
</body>
</html>
