<!DOCTYPE html>
<html lang="en">
	<head>
        <title>CP317 PartyAll SQA</title>
		<!-- I don't remember who all is doing design, so just add your names here -->
		<meta name='author' content='Dallas Fraser, Matthew Rodusek, Kevin Holmes, '>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
		<style>
			/* Set standards for text */
			body {
				background-color: #F3F4F7;
				font-family: 'Helvetica Neue'
			}
			.issue-container {
				padding: 20px;
				max-width: 900px;
				background-color: white;
				border: 1px solid rgb(231, 231, 231);
				margin: 10px auto;
			}
			.title {
				text-align: center;
			}
			.red-text {
				color: #d9534f;
			}
			.logo-container {
				width: 100%;
				height: 100px;
				background-color: #d9534f;
				/*background-color: white;*/
				-webkit-box-shadow: 0px 1px 8px #D1D1D1;
				-moz-box-shadow: 0px 1px 8px #D1D1D1;
				box-shadow: 0px 1px 8px #D1D1D1;
			}
			.logo-container.red-back {
				background-color: #d9534f;
			}
			.logo-container .logo {
				height: 100%;
				width: 300px;
				margin: 0px auto;
				background-size: 100%;
				background-repeat: no-repeat;
				background-position: center;
			}
			.logo.white-logo {
				background-image: url(/img/party-all-text-logo-white.png?inline=1);
			}
		</style>
    </head>
	<body>
		<div class="logo-container red-back"><div class="logo white-logo"></div></div>
		<div class="container-fluid">
			<h1 class="title">CP317 Spring 2014 SQA</h1>
			% for issue in issues:
				<div class="issue-container">
					<h1>Issue Title: ${issue['title']} <small>Raised by: ${issue['sqa']} on ${issue['opened']}</small></h1>
					<h4>Label: <span class="label label-default">${issue['lables']}</span></h4>
					<h4>URL: <a href="${issue['url']}">${issue['url']}</a></h4>
					<h4>Description:</h4>
					<p>${issue['description']}</p>
					<h4>Comments:</h4>
					% for comment in issue['comments']:
						<h5>
							<span>Comment by ${comment['user']}<span>
							% if comment['date'] is UNDEFINED:
								<span></span>
							% else:
								<span>on ${comment['date']}</span>
							% endif
						</h5>
						<blockquote>
							% if comment['description'] is UNDEFINED:
								<p>No content</p>
							% else:
								<p>${comment['description']}</p>
							% endif
						</blockquote>
					% endfor
					<h4 class="red-text">
						% if issue['solved'] is UNDEFINED:
							<span>Issue still open.</span>
						% else:
							<span>Closed by ${issue['solved']} on ${issue['closed']}</span>
						% endif
					</h4>
				</div>
			% endfor
		</div>
	</body>
</html>