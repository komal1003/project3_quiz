package com.example.quizweb.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.example.quizweb.dao.QuizDAO;
import com.example.quizweb.model.Question;
import com.example.quizweb.model.Quiz;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class QuizListServlet
 */

@WebServlet("/user/quizList")
public class QuizListServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private QuizDAO quizDAO = new QuizDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        
        List<Quiz> allQuizzes = quizDAO.getAllQuizzes();
        List<Quiz> authorizedQuizzes = new ArrayList<>();

        for (Quiz quiz : allQuizzes) {
           
            List<Question> questions = quizDAO.getQuizQuestions(quiz.getQuizId());
            quiz.setQuestions(questions);
            if (questions != null && !questions.isEmpty()) {
                authorizedQuizzes.add(quiz);
            }
        }

        request.setAttribute("quizzes", authorizedQuizzes);
        System.out.println("Filtered quizzes sent");

        request.getRequestDispatcher("/jsp/user/quizList.jsp").forward(request, response);
    }
}