<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Display Tweet</title>
<h1 id="hdr">Display Tweet page</h1> 
<br/>
<br/>
</head>
<body>
	<input type="hidden" id="sndName" name="sndName" value=">" >
	<p>Tweet id:</p>
	<p id="ID"></p>
	<br>
	<p>Tweet sender:</p>
	<p id="sender"></p>
	<br>
	<p>Tweet Message:</p>
	<p id="msg"></p>
	<br>
	<p>Tweet Date:</p>
	<p id="msgDate"></p>
	<br>
	<p>Tweet visited:</p>
	<p id="visited"></p>
	<br>

	 <script>
	 //console.log("Record Count = "+'${rCount}');
	 document.getElementById("ID").innerHTML='${ID}'
	 document.getElementById("sender").innerHTML='${sender}'
	 document.getElementById("msg").innerHTML='${msg}'
	 document.getElementById("msgDate").innerHTML='${msgDate}'
	 document.getElementById("visited").innerHTML='${visited}'
	</script>
</body>
</html>