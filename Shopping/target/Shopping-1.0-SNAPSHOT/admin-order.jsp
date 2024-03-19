<%-- 
    Document   : admin
    Created on : Nov 21, 2023, 4:14:02 PM
    Author     : Trong Huy
--%>

<%@page import="java.util.*"%>
<%@page import="entity.*" %>
<%@page import="dataAccess.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    OrderDAO orderDao = new OrderDAO();
    UserDAO userDao = new UserDAO();
    List<Order> orderList = orderDao.selectAllOrder();
    User user = (User) request.getSession().getAttribute("admin");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin|Grocerymart</title>
        <!-- Favicon -->
        <link rel="apple-touch-icon" sizes="76x76" href="./assets/favicon/apple-touch-icon.png" />
        <link rel="icon" type="image/png" sizes="32x32" href="./assets/favicon/favicon-32x32.png" />
        <link rel="icon" type="image/png" sizes="16x16" href="./assets/favicon/favicon-16x16.png" />
        <link rel="manifest" href="./assets/favicon/site.webmanifest" />
        <link rel="mask-icon" href="./assets/favicon/safari-pinned-tab.svg" color="#5bbad5" />
        <meta name="msapplication-TileColor" content="#da532c" />
        <meta name="theme-color" content="#ffffff" />
        <!-- Fonts -->
        <link rel="stylesheet" href="./assets/fonts/stylesheet.css" />
        <!-- Stylesheets -->
        <link rel="stylesheet" href="./assets/css/main.css" />
        <link rel="stylesheet" href="./assets/css/admin.css" />
        <!-- Scripts -->
        <script src="./assets/js/scripts.js"></script>
    </head>
    <body>
        <%
        if(user == null) {
        %>
        <h3 style='color:crimson; font-size: 30px; font-weight: 500; text-align: center'>You are not logged into the system! <a href='sign-in.jsp'>Sign In</a></h3>")
        <%} else {%>   
        <!-- Sidebar -->
        <div class="admin-sidebar">
            <!-- Logo -->
            <a href="customer.jsp" class="logo top-bar__logo admin-logo">
                <img src="./assets/icons/logo.svg" alt="grocerymart" class="logo__img top-bar__logo-img" />
                <h1 class="logo__title top-bar__logo-title">grocerymart</h1>
            </a>
            <h3 class="sidebar__heading">APPLICATION</h3>
            <ul class="sidebar__list">
                <li class="sidebar__item">
                    <a href="customer.jsp" class="sidebar__link">
                        <svg
                            fill="rgb(143, 159, 188)"
                            xmlns="http://www.w3.org/2000/svg"
                            height="1em"
                            viewBox="0 0 448 512"
                            >
                        <path
                            d="M304 128a80 80 0 1 0 -160 0 80 80 0 1 0 160 0zM96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM49.3 464H398.7c-8.9-63.3-63.3-112-129-112H178.3c-65.7 0-120.1 48.7-129 112zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3z"
                            />
                        </svg>

                        Customer</a
                    >
                </li>
                <li class="sidebar__item">
                    <a href="admin.jsp" class="sidebar__link">
                        <svg
                            fill="rgb(143, 159, 188)"
                            xmlns="http://www.w3.org/2000/svg"
                            height="1em"
                            viewBox="0 0 448 512"
                            >
                        <path
                            d="M304 128a80 80 0 1 0 -160 0 80 80 0 1 0 160 0zM96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM49.3 464H398.7c-8.9-63.3-63.3-112-129-112H178.3c-65.7 0-120.1 48.7-129 112zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3z"
                            />
                        </svg>

                        Admin</a
                    >
                </li>
                <li class="sidebar__item">
                    <a href="admin-product.jsp" class="sidebar__link">
                        <svg
                            fill="rgb(143, 159, 188)"
                            xmlns="http://www.w3.org/2000/svg"
                            height="1em"
                            viewBox="0 0 512 512"
                            >
                        <!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                        <path
                            d="M326.3 218.8c0 20.5-16.7 37.2-37.2 37.2h-70.3v-74.4h70.3c20.5 0 37.2 16.7 37.2 37.2zM504 256c0 137-111 248-248 248S8 393 8 256 119 8 256 8s248 111 248 248zm-128.1-37.2c0-47.9-38.9-86.8-86.8-86.8H169.2v248h49.6v-74.4h70.3c47.9 0 86.8-38.9 86.8-86.8z"
                            />
                        </svg>

                        Product</a
                    >
                </li>
                <li class="sidebar__item sidebar__item--active">
                    <a href="admin-order.jsp" class="sidebar__link">
                        <svg
                            fill="rgb(143, 159, 188)"
                            xmlns="http://www.w3.org/2000/svg"
                            height="1em"
                            viewBox="0 0 576 512"
                            >
                        <!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                        <path
                            d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"
                            />
                        </svg>

                        Order</a
                    >
                </li>
            </ul>
        </div>
        <!-- Navbar -->
        <nav class="admin-navbar">
            <ul class="admin-navbar__list">
                <li class="admin-navbar__item">
                    <a href="#!" class="admin-navbar__link">
                        <img
                            src="https://templates.iqonic.design/datum/html/assets/images/user/1.jpg"
                            alt=""
                            class="admin-navbar__img"
                            />
                        <span class="admin-navbar__text"><%=user.getFullName()%></span>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- Main -->
        <main class="main">
            <div class="admin-top">
                <h1 class="admin__heading">Customer</h1>
                <form action="customer.jsp" method="POST" class="search-bar d-flex admin__search-bar">
                    <input
                        type="text"
                        name="data"
                        id=""
                        value=""
                        placeholder="Search for item"
                        class="search-bar__input"
                        />
                    <button class="search-bar__submit">
                        <img src="./assets/icons/search.svg" alt="" class="search-bar__icon icon" />
                    </button>
                </form>
                <a href="customer-add.jsp" class="admin__add-btn">+ Add Customer</a>
            </div>
            <%
            if(orderList == null) {
            %>

            <div style="font-size: 3rem; font-weight: 700; display: flex; align-items: center; justify-content: center">
                Empty
            </div> 
            <%} else {
            %>
            <table class="table">
                <thead class="table__head">
                    <tr>
                        <th class="table__heading">ID</th>
                        <th class="table__heading">Date</th>
                        <th class="table__heading">Customer</th>
                        <th class="table__heading">Total</th>
                        <th class="table__heading">Status</th>
                        <th class="table__heading">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for(Order o : orderList) {
                        User tempUser = new User();
                        User u = new User();
                        tempUser.setId(o.getUid());
                        u = userDao.selectById(tempUser);
                        List<Order> orderItems = null;
                        orderItems = orderDao.getAllOrderDetail(o.getOrderId(), u.getId());
                        DAO dao = new DAO();
                        double total = dao.getTotalOrderPrice(orderItems);
                    %>
                    <tr>
                        <td>
                            <p class="table__data"><%=o.getOrderId()%></p>
                        </td>
                        <td>
                            <p class="table__data"><%=o.getDate()%></p>
                        </td>
                        <td>
                            <p class="table__data"><%=u.getFullName()%></p>
                        </td>

                        <td>
                            <p class="table__data">$<%=total%></p>
                        </td>
                        <td>
                            <%
                            if(o.getStatus() == 0) {
                            %>
                            <p class="table__data" style="color: red; font-weight: 600">Canceled</p>
                            <%} else if (o.getStatus() == 1) {%>
                            <p class="table__data" style="color: #db7e06; font-weight: 600">Pending</p>
                            <% } else if (o.getStatus() == 2) {%>
                            <p class="table__data" style="color: #db7e06; font-weight: 600">Confirmed</p>
                            <% } else if (o.getStatus() == 3) {%>
                            <p class="table__data" style="color: #db7e06; font-weight: 600">Packed</p>
                            <% } else if (o.getStatus() == 4) {%>
                            <p class="table__data" style="color: #db7e06; font-weight: 600">In Transit</p>
                            <%} else {%>
                            <p class="table__data" style="color: #3cb72c; font-weight: 600">Completed</p>
                            <%}%>
                        </td>
                        <td>
                            <div class="table__act">

                                <a href="admin-order-detail.jsp?id=<%=o.getOrderId()%>" class="table__act-btn table__act-btn-avatar"  title="view">
                                    <svg fill="rgb(143, 159, 188)" xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M288 80c-65.2 0-118.8 29.6-159.9 67.7C89.6 183.5 63 226 49.4 256c13.6 30 40.2 72.5 78.6 108.3C169.2 402.4 222.8 432 288 432s118.8-29.6 159.9-67.7C486.4 328.5 513 286 526.6 256c-13.6-30-40.2-72.5-78.6-108.3C406.8 109.6 353.2 80 288 80zM95.4 112.6C142.5 68.8 207.2 32 288 32s145.5 36.8 192.6 80.6c46.8 43.5 78.1 95.4 93 131.1c3.3 7.9 3.3 16.7 0 24.6c-14.9 35.7-46.2 87.7-93 131.1C433.5 443.2 368.8 480 288 480s-145.5-36.8-192.6-80.6C48.6 356 17.3 304 2.5 268.3c-3.3-7.9-3.3-16.7 0-24.6C17.3 208 48.6 156 95.4 112.6zM288 336c44.2 0 80-35.8 80-80s-35.8-80-80-80c-.7 0-1.3 0-2 0c1.3 5.1 2 10.5 2 16c0 35.3-28.7 64-64 64c-5.5 0-10.9-.7-16-2c0 .7 0 1.3 0 2c0 44.2 35.8 80 80 80zm0-208a128 128 0 1 1 0 256 128 128 0 1 1 0-256z"/></svg></a>
                                    <%
                                    if(o.getStatus() == 1) {
                                    %>
                                <a href="confirm-order?id=<%=o.getOrderId()%>" class="table__act-btn table__act-btn-avatar"  title="confirm">
                                <svg fill="rgb(143, 159, 188)" xmlns="http://www.w3.org/2000/svg" height="20" width="20" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M438.6 105.4c12.5 12.5 12.5 32.8 0 45.3l-256 256c-12.5 12.5-32.8 12.5-45.3 0l-128-128c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L160 338.7 393.4 105.4c12.5-12.5 32.8-12.5 45.3 0z"/></svg></div>
                                <%}%>
                                <%
                                    if(o.getStatus() != 0 && o.getStatus() != 1) {
                                %>
                            <div class="table__act-btn table__act-btn-status"  title="update status">
                                <svg
                                    fill="rgb(143, 159, 188)"
                                    xmlns="http://www.w3.org/2000/svg"
                                    height="1em"
                                    viewBox="0 0 512 512"
                                    >
                                <!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->
                                <path
                                    d="M362.7 19.3L314.3 67.7 444.3 197.7l48.4-48.4c25-25 25-65.5 0-90.5L453.3 19.3c-25-25-65.5-25-90.5 0zm-71 71L58.6 323.5c-10.4 10.4-18 23.3-22.2 37.4L1 481.2C-1.5 489.7 .8 498.8 7 505s15.3 8.5 23.7 6.1l120.3-35.4c14.1-4.2 27-11.8 37.4-22.2L421.7 220.3 291.7 90.3z"
                                    />
                                </svg>
                                <ul class="order-status__list">
                                    <li class="order-status__item">
                                        <a href="update-order-status?action=packed&id=<%=o.getOrderId()%>" class="order-status__link">
                                            Packed
                                        </a>
                                    </li>
                                    <li class="order-status__item">
                                        <a href="update-order-status?action=intransit&id=<%=o.getOrderId()%>" class="order-status__link">
                                            In transit
                                        </a>
                                    </li>
                                    <li class="order-status__item">
                                        <a href="update-order-status?action=delivered&id=<%=o.getOrderId()%>" class="order-status__link">
                                            Delivered
                                        </a>
                                    </li>
                                </ul>
                            </div>
                                <%}%>
                            </div>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
            <%}%>
        </main>
        <%}%>  
    </body>
</html>

