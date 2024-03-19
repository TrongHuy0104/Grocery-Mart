<%-- 
    Document   : sign-up
    Created on : Nov 18, 2023, 9:25:57 PM
    Author     : Trong Huy
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sign Up | Grocery Mart</title>
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
            .auth__form {
                margin-top: 0;
            }

            .sign-up-content-inner {
                margin: 0;
                width: auto;
            }

            .form__group {
                text-align: left;
            }

            .form__group--inline {
                flex-direction: column;
                align-items: unset;
            }

            .form__title {
                font-size: 2.4rem;
                font-weight: 600;
                margin: 40px 0 20px;
                text-align: left;
            }

            .gender-container {
                display: flex;
                align-items: center;
                justify-content: space-around;
                margin: 20px 0;
            }

            .gender-group {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 1.8rem;
                font-weight: 500;
            }

            .form__error {
                font-size: 1.6rem;
                color: red;
                margin-top: 20px;
                font-weight: 500;
                align-self: flex-start;
                margin-left: 15px;
            }
        </style>
    </head>
    <body>
        <!-- Main -->
        <main class="auth container">

            <!-- Auth Content -->
            <div id="auth-content" class="auth__content">
                <div class="auth__content-inner sign-up-content-inner">
                    <!-- Logo -->
                    <a href="Home" class="logo">
                        <img src="./assets/icons/logo.svg" alt="grocerymart" class="logo__img top-bar__logo-img" />
                        <h2 class="logo__title top-bar__logo-title">grocerymart</h2>
                    </a>
                    <h1 class="auth__heading">Sign Up</h1>
                    <p class="auth__desc">Let’s create your account and Shop like a pro and save money.</p>
                    <p class="form__error">${error == "" ? "" : error}</p>
                    <form
                        action="user"
                        method="POST"
                        class="form auth__form row row-cols-2 row-cols-md-1 gx-5 gx-sm-0"
                        id="sign-up-form"
                        >

                        <input type="hidden" name="action" value="sign-up"/>
                        <div class="col">
                            <p class="form__title">Account</p>
                            <div class="form__group">
                                <div class="form__text-input">
                                    <input
                                        type="text"
                                        placeholder="Username"
                                        class="form__input"
                                        name="username"
                                        value="${username != null ? username : ""}"
                                        rules="required|minLength:2"
                                        />
                                    <svg  class="icon form__input-icon" xmlns="http://www.w3.org/2000/svg" height="1.4em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M304 128a80 80 0 1 0 -160 0 80 80 0 1 0 160 0zM96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM49.3 464H398.7c-8.9-63.3-63.3-112-129-112H178.3c-65.7 0-120.1 48.7-129 112zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3z"/></svg>
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group">
                                <div class="form__text-input">
                                    <input
                                        id="password"
                                        type="password"
                                        placeholder="Password"
                                        class="form__input"
                                        name="password"
                                        rules="required|minLength:6"
                                        />
                                    <img
                                        src="./assets/icons/eye.svg"
                                        alt=""
                                        class="form__input-icon"
                                        id="togglePassword"
                                        />
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group">
                                <div class="form__text-input">
                                    <input
                                        id="password_confirmation"
                                        type="password"
                                        placeholder="Confirm password"
                                        class="form__input"
                                        name="password_confirmation"
                                        rules="required|confirm:#password"
                                        />
                                    <img
                                        src="./assets/icons/eye.svg"
                                        alt=""
                                        class="form__input-icon"
                                        id="togglePasswordConfirm"
                                        />
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <p class="form__title">User Information</p>
                            <div class="form__group">
                                <div class="form__text-input">
                                    <input
                                        type="text"
                                        placeholder="Name"
                                        class="form__input"
                                        name="name"
                                        value="${name != null ? name : ""}"
                                        rules="required"
                                        />
                                    <svg class="icon form__input-icon" xmlns="http://www.w3.org/2000/svg" height="1.4em" viewBox="0 0 640 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M192 128c0-17.7 14.3-32 32-32s32 14.3 32 32v7.8c0 27.7-2.4 55.3-7.1 82.5l-84.4 25.3c-40.6 12.2-68.4 49.6-68.4 92v71.9c0 40 32.5 72.5 72.5 72.5c26 0 50-13.9 62.9-36.5l13.9-24.3c26.8-47 46.5-97.7 58.4-150.5l94.4-28.3-12.5 37.5c-3.3 9.8-1.6 20.5 4.4 28.8s15.7 13.3 26 13.3H544c17.7 0 32-14.3 32-32s-14.3-32-32-32H460.4l18-53.9c3.8-11.3 .9-23.8-7.4-32.4s-20.7-11.8-32.2-8.4L316.4 198.1c2.4-20.7 3.6-41.4 3.6-62.3V128c0-53-43-96-96-96s-96 43-96 96v32c0 17.7 14.3 32 32 32s32-14.3 32-32V128zm-9.2 177l49-14.7c-10.4 33.8-24.5 66.4-42.1 97.2l-13.9 24.3c-1.5 2.6-4.3 4.3-7.4 4.3c-4.7 0-8.5-3.8-8.5-8.5V335.6c0-14.1 9.3-26.6 22.8-30.7zM24 368c-13.3 0-24 10.7-24 24s10.7 24 24 24H64.3c-.2-2.8-.3-5.6-.3-8.5V368H24zm592 48c13.3 0 24-10.7 24-24s-10.7-24-24-24H305.9c-6.7 16.3-14.2 32.3-22.3 48H616z"/></svg>
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group">
                                <label for="gender" class="form__label">Gender</label>
                                <div class="gender-container">
                                    <div class="gender-group">

                                        <label class="radio" for="male">
                                            <input
                                                name="gender"
                                                type="radio"
                                                rules="required"
                                                value="male"
                                                ${gender == "male" ? "checked" : ""}
                                                class="form__input"
                                                id="male"
                                                />
                                            Male
                                        </label>
                                    </div>
                                    <div class="gender-group">
                                        <label class="radio" for="female">
                                            <input
                                                name="gender"
                                                type="radio"
                                                rules="required"
                                                value="female"
                                                ${gender == "female" ? "checked" : ""}
                                                class="form__input"
                                                id="female"
                                                />
                                            Female
                                        </label>
                                    </div>
                                    <div class="gender-group">
                                        <label class="radio" for="other">
                                            <input
                                                name="gender"
                                                type="radio"
                                                rules="required"
                                                value="other"
                                                ${gender == "other" ? "checked" : ""}
                                                class="form__input"
                                                id="other"
                                                />
                                            Other
                                        </label>
                                    </div>
                                </div>
                                <span class="form__message"></span>
                            </div>
                        </div>
                        <div class="col">
                            <p class="form__title">Address</p>
                            <div class="form__group">
                                <div class="form__text-input">
                                    <input
                                        type="text"
                                        placeholder="Address"
                                        class="form__input"
                                        name="address"
                                        value="${address != null ? address : ""}"
                                        rules="required"
                                        />
                                    <svg  class="form__input-icon icon"  xmlns="http://www.w3.org/2000/svg" height="1.4em" viewBox="0 0 384 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M215.7 499.2C267 435 384 279.4 384 192C384 86 298 0 192 0S0 86 0 192c0 87.4 117 243 168.3 307.2c12.3 15.3 35.1 15.3 47.4 0zM192 128a64 64 0 1 1 0 128 64 64 0 1 1 0-128z"/></svg>
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group">
                                <div class="form__text-input">
                                    <input
                                        type="text"
                                        placeholder="Delivery Address"
                                        class="form__input"
                                        name="delivery-address"
                                        value="${delivery-Adress != null ? deliveryAddress : ""}"
                                        rules="required"
                                        /><svg  class="form__input-icon icon"  xmlns="http://www.w3.org/2000/svg" height="1.4em" viewBox="0 0 384 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M215.7 499.2C267 435 384 279.4 384 192C384 86 298 0 192 0S0 86 0 192c0 87.4 117 243 168.3 307.2c12.3 15.3 35.1 15.3 47.4 0zM192 128a64 64 0 1 1 0 128 64 64 0 1 1 0-128z"/></svg>
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group">
                                <div class="form__text-input">
                                    <input
                                        type="text"
                                        placeholder="Phone number"
                                        class="form__input"
                                        name="phone"
                                        value="${phone != null ? phone : ""}"
                                        rules="required|phone"
                                        />
                                    <svg class="form__input-icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M164.9 24.6c-7.7-18.6-28-28.5-47.4-23.2l-88 24C12.1 30.2 0 46 0 64C0 311.4 200.6 512 448 512c18 0 33.8-12.1 38.6-29.5l24-88c5.3-19.4-4.6-39.7-23.2-47.4l-96-40c-16.3-6.8-35.2-2.1-46.3 11.6L304.7 368C234.3 334.7 177.3 277.7 144 207.3L193.3 167c13.7-11.2 18.4-30 11.6-46.3l-40-96z"/></svg>

                                    <!--<img src="./assets/icons/letter.svg" alt="" class="form__input-icon" />-->
                                </div>
                                <span class="form__message"></span>
                            </div>

                            <div class="form__group">
                                <div class="form__text-input">
                                    <input
                                        type="email"
                                        placeholder="Email"
                                        class="form__input"
                                        name="email"
                                        value="${email != null ? email : ""}"
                                        rules="required|email"
                                        />
                                    <svg class="icon form__input-icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M48 64C21.5 64 0 85.5 0 112c0 15.1 7.1 29.3 19.2 38.4L236.8 313.6c11.4 8.5 27 8.5 38.4 0L492.8 150.4c12.1-9.1 19.2-23.3 19.2-38.4c0-26.5-21.5-48-48-48H48zM0 176V384c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V176L294.4 339.2c-22.8 17.1-54 17.1-76.8 0L0 176z"/></svg>
                                    <!--<svg class="form__input-icon icon" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512">! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. <path d="M164.9 24.6c-7.7-18.6-28-28.5-47.4-23.2l-88 24C12.1 30.2 0 46 0 64C0 311.4 200.6 512 448 512c18 0 33.8-12.1 38.6-29.5l24-88c5.3-19.4-4.6-39.7-23.2-47.4l-96-40c-16.3-6.8-35.2-2.1-46.3 11.6L304.7 368C234.3 334.7 177.3 277.7 144 207.3L193.3 167c13.7-11.2 18.4-30 11.6-46.3l-40-96z"/></svg>-->
                                </div>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group form__group--inline">
                                <label class="form__checkbox">
                                    <input type="checkbox" name="policy" value="true" 

                                           ${policy != null ? "checked" : ""}
                                           rules="required" id="" class="form__checkbox-input d-none" />
                                    <span class="form__checkbox-label">Accept all our policies</span>
                                </label>
                                <span class="form__message"></span>
                            </div>
                            <div class="form__group auth__btn-group">
                                <button class="btn btn--primary auth__btn form__submit-btn">Sign Up</button>
                            </div>
                        </div>
                    </form>
                    <p class="auth__text">
                        You have an account yet?
                        <a href="./sign-in.jsp" class="auth__link auth__text-link">Sign In</a>
                    </p>
                </div>
            </div>
        </main>
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