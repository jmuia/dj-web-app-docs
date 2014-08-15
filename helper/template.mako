<html>
	<body>
	<h1>
		Cp317 Spring 2014 SQA
	</h1>
	<table>
		% for issue in issues:
			<tr>
				<td>Title: ${issue['title']}</td>
				<td>Date: ${issue['opened']}</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>Raised by: ${issue['sqa']}</td>
				<td><a href="${issue['url']}">see more</a></td>
				<td>Description: ${issue['description']}</td>
			</tr>
			% for comment in issue['comments']:
				<tr>
					<td></td>
					<td> Comment by: ${comment['user']}</td>
					% if comment['date'] is UNDEFINED:
						<td></td>
					% else:
						<td> Date: ${comment['date']}</td>
					% endif
					% if comment['description'] is UNDEFINED:
						<td></td>
					%else:
						<td> Description: ${comment['description']}</td>
					% endif

				</tr>
			% endfor
			<tr>
				<td>Closed On:${issue['closed']}</td>
				<td>Closed By: ${issue['solved']}</td>
				<td></td>
				<td></td>
			</tr>
		% endfor
	</table>
	</body>
</html>