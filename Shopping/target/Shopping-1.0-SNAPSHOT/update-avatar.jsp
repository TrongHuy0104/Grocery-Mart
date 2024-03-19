<%-- 
    Document   : update-avatar
    Created on : Nov 21, 2023, 12:38:27 AM
    Author     : Trong Huy
--%>
<%@page import="entity.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : reset-password
    Created on : Nov 20, 2023, 1:48:56 PM
    Author     : Trong Huy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Reset Password | Grocery Mart</title>
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
        <!-- Styles -->
        <link rel="stylesheet" href="./assets/css/main.css" />
        <!-- Scripts -->
        <script src="./assets/js/scripts.js"></script>
        <style>
            .form__error {
                font-size: 1.6rem;
                color: red;
                margin-top: 20px;
                font-weight: 500;
                align-self: flex-start;
                margin-left: 15px;
            }


            .form__group .avatar-preview {
                margin-top: 16px;
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                object-position: center;
            }
        </style>
    </head>
    <body>

        <!-- Main -->
        <main class="auth">
            <%
                Object obj = session.getAttribute("user");
                User user = null;
                if (obj!=null)
                    user = (User)obj;		
                    if(user==null){		
            %>
            <div style="display: flex; align-items: center; justify-content: center; flex-direction: column; gap: 30px; width: 100%;">

                <h1 style="font-size: 3.6rem; font-weight: 600;">Bạn chưa đăng nhập vào hệ thống. Vui lòng quay lại trang chủ!</h1>
                <p class="auth__text">
                    <a href="Home" class="auth__link auth__text-link">Back to home page</a>
                </p>
            </div>
            <%
            }else {
            %>
            <!-- Auth Intro -->
            <div class="auth__intro d-md-none">
                <img src="https://png.pngtree.com/png-clipart/20220508/original/pngtree-hand-drawn-flat-style-vector-design-concept-illustration-of-men-and-png-image_7666496.png" alt="" class="auth__intro-img" />
            </div>
            <!-- Auth Content -->
            <div class="auth__content">
                <div class="auth__content-inner">
                    <!-- Logo -->
                    <a href="Home" class="logo">
                        <img src="./assets/icons/logo.svg" alt="grocerymart" class="logo__img top-bar__logo-img" />
                        <h2 class="logo__title top-bar__logo-title">grocerymart</h2>
                    </a>
                    <h1 class="auth__heading">Update your avatar</h1>
                    <p class="auth__desc">Click on image and change your avatar. Choose your avatar file less than 5MB</p>
                    <p class="form__error">${note == "" ? "" : note}</p>
                    <form action="update-avatar" enctype="multipart/form-data" method="POST" class="form auth__form" id="sign-up-form">


                        <div class="form__group">
                            <label for="avatar" class="form__label">Avatar</label>
                            <input id="avatar" name="avatar" type="file" class="form__input" 
                                   accept="image/png, image/gif, image/jpeg" hidden >
                            <label for="avatar">
                                <%
                                    String url;
                                    String root = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                                    + request.getContextPath();
                                    String avatarURL= user.getAvatar();
                                    if (avatarURL != null) {
//                                        D:\Workspace\Java\Shopping\src\main\webapp\assets\img\avatar
                                        url = root + "/assets/img/avatar/" + avatarURL;
                                    } else url = "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png";
                                %>
                                <img
                                    id="preview"
                                    class="avatar-preview"
                                    src="<%=url%>"
                                    alt=""
                                    style="cursor: pointer"
                                    />
                            </label>
                            <span class="form__message"></span>
                        </div>  

                        <div class="form__group auth__btn-group">
                            <button class="btn btn--primary auth__btn form__submit-btn">Update</button>
                        </div>
                    </form>
                    <p class="auth__text">
                        <a href="Home" class="auth__link auth__text-link">Back to home page</a>
                    </p>
                </div>
            </div>
            <%} %>
        </main>
        <script>
                let avatar = document.querySelector("#preview");
                let file = document.querySelector("#avatar");
            function updateImg() {
                avatar.src = window.URL.createObjectURL(file.files[0]);
            }
            file.onchange = function () {
                updateImg();
            };
        </script>
        <script>
            window.dispatchEvent(new Event("template-loaded"));
        </script>
        <script src="./assets/js/validator.js"></script>
        <script>
            new Validator("#sign-up-form");
        </script>
        <script src="assets/js/theme.js" type="text/javascript"></script>
    </body>
</html>


