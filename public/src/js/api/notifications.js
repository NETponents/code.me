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
  var resp = req.responseText;
  // Insert Toastr(JQuery) code here
}
req.open("GET", "http://code-me.herokuapp.com/api/notifications", true);
req.send();
