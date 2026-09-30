<!DOCTYPE html>
<html>
<head>
    <title>Chat Login</title>

    <style>
        body {
            font-family: Arial;
            background-color: #e8f5e9;
            text-align: center;
            padding-top: 100px;
        }

        .login-box {
            background-color: white;
            width: 350px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px gray;
        }

        input {
            width: 90%;
            padding: 12px;
            margin: 10px;
            box-sizing: border-box;
        }

        button {
            padding: 12px 30px;
            background-color: #2e7d32;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>

<body>

<div class="login-box">

    <h2>Simple Chatting System</h2>

    <form action="login" method="post">

        <input type="text"
               name="username"
               placeholder="Enter Username"
               required>

        <br>

        <button type="submit">Login</button>

    </form>

</div>

</body>
</html>