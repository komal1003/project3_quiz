<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.quizweb.model.*" %>
<%@ page isELIgnored="false"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login");
        return;
    }
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    Question question = (Question) request.getAttribute("question");
    int questionNumber = (Integer) request.getAttribute("questionNumber");
    int totalQuestions = (Integer) request.getAttribute("totalQuestions");
    Integer savedAnswer = (Integer) request.getAttribute("savedAnswer");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Attempt Quiz - <%= quiz.getQuizTitle() %></title>

   <style>
* { margin: 0; padding: 0; box-sizing: border-box; }

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
    max-width: 650px;
    width: 100%;
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

/* ---------- QUIZ TITLE ---------- */
.quiz-title {
    font-size: 28px;
    font-weight: 700;
    color: #1f3f36;
    margin-bottom: 8px;
}

.question-progress {
    color: #555f5b;
    font-size: 15px;
    margin-bottom: 25px;
}

.question-text {
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 25px;
    color: #2b2b2b;
}

/* ---------- OPTIONS ---------- */
.option {
    background: #f0f4f2;
    padding: 16px 18px;
    border-radius: 12px;
    margin-bottom: 16px;
    border: 2px solid transparent;
    cursor: pointer;
    font-size: 17px;
    transition: all 0.25s ease;
    display: flex;
    align-items: center;
}

.option:hover {
    border-color: #1f6f5c; /* emerald accent */
    background: #e6f0ec;
}

.option.selected {
    background: #1f6f5c;
    color: white;
    border-color: #185c4c;
}

/* Smooth radio input spacing */
.option input {
    margin-right: 12px;
}

/* ---------- NAVIGATION BUTTONS ---------- */
.navigation {
    margin-top: 30px;
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 10px;
}

.btn {
    padding: 12px 28px;
    border: none;
    font-size: 16px;
    font-weight: 700;
    border-radius: 25px;
    cursor: pointer;
    color: white;
    transition: all 0.3s ease;
    flex: 1;
    text-align: center;
}

/* Next button */
.btn-next {
    background: #1f6f5c;
}
.btn-next:hover {
    background: #185c4c;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 6px 14px rgba(31,111,92,0.2);
}

/* Previous button */
.btn-prev {
    background: #888;
}
.btn-prev:hover {
    background: #666;
    transform: translateY(-2px);
}

/* Submit button */
.btn-submit {
    background: #28a745;
}
.btn-submit:hover {
    background: #1e7e34;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 6px 12px rgba(40,160,70,0.2);
}

/* ---------- RESPONSIVE ---------- */
@media (max-width: 600px) {
    .container {
        padding: 30px 20px;
    }

    .navigation {
        flex-direction: column;
    }

    .btn {
        flex: 100%;
    }
}
</style>


    <script>
        function selectOption(optionNum) {
            document.querySelectorAll('.option').forEach(opt => opt.classList.remove('selected'));
            const opt = document.getElementById('opt' + optionNum);
            opt.classList.add('selected');

            document.getElementById('radio' + optionNum).checked = true;
        }

        window.onload = function() {
            <% if (savedAnswer != null) { %>
                selectOption(<%= savedAnswer %>);
            <% } %>
        }
    </script>
</head>

<body>
<div class="container">

    <div class="quiz-title"><%= quiz.getQuizTitle() %></div>
    <div class="question-progress">
        Question <%= questionNumber %> of <%= totalQuestions %>
    </div>

    <div class="question-text"><%= question.getQuestionText() %></div>

    <form action="${pageContext.request.contextPath}/user/attemptQuiz" method="post">

        <div class="option" id="opt1" onclick="selectOption(1)">
            <input type="radio" id="radio1" name="selectedOption" value="1"
                   <%= (savedAnswer != null && savedAnswer == 1) ? "checked" : "" %> />
            <label><%= question.getOption1() %></label>
        </div>

        <div class="option" id="opt2" onclick="selectOption(2)">
            <input type="radio" id="radio2" name="selectedOption" value="2"
                   <%= (savedAnswer != null && savedAnswer == 2) ? "checked" : "" %> />
            <label><%= question.getOption2() %></label>
        </div>

        <div class="option" id="opt3" onclick="selectOption(3)">
            <input type="radio" id="radio3" name="selectedOption" value="3"
                   <%= (savedAnswer != null && savedAnswer == 3) ? "checked" : "" %> />
            <label><%= question.getOption3() %></label>
        </div>

        <div class="option" id="opt4" onclick="selectOption(4)">
            <input type="radio" id="radio4" name="selectedOption" value="4"
                   <%= (savedAnswer != null && savedAnswer == 4) ? "checked" : "" %> />
            <label><%= question.getOption4() %></label>
        </div>

        <div class="navigation">
            <% if (questionNumber > 1) { %>
                <button class="btn btn-prev" type="submit" name="action" value="previous">Previous</button>
            <% } else { %>
                <div></div>
            <% } %>

            <% if (questionNumber < totalQuestions) { %>
                <button class="btn btn-next" type="submit" name="action" value="next">Next</button>
            <% } else { %>
                <button class="btn btn-submit" type="submit" name="action" value="submit">Submit</button>
            <% } %>
        </div>

    </form>
</div>
</body>
</html>