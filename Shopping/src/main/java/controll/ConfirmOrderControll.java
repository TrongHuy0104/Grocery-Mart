/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controll;

import dataAccess.DAO;
import dataAccess.OrderDAO;
import entity.Order;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Trong Huy
 */
public class ConfirmOrderControll extends HttpServlet {

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
            String id = request.getParameter("id");
            if (id != null) {
                DAO dao = new DAO();
                OrderDAO orderDao = new OrderDAO();
                List<Order> orderItemList = orderDao.getAllOrderDetail(id);
                if (orderItemList != null) {
                    for (Order orderItem : orderItemList) {
                        Product currentProduct = dao.getProductByID(orderItem.getpId());
                        if (currentProduct.getpNumberLeft() < orderItem.getQunatity()) {
                            out.println("<h3 style='color:crimson; font-size: 30px; font-weight: 500; text-align: center'>"
                                    + "Quantity of " + orderItem.getpName() + " in order is :" + orderItem.getQunatity()
                                    + "<br><br>Quantity of " + currentProduct.getpName() + " in storage is :" + currentProduct.getpNumberLeft()
                                    + "<br><br><a href='admin-order.jsp'>Return admin page</a></h3>");
                        } else {
                            Product tempProduct = new Product();
                            tempProduct.setpId(orderItem.getpId());
                            tempProduct.setpNumberLeft(currentProduct.getpNumberLeft() - orderItem.getQunatity());
                            dao.updateNumberLeft(tempProduct);
                            orderDao.confirmOrder(id);
                            response.sendRedirect("admin-order.jsp");
                        }
                    }
                }
            } else {
                response.sendRedirect("admin-order.jsp");
            }

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
        processRequest(request, response);
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
