package com.zaidsoft.webmail;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zaidsoft.webmail.*;
import com.google.gson.*;

/**
 * Servlet implementation class ConListGenerator
 */
/*@WebServlet(description = "generates contact list and serve it to user using ajax(json)", urlPatterns = { "/ConListGenerator" })*/
public class ConListGenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConListGenerator() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		System.out.println("----------Inside doGet of conlistgenerator servlet ---------------");
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("----------Inside doPost of conlistgenerator servlet ---------------");
		HttpSession sess = request.getSession(true);
		List<String> mycontacts = new ArrayList<String>();
		IMAPBean imb = new IMAPBean();
		imb = (IMAPBean) sess.getAttribute("imapConList");
		try {
			mycontacts=imb.buildSentContacts();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(mycontacts.toString());
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(new Gson().toJson(mycontacts)); 		
	}

}
