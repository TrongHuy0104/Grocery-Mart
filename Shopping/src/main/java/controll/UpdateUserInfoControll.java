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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Trong Huy
 */
public class UpdateUserInfoControll extends HttpServlet {

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
            out.println("<title>Servlet UpdateUserInfoControll</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUserInfoControll at " + request.getContextPath() + "</h1>");
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
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String deliveryAddress = request.getParameter("delivery-address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String avatar = request.getParameter("avatar");

        request.setAttribute("name", name);
        request.setAttribute("gender", gender);
        request.setAttribute("address", address);
        request.setAttribute("deliveryAddress", deliveryAddress);
        request.setAttribute("phone", phone);
        request.setAttribute("email", email);
        request.setAttribute("avatar", avatar);

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
                    User uUser1 = new User(id, "", "", address, email, name, gender, phone, deliveryAddress, avatar);
                    userDAO.updateUserInfo(uUser1);
                    User uUser2 = userDAO.selectById(user);

                    note = "Information has been updated!";
                    request.getSession().setAttribute("user", uUser2);
                    url = "/update-information.jsp";
                }
            }
        }

        request.getRequestDispatcher(url).forward(request, response);
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
