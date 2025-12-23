package com.example.quizweb.servlet;

import java.io.IOException;
import java.util.List;

import com.example.quizweb.dao.QuestionDAO;
import com.example.quizweb.dao.QuizDAO;
import com.example.quizweb.model.Admin;
import com.example.quizweb.model.Question;
import com.example.quizweb.model.Quiz;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class CreateQuizServlet
 */
@WebServlet("/admin/createQuiz")
public class CreateQuizServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private QuizDAO quizDAO = new QuizDAO();
    private QuestionDAO questionDAO = new QuestionDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        List<Question> questions = questionDAO.getAllQuestions();
        request.setAttribute("questions", questions);
        request.getRequestDispatcher("/jsp/admin/createQuiz.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        String quizTitle = request.getParameter("quizTitle");
        String category = request.getParameter("category");
        String[] selectedQuestions = request.getParameterValues("questions");
        
        Quiz quiz = new Quiz();
        quiz.setQuizTitle(quizTitle);
        quiz.setCategory(category);
        quiz.setCreatedBy(admin.getAdminId());
        
        int quizId = quizDAO.createQuiz(quiz);
        
        if (quizId > 0 && selectedQuestions != null) {
            for (String questionId : selectedQuestions) {
                quizDAO.addQuestionToQuiz(quizId, Integer.parseInt(questionId));
            }
            request.setAttribute("success", "Quiz created successfully!");
        } else {
            request.setAttribute("error", "Failed to create quiz!");
        }
        
        List<Question> questions = questionDAO.getAllQuestions();
        request.setAttribute("questions", questions);
        request.getRequestDispatcher("/jsp/admin/createQuiz.jsp").forward(request, response);
    }
}