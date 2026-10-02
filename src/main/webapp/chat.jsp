<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession(false);

    String loggedInUser = "";

    if (sessionUser != null) {
        loggedInUser = (String) sessionUser.getAttribute("username");
    }

    if (loggedInUser == null || loggedInUser.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <title>ChattingSystem1</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 30px;
        }

        .chat-container {
            width: 500px;
            margin: auto;
            background-color: white;
            padding: 25px;
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
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #333;
            color: white;
            border: none;
            cursor: pointer;
        }

        #chatBox {
            margin-top: 20px;
            padding: 15px;
            min-height: 150px;
            border: 1px solid #ccc;
            background-color: #fafafa;
        }

        .logout {
            display: block;
            text-align: right;
            margin-bottom: 15px;
            color: red;
            text-decoration: none;
            font-weight: bold;
        }

    </style>

</head>

<body>

<div class="chat-container">

    <a href="logout" class="logout">Logout</a>

    <h2>Simple ChattingSystem1</h2>

    <label>Sender:</label>

    <input type="text"
           id="sender"
           value="<%= loggedInUser %>"
           readonly>

    <label>Receiver:</label>

    <input type="text"
           id="receiver"
           placeholder="Enter username">

    <label>Message:</label>

    <input type="text"
           id="message"
           placeholder="Type your message">

    <button onclick="sendMessage()">Send</button>

    <h3>Chat Messages</h3>

    <div id="chatBox">
        No messages yet.
    </div>

</div>


<script>

function sendMessage() {

    var sender = document.getElementById("sender").value;
    var receiver = document.getElementById("receiver").value;
    var message = document.getElementById("message").value;

    if (sender == "" || receiver == "" || message == "") {

        alert("Please enter all fields");
        return;
    }

    var xhr = new XMLHttpRequest();

    xhr.open("POST", "message", true);

    xhr.setRequestHeader(
        "Content-Type",
        "application/x-www-form-urlencoded"
    );

    xhr.onload = function() {

        if (xhr.status == 200) {

            document.getElementById("message").value = "";

            loadMessages();
        }
    };

    xhr.send(
        "sender=" + encodeURIComponent(sender) +
        "&receiver=" + encodeURIComponent(receiver) +
        "&message=" + encodeURIComponent(message)
    );
}


function loadMessages() {

    var sender = document.getElementById("sender").value;
    var receiver = document.getElementById("receiver").value;

    if (sender == "" || receiver == "") {
        return;
    }

    var xhr = new XMLHttpRequest();

    xhr.open(
        "GET",
        "message?sender=" + encodeURIComponent(sender) +
        "&receiver=" + encodeURIComponent(receiver),
        true
    );

    xhr.onload = function() {

        if (xhr.status == 200) {

            document.getElementById("chatBox").innerHTML =
                xhr.responseText;
        }
    };

    xhr.send();
}


/* Set receiver when page opens */

window.onload = function() {

    var loggedInUser =
        document.getElementById("sender").value;

    if (loggedInUser == "user1") {

        document.getElementById("receiver").value = "user2";

    } else if (loggedInUser == "user2") {

        document.getElementById("receiver").value = "user1";
    }

    loadMessages();
};

</script>

</body>
</html>