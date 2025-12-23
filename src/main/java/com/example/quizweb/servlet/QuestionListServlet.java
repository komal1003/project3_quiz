package com.example.quizweb.servlet;

import java.io.IOException;
import java.util.List;

import com.example.quizweb.dao.QuestionDAO;
import com.example.quizweb.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class QuestionListServlet
 */
@WebServlet("/admin/questionList")
public class QuestionListServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
        request.getRequestDispatcher("/jsp/admin/questionList.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        int questionId = Integer.parseInt(request.getParameter("questionId"));

        if ("delete".equals(action)) {
            questionDAO.deleteQuestion(questionId);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/questionList");
    }

}