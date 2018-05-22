<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Tweeter Project Home page</title>
<h1 id="hdr">Tweeter Project Home page</h1> 
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
<body>
	 <script>
     	 window.fbAsyncInit = function() {
			FB.init({
				appId : '835773313238911',
				xfbml : true,
				version : 'v2.9'
			});

			function onLogin(response) {
				if (response.status == 'connected') {
					FB.api('/me?fields=first_name,last_name', function(data) {
						var welcomeBlock = document.getElementById('fb-welcome');
						welcomeBlock.innerHTML = 'Hello, ' + data.first_name+' '+ data.last_name + '!'+'<br/>'+"Welcome to the Application";
						
					    document.getElementById("tweetLink").href="/tweet?sndName="+data.first_name+' '+ data.last_name; 
					});

					/* FB.api('/me?fields=last_name', function(data) {
						var welcomeBlock = document
								.getElementById('fb-welcome');
						welcomeBlock.innerHTML = welcomeBlock.innerHTML
								+ '  last name= ' + data.last_name + '!';
					}); */

					/* FB.api('/me?fields=birthday', function(data) {
						var welcomeBlock = document
								.getElementById('fb-welcome');
						welcomeBlock.innerHTML = welcomeBlock.innerHTML
								+ '  Your Age is , '
								+ (2017 - parseInt(data.birthday.toString()
										.substring(6, 10))).toString() + '!';
					}); */

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


	 <!-- <div class="fb-like" data-share="true" data-width="450"	data-show-faces="true"></div> -->

</body>
</html>