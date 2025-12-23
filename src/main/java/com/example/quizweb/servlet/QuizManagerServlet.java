package com.example.quizweb.servlet;

import java.io.IOException;
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
 * Servlet implementation class QuizManagerServlet
 */
@WebServlet("/admin/quizManager")
public class QuizManagerServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private QuizDAO quizDAO = new QuizDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        String quizIdParam = request.getParameter("quizId");

        if ("view".equals(action) && quizIdParam != null) {
            int quizId = Integer.parseInt(quizIdParam);
            Quiz quiz = quizDAO.getQuizById(quizId);
            List<Question> questions = quizDAO.getQuizQuestions(quizId);
            quiz.setQuestions(questions);
            request.setAttribute("quiz", quiz);
            request.getRequestDispatcher("/jsp/admin/quizDetail.jsp").forward(request, response);
        } 
        else if ("edit".equals(action) && quizIdParam != null) {
            int quizId = Integer.parseInt(quizIdParam);
            Quiz quiz = quizDAO.getQuizById(quizId);
            request.setAttribute("quiz", quiz); // pass quiz to JSP
            List<Quiz> quizzes = quizDAO.getAllQuizzes();
            request.setAttribute("quizzes", quizzes); // also pass all quizzes
            request.getRequestDispatcher("/jsp/admin/quizManager.jsp").forward(request, response);
        }
        else {
            List<Quiz> quizzes = quizDAO.getAllQuizzes();
            request.setAttribute("quizzes", quizzes);
            request.getRequestDispatcher("/jsp/admin/quizManager.jsp").forward(request, response);
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int quizId = Integer.parseInt(request.getParameter("quizId"));
            quizDAO.deleteQuiz(quizId);
        } 
        else if ("update".equals(action)) {
            int quizId = Integer.parseInt(request.getParameter("quizId"));
            String quizTitle = request.getParameter("quizTitle");
            String category = request.getParameter("category");

            Quiz quiz = new Quiz();
            quiz.setQuizId(quizId);
            quiz.setQuizTitle(quizTitle);
            quiz.setCategory(category);

            quizDAO.updateQuiz(quiz);
        }

        // ✅ Redirect to servlet, not JSP
        response.sendRedirect(request.getContextPath() + "/admin/quizManager");
    }
}
