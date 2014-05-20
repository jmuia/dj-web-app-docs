var express  = require('express'),
    fs       = require('fs'),
    htmlfile = 'index.html';

var app     = express();
app.get('/', function(request, response) {
    var html = fs.readFileSync(htmlfile).toString();
    response.send(html);
});
app.use('/', express.static(__dirname + '/'));
var port = process.env.PORT || 8000;
app.listen(port, function() {
    console.log('Listening on ' + port);
});