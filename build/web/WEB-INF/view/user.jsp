<%-- 
Document   : user
Created on : Oct 31, 2017, 3:25:08 PM
Author     : Strong man
--%>
<div id="idLogout">
    <form action="index.jsp">
        <input class="myButton" type="submit" value="Log out" />
    </form>
</div>
<div id="indexUser"  >
    <p class="tblheader" scope="col">User Information</p>
    <table style="width: 60%; color: green" cellpadding="7">
        <tbody>
            <tr>            
                <td>Name</td> <td> ${user.name}</td>
            </tr>
            <tr>
                <td>Address</td> <td> ${user.adress}</td> 
            </tr>
            <tr>
                <td>Email</td> <td> ${user.email}</td>
            </tr>
        </tbody>
    </table>
</div>
<br>
<div id="indexAccount">
    <p class="tblheader" scope="col">Accounts</p>
    <table style="width: 100%" cellpadding="7" >
        <tr>
            <th>Account Number</th>
            <th>Total Balance</th>
            <th>Open Date</th>
        </tr>
        <c:forEach var="account" items="${accounts}">
            <tr>
                <td> <a href="account?idAccount=${account.idAccount}"> ${account.idAccount}</a></td>
                <td>${account.balance}</td>
                <td>${account.date}</td>
            </tr>
        </c:forEach>
    </table>

</div>



