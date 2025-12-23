package com.example.quizweb.servlet;

import java.io.IOException;

import com.example.quizweb.dao.QuestionDAO;
import com.example.quizweb.model.Question;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class AddQuestionServlet
 */
@WebServlet("/admin/addQuestion")
public class AddQuestionServlet extends HttpServlet {
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
        request.getRequestDispatcher("/jsp/admin/addQuestion.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        String questionText = request.getParameter("questionText");
        String option1 = request.getParameter("option1");
        String option2 = request.getParameter("option2");
        String option3 = request.getParameter("option3");
        String option4 = request.getParameter("option4");
        int correctOption = Integer.parseInt(request.getParameter("correctOption"));
        String category = request.getParameter("category");
        
        Question question = new Question();
        question.setQuestionText(questionText);
        question.setOption1(option1);
        question.setOption2(option2);
        question.setOption3(option3);
        question.setOption4(option4);
        question.setCorrectOption(correctOption);
        question.setCategory(category);
        
        boolean success = questionDAO.addQuestion(question);
        
        if (success) {
            request.setAttribute("success", "Question added successfully!");
        } else {
            request.setAttribute("error", "Failed to add question!");
        }
        
        request.getRequestDispatcher("/jsp/admin/addQuestion.jsp").forward(request, response);
    }
}