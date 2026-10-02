<!DOCTYPE html>
<html>
<head>

    <title>ChattingSystem1 - Login</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-box {
            width: 350px;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }

        h2 {
            text-align: center;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        input {
            width: 95%;
            padding: 10px;
            margin-top: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #333;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>

</head>

<body>

<div class="login-box">

    <h2>ChattingSystem1</h2>

    <form action="login" method="post">

        <label>User name</label>
        <input type="text" name="username" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button type="submit">Login</button>

    </form>

</div>

</body>
</html>