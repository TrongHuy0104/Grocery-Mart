<%-- 
   Document   : index
   Created on : Nov 16, 2023, 2:46:08 PM
   Author     : Trong Huy
--%>
<%@page import="entity.*"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList");
    ArrayList<Product> productCateList = (ArrayList<Product>) request.getAttribute("productCateList");
    ArrayList<Product> productSearchList = (ArrayList<Product>) request.getAttribute("productSearchList");
    int pageActive = (int)request.getAttribute("pageActive");
    int endPage = (int)request.getAttribute("endPage");
    int totalProduct = (int)request.getAttribute("totalProduct");
    int productStart = (int)request.getAttribute("productStart");
    int productEnd = (int)request.getAttribute("productEnd");
%>
<!DOCTYPE html>
<html class="">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Grocery Mart</title>
        <!-- Favicon -->
        <link rel="apple-touch-icon" sizes="76x76" href="./assets/favicon/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="./assets/favicon/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="./assets/favicon/favicon-16x16.png">
        <link rel="manifest" href="./assets/favicon/site.webmanifest">
        <link rel="mask-icon" href="./assets/favicon/safari-pinned-tab.svg" color="#5bbad5">
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="theme-color" content="#ffffff">
        <!-- Fonts -->
        <link rel="stylesheet" href="./assets/fonts/stylesheet.css">
        <!-- Stylesheets -->
        <link href="./assets/css/main.css" rel="stylesheet" type="text/css"/>
        <!-- Scripts -->
        <script src="./assets/js/scripts.js"></script>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="/templates/header.jsp" /> 

        <!-- Main -->
        <main class="container home">
            <form action="Search" method="POST" class="search-bar d-none d-xl-flex navbar__search-bar">
                <input type="text" name="data" id="" value="" placeholder="Search for item" class="search-bar__input">
                <button class="search-bar__submit">
                    <img src="./assets/icons/search.svg" alt="" class="search-bar__icon icon">
                </button>
            </form>
            <!-- Slideshow -->
            <div class="home__container">
                <div class="slideshow">
                    <div class="slideshow__inner">
                        <div class="slideshow__item">
                            <a href="#!" class="slideshow__link">
                                <picture>
                                    <!--<source media="(max-width: 767.98px)" srcset="./assets/img/slideshow/item-1-md.png">-->
                                    <img src="assets/img/slideshow/8495151 (1).jpg" alt="" class="slideshow__img">
                                </picture>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Browse Products -->
            <section class="home__container">
                <div class="home__row">
                    <h2 class="home__heading">Total</h2>
                </div>
                <div class="row row-cols-4 row-cols-lg-2 row-cols-md-1 g-3" ">
                    <%
                    if(productList != null) {
                    for(Product o:productList) {
                    %>
                    <%
                                String url;
                                String root = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                                + request.getContextPath();
                                String avatarURL= o.getpThumb();
                                if (avatarURL != null) {
//                                        D:\Workspace\Java\Shopping\src\main\webapp\assets\img\avatar
                                    url = root + "/assets/img/product/" + avatarURL;
                                } else url = "";
                    %>
                    <div class="col">
                        <article class="product-card">
                            <div class="product-card__thumb-wrap">
                                <a href="Detail?pid=<%=o.getpId()%>">
                                    <img src="<%=url%>" alt="" class="product-card__thumb">
                                </a>
                            </div>
                            <h3 class="product-card__title">
                                <a href="Detail?pid=<%=o.getpId()%>"><%=o.getpName()%> </a>
                            </h3>
                            <p class="product-card__branch"><%=o.getpOrigin()%></p>
                            <div class="product-card__row">
                                <span class="product-card__price"><%=o.getpPrice()%> $</span>
                                <img src="./assets/icons/star.svg" alt="" class="product-card__star">
                                <span class="product-card__score"><%=o.getpRating()%></span>
                            </div>
                        </article>
                    </div>
                    <%}}%>
                </div>
            </section>
            <!-- Paging -->

            <%if(productCateList != null) {%> 
            <div class="paging">
                <div class="paging-info">
                    Showing <span class="paging-start"><%=productStart%></span> to <span class="paging-end"><%=productEnd%></span> of <span class="paging-total"><%=totalProduct%></span> entries
                </div>
                <ul class="paging__list">
                    <%
                    if (pageActive > 1) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="category-paging?index=1"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M41.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.3 256 246.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160zm352-160l-160 160c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L301.3 256 438.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0z"/></svg></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="category-paging?index=1"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M41.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.3 256 246.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160zm352-160l-160 160c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L301.3 256 438.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0z"/></svg></a>
                    </li>
                    <%}%>
                    <%
                    if (pageActive > 1) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="category-paging?index=${pageActive - 1}"><img src="./assets/icons/previous.svg" class="icon" alt=""></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="category-paging?index=${pageActive - 1}"><img src="./assets/icons/previous.svg" class="icon" alt=""></a>
                    </li>
                    <%}%>
                    <li class="paging__item  paging__item--active"><a class="paging__link">${pageActive}</a></li>
                        <%
                        if (pageActive < endPage) {
                        %>
                    <li class="paging__item">
                        <a class="paging__link" href="category-paging?index=${pageActive + 1}"><img src="./assets/icons/next.svg" class="icon" alt=""></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="category-paging?index=${pageActive + 1}"><img src="./assets/icons/next.svg" class="icon" alt=""></a>
                    </li>
                    <%}%>
                    <%
                    if (pageActive < endPage) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="category-paging?index=<%=endPage%>"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M470.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 256 265.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160zm-352 160l160-160c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L210.7 256 73.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0z"/></svg></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="category-paging?index=<%=endPage%>"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M470.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 256 265.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160zm-352 160l160-160c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L210.7 256 73.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0z"/></svg></a>
                    </li>
                    <%}%>
                </ul>
            </div> 
                 
            <%} else if (productSearchList != null) {%>
            
            <div class="paging">
                <div class="paging-info">
                    Showing <span class="paging-start"><%=productStart%></span> to <span class="paging-end"><%=productEnd%></span> of <span class="paging-total"><%=totalProduct%></span> entries
                </div>
                <ul class="paging__list">
                    <%
                    if (pageActive > 1) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="search-paging?index=1"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M41.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.3 256 246.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160zm352-160l-160 160c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L301.3 256 438.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0z"/></svg></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="search-paging?index=1"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M41.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.3 256 246.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160zm352-160l-160 160c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L301.3 256 438.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0z"/></svg></a>
                    </li>
                    <%}%>
                    <%
                    if (pageActive > 1) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="search-paging?index=${pageActive - 1}"><img src="./assets/icons/previous.svg" class="icon" alt=""></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="search-paging?index=${pageActive - 1}"><img src="./assets/icons/previous.svg" class="icon" alt=""></a>
                    </li>
                    <%}%>
                    <li class="paging__item  paging__item--active"><a class="paging__link">${pageActive}</a></li>
                        <%
                        if (pageActive < endPage) {
                        %>
                    <li class="paging__item">
                        <a class="paging__link" href="search-paging?index=${pageActive + 1}"><img src="./assets/icons/next.svg" class="icon" alt=""></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="search-paging?index=${pageActive + 1}"><img src="./assets/icons/next.svg" class="icon" alt=""></a>
                    </li>
                    <%}%>
                    <%
                    if (pageActive < endPage) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="search-paging?index=<%=endPage%>"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M470.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 256 265.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160zm-352 160l160-160c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L210.7 256 73.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0z"/></svg></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="search-paging?index=<%=endPage%>"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M470.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 256 265.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160zm-352 160l160-160c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L210.7 256 73.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0z"/></svg></a>
                    </li>
                    <%}%>
                </ul>
            </div> 
            <%} else if(productList != null) {%>
            <div class="paging">
                <div class="paging-info">
                    Showing <span class="paging-start"><%=productStart%></span> to <span class="paging-end"><%=productEnd%></span> of <span class="paging-total"><%=totalProduct%></span> entries
                </div>
                <ul class="paging__list">
                    <%
                    if (pageActive > 1) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="Home?index=1"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M41.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.3 256 246.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160zm352-160l-160 160c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L301.3 256 438.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0z"/></svg></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="Home?index=1"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M41.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.3 256 246.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160zm352-160l-160 160c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L301.3 256 438.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0z"/></svg></a>
                    </li>
                    <%}%>
                    <%
                    if (pageActive > 1) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="Home?index=${pageActive - 1}"><img src="./assets/icons/previous.svg" class="icon" alt=""></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="Home?index=${pageActive - 1}"><img src="./assets/icons/previous.svg" class="icon" alt=""></a>
                    </li>
                    <%}%>

                    <li class="paging__item  paging__item--active"><a class="paging__link">${pageActive}</a></li>
                        <%
                        if (pageActive < endPage) {
                        %>
                    <li class="paging__item">
                        <a class="paging__link" href="Home?index=${pageActive + 1}"><img src="./assets/icons/next.svg" class="icon" alt=""></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="Home?index=${pageActive + 1}"><img src="./assets/icons/next.svg" class="icon" alt=""></a>
                    </li>
                    <%}%>
                    <%
                    if (pageActive < endPage) {
                    %>
                    <li class="paging__item">
                        <a class="paging__link" href="Home?index=<%=endPage%>"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M470.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 256 265.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160zm-352 160l160-160c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L210.7 256 73.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0z"/></svg></a>
                    </li>
                    <%} else {%>
                    <li class="paging__item paging__item--disable">
                        <a class="paging__link" href="Home?index=<%=endPage%>"><svg class="icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M470.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 256 265.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160zm-352 160l160-160c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L210.7 256 73.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0z"/></svg></a>
                    </li>
                    <%}%>
                </ul>
            </div>
            <%}%>
        </main>
        <!-- Footer -->
        <%@include file="/templates/footer.jsp"%>
        <script>window.dispatchEvent(new Event("template-loaded"));</script>
        <script src="assets/js/theme.js" type="text/javascript"></script>
    </body>
</html>
