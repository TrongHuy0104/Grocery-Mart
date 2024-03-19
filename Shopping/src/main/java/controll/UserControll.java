/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controll;

import static context.DBContext.CreateConnection;
import dataAccess.UserDAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.Encode;
import static util.Encode.encodeToSHA256;

/**
 *
 * @author Trong Huy
 */
public class UserControll extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserControll</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserControll at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action.equals("sign-in")) {
            signIn(request, response);
        } else if (action.equals("sign-up")) {
            signUp(request, response);
        } else if (action.equals("log-out")) {
            logOut(request, response);
        } else if (action.equals("change-password")) {
            changePassword(request, response);
        } else if (action.equals("validate-email")) {
            validateEmail(request, response);
        } else if (action.equals("resetpassword")) {
            resetPassword(request, response);
        } else if (action.equals("update-information")) {
            updateInfo(request, response);
        }
    }

    public Boolean isAdmin(HttpServletRequest request, HttpServletResponse response) {
        Boolean result = false;
        Object obj = request.getSession().getAttribute("user");
        User user = null;
        if (obj != null) {
            user = (User) obj;
            if (user != null) {
                int isAdmin = user.getIsAdmin();
                if (isAdmin == 0) {
                    result = false;
                } else {
                    result = true;
                }
            }
        }
        return result;
    }

    private void signIn(HttpServletRequest request, HttpServletResponse response) {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            request.setAttribute("username", username);

            password = encodeToSHA256(password);
            User u = new User();
            u.setUserName(username);
            u.setPassword(password);

            UserDAO userDAO = new UserDAO();
            User user = userDAO.checkSignIn(u);
            String url = "";

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                if (isAdmin(request, response)) {

                    session.setAttribute("admin", user);
                    url = "customer.jsp";
                } else {
                    url = "Home";
                }
            } else {
                request.setAttribute("error", "Username or password is incorrect!");
                url = "/sign-in.jsp";
            }

            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void signUp(HttpServletRequest request, HttpServletResponse response) {
        try {
            String userName = request.getParameter("username");
            String pass = request.getParameter("password");
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String deliveryAddress = request.getParameter("delivery-address");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String policy = request.getParameter("policy");

            request.setAttribute("username", userName);
            request.setAttribute("password", pass);
            request.setAttribute("name", name);
            request.setAttribute("gender", gender);
            request.setAttribute("address", address);
            request.setAttribute("deliveryAddress", deliveryAddress);
            request.setAttribute("phone", phone);
            request.setAttribute("email", email);
            request.setAttribute("policy", policy);

            String url = "";
            String error = "";

            UserDAO userDAO = new UserDAO();

            if (userDAO.checkUserIsDuplicated(userName)) {
                error += "Username already exists, please choose another username!";
            }

            request.setAttribute("error", error);

            if (error.length() > 0) {
                url = "/sign-up.jsp";
            } else {
                Random rd = new Random();
                String id = System.currentTimeMillis() + rd.nextInt(1000) + "";
                pass = encodeToSHA256(pass);

                User u = new User(id, userName, pass, address, email, name, gender, phone, deliveryAddress);
                userDAO.insert(u);
                request.setAttribute("note", "Account created successfully, please log in again!");
                url = "/sign-in.jsp";
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            rd.forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void logOut(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
//            session.invalidate();
            session.removeAttribute("user");
            response.sendRedirect("Home");
        } catch (IOException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) {
        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");

        currentPassword = Encode.encodeToSHA256(currentPassword);
        newPassword = Encode.encodeToSHA256(newPassword);

        String note = "";
        String error = "";
        String url = "";

        HttpSession session = request.getSession();
        Object obj = session.getAttribute("user");
        User user = null;
        if (obj != null) {
            user = (User) obj;
        }
//        If user is not logged in
        if (user == null) {
            error = "You are not logged into the system!";
        } else {
            try {
                //            If user logged in
                if (!currentPassword.equals(user.getPassword())) {
                    error = "Current password is not correct";
                    url = "/change-password.jsp";
                } else {
//        Check current password is the same in the database or not
                    if (newPassword.equals(user.getPassword())) {
                        error = "New password is same with current password";
                        url = "/change-password.jsp";

                    } else {
                        user.setPassword(newPassword);
                        UserDAO userDAO = new UserDAO();
                        if (userDAO.changePassword(user)) {
                            note = "Change password successfully!";
                            url = "/sign-in.jsp";
                        } else {
                            error = "Change password unsuccessfully!";
                            url = "/change-password.jsp";
                        }
                    }
                }
                request.setAttribute("note", note);
                request.setAttribute("error", error);
                request.getRequestDispatcher(url).forward(request, response);
            } catch (ServletException ex) {
                Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void validateEmail(HttpServletRequest request, HttpServletResponse response) {
        try {
            String userName = request.getParameter("username");
            String email = request.getParameter("email");
            String note = "";
            String url = "";

            UserDAO userDAO = new UserDAO();
            User user = new User();
            user.setUserName(userName);
            user.setEmail(email);

            if (!userDAO.checkUsernameEmailIsDuplicated(userName, email)) {
                note = "Username or email is incorrect!";
                url = "/reset-password.jsp";
            } else {
//            userDAO.resetPassword(user);
                HttpSession session = request.getSession();
                session.setAttribute("reset-key", userName);
                note = "Reset your password!";
                url = "/reset-password-emailed.jsp";
            }
            request.setAttribute("note", note);
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response) {
        try {
            String password = request.getParameter("password");
            password = Encode.encodeToSHA256(password);
            String username = (String) request.getSession().getAttribute("reset-key");
            User user = new User();
            user.setPassword(password);
            user.setUserName(username);

            UserDAO userDAO = new UserDAO();
            userDAO.resetPassword(user);
            request.setAttribute("note", "Reset password successfully. Please sign in again!");
            request.getRequestDispatcher("/sign-in.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void updateInfo(HttpServletRequest request, HttpServletResponse response) {
        try {
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String deliveryAddress = request.getParameter("delivery-address");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
//            String avatar = request.getParameter("avatar");

            request.setAttribute("name", name);
            request.setAttribute("gender", gender);
            request.setAttribute("address", address);
            request.setAttribute("deliveryAddress", deliveryAddress);
            request.setAttribute("phone", phone);
            request.setAttribute("email", email);
//            request.setAttribute("avatar", avatar);

            String url = "";
            String note = "";
            UserDAO userDAO = new UserDAO();

            if (note.length() > 0) {
                url = "/sign-in.jsp";
            } else {
                Object obj = request.getSession().getAttribute("user");
                User user = null;
                if (obj != null) {
                    user = (User) obj;
                    if (user != null) {
                        String id = user.getId();
                        User uUser1 = new User(id, "", "", address, email, name, gender, phone, deliveryAddress);
                        userDAO.updateUserInfo(uUser1);
                        User uUser2 = userDAO.selectById(user);

                        note = "Information has been updated!";
                        request.getSession().setAttribute("user", uUser2);
                        url = "/update-information.jsp";
                    }
                }
            }

            request.setAttribute("note", note);
            request.getRequestDispatcher(url).forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
