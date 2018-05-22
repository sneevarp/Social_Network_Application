<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Friends Page</title>
<h1 id="hdr">Friends Page</h1> 
<br/>
<h1 id="fb-welcome"></h1>
<br/>
<table style="width:60%; border: 1px solid black">
  <tr>
    <th style="width:33%; border: 1px solid black"><a id="tweetLink">Tweeet</a></th>
    <th style="width:33%; border: 1px solid black"><a href="/friendspage">Friends Page</a></th> 
    <th style="width:33%; border: 1px solid black"><a href="/toptweets">Top Tweets</a></th>
  </tr>
</table>

</head>
<body id="body">
	<input type="hidden" id="sndName" name="sndName" value=">" >
	<!-- <img id="img" src="" alt="HTML5 Icon" width="64" height="64"> -->
	<br>

	 <script>
		//console.log('${usertweetsCount}');
		 var usertweets = '${usertweets}';
		//console.log(usertweets);
		usertweetsArray = usertweets.split("-----")
		for (var i = 0; i < usertweetsArray.length-1; i++) {
			//console.log(usertweetsArray[i]);
			//console.log(document.getElementById('tt').innerHTML);
			//document.getElementById('tt').innerHTML = document.getElementById('tt').innerHTML +usertweets[i].split('--')[0]+'  =====>  '+usertweets[i].split('--')[1]+'<br>';
		} 
		
	 window.fbAsyncInit = function() {
			FB.init({
				appId : '835773313238911',
				xfbml : true,
				version : 'v2.9'
			});

			function onLogin(response) {
				if (response.status == 'connected') {
					FB.api('/me?fields=first_name,last_name,picture', function(data) {
					    //console.log(data);
						//console.log(data.first_name + " " + data.last_name);
					    //console.log(data.picture.data.url);
					    //document.getElementById('img').src= data.picture.data.url
					    //console.log(document.getElementById('img').src);
					    var image = document.createElement("img");
					    var imageParent = document.getElementById("body");
					    image.id = "Owner Image";
					    image.className = "class";
					    image.src = data.picture.data.url;
					    imageParent.appendChild(image);
					    
					    var t = document.createTextNode(" " + data.first_name + " " + data.last_name);
					    imageParent.appendChild(t);
					    
					    linebreak = document.createElement("br");
					    imageParent.appendChild(linebreak);
					    
					    if (usertweets.includes(data.first_name + " " + data.last_name)) {
							for (var i = 0; i < usertweetsArray.length-1; i++) {
								if (usertweetsArray[i].includes(data.first_name + " " + data.last_name)){
									var a = document.createElement('a');
									var msg = document.createTextNode(usertweetsArray[i].split("--")[2]);
								    msg.textIndent="100px";
									a.appendChild(msg)
									a.title = msg;
									a.href = "https://1-dot-tweeterproject-167702.appspot.com/display_tweet?id="+usertweetsArray[i].split("--")[0];
									a.target="_blank";
									imageParent.appendChild(document.createTextNode( '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0' ));
								    imageParent.appendChild(a);
								    lb = document.createElement("br");
								    imageParent.appendChild(lb);
								}
							} 
						    lb = document.createElement("br");
						    imageParent.appendChild(lb);
					    }
					    
						var welcomeBlock = document.getElementById('fb-welcome');
						welcomeBlock.innerHTML = 'Hello, ' + data.first_name+' '+ data.last_name + '!'+'<br/>'+"Welcome to the Application";
					    document.getElementById("tweetLink").href="/tweet?sndName="+data.first_name+' '+ data.last_name; 
						var sndName= document.getElementById("sndName")
						if (sndName){
							console.log('The sender is ok ');
							sndName.value = data.first_name+' '+ data.last_name
						}else{
							console.log('The sender is ok ');
						}
					});

					FB.api('/me/friends?fields=first_name,last_name,picture', function(data){
					    //console.log(data);
					    
					    for (var i in data.data) {
						    //console.log(data.data[i].first_name + " " + data.data[i].last_name);
						    //console.log(data.data[i].picture.data.url);
						    
						    var image = document.createElement("img");
						    var imageParent = document.getElementById("body");
						    image.id = "id"+i;
						    image.className = "class";
						    image.src = data.data[i].picture.data.url;
						    imageParent.appendChild(image);
						    
						    var t = document.createTextNode(" " + data.data[i].first_name + " " + data.data[i].last_name);    
						    imageParent.appendChild(t);

						    linebreak = document.createElement("br");
						    imageParent.appendChild(linebreak);
						    
						    if (usertweets.includes(data.data[i].first_name + " " + data.data[i].last_name)) {
								for (var k = 0; k < usertweetsArray.length-1; k++) {
									if (usertweetsArray[k].includes(data.data[i].first_name + " " + data.data[i].last_name)){
										var a = document.createElement('a');
									    var msg = document.createTextNode(usertweetsArray[k].split("--")[2]);
									    msg.textIndent="100px";
										a.appendChild(msg)
										a.title = msg;
										a.href = "https://1-dot-tweeterproject-167702.appspot.com/display_tweet?id="+usertweetsArray[k].split("--")[0];
										a.target="_blank";
										imageParent.appendChild(document.createTextNode( '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0' ));
									    imageParent.appendChild(a);
									    lb = document.createElement("br");
									    imageParent.appendChild(lb);
									}
								} 
							    lb = document.createElement("br");
							    imageParent.appendChild(lb);
						    }

				        }
					    
					}, {scope: 'user_friends'});
					
					
				} else {
					var welcomeBlock = document.getElementById('fb-welcome');
					welcomeBlock.innerHTML = 'Cant get data ' + response.status + '!';
				}
			}

			FB.getLoginStatus(function(response) {
				// Check login status on load, and if the user is
				// already logged in, go directly to the welcome message.
				console.log('getLoginStatus .... ');

				if (response.status == 'connected') {
					console.log('connected .... ');
					onLogin(response);
				} else {
					// Otherwise, show Login dialog first.
					console.log('Not connected .... ');
					FB.login(function(response) {
						onLogin(response);
					}, {
						scope : 'user_friends, email, user_birthday'
					});
				}
			});

			console.log('logPageView .... ');
			FB.AppEvents.logPageView();

		};

		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));

	</script>
</body>
</html>