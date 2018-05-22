<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Tweeter Project Home page</title>
<h1 id="hdr">Tweeter Project Home page</h1> 
<br/>
<img id="img" src="">
<h1 id="fb-welcome"></h1>
<table style="width:60%; border: 1px solid black">
  <tr>
    <th style="width:33%; border: 1px solid black"><a href="/tweet">Tweeet</a></th>
    <th style="width:33%; border: 1px solid black"><a href="/friendspage">Friends Page</a></th> 
    <th style="width:33%; border: 1px solid black"><a href="/toptweets">Top Tweets</a></th>
  </tr>
</table>

</head>
<body>
	<br>
	<form action="tweet" method="post">
	<p>Type your tweet here:</p>
	<input type="text" value="" name="my_text" style="width:60%;">
	<input type="hidden" id="sndName" name="sndName" value=">" >
	<br>
	<br>
	<input type="submit" value="Save Tweet" style="width:200px;">
	<br>
	<br>
	</form>
	<p id="confirmText"></p>
	
	<select name="myselect" id="myselect" size="5">  
	</select>
	<br>
	<br>
	<input type="button" value="Display full tweet info" id="my_btn3"  onclick="showTweet();" style="width:200px;" />
	<br>
	<br>
	<input type="button" value="Post to Timeline" id="my_btn"  onclick="postToTimeLine();" style="width:200px;" />
	<br>
	<br>
	<input type="button" value="Send Message to friend(s)" id="my_btn2"  onclick="SendtofbMessageFriend();" style="width:200px;" />


	 <script>
	 	//var lnk = '${testsndName}';
		//console.log(lnk);
		//var usertweetsCount = '${usertweetsCount}';
		//console.log(usertweetsCount);
		var usertweets = '${usertweets}';
		//console.log(usertweets);
		var myselect = document.getElementById('myselect');
		usertweets = usertweets.split("-----")
		for (var i = 0; i < usertweets.length-1; i++) {
			//console.log(usertweets[i]);
			var opt = document.createElement('option');
		    opt.value = usertweets[i].split('--')[0];
		    opt.innerHTML = usertweets[i].split('--')[1];
		    myselect.appendChild(opt);
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
						var welcomeBlock = document.getElementById('fb-welcome');
						welcomeBlock.innerHTML = 'Hello, ' + data.first_name+' '+ data.last_name + '!'+'<br/>'+"Welcome to the Application";
						var sndName= document.getElementById("sndName")
						if (sndName){
							console.log('The sender is ok ');
							sndName.value = data.first_name+' '+ data.last_name
						}else{
							console.log('The sender is ok ');
						}
						
					    var image = document.getElementById("img");
					    image.className = "class";
					    image.src = data.picture.data.url;

					});

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
						scope : 'user_friends, email, user_birthday'});
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
		
		
		function postToTimeLine() {
			console.log('Posting to TimeLine ');

			var mt = myselect.options[myselect.selectedIndex].innerHTML;
			var lnk = 'https://1-dot-tweeterproject-167702.appspot.com/display_tweet?id=' + myselect.options[myselect.selectedIndex].value ;

			FB.login(function() {
						FB.api('/me/feed', 'post', {
							message : lnk
						});
						document.getElementById('confirmText').innerHTML = 'Thanks for posting the message ' + mt;
						}, {scope : 'publish_actions'});
				}


		
			function SendtofbMessageFriend() {

				console.log('Posting a message to user,s friend()s .... ');
				//var msg = document.getElementById('my_text').value;
				var lnk = 'https://1-dot-tweeterproject-167702.appspot.com/display_tweet?id=' + myselect.options[myselect.selectedIndex].value ;

				//link : 'http://www.nytimes.com/interactive/2015/04/15/travel/europe-favorite-streets.html',
				//link : lnk,
				FB.ui({
					app_id : '835773313238911',
					method : 'send',
					link : lnk,
				});

			}
			
			function showTweet() {
		        window.open('https://1-dot-tweeterproject-167702.appspot.com/display_tweet?id=' + myselect.options[myselect.selectedIndex].value 
		        		, '_blank', 'toolbar=yes, location=yes, status=yes, menubar=yes, scrollbars=yes');
			}

	</script>
</body>
</html>