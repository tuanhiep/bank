<%-- 
    Document   : confirmation
    Created on : Oct 31, 2017, 10:16:29 AM
    Author     : Strong man
--%>
<div id="idLogout">
    <form action="index.jsp">
        <input class="myButton" type="submit" value="Log out" />
    </form>
</div>
<div id="indexForecast">
    <p class="tblheader" scope="col">Operation</p>
    <table style="width: 60%; color: green" cellpadding="7" >
        <tbody>
            <tr >
                <td>Account </td> <td>${account.idAccount}</td> 
            </tr>
            <tr > 
                <td>Operation </td> <td>${typeTransaction}</td>
            </tr>
            <tr >
                <td>Amount</td> <td>${amount} </td>
            </tr>
            <tr >
                <td>Actual Balance </td> <td> ${account.balance}</td>
            </tr>
            <tr>
                <td>OverDraft</td> <td> 0 Euro</td>
            </tr>
            <tr >
                <td>Forecast balance </td> <td>${nextBalance}</td>
            </tr>

        </tbody>
    </table>
</div>        
<div id="confirm">
    <table>
        <tbody>
            <tr>
        <form action="account" method="post">
            <input type="hidden" size="60" value="Return" name="decision">
            <input class="myButton" type="submit" name="submit" value="Cancel">
        </form>
        <span style="display:inline-block; width: 10px;"></span>
        <form action="account" method="post">
            <input type="hidden" size="60" value="Confirm" name="decision">
            <input class="myButton" type="submit" name="submit" value="Confirm">
        </form>
        </tr>
        </tbody>
    </table>
</div>

