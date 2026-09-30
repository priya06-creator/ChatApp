package com.chat;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {

    static List<Message> messages = new ArrayList<>();

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String sender = (String) session.getAttribute("username");
        String receiver = request.getParameter("receiver");
        String message = request.getParameter("message");

        if (sender != null && receiver != null && message != null
                && !message.trim().isEmpty()) {

            String time = new SimpleDateFormat("HH:mm:ss")
                    .format(new Date());

            messages.add(new Message(
                    sender,
                    receiver,
                    message,
                    time
            ));
        }

        response.setContentType("text/plain");
        response.getWriter().print("Message Sent");
    }

    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("username");
        String receiver = request.getParameter("receiver");

        response.setContentType("text/html");

        StringBuilder result = new StringBuilder();

        for (Message m : messages) {

            if ((m.sender.equals(username)
                    && m.receiver.equals(receiver))
                    ||
                (m.sender.equals(receiver)
                    && m.receiver.equals(username))) {

                result.append("<div class='message'>");

                result.append("<b>")
                      .append(m.sender)
                      .append("</b>: ");

                result.append(m.message);

                result.append("<span>")
                      .append(m.time)
                      .append("</span>");

                result.append("</div>");
            }
        }

        response.getWriter().print(result.toString());
    }


    static class Message {

        String sender;
        String receiver;
        String message;
        String time;

        Message(String sender,
                String receiver,
                String message,
                String time) {

            this.sender = sender;
            this.receiver = receiver;
            this.message = message;
            this.time = time;
        }
    }
}