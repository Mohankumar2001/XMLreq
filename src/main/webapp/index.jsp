<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User details</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
        .invoker {
        	font-family: "Arial";
        	background: #56A5EC;
        	display: flex;
        	justify-content: center;
        	padding: 5px;
        	margin: 5px;
        }
        .content{
        	padding: 5px;
        	display: flex;
        	flex-direction: column;
        	justify-content: center;
        	margin: 5px;
        }
        .content div {
        	margin: 5px;
        }
            table, th, td {
                border: 1px solid white;
                border-collapse: collapse;
                font-family: "Arial";
            }
            table {
                margin-left: auto;
                margin-right: auto;
                margin-top: 100px;
            }
            th, td {
                background-color: seagreen;
                padding: 5px;
            }
            
            th {
                height: 50px;
            }
            
            td {
                text-align: center;
              }
        </style>
        <script>
            function sendInfo() {
                var url = "getData.jsp?user_id="+document.getElementById("user_id").value;
                if(window.XMLHttpRequest){  
                    request=new XMLHttpRequest();  
                }  
                else if(window.ActiveXObject){  
                    request=new ActiveXObject("Microsoft.XMLHTTP");  
                }  

                try{  
                    request.onreadystatechange=getInfo;  
                    request.open("GET",url,true);  
                    request.send();  
                }
                catch(e){
                    alert("Unable to connect to server");
                }
            }
            
            function getInfo() {
                if(request.readyState==4){
                    if(request.status == 200){
                        parseMessages(request.responseXML);
                    }
                    else{
                        alert("Something wrong");
                    }
                }
            }
            
            function parseMessages(responseXML){
                if(responseXML == null){
                    return false;
                }
                else{
                    var users = responseXML.getElementsByTagName("users")[0];
                    deleteRows();
                    if(users.childNodes.length > 0){
                        
                        var user = users.childNodes[0];
                        var Name = user.getElementsByTagName("name")[0];
                        var Email = user.getElementsByTagName("email")[0];
                        var userName = user.getElementsByTagName("username")[0];
                        appendTable(Name.childNodes[0].nodeValue, Email.childNodes[0].nodeValue, userName.childNodes[0].nodeValue);
                    }
                    
                }
            }
            
            
            function appendTable(Name, Email, userName){
                
                var table = document.getElementById("myTable");
                var nRows = table.rows.length;
                var row = table.insertRow(nRows);
                
                var cell0 = row.insertCell(0);
                var cell1 = row.insertCell(1);
                var cell2 = row.insertCell(2);
                
                cell0.innerHTML = Name;
                cell1.innerHTML = Email;
                cell2.innerHTML = userName;
            }
            
            
            function deleteRows(){
                var table = document.getElementById("myTable");
                var nRows = table.rows.length;
                if(nRows == 1){
                    return false;
                }
                for(var i=nRows-1; i>0; i--){
                    table.deleteRow(i);
                }
            }
        </script>
    </head>
    <body>
    <div class="invoker"><div class="content">
        <div>User id: <input type="text" id = "user_id" name = "user_id"/> </div>
        <div><button onclick="sendInfo()">Get user Details</button></div></div>
        </div>
        <table id="myTable" style="width:40%">
            <tr>
              <th>Name</td>
              <th>Email</td>
              <th>Username</td>
            </tr>
        </table>
    </body>
</html>
