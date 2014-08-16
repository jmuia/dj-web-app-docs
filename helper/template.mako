<!DOCTYPE html>
<html lang="en">
	<head>
        <title>CP317 PartyAll SQA</title>
		<!-- I don't remember who all is doing design, so just add your names here -->
		<meta name='author' content='Dallas Fraser, Matthew Rodusek, Kevin Holmes, '>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<style>
		/* Set standards for text */
		body{
			font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
			font-size: 16px;
			text-rendering: optimizeLegibility;
			line-height: 1.42857143;
			color: #333;
			background-color: #fff;
			counter-reset: h2counter;
		}
		#content{
			max-width: 1200px;
			min-width: 600px;
			margin: 0 auto;
		}
		/* Text styling */
		h1{
			font-weight: 800;
		}
		object{border: 0;}
		h2{
			border-bottom: 1px solid #DDD;
		}
		/* Auto-counters for headers and navigation */
		h1{ counter-reset: h2counter; }
	    h2:before {
	        content: counter(h2counter) ".\0000a0\0000a0";
	        counter-increment: h2counter;
	    }
	    h2{ counter-reset: h3counter; }
	    h3:before {
	        content: counter(h2counter) "." counter(h3counter) ".\0000a0\0000a0";
	        counter-increment: h3counter;
	    }
	    h3{ counter-reset: h4counter; }
		h4:before{
			content: counter(h2counter) "." counter(h3counter) "." counter(h4counter) "\000a0\000a0";
			counter-increment: h4counter;
		}
		h2.nocount:before,h3.nocount:before,h4.nocount:before{
			content: none;
			counter-increment: none;
		}
		#nav ol{ 
			margin: 0;
			padding: 0;
			counter-reset: item 
		}
		#nav ol > li{
			margin: 0 20px;
		}
		#nav ol li{ 
			display: block 
		}
	    #nav ol li:before{ 
	    	content: counters(item, ".") ".\000a0\000a0"; 
	    	counter-increment: item 
	    }
	    .tab {
	    	padding: 0px 0px 0px 15px 
	    }
	    .large-tab{
	    	padding: 0px 0px 0px 30px 
	    }
	    .indented-list{
	    	padding: 0px 0px 0px 60px 
	    }
	    .sublist{
	    	padding: 0px 0px 0px 90px 
	    }
	    /* Definition headers */
	    /* Temporary classes for placeholders/messages */
	    .placeholder{
	    	font-style: italic;
	    	color: #666;
	    }
	    .alert-warning{ /* Shamelessly stolen from bootstrap*/
		    padding: 15px;
			margin-bottom: 20px;
			border: 1px solid transparent;
			border-radius: 4px;
		    background-image: -webkit-linear-gradient(top,#fcf8e3 0,#f8efc0 100%);
			background-image: -o-linear-gradient(top,#fcf8e3 0,#f8efc0 100%);
			background-image: -webkit-gradient(linear,left top,left bottom,from(#fcf8e3),to(#f8efc0));
			background-image: linear-gradient(to bottom,#fcf8e3 0,#f8efc0 100%);
			filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fffcf8e3', endColorstr='#fff8efc0', GradientType=0);
			background-repeat: repeat-x;
			border-color: #f5e79e;
		    text-shadow: 0 1px 0 rgba(255,255,255,.2);
			-webkit-box-shadow: inset 0 1px 0 rgba(255,255,255,.25),0 1px 2px rgba(0,0,0,.05);
			box-shadow: inset 0 1px 0 rgba(255,255,255,.25),0 1px 2px rgba(0,0,0,.05);
			color: #8a6d3b;
			background-color: #fcf8e3;
	    }
	    table h4{margin: 0;}
		/* Bordered table stolen from Bootstrap */
		.table{
		width: 100%;
		max-width: 100%;
		margin-bottom: 20px;
		background-color: transparent;
		border-spacing: 0;
		border-collapse: collapse;
		}
		.table-bordered{
		border: 1px solid #ddd;
		}
		.table>caption+thead>tr:first-child>th, 
		.table>colgroup+thead>tr:first-child>th, 
		.table>thead:first-child>tr:first-child>th, 
		.table>caption+thead>tr:first-child>td, 
		.table>colgroup+thead>tr:first-child>td, 
		.table>thead:first-child>tr:first-child>td {border-top: 0;}
		.table-bordered>thead>tr>th, 
		.table-bordered>tbody>tr>th, 
		.table-bordered>tfoot>tr>th, 
		.table-bordered>thead>tr>td, 
		.table-bordered>tbody>tr>td, 
		.table-bordered>tfoot>tr>td {border: 1px solid #ddd;}
		.table-bordered>thead>tr>th, 
		.table-bordered>thead>tr>td {border-bottom-width: 2px;}
		.table>thead>tr>th, 
		.table>tbody>tr>th, 
		.table>tfoot>tr>th, 
		.table>thead>tr>td, 
		.table>tbody>tr>td, 
		.table>tfoot>tr>td {
			padding: 8px;
			line-height: 1.42857143;
			vertical-align: top;
			border-top: 1px solid #ddd;
		}
		.table-striped>tbody>tr:nth-child(odd)>td, 
		.table-striped>tbody>tr:nth-child(odd)>th {
			background-color: #f9f9f9;
		}
		th {text-align: left;}
		th,td{
			word-wrap: break-word;
			white-space: nowrap;
		}
		.table-decomp>tbody>tr>td:first-child,
		.table-decomp>tbody>tr>th:first-child{
			width: 20%;
		}
		</style>
    </head>
	<body>
	<h1>
		Cp317 Spring 2014 SQA
	</h1>
	<table class="table">
		% for issue in issues:
			<tr>
				<td><strong>Title: ${issue['title']}</strong></td>
				<td><a href="${issue['url']}">see more</a></td>
				<td>Classfication: ${issue['lables']}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>Raised by: ${issue['sqa']}</td>
				<td>Date: ${issue['opened']}</td>
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
				<td></td>
				<td>Closed By: ${issue['solved']}</td>
				<td>Closed On:${issue['closed']}</td>
				<td></td>
			</tr>
			<tr class="empty">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		% endfor
	</table>
	</body>
</html>