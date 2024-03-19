
<%@page import="java.util.*"%>
<%@page import="entity.*" %>
<%@page import="dataAccess.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) request.getSession().getAttribute("user");
    String menu = request.getParameter("menu");
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if (cart_list != null) {
        DAO dao = new DAO();
        cartProduct = dao.getCartProducts(cart_list);
        double total = dao.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
    }

    int number_of_cart;
    if (cart_list == null) {
    number_of_cart = 0;
    } else {
    number_of_cart = cart_list.size();
    }
%>

<header id="header" class="header">

    <div class="container">
        <div class="top-bar">
            <!-- More  -->
            <button class="top-bar__more js-toggle d-none d-lg-block" toggle-target="#navbar">
                <img src="./assets/icons/more.svg" alt="" class="icon top-bar__more-icon" />
            </button>

            <!-- Logo -->
            <a href="Home" class="logo top-bar__logo">
                <img src="./assets/icons/logo.svg" alt="grocerymart" class="logo__img top-bar__logo-img" />
                <h1 class="logo__title top-bar__logo-title">grocerymart</h1>
            </a>

            <!-- Navbar -->
            <nav id="navbar" class="navbar hide">
                <button class="navbar__close-btn d-none d-lg-block js-toggle" toggle-target="#navbar">
                    <img src="./assets/icons/arrow-left.svg" alt="" class="icon" />
                </button>
                <%
                if (user != null) {
                %>
                <a href="orders.jsp" class="nav-btn d-none d-md-flex">
                    <img src="./assets/icons/truck.png" width="32px" alt="" class="icon top-act__icon" />
                    <span class="nav-btn__title">Order</span>
                </a>
                <a href="checkout.jsp" class="nav-btn d-none d-md-flex">
                    <img src="./assets/icons/cart.svg" alt="" class="icon top-act__icon" />
                    <span class="nav-btn__title">Cart(s) </span>
                    <span class="nav-btn__qnt"><%=number_of_cart%></span>
                </a>
                <%}%>
                <c:out value="${menu}" escapeXml="false"/>

            </nav>
            <div class="navbar__overlay js-toggle" toggle-target="#navbar"></div>

            <!--Search-->
            <form action="Search" method="POST" class="search-bar d-xl-none d-flex navbar__search-bar search-bar--mb">
                <input type="text" name="data" id="" value="${dataSearch}" placeholder="Search for item" class="search-bar__input" />
                <button class="search-bar__submit">
                    <img src="./assets/icons/search.svg" alt="" class="search-bar__icon icon" />
                </button>
            </form>
            <%
						
            if(user==null){
            %>
            <!-- Actions -->
            <div class="top-act">
                <a href="./sign-in.jsp" class="btn btn--text d-md-none d-lg-flex d-xl-none">Sign In</a>
                <a href="./sign-up.jsp" class="btn btn--primary top-act__sign-up">Sign Up</a>
            </div>
            <%} else { %>
            <!-- Actions -->
            <div class="top-act" style="margin-left: auto">
                <div class="top-act__group d-md-none">
                    <div class="top-act__btn-wrap">
                        <a href="orders.jsp" class="top-act__btn">
                            <img src="./assets/icons/truck.png" width="32px" alt="" class="icon top-act__icon" />
                        </a>
                    </div>
                    <div class="top-act__separate"></div>
                    <div class="top-act__btn-wrap">
                        <button class="top-act__btn">
                            <img src="./assets/icons/cart.svg" alt="" class="icon top-act__icon" />
                            <span class="top-act__title"><%=number_of_cart%></span>
                        </button>
                        <!-- Dropdown -->
                        <div class="act-dropdown">
                            <%
                            if (cart_list == null || cart_list.isEmpty()) {
                            %>
                            <p style="text-align: center;
                               line-height: 100%;
                               font-size: 2.4rem;
                               font-weight: 500;
                               position: relative;
                               padding: 30px;
                               border-radius: 20px;
                               background: var(--header-act-dropdown-bg);
                               box-shadow: 0px 40px 90px 20px var(--header-act-dropdown-shadow);">Empty</p>
                            <%
                                } else {
                            %>
                            <div class="act-dropdown__inner">
                                <img src="./assets/icons/arrow-up.png" alt="" class="act-dropdown__arrow" />
                                <div class="act-dropdown__top">
                                    <h2 class="act-dropdown__title">You have <%=number_of_cart%> item(s)</h2>
                                    <a href="checkout.jsp" class="act-dropdown__view-all" previewlistener="true"
                                       >See All</a
                                    >
                                </div> 
                                <div class="row row-cols-3 gx-2 act-dropdown__list">
                                    <%
                                            
                                    ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("cart");
                                    if(carts != null && !carts.isEmpty()) {
                                    for(Cart o:carts) {
                                    %>
                                    <%
                                    String url;
                                    String root = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                                    + request.getContextPath();
                                    String avatarURL= o.getpThumb();
                                    if (avatarURL != null) {
                                    url = root + "/assets/img/product/" + avatarURL;
                                    } else url = "";
                                    %>
                                    <div class="col">
                                        <article class="cart-preview-item">
                                            <div class="cart-preview-item__img-wrap">
                                                <img
                                                    src="<%=url%>"
                                                    alt=""
                                                    class="cart-preview-item__thumb"
                                                    />
                                            </div>
                                            <h3 class="cart-preview-item__title"><%=o.getpName()%></h3>
                                            <p class="cart-preview-item__price">$<%=o.getpPrice()%></p>
                                        </article>
                                    </div>
                                    <%}%>
                                </div>
                                <div class="act-dropdown__bottom">
                                    <div class="act-dropdown__row">
                                        <span class="act-dropdown__label">Subtotal</span>
                                        <span class="act-dropdown__value">$${total > 0 ? total : 0}</span>
                                    </div>
                                    <div class="act-dropdown__row">
                                        <span class="act-dropdown__label">Texes</span>
                                        <span class="act-dropdown__value">Free</span>
                                    </div>
                                    <div class="act-dropdown__row">
                                        <span class="act-dropdown__label">Shipping</span>
                                        <span class="act-dropdown__value">$10.00</span>
                                    </div>
                                    <div class="act-dropdown__row act-dropdown__row--bold">
                                        <span class="act-dropdown__label">Total Price</span>
                                        <span class="act-dropdown__value">$${total > 0 ? total + 10.00 : 0} </span>
                                    </div>
                                </div>
                                <div class="act-dropdown__checkout">
                                    <a
                                        href="checkout.jsp"
                                        class="btn btn--primary btn--rounded act-dropdown__checkout-btn"
                                        previewlistener="true"
                                        >
                                        Check Out All
                                    </a>
                                </div>
                            </div>

                            <%}}%>
                        </div>
                    </div>
                </div>
                <div class="top-act__user top-act__btn-wrap">
                    <%
                                    String url;
                                    String root = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                                    + request.getContextPath();
                                    String avatarURL= user.getAvatar();
//                                        D:\Workspace\Java\Shopping\src\main\webapp\assets\img\avatar
                                        if (avatarURL != null) {
//                                        D:\Workspace\Java\Shopping\src\main\webapp\assets\img\avatar
                                        url = root + "/assets/img/avatar/" + avatarURL;
                                    } else url = "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png";
                    %>
                    <img src="<%=url%>" alt="" class="top-act__avatar" />
                    <!-- Dropdown -->
                    <div class="act-dropdown user__dropdown">
                        <div class="act-dropdown__inner user__dropdown-inner">

                            <img
                                src="./assets/icons/arrow-up.png"
                                alt=""
                                class="act-dropdown__arrow user__dropdown-arrow"
                                />
                            <h3 class="user__dropdown-heading">Account</h3>
                            <ul class="user__dropdown-list">
                                <li class="user__dropdown-item">
                                    <span class="user__dropdown-text-wrap">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M304 128a80 80 0 1 0 -160 0 80 80 0 1 0 160 0zM96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM49.3 464H398.7c-8.9-63.3-63.3-112-129-112H178.3c-65.7 0-120.1 48.7-129 112zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3z"/></svg>
                                        <span class="user__dropdown-text">${user.fullName}</span>
                                    </span>
                                </li>
                                <li class="user__dropdown-item">
                                    <div class="user__dropdown-link user__dropdown-theme">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 384 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M144.7 98.7c-21 34.1-33.1 74.3-33.1 117.3c0 98 62.8 181.4 150.4 211.7c-12.4 2.8-25.3 4.3-38.6 4.3C126.6 432 48 353.3 48 256c0-68.9 39.4-128.4 96.8-157.3zm62.1-66C91.1 41.2 0 137.9 0 256C0 379.7 100 480 223.5 480c47.8 0 92-15 128.4-40.6c1.9-1.3 3.7-2.7 5.5-4c4.8-3.6 9.4-7.4 13.9-11.4c2.7-2.4 5.3-4.8 7.9-7.3c5-4.9 6.3-12.5 3.1-18.7s-10.1-9.7-17-8.5c-3.7 .6-7.4 1.2-11.1 1.6c-5 .5-10.1 .9-15.3 1c-1.2 0-2.5 0-3.7 0c-.1 0-.2 0-.3 0c-96.8-.2-175.2-78.9-175.2-176c0-54.8 24.9-103.7 64.1-136c1-.9 2.1-1.7 3.2-2.6c4-3.2 8.2-6.2 12.5-9c3.1-2 6.3-4 9.6-5.8c6.1-3.5 9.2-10.5 7.7-17.3s-7.3-11.9-14.3-12.5c-3.6-.3-7.1-.5-10.7-.6c-2.7-.1-5.5-.1-8.2-.1c-3.3 0-6.5 .1-9.8 .2c-2.3 .1-4.6 .2-6.9 .4z"/>
                                        </svg>Turn on dark interface</div>
                                </li>
                                <li class="user__dropdown-item">
                                    <a href="change-password.jsp" class="user__dropdown-link">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M144 144v48H304V144c0-44.2-35.8-80-80-80s-80 35.8-80 80zM80 192V144C80 64.5 144.5 0 224 0s144 64.5 144 144v48h16c35.3 0 64 28.7 64 64V448c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V256c0-35.3 28.7-64 64-64H80z"/></svg>
                                        Change password</a
                                    >
                                </li>
                                <li class="user__dropdown-item">
                                    <a href="update-information.jsp" class="user__dropdown-link">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M441 58.9L453.1 71c9.4 9.4 9.4 24.6 0 33.9L424 134.1 377.9 88 407 58.9c9.4-9.4 24.6-9.4 33.9 0zM209.8 256.2L344 121.9 390.1 168 255.8 302.2c-2.9 2.9-6.5 5-10.4 6.1l-58.5 16.7 16.7-58.5c1.1-3.9 3.2-7.5 6.1-10.4zM373.1 25L175.8 222.2c-8.7 8.7-15 19.4-18.3 31.1l-28.6 100c-2.4 8.4-.1 17.4 6.1 23.6s15.2 8.5 23.6 6.1l100-28.6c11.8-3.4 22.5-9.7 31.1-18.3L487 138.9c28.1-28.1 28.1-73.7 0-101.8L474.9 25C446.8-3.1 401.2-3.1 373.1 25zM88 64C39.4 64 0 103.4 0 152V424c0 48.6 39.4 88 88 88H360c48.6 0 88-39.4 88-88V312c0-13.3-10.7-24-24-24s-24 10.7-24 24V424c0 22.1-17.9 40-40 40H88c-22.1 0-40-17.9-40-40V152c0-22.1 17.9-40 40-40H200c13.3 0 24-10.7 24-24s-10.7-24-24-24H88z"/></svg>
                                        Update user information</a
                                    >
                                </li>
                                <li class="user__dropdown-item">
                                    <a href="update-avatar.jsp" class="user__dropdown-link">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 640 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3zM504 312V248H440c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V136c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H552v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z"/></svg>
                                        Update avatar</a
                                    >
                                </li>
                                <div class="act-dropdown__separate" style="margin: 0 auto; width: calc(100% - 48px);"></div>
                                <li class="user__dropdown-item">
                                    <a href="user?action=log-out" class="user__dropdown-link">
                                        <img
                                            class="icon"
                                            alt=""
                                            aria-hidden="true"
                                            loading="lazy"
                                            src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYiIGhlaWdodD0iMTQiIHZpZXdCb3g9IjAgMCAxNiAxNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTE1Ljg0MzggNi42NTYyNUwxMS4zNDM4IDIuMTU2MjVDMTEuMTU2MiAxLjk2ODc1IDEwLjgxMjUgMS45Njg3NSAxMC42MjUgMi4xNTYyNUMxMC40Mzc1IDIuMzQzNzUgMTAuNDM3NSAyLjY4NzUgMTAuNjI1IDIuODc1TDE0LjI4MTIgNi41SDUuNUM1LjIxODc1IDYuNSA1IDYuNzUgNSA3QzUgNy4yODEyNSA1LjIxODc1IDcuNSA1LjUgNy41SDE0LjI4MTJMMTAuNjI1IDExLjE1NjJDMTAuNDM3NSAxMS4zNDM4IDEwLjQzNzUgMTEuNjg3NSAxMC42MjUgMTEuODc1QzEwLjgxMjUgMTIuMDYyNSAxMS4xNTYyIDEyLjA2MjUgMTEuMzQzOCAxMS44NzVMMTUuODQzOCA3LjM3NUMxNS45Mzc1IDcuMjgxMjUgMTYgNy4xNTYyNSAxNiA3QzE2IDYuODc1IDE1LjkzNzUgNi43NSAxNS44NDM4IDYuNjU2MjVaTTUuNSAxM0gyLjVDMS42NTYyNSAxMyAxIDEyLjM0MzggMSAxMS41VjIuNUMxIDEuNjg3NSAxLjY1NjI1IDEgMi41IDFINS41QzUuNzUgMSA2IDAuNzgxMjUgNiAwLjVDNiAwLjI1IDUuNzUgMCA1LjUgMEgyLjVDMS4wOTM3NSAwIDAgMS4xMjUgMCAyLjVWMTEuNUMwIDEyLjkwNjIgMS4wOTM3NSAxNCAyLjUgMTRINS41QzUuNzUgMTQgNiAxMy43ODEyIDYgMTMuNUM2IDEzLjI1IDUuNzUgMTMgNS41IDEzWiIgZmlsbD0iIzgwOEI5QSIvPgo8L3N2Zz4K"
                                            />
                                        Log out</a
                                    >
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

</header>

