<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*, java.util.List, java.util.Map" %>
<%@ page isELIgnored="false" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login");
        return;
    }

    int score = (Integer) request.getAttribute("score");
    int totalQuestions = (Integer) request.getAttribute("totalQuestions");
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    List<Question> questions = (List<Question>) request.getAttribute("questions");
    Map<Integer, Integer> userAnswers = (Map<Integer, Integer>) request.getAttribute("userAnswers");
    double percentage = (score * 100.0) / totalQuestions;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Result</title>

   <style>
/* ---------- RESET ---------- */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Inter', Arial, sans-serif;
}

/* ---------- BODY ---------- */
body {
    background: #f7f8f7;  /* light neutral */
    color: #2b2b2b;
    padding: 40px 20px;
}

/* ---------- CONTAINER ---------- */
.container {
    max-width: 800px;
    background: #ffffff;
    margin: 0 auto;
    padding: 35px 30px;
    border-radius: 16px;
    border: 1px solid #d8ebe4;
    box-shadow: 0 12px 28px rgba(31,111,92,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.container:hover {
    transform: translateY(-2px);
    box-shadow: 0 18px 36px rgba(31,111,92,0.15);
}

/* ---------- MAIN RESULT ---------- */
.result-main {
    text-align: center;
    margin-bottom: 40px;
}

.result-main h1 {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 12px;
    color: #1f3f36;
}

.score {
    font-size: 48px;
    font-weight: 800;
    color: #1f6f5c; /* emerald green */
    margin-bottom: 8px;
}

.percent {
    font-size: 20px;
    color: #555f5b;
    margin-bottom: 20px;
}

/* ---------- BUTTONS ---------- */
.btn {
    display: inline-block;
    padding: 12px 28px;
    margin: 8px;
    background: #1f6f5c;
    color: white;
    text-decoration: none;
    border-radius: 25px;
    font-weight: 700;
    transition: all 0.3s ease;
}

.btn:hover {
    background: #185c4c;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 6px 14px rgba(31,111,92,0.2);
}

/* ---------- REVIEW BOX ---------- */
.review-box {
    margin-top: 30px;
}

.review-box h2 {
    font-size: 24px;
    margin-bottom: 20px;
    font-weight: 700;
    text-align: center;
    color: #1f3f36;
}

/* ---------- QUESTION ITEMS ---------- */
.question-item {
    background: #f0f4f2;
    border-left: 6px solid #d8ebe4;
    padding: 15px 20px;
    margin-bottom: 16px;
    border-radius: 10px;
    transition: all 0.3s ease;
}

.question-item.correct {
    border-left-color: #1f6f5c;
    background: #e6f0ec;
}

.question-item.incorrect {
    border-left-color: #dc3545;
    background: #fdecea;
}

.question-item:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(31,111,92,0.1);
}

/* ---------- QUESTION TEXT ---------- */
.q-title {
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 6px;
}

.q-info {
    font-size: 15px;
    margin-bottom: 5px;
    color: #555f5b;
}

.correct-text {
    color: #1f6f5c;
    font-weight: 700;
}

.wrong-text {
    color: #dc3545;
    font-weight: 700;
}

/* ---------- RESPONSIVE ---------- */
@media (max-width: 720px) {
    .container {
        padding: 25px 20px;
    }

    .result-main h1 {
        font-size: 28px;
    }

    .score {
        font-size: 40px;
    }

    .btn {
        padding: 10px 22px;
        font-size: 16px;
    }

    .review-box h2 {
        font-size: 20px;
    }
}
</style>
</head>

<body>

<div class="container">

    <div class="result-main">
        <h1>Quiz Completed</h1>

        <div class="score"><%= score %> / <%= totalQuestions %></div>
        <div class="percent"><%= String.format("%.1f", percentage) %>%</div>

        <a href="${pageContext.request.contextPath}/user/leaderboard?quizId=<%= quiz.getQuizId() %>" class="btn">View Leaderboard</a>
        <a href="${pageContext.request.contextPath}/user/quizList" class="btn">Back to Quiz List</a>
    </div>

    <div class="review-box">
        <h2>Your Answers</h2>

        <%
            int i = 1;
            for (Question q : questions) {
                Integer userAns = userAnswers.get(q.getQuestionId());
                boolean correct = userAns != null && userAns == q.getCorrectOption();
                String[] opts = { q.getOption1(), q.getOption2(), q.getOption3(), q.getOption4() };
        %>

        <div class="question-item <%= correct ? "correct" : "incorrect" %>">
            <div class="q-title">Question <%= i++ %>: <%= q.getQuestionText() %></div>

            <div class="q-info">
                <strong>Your Answer:</strong>
                <span class="<%= correct ? "correct-text" : "wrong-text" %>">
                    <%= userAns != null ? opts[userAns - 1] : "Not answered" %>
                </span>
            </div>

            <% if (!correct) { %>
                <div class="q-info">
                    <strong>Correct Answer:</strong>
                    <span class="correct-text"><%= opts[q.getCorrectOption() - 1] %></span>
                </div>
            <% } %>
        </div>

        <% } %>

    </div>

</div>

</body>
</html>
