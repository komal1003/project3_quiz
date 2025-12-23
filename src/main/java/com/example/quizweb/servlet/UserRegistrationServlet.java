package com.example.quizweb.servlet;

import java.io.IOException;

import com.example.quizweb.dao.UserDAO;
import com.example.quizweb.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserRegistrationServlet
 */
@WebServlet("/user/register")
public class UserRegistrationServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/user/register.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already registered!");
            request.getRequestDispatcher("/jsp/user/register.jsp").forward(request, response);
            return;
        }
        
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setFullName(fullName);
        
        boolean success = userDAO.registerUser(user);
        
        if (success) {
            request.setAttribute("success", "Account created successfully!");
            request.getRequestDispatcher("/jsp/user/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed!");
            request.getRequestDispatcher("/jsp/user/register.jsp").forward(request, response);
        }
    }
}