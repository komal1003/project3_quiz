<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*, java.util.List" %>
<%@ page isELIgnored="false"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    List<Question> questions = (List<Question>) request.getAttribute("questions");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Question Manager - Quiz App</title>
<style>
/* Reset & base */
* { margin:0; padding:0; box-sizing:border-box; font-family: Arial, sans-serif; }
body { display:flex; min-height:100vh; background-color:#f5f5f5; color:#222; }

/* Sidebar */
.sidebar {
    width:260px;
    background-color:#2f7c5e; /* Emerald primary */
    color:white;
    display:flex;
    flex-direction:column;
    padding:25px;
    justify-content:space-between;
}
.sidebar .logo { font-size:24px; font-weight:bold; margin-bottom:30px; }
.sidebar a { 
    display:block; text-decoration:none; color:white; 
    padding:12px 18px; margin-bottom:12px; border-radius:6px; font-size:16px; 
    transition:0.25s;
}
.sidebar a:hover { background-color:#215d45; transform: translateX(3px); }
.sidebar a.active { background-color:#215d45; }
.sidebar .logout-btn { 
    background-color:#28a745; /* Emerald logout button */ 
    text-align:center; font-weight:bold; font-size:16px; padding:12px; 
    transition:0.25s;
}
.sidebar .logout-btn:hover { background-color:#1e7e34; }

/* Main content */
.main-content { flex:1; padding:40px; background-color:#fff; border-radius:12px; overflow-x:auto; }
.header { display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; }
.header h1 { font-size:30px; color:#2f7c5e; } /* Emerald heading */

/* Table styling */
table {
    width:100%;
    border-collapse: separate;
    border-spacing:0 12px;
    font-size:16px;
}
thead th {
    text-align:left;
    padding:12px 20px;
    background:#e6f2ec; /* light emerald/neutral header */
    color:#2f7c5e;
    font-weight:700;
    border-radius:8px 8px 0 0;
}
tbody td {
    padding:14px 20px;
    vertical-align:middle;
    color:#333;
    background:#f1f9f5; /* neutral row background */
    border-radius:6px;
    transition:0.2s;
}
tbody tr:hover td {
    background-color:#d6ede1; /* subtle hover highlight */
}

/* Action buttons */
.action-buttons { display:flex; gap:8px; flex-wrap:wrap; }
.btn { 
    padding:6px 12px; border-radius:6px; font-weight:600; font-size:14px; 
    border:none; cursor:pointer; white-space:nowrap; text-decoration:none; transition:0.25s;
}
.btn-delete { background-color:#e74c3c; color:#fff; }
.btn-delete:hover { background-color:#c0392b; }

/* Responsive */
@media (max-width:768px){
    .sidebar{ width:220px; padding:20px; }
    .action-buttons { flex-direction:column; gap:6px; }
}
</style>

</head>
<body>
    <aside class="sidebar">
        <div>
            <div class="logo">QUIZ APP</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/quizManager">Quiz Manager</a>
            <a href="${pageContext.request.contextPath}/admin/questionList" class="active">Question Manager</a>
            <a href="${pageContext.request.contextPath}/admin/addQuestion">Add Question</a>
            <a href="${pageContext.request.contextPath}/admin/createQuiz">Create Quiz</a>
        </div>
        <a href="${pageContext.request.contextPath}/jsp/user/home.jsp" class="logout-btn">Logout</a>
    </aside>

    <main class="main-content">
        <div class="header">
            <h1>Question Manager</h1>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Sr No.</th>
                    <th>Question</th>
                    <th>Option 1</th>
                    <th>Option 2</th>
                    <th>Option 3</th>
                    <th>Option 4</th>
                    <th>Correct</th>
                    <th>Category</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% if (questions != null && !questions.isEmpty()) {
                    int srNo = 1;
                    for (Question q : questions) { %>
                <tr>
                    <td><%= srNo++ %></td>
                    <td><%= q.getQuestionText() %></td>
                    <td><%= q.getOption1() %></td>
                    <td><%= q.getOption2() %></td>
                    <td><%= q.getOption3() %></td>
                    <td><%= q.getOption4() %></td>
                    <td><%= q.getCorrectOption() %></td>
                    <td><%= q.getCategory() %></td>
                    <td>
                        <div class="action-buttons">
                            <form action="${pageContext.request.contextPath}/admin/questionList" method="post" onsubmit="return confirm('Are you sure?');" style="display:inline;">
                                <input type="hidden" name="questionId" value="<%= q.getQuestionId() %>">
                                <input type="hidden" name="action" value="delete">
                                <button type="submit" class="btn btn-delete">Delete</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% } } else { %>
                    <tr><td colspan="9" style="text-align:center;">No questions found</td></tr>
                <% } %>
            </tbody>
        </table>
    </main>
</body>
</html>
