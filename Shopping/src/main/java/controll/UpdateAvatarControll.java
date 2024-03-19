/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controll;

import dataAccess.UserDAO;
import entity.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Trong Huy
 */
public class UpdateAvatarControll extends HttpServlet {

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
            out.println("<title>Servlet UpdateAvatarControll</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAvatarControll at " + request.getContextPath() + "</h1>");
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
        Object obj = request.getSession().getAttribute("user");
        User user = null;
        if (obj != null) {
            user = (User) obj;
        }
        if (user != null) {
            try {
                String folder = getServletContext().getRealPath("\\assets\\img\\avatar");
                File file;
                int maxFileSize = 5000 * 1024;
                int maxMemSize = 5000 * 1024;

                String contentType = request.getContentType();

                if (contentType.indexOf(contentType) >= 0) {
                    DiskFileItemFactory factory = new DiskFileItemFactory();

                    factory.setSizeThreshold(maxMemSize);

                    ServletFileUpload upload = new ServletFileUpload(factory);

                    upload.setSizeMax(maxFileSize);

                    List<FileItem> files = upload.parseRequest(request);

                    for (FileItem fileItem : files) {
                        if (!fileItem.isFormField()) {
                            if (!fileItem.getName().equals("")) {
                                String fileName = System.currentTimeMillis() + fileItem.getName();
                                String path = folder + "\\" + fileName;
                                file = new File(path);

                                fileItem.write(file);

                                user.setAvatar(fileName);
                                UserDAO userDAO = new UserDAO();
                                userDAO.updateAvatar(user);
                                user = userDAO.selectById(user);
                            }
                        } else {
                            String name = fileItem.getFieldName();
                            String value = fileItem.getString();
                            System.out.println(name + " : " + value);
                        }
                    }
                }

                request.setAttribute("note", "Update succesfully!");
                request.getRequestDispatcher("update-avatar.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
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
