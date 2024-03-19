/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controll;

import dataAccess.DAO;
import entity.Cart;
import entity.Product;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Trong Huy
 */
public class AddToCartControll extends HttpServlet {

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
            HttpSession session = request.getSession();
            Object obj = session.getAttribute("user");
            User user = null;
            if (obj != null) {
                user = (User) obj;
            }
//        If user is not logged in
            if (user == null) {
                out.println("<h3 style='color:crimson; font-size: 30px; font-weight: 500; text-align: center'>You are not logged into the system! <a href='sign-in.jsp'>Sign In</a></h3>");
            } else {
                DAO dao = new DAO();
                ArrayList<Cart> cartList = new ArrayList<>();
                long id = Long.parseLong(request.getParameter("id"));
                Cart cm = new Cart();
                String date = new SimpleDateFormat("dd-MM-yyyy").format(Calendar.getInstance().getTime());
                cm.setpId(id);
                cm.setQuantity(1);
                cm.setDate(date);
                ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
                if (cart_list == null) {
                    cartList.add(cm);
                    session.setAttribute("cart-list", cartList);
                    List<Cart> c = dao.getCartProducts(cartList);
                    session.setAttribute("cart", c);
                    response.sendRedirect("product-detail.jsp");
                } else {
                    cartList = cart_list;

                    boolean exist = false;
                    for (Cart cart : cart_list) {
                        if (cart.getpId() == id) {
                            exist = true;
                            Product temp = dao.getProductByID(id);
                            if (cart.getQuantity() < temp.getpNumberLeft()) {
                                cart.setQuantity(cart.getQuantity() + 1);
                                List<Cart> c = dao.getCartProducts(cartList);
                                session.setAttribute("cart", c);
                                response.sendRedirect("product-detail.jsp");
                            } else {
                                out.println("<h3 style='color:crimson; font-size: 30px; font-weight: 500; text-align: center'>Exceeds available stock.<a href='product-detail.jsp?id='" + cart.getpId() + ">Return to the purchase pag</a></h3>");

                            }
                        }
                    }

                    if (!exist) {
                        cartList.add(cm);
                        List<Cart> c = dao.getCartProducts(cartList);
                        session.setAttribute("cart", c);
                        response.sendRedirect("product-detail.jsp");
                    }
                }
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
