/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controll;

import dataAccess.UserDAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static util.Encode.encodeToSHA256;

/**
 *
 * @author Trong Huy
 */
public class AddAdminControll extends HttpServlet {

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
            out.println("<title>Servlet AddAdminControll</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAdminControll at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
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
            int isAdmin = 1;

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
            if (userDAO.checkEmailIsDuplicated(email)) {
                error += "Email already exists, please choose another email!";
            }

            request.setAttribute("error", error);

            if (error.length() > 0) {
                url = "/customer-add.jsp";
            } else {
                Random rd = new Random();
                String id = System.currentTimeMillis() + rd.nextInt(1000) + "";
                pass = encodeToSHA256(pass);

                User u = new User(id, userName, pass, address, email, name, gender, phone, deliveryAddress, isAdmin);
                userDAO.insertAdmin(u);
                request.setAttribute("note", "Account created successfully, please log in again!");
                url = "/customer-add.jsp";
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
            rd.forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserControll.class.getName()).log(Level.SEVERE, null, ex);
        }
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
