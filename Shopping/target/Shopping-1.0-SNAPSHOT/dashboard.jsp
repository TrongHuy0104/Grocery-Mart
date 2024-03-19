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
    DAO Dao = new DAO();
    List<Product> productList = Dao.selectAll();
    User user = (User) request.getSession().getAttribute("admin");
//    String dataSearch = request.getParameter("data");
//    List<User> userListSearch = userDao.searchByName(dataSearch);
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
        <%--<%
            if (user == null) {
        %>
        <h3 style='color:crimson; font-size: 30px; font-weight: 500; text-align: center'>You are not logged into the system! <a href='sign-in.jsp'>Sign In</a></h3>")
        <%} else {%>--%>   
        <!-- Sidebar -->
        <div class="admin-sidebar">
            <!-- Logo -->
            <a href="dashboard.jsp" class="logo top-bar__logo admin-logo">
                <img src="./assets/icons/logo.svg" alt="grocerymart" class="logo__img top-bar__logo-img" />
                <h1 class="logo__title top-bar__logo-title">grocerymart</h1>
            </a>
            <h3 class="sidebar__heading">APPLICATION</h3>
            <ul class="sidebar__list">
                <li class="sidebar__item">
                    <a href="dashboard.jsp" class="sidebar__link">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" height="1em">
                        <!-- Background Circle -->
                        <circle cx="100" cy="100" r="90" fill="rgb(143, 159, 188)" />

                        <!-- Data Circle (Example) -->
                        <circle cx="100" cy="100" r="70" fill="rgb(143, 159, 188)" />

                        <!-- Text Label -->
                        <text x="50%" y="50%" font-size="20" text-anchor="middle" fill="#333">75%</text>
                        </svg>


                        Dashboard</a
                    >
                </li>
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
                <li class="sidebar__item sidebar__item--active">
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
                <li class="sidebar__item">
                    <a href="#!" class="sidebar__link">
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
                        <span class="admin-navbar__text"></span>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- Main -->
        <main class="main">
            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="dashboard.jsp"><b>Dashboard</b></a></li>
                        </ul>
                        <div id="clock"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <!--Left-->
                <div class="col-md-12 col-lg-6">
                    <%--<div class="row">
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng khách hàng</h4>
                                    <p><b>${requestScope.users.size()} khách hàng</b></p>
                                    <p class="info-tong">Tổng số khách hàng được quản lý.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-data fa-3x'></i>
                                <div class="info">
                                    <h4>Total Revenue</h4>
                                    <p><b>${requestScope.} VND</b></p>
                                    <p class="info-tong">Tổng số sản phẩm được quản lý.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small warning coloured-icon"><i class='icon bx bxs-shopping-bags fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng đơn hàng</h4>
                                    <p><b>${requestScope.orders.size()} đơn hàng</b></p>
                                    <p class="info-tong">Tổng số hóa đơn bán hàng</p>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                </div>
                <!--END left-->
                <!--Right-->
                <div class="col-md-12 col-lg-6">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">Dữ liệu 6 tháng đầu vào</h3>
                                <div class="embed-responsive embed-responsive-16by9">
                                    <canvas class="embed-responsive-item" id="lineChartDemo"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">Thống kê 6 tháng doanh thu</h3>
                                <div class="embed-responsive embed-responsive-16by9">
                                    <canvas class="embed-responsive-item" id="barChartDemo"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!--END right-->
            </div>
        </main>
        <script src="js/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="js/popper.min.js"></script>
        <script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
        <!--===============================================================================================-->
        <script src="js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="js/main.js"></script>
        <!--===============================================================================================-->
        <script src="js/plugins/pace.min.js"></script>
        <!--===============================================================================================-->
        <script type="text/javascript" src="js/plugins/chart.js"></script>
        <!--===============================================================================================-->
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">
        $('#sampleTable').DataTable();
        var data = {
            labels: ["Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11"],
            datasets: [{
                    label: "Dữ liệu đầu tiên",
                    fillColor: "rgba(255, 213, 59, 0.767), 212, 59)",
                    strokeColor: "rgb(255, 212, 59)",
                    pointColor: "rgb(255, 212, 59)",
                    pointStrokeColor: "rgb(255, 212, 59)",
                    pointHighlightFill: "rgb(255, 212, 59)",
                    pointHighlightStroke: "rgb(255, 212, 59)",
                    data: [20, 59, 90, 51, 56, 100]
                },
                {
                    label: "Dữ liệu kế tiếp",
                    fillColor: "rgba(9, 109, 239, 0.651)  ",
                    pointColor: "rgb(9, 109, 239)",
                    strokeColor: "rgb(9, 109, 239)",
                    pointStrokeColor: "rgb(9, 109, 239)",
                    pointHighlightFill: "rgb(9, 109, 239)",
                    pointHighlightStroke: "rgb(9, 109, 239)",
                    data: [48, 48, 49, 39, 86, 10]
                }
            ]
        };
        var ctxl = $("#lineChartDemo").get(0).getContext("2d");
        var lineChart = new Chart(ctxl).Line(data);
        var ctxb = $("#barChartDemo").get(0).getContext("2d");
        var barChart = new Chart(ctxb).Bar(data);
        </script>
        <script type="text/javascript">
            //Thời Gian
            function time() {
                var today = new Date();
                var weekday = new Array(7);
                weekday[0] = "Chủ Nhật";
                weekday[1] = "Thứ Hai";
                weekday[2] = "Thứ Ba";
                weekday[3] = "Thứ Tư";
                weekday[4] = "Thứ Năm";
                weekday[5] = "Thứ Sáu";
                weekday[6] = "Thứ Bảy";
                var day = weekday[today.getDay()];
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                m = checkTime(m);
                s = checkTime(s);
                nowTime = h + " giờ " + m + " phút " + s + " giây";
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }
                today = day + ', ' + dd + '/' + mm + '/' + yyyy;
                tmp = '<span class="date"> ' + today + ' - ' + nowTime +
                        '</span>';
                document.getElementById("clock").innerHTML = tmp;
                clocktime = setTimeout("time()", "1000", "Javascript");
                function checkTime(i) {
                    if (i < 10) {
                        i = "0" + i;
                    }
                    return i;
                }
            }
        </script>
    </body>
</html>