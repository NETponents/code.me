toastr.options.closeButton = true;
var xmlhttp = false;
if (window.XMLHttpRequest) {
  xmlhttp = new XMLHttpRequest();
  xmlhttp.overrideMimeType('text/xml');
} else if (window.ActiveXObject) {
  xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
} else {
  toastr.error("A team of highly trained monkeys have been dispatched and are investigating the problem. If you see them, send them this error code: 0xCLI-JS-API:NOT-XMLOBJ", "Error");
}

function getNotifications() {
  var url = "http://code-me.herokuapp.com/api/notifications";
  xmlhttp.open('GET', url, true);
  xmlhttp.onreadystatechange = getNotContent;
  xmlhttp.send(null);
}
function getNotContent() {
  if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
    try {
      if (xmlhttp.responseText == "") {
        //No new notifications
      } else {
        eval("var response = (" + xmlhttp.responseText + ")");
        var title = msg = type = null;
        for (var i = 0; i < response.length; i++) {
          title = response[i].title;
          msg = response[i].msg;
          type = response[i].type;
          toastr.info(msg, title);
        }
      } catch (e) {
        toastr.error("A team of highly trained monkeys have been dispatched and are investigating the problem. If you see them, send them this error code: 0xCLI-JS-API:NOT-XMLPAR", "Error");
      }
    }
  }
}
