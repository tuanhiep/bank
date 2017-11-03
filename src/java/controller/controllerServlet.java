/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import entity.Transaction;
import entity.User;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import session.AccountFacade;
import session.TransactionFacade;
import session.UserFacade;

/**
 *
 * @author Strong man
 */
@WebServlet(
        name = "controllerServlet",
        loadOnStartup = 1,
        urlPatterns = {
            "/user",
            "/account",
            "/confirmation"}
)
public class controllerServlet extends HttpServlet {

    public static final double OVERDRAFT = 0;
    @EJB
    private UserFacade userFacade;
    @EJB
    private AccountFacade accountFacade;
    @EJB
    private TransactionFacade transactionFacade;

    @Override
    public void init() throws ServletException {
        getServletContext().setAttribute("users", userFacade.findAll());
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        String userPath = request.getServletPath();

        switch (userPath) {
            case "/account":
                int idAccount = Integer.parseInt(request.getParameter("idAccount"));
                Account account = accountFacade.find(idAccount);
                if (account != null) {
                    request.getSession().setAttribute("account", account);
                    request.getSession().setAttribute("transactions", account.getTransactionCollection());
                }
                break;
            case "/confirmation":
                break;
        }
        // use RequestDispatcher to forward request internally
        String url = "/WEB-INF/view" + userPath + ".jsp";

        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        String userPath = request.getServletPath();
        Account account = (Account) request.getSession().getAttribute("account");
        switch (userPath) {
            case "/user":
                List<User> users = (List<User>) getServletContext().getAttribute("users");
                if (users != null) {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    User presentUser = null;
                    for (User u : users) {

                        if (u.getName().equals(username) && u.getPassword().equals(password)) {
                            presentUser = u;
                            request.getSession().setAttribute("user", u);
                        }

                    }
                    if (presentUser != null) {
                        request.getSession().setAttribute("accounts", presentUser.getAccountCollection());
                    } else {
                        request.getSession().invalidate();   // terminate session
                        userPath = "/error";
                    }
                } else {
                    request.getSession().invalidate();   // terminate session
                    userPath = "/error";
                }
                break;
            case "/confirmation":
                String amountPara = request.getParameter("amount");
                String typeTransactionPara = request.getParameter("typeTransaction");
                request.getSession().setAttribute("typeTransaction", typeTransactionPara);
                request.getSession().setAttribute("amount", amountPara);
                double nextBalance = account.getBalance();
                try {
                    nextBalance = forecastBalance(typeTransactionPara, Double.parseDouble(amountPara), account.getBalance());
                } catch (Exception ex) {
                    Logger.getLogger(controllerServlet.class.getName()).log(Level.SEVERE, null, ex);
                    userPath = "/warning";
                }
                request.getSession().setAttribute("nextBalance", nextBalance);
                break;
            case "/account":
                String amount = (String) request.getSession().getAttribute("amount");
                String typeTransation = (String) request.getSession().getAttribute("typeTransaction");
                String decision = request.getParameter("decision");
                if ("Confirm".equals(decision)) {
                    Account updatedAccount = null;
                    switch (typeTransation) {
                        case "deposit":
                            updatedAccount = deposit(account, Double.parseDouble(amount));
                            break;
                        case "withdraw":
                            updatedAccount = withdraw(account, Double.parseDouble(amount));
                            if (updatedAccount == null) {
                                userPath = "/warning";
                            }
                            break;
                    }
                    if (updatedAccount != null) {
                        request.getSession().setAttribute("account", updatedAccount);
                        request.getSession().setAttribute("transactions", updatedAccount.getTransactionCollection());
                    }
                }
                break;
        }
        // use RequestDispatcher to forward request internally
        String url = "/WEB-INF/view" + userPath + ".jsp";
        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private double forecastBalance(String typeTransaction, double amount, double actualBalance) throws Exception {

        double forecaseBalance = actualBalance;
        switch (typeTransaction) {
            case "deposit":
                forecaseBalance = actualBalance + amount;
                break;
            case "withdraw":
                forecaseBalance = actualBalance - amount;
                break;
            default:
                throw new Exception("Operation is denied !");
        }
        return forecaseBalance;
    }

    private Account deposit(Account account, double amount) {

        double actual = account.getBalance();
        account.setBalance(actual + amount);
        try {

            Transaction operation = new Transaction();
            operation.setAmount(amount);
            operation.setDate(new Date());
            operation.setIdAccount(account);
            operation.setType("deposit");
            operation.setComment("deposit " + String.valueOf(amount));
            transactionFacade.create(operation);
            account.getTransactionCollection().add(operation);
            accountFacade.edit(account);
            return account;
        } catch (Exception e) {
            return null;
        }

    }

    private Account withdraw(Account account, double amount) {
        double actual = account.getBalance();
        double nextBalance = actual - amount;
        if (nextBalance > OVERDRAFT) {

            account.setBalance(nextBalance);
            try {

                Transaction operation = new Transaction();
                operation.setAmount(amount);
                operation.setDate(new Date());
                operation.setIdAccount(account);
                operation.setType("withdraw");
                operation.setComment("withdraw " + String.valueOf(amount));
                transactionFacade.create(operation);
                account.getTransactionCollection().add(operation);
                accountFacade.edit(account);
                return account;
            } catch (Exception e) {
                return null;
            }
        }
        return null;

    }

}
