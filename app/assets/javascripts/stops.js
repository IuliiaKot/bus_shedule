$(document).ready(function() {
var y =  document.getElementById("location");

    if (navigator.geolocation) {
        y.innerHTML = "Finding location. Please wait...";
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        y.innerHTML = "Geolocation is not supported by this browser.";
    }


function showPosition(position) {
     var geocoder = new google.maps.Geocoder();
     var latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
     geocoder.geocode({'latLng': latlng}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      if (results[0]) {
         y.innerHTML = "You location "+ (results[0].formatted_address);
      };
    };
  });
    $("form input[name='latitude']").val(position.coords.latitude);
    $("form input[name='longitude']").val(position.coords.longitude);

};

});
