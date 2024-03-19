<%-- 
    Document   : product-detail
    Created on : Nov 16, 2023, 10:27:42 AM
    Author     : Trong Huy
--%>

<%@page import="entity.*"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  Product product = (Product) session.getAttribute("detail");
  ArrayList<Product> similarList = (ArrayList<Product>) session.getAttribute("similarList");
  
%>
<!DOCTYPE html>
<html lang="en" class="">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Grocery Mart</title>
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
        <!-- Scripts -->
        <script src="./assets/js/scripts.js"></script>
    </head>
    <body>

        <!-- Header -->
        <jsp:include page="/templates/header.jsp" />
        <!-- Main -->
        <main class="product-page">
            <div class="container">
                <!-- Search Bar -->
                <div class="product-container">
                    <div class="search-bar d-none d-md-flex">
                        <input type="text" class="search-bar__input" placeholder="Search for item..." />
                        <button class="search-bar__submit" type="submit">
                            <img src="./assets/icons/search.svg" alt="" class="search-bar__icon" />
                        </button>
                    </div>
                </div>
                <!-- Breadcrumbs -->
                <div class="product-container">
                    <ul class="breadcrumbs">
                        <li>
                            <a href="Home" class="breadcrumbs__link">
                                Home
                                <img class="breadcrumbs__icon" src="./assets/icons/arrow-right.svg" alt="" />
                            </a>
                        </li>
                        <li>
                            <a href="#!" class="breadcrumbs__link breadcrumbs__link--current">
                                Product Detail
                            </a>
                        </li>
                    </ul>
                </div>
                <!-- Product Info -->
                <div class="product-container prod-info-content">
                    <div class="row">
                        <%
                            if(product != null) {
                                    String url;
                                    String root = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                                    + request.getContextPath();
                                    String avatarURL= product.getpThumb();
                                    if (avatarURL != null) {
    //                                        D:\Workspace\Java\Shopping\src\main\webapp\assets\img\avatar
                                        url = root + "/assets/img/product/" + avatarURL;
                                    } else url = "";
                        %>
                        <div class="col-5 col-xl-6 col-lg-12">
                            <div class="product-preview">
                                <div class="product-preview__item">
                                    <img
                                        src="<%=url%>"
                                        alt=""
                                        class="product-preview__img js-slideshow-thumb"
                                        />
                                </div>
                            </div>
                        </div>
                        <div class="col-7 col-xl-6 col-lg-12">
                            <section class="product-info">
                                <h1 class="product-info__heading">
                                    ${detail.pName}
                                </h1>
                                <div class="row">
                                    <div class="col-5 col-xxl-6 col-xl-12">
                                        <div class="product-property">
                                            <img
                                                src="./assets/icons/star.svg"
                                                alt=""
                                                class="product-property__icon"
                                                />
                                            <h4 class="product-property__title">(${detail.pRating})</h4>
                                        </div>
                                        <div class="product-property">
                                            <img
                                                src="./assets/icons/cart.svg"
                                                alt=""
                                                class="product-property__icon"
                                                />
                                            <div>
                                                <h4 class="product-property__title">Delivery</h4>
                                                <p class="product-property__desc">From $6 for 1-3 days</p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-7 col-xxl-6 col-xl-12">
                                        <div class="product-properties">
                                            <div class="product-property">
                                                <img
                                                    src="./assets/icons/document.svg"
                                                    alt=""
                                                    class="product-property__icon"
                                                    />
                                                <div><h4 class="product-property__title">Quantity</h4>
                                                    <p class="product-property__desc">${detail.pNumberLeft} product(s) left</p></div>
                                            </div>

                                        </div>
                                        <div class="product-info__card">
                                            <div class="product-info__row">
                                                <span class="product-info__price">$${detail.pPrice}</span>
                                                <span class="product-info__tax">${detail.pTax}%</span>
                                            </div>
                                            <c:set var="total" value="${detail.pPrice + (detail.pPrice * detail.pTax / 100)} $" scope="page" />
                                            <p class="product-info__total-price">
                                                <c:out value="${total}" escapeXml="false"/></p>
                                            <div class="product-info__row">
                                                <%
                                                    int status = product.getpStatus();
                                                    if(status == 0 || product.getpNumberLeft() == 0) {
                                                %>
                                                <a href="add-to-cart?id=${detail.pId}" class="btn btn--primary btn--disabled product-info__add-to-cart">
                                                    Add to cart
                                                </a>
                                                <% } else {%>
                                                <a href="add-to-cart?id=${detail.pId}" class="btn btn--primary product-info__add-to-cart">
                                                    Add to cart
                                                </a>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <%}%>                            
                    </div>
                </div>
                <!-- Product Tab -->
                <div class="product-container">
                    <div class="product-tab js-tabs">
                        <ul class="product-tab__list">
                            <li class="product-tab__item product-tab__item--active">Similar</li>
                            <li class="product-tab__item ">Description</li>
                        </ul>
                        <div class="product-tab__contents">

                            <div class="product-tab__content product-tab__content--active">
                                <h2 class="product-tab__content-heading">Similar items you might like</h2>
                                <div class="row row-cols-6 row-cols-xl-4 row-cols-lg-3 row-cols-md-2 row-cols-sm-1 g-2 product-card__wrap" style="overflow-x: auto; flex-wrap: nowrap;">
                                    <!-- Product Card  -->

                                    <%
                                        if(similarList != null) {
                                        for(Product o:similarList) {
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
                            </div>
                            <div class="product-tab__content">
                                <div class="row">
                                    <div class="col-8 col-xl-10 col-lg-12">
                                        <div class="text-content product-tab__text-content">
                                            <h2>Detail of ${detail.pName}</h2>
                                            <p>
                                                <%
                                                    String input = product.getpDescription();
                                                    String[] result = input.split("//");
                                                    List<String> resultList = Arrays.asList(result);                                              
                                                %>
                                                <% for(String str : resultList) { %>
                                                <%= str%><br>
                                                <% }%>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- Footer -->
        <%@include file="/templates/footer.jsp"%>
        <script>window.dispatchEvent(new Event("template-loaded"));</script>
        <script src="./assets/js/slideshow.js"></script>
        <script src="assets/js/theme.js" type="text/javascript"></script>
    </body>
</html>
