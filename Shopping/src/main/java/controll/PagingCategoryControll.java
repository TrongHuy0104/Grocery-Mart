/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controll;

import dataAccess.DAO;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Trong Huy
 */
public class PagingCategoryControll extends HttpServlet {

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
            // get cate id
            String cateID = (String)session.getAttribute("cateID");
            int id = Integer.parseInt(cateID);

            // get page index
            String indexPage = request.getParameter("index");
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);
            int pageLimit = 16;
            // Get Total Products
            DAO dao = new DAO();
            int pCount = dao.countCateProduct(id);
            int endPage = pCount / pageLimit;
            if (endPage % pageLimit != 0) {
                endPage++;
            }
            int productStart = (index - 1) * pageLimit + 1;
            int productEnd;
            if (index == endPage) {
                productEnd = pCount;
            } else if(pCount <= pageLimit) {
                productEnd = pCount;
            } else {
                productEnd = index * pageLimit;
            }

            List<Product> productList = dao.getProductFromCate(id, index);
            request.setAttribute("productList", productList);
            request.setAttribute("productCateList", productList);
            request.setAttribute("totalProduct", pCount);
            request.setAttribute("productStart", productStart);
            request.setAttribute("productEnd", productEnd);
            request.setAttribute("endPage", endPage);
            request.setAttribute("pageActive", index);
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
