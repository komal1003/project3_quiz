<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*, java.util.List, java.util.Collections, java.util.Comparator" %>
<%@ page isELIgnored="false"%>
<%
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    List<Leaderboard> leaderboard = (List<Leaderboard>) request.getAttribute("leaderboard");

    // Sort by score descending
    if (leaderboard != null) {
        Collections.sort(leaderboard, new Comparator<Leaderboard>() {
            public int compare(Leaderboard a, Leaderboard b) {
                return b.getScore() - a.getScore(); // highest score first
            }
        });
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Leaderboard</title>

   <style>
* { margin: 0; padding: 0; box-sizing: border-box; }

/* ---------- BODY ---------- */
body {
    font-family: 'Inter', Arial, sans-serif;
    background: #f7f8f7; /* light neutral background */
    color: #2b2b2b;
    padding: 40px 20px;
    display: flex;
    justify-content: center;
}

/* ---------- CONTAINER ---------- */
.container {
    width: 100%;
    max-width: 900px;
    background: #ffffff;
    padding: 40px 35px;
    border-radius: 16px;
    box-shadow: 0 12px 28px rgba(31,111,92,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.container:hover {
    transform: translateY(-2px);
    box-shadow: 0 18px 36px rgba(31,111,92,0.15);
}

/* ---------- HEADER ---------- */
.header {
    text-align: center;
    margin-bottom: 30px;
}

.quiz-name {
    font-size: 28px;
    font-weight: 700;
    color: #1f3f36;
    margin-bottom: 5px;
}

.category {
    font-size: 18px;
    color: #1f6f5c;
    font-weight: 600;
}

/* ---------- LEADERBOARD TABLE ---------- */
.leaderboard-table {
    margin-top: 25px;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead {
    background-color: #1f6f5c; /* emerald */
    color: white;
}

th {
    padding: 16px;
    text-align: left;
    font-weight: 700;
}

td {
    padding: 14px 16px;
    border-bottom: 1px solid #d8ebe4;
    font-size: 15px;
}

tbody tr:nth-child(even) {
    background: #e6f0ec; /* light emerald shade */
}

tbody tr:hover {
    background: #d8ebe4;
    transform: translateX(2px);
    transition: all 0.25s ease;
}

/* ---------- BACK BUTTON ---------- */
.btn-back {
    display: inline-block;
    margin-top: 30px;
    padding: 12px 28px;
    background: #1f6f5c; /* emerald */
    color: white;
    text-decoration: none;
    font-weight: 700;
    border-radius: 25px;
    transition: all 0.3s ease;
}

.btn-back:hover {
    background: #185c4c;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 6px 14px rgba(31,111,92,0.2);
}

/* ---------- RESPONSIVE ---------- */
@media (max-width: 720px) {
    .container {
        padding: 30px 20px;
    }
    .quiz-name {
        font-size: 24px;
    }
    .category {
        font-size: 16px;
    }
    th, td {
        padding: 12px;
    }
    .btn-back {
        padding: 10px 22px;
        font-size: 16px;
    }
}
</style>

</head>

<body>
<div class="container">

    <div class="header">
        <% if (quiz != null) { %>
            <div class="quiz-name">
                LEADERBOARD – <%= quiz.getQuizTitle().toUpperCase() %>
            </div>
        <% } %>

        <div class="category">
            CATEGORY: <%= quiz != null ? quiz.getCategory() : "ALL QUIZZES" %>
        </div>
    </div>

    <div class="leaderboard-table">
        <table>
            <thead>
                <tr>
                    <th>RANK</th>
                    <th>NAME</th>
                    <th>EMAIL</th>
                    <th>SCORE</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (leaderboard != null && !leaderboard.isEmpty()) {
                        int rank = 1;
                        for (Leaderboard entry : leaderboard) {
                %>
                    <tr>
                        <td><%= rank++ %></td>
                        <td><%= entry.getUsername() %></td>
                        <td><%= entry.getEmail() %></td>
                        <td><%= entry.getScore() %></td>
                    </tr>
                <% 
                        }
                    } else { 
                %>
                    <tr>
                        <td colspan="4" style="text-align:center; padding:20px; color:#555;">
                            No attempts yet
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <a href="${pageContext.request.contextPath}/user/quizList" class="btn-back">Back to Quiz List</a>

</div>
</body>
</html>
