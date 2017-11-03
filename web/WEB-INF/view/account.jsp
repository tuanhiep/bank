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

<div id="indexUser">
    <p class="tblheader" scope="col">Account Information</p>
    <table style="width: 60%; color: green" cellpadding="7" >

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
            <tr>
                <td>Account</td> <td> ${account.idAccount}</td>
            </tr>
            <tr>
                <td>Balance</td> <td> ${account.balance}</td>
            </tr>
            <tr>
                <td>OverDraft</td> <td> 0 Euro</td>
            </tr>
        </tbody>
    </table>

</div>
<br>
<div id="returnUser">
    <form action="user" method="get">
        <input class="myButton" type="submit" name="submit" value="Return to list of accounts">
    </form>

</div>

<div id="indexTransaction">
    <p class="tblheader" scope="col">Transactions</p>
    <div id="idButton">
        <input class="myButton" type="button" onclick="printDiv('indexTransaction')" value="Printer" />
    </div>
    <table style="width: 100%"  cellpadding="7">
        <tr>
            <th>Transaction Number</th>
            <th>Amount</th>
            <th>Type </th>
            <th>Date</th>
            <th>Comment</th>
        </tr>
        <c:forEach var="transaction" items="${transactions}">
            <tr>

                <td>${transaction.idTransaction}</td>
                <td>${transaction.amount}</td>
                <td>${transaction.type}</td>
                <td>${transaction.date}</td>
                <td>${transaction.comment}</td>

            </tr>
        </c:forEach>

    </table>

</div>

<div id="doTransaction">
    <form action="confirmation" method="post">
        <input type="text" size="60" value="" name="amount">
        <select name="typeTransaction"   id="typeTransaction">
            <option value ="deposit">Deposit</option>
            <option value ="withdraw">Withdraw</option>
        </select>
        <input class="myButton" type="submit" name="submit" value="Realize">
    </form>

</div>
<script type="text/javascript">
    function printDiv(divName) {
        var printContents = document.getElementById(divName).innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;
    }
</script>