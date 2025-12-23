package com.example.quizweb.servlet;

import java.io.IOException;
import java.util.List;

import com.example.quizweb.dao.LeaderboardDAO;
import com.example.quizweb.dao.QuizDAO;
import com.example.quizweb.model.Leaderboard;
import com.example.quizweb.model.Quiz;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LeaderboardServlet
 */
@WebServlet("/user/leaderboard")
public class LeaderboardServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private LeaderboardDAO leaderboardDAO = new LeaderboardDAO();
    private QuizDAO quizDAO = new QuizDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String quizIdParam = request.getParameter("quizId");
        
        if (quizIdParam != null && !quizIdParam.isEmpty()) {
            int quizId = Integer.parseInt(quizIdParam);
            Quiz quiz = quizDAO.getQuizById(quizId);
            List<Leaderboard> leaderboard = leaderboardDAO.getLeaderboardByQuiz(quizId);
            
            request.setAttribute("quiz", quiz);
            request.setAttribute("leaderboard", leaderboard);
        } else {
            List<Leaderboard> leaderboard = leaderboardDAO.getAllLeaderboard();
            request.setAttribute("leaderboard", leaderboard);
        }
        
        request.getRequestDispatcher("/jsp/user/leaderboard.jsp").forward(request, response);
    }
}