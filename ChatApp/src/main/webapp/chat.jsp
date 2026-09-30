<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>
    <title>Simple Chatting System</title>

    <style>
        body {
            font-family: Arial;
            background: #f1f8e9;
        }

        .chat-container {
            width: 600px;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px gray;
        }

        h2 {
            color: #2e7d32;
        }

        #chatBox {
            height: 350px;
            border: 1px solid #ccc;
            margin: 15px 0;
            padding: 10px;
            overflow-y: auto;
        }

        .message {
            background: #e8f5e9;
            padding: 10px;
            margin: 8px;
            border-radius: 5px;
        }

        .message span {
            color: gray;
            font-size: 12px;
            margin-left: 10px;
        }

        input {
            padding: 10px;
            margin: 5px;
        }

        #receiver {
            width: 200px;
        }

        #message {
            width: 350px;
        }

        button {
            padding: 10px 20px;
            background: #2e7d32;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>

<body>

<div class="chat-container">

    <h2>Simple Chatting System</h2>

    <p>
        Logged in as:
        <b><%= username %></b>
    </p>

    <input type="text"
           id="receiver"
           placeholder="Enter receiver username">

    <button onclick="openChat()">Open Chat</button>

    <div id="chatBox">
        <p>Select a user to start chatting.</p>
    </div>

    <input type="text"
           id="message"
           placeholder="Type your message">

    <button onclick="sendMessage()">Send</button>

</div>


<script>

function openChat() {

    var receiver =
        document.getElementById("receiver").value.trim();

    if (receiver === "") {
        alert("Enter receiver username");
        return;
    }

    loadMessages();
}


function sendMessage() {

    var receiver =
        document.getElementById("receiver").value.trim();

    var message =
        document.getElementById("message").value.trim();

    if (receiver === "") {
        alert("Enter receiver username");
        return;
    }

    if (message === "") {
        alert("Enter a message");
        return;
    }

    var xhr = new XMLHttpRequest();

    xhr.open("POST", "chat", true);

    xhr.setRequestHeader(
        "Content-Type",
        "application/x-www-form-urlencoded"
    );

    xhr.onreadystatechange = function() {

        if (xhr.readyState === 4) {

            if (xhr.status === 200) {

                document.getElementById("message").value = "";

                loadMessages();

            } else {

                alert("Message could not be sent.");

            }
        }
    };

    xhr.send(
        "receiver=" + encodeURIComponent(receiver) +
        "&message=" + encodeURIComponent(message)
    );
}


function loadMessages() {

    var receiver =
        document.getElementById("receiver").value.trim();

    if (receiver === "") {
        return;
    }

    var xhr = new XMLHttpRequest();

    xhr.open(
        "GET",
        "chat?receiver=" + encodeURIComponent(receiver),
        true
    );

    xhr.onreadystatechange = function() {

        if (xhr.readyState === 4 &&
            xhr.status === 200) {

            document.getElementById("chatBox").innerHTML =
                xhr.responseText;

            var box =
                document.getElementById("chatBox");

            box.scrollTop = box.scrollHeight;
        }
    };

    xhr.send();
}


// Check for new messages every 1 second

setInterval(function() {

    var receiver =
        document.getElementById("receiver").value.trim();

    if (receiver !== "") {
        loadMessages();
    }

}, 1000);

</script>

</body>

</html>