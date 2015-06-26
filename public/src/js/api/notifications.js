// Create the XML REST request object
function createRequestObject()
{
  var result = null;
  if (window.XMLHttpRequest)
  {
    // FireFox, Safari, etc.
    result = new XMLHttpRequest();
    if (typeof xmlhttp.overrideMimeType != 'undefined')
    {
      // Or anything else
      result.overrideMimeType('text/xml');
    }
  }
  else if (window.ActiveXObject)
  {
    // MSIE
    result = new ActiveXObject("Microsoft.XMLHTTP");
  } 
  else
  {
    // No known mechanism -- consider aborting the application
  }
  return result;
}

var req = createRequestObject();
// Create the callback:
req.onreadystatechange = function()
{
  if (req.readyState != 4) return; // Not there yet
  if (req.status != 200)
  {
    // Handle request failure here...
    return;
  }
  // Request successful, read the response
  //var resp = req.responseText;
  toastr.options = {
    "closeButton": true,
    "debug": false,
    "newestOnTop": false,
    "progressBar": true,
    "positionClass": "toast-top-right",
    "preventDuplicates": false,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  }
  try {
    var itemnodes = req.responseXML.getElementsByTagName('item');
    for (var i = 0; i < itemnodes.length; i++) {
      var message = null;
      //
    }
  } catch (e) {
    toastr["error"]("A team of highly trained monkeys have been dispatched and are investigating the problem. If you see them, send them this error code: 0xCLI-JS-API:NOT-XMLPAR", "Error");
  }
  toastr["info"]("NULL", "Notification");
}
req.open("GET", "http://code-me.herokuapp.com/api/notifications", true);
req.send();
