/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controll;

import dataAccess.DAO;
import entity.Category;
import entity.MenuItems;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Trong Huy
 */
@WebServlet(name = "HomeControll", urlPatterns = {"/Home"})
public class HomeControll extends HttpServlet {

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
        // Get Index Product
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        int pageLimit = 16;
        // Get Total Products
        DAO dao = new DAO();
        int pCount = dao.countTotal();
        int endPage = pCount / pageLimit;
        if (endPage % pageLimit != 0) {
            endPage++;
        }

        int productStart = (index - 1) * pageLimit + 1;
        int productEnd;
        if (index == endPage) {
            productEnd = pCount;
        } else {
            productEnd = index * pageLimit;
        }
        // Get All Product
        List<Product> productList = dao.pagingProduct(index);

        List<Category> rawData = DAO.getAllCat(); // get all category

        // Handle Cate Data 
        List<MenuItems> rootMenu = this.recursiveMenu(0, rawData);
        String menu = this.createMenu(rootMenu);

        HttpSession session = request.getSession();
        session.setAttribute("data", rawData);
        session.setAttribute("menu", menu);
        session.removeAttribute("dataSearch");
        request.setAttribute("productList", productList);
        request.setAttribute("totalProduct", pCount);
        request.setAttribute("productStart", productStart);
        request.setAttribute("productEnd", productEnd);
        request.setAttribute("endPage", endPage);
        request.setAttribute("pageActive", index);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    public List<MenuItems> recursiveMenu(int root, List<Category> listData) {
        List<MenuItems> result = new ArrayList<>();
        for (int i = 0; i < listData.size(); i++) {
            Category cat1 = listData.get(i);
            int parentId = cat1.getParent_id();
            if (root == parentId) {
                List<MenuItems> childs = this.recursiveMenu(cat1.getId(), listData);
                MenuItems mItem = new MenuItems();
                mItem.setId(cat1.getId());
                mItem.setName(cat1.getName_category());
                mItem.setParentId(cat1.getParent_id());
                mItem.setChild(childs);
                result.add(mItem);
            }
        }
        return result;
    }

    public String createMenu(List<MenuItems> rootMenu) {
        String result = "<ul class='navbar__list js-dropdown-list'>";
        for (MenuItems item : rootMenu) {
            List<MenuItems> childs = item.getChild();
            if (childs.size() > 0) {
                result += "<li class='navbar__item'>";
                result += "<a href='Categories?cateID=" + item.getId() + "'class='navbar__link'>" + item.getName();
                result += "<img src='./assets/icons/arrow-down.svg' alt='' class='icon navbar__icon' />";
                result += "</a>";
                result += this.createMenu((List<MenuItems>) childs);
                result += "</li>";
            } else {
                result += "<li class='navbar__item'>";
                result += "<a href='Categories?cateID=" + item.getId() + "'class='navbar__link'>" + item.getName();
                result += "</a>";
                result += "</li>";
            }
        }
        result += "</ul>";

        return result;
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
