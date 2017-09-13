//#############################################################################
$(document).ready(function(){

var mapCanvas = $('#map-container');


if(mapCanvas)
$('.location').on('click', function () {
    // google map takes time to load, so it's better to get
    // the data after map is rendered completely
    var map = mapCanvas.data("map");
    if (map) {
        map.panTo(new google.maps.LatLng(
            $(this).data('latitude'),
            $(this).data('longitude')
            ));
    }
});
});

//#############################################################################
function initialize()
{
  var handler = Gmaps.build('Google');
  handler.buildMap({ internal: {id: 'map-container'} }, function(){

      function displayOnMap(position){

            if($('#service_coordinates').attr('value'))
    {
      latitude = $('#service_coordinates').attr('value').split(" ")[0];
      longitude = $('#service_coordinates').attr('value').split(" ")[1];
    }
    else
    {
      latitude = position.coords.latitude;
      longitude = position.coords.longitude;
    }

    markers = handler.addMarkers([
    {
      lat: latitude,
      lng: longitude,
      // picture: {
      //   url: "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
      //   width:  36,
      //   height: 36
      // },
      infowindow: "Select the place of your service"
    }

  ],
  { draggable: true}
  );


  handler.map.centerOn(markers[0]);
  handler.getMap().setZoom(16);

google.maps.event.addListener(markers[0].getServiceObject(), "dragend", function(event) {
      var lat = event.latLng.lat();
      var lng = event.latLng.lng();
      $('#service_coordinates').val(lat + " " + lng);
      // console.log($('#service_coordinates').value);
      console.log($('#service_coordinates').attr('value'));
      console.log('Marker with id: ' +  ' dropped hat lat: ' + lat + ' and lng: ' + lng);
    });

};

    if (navigator.geolocation)
      navigator.geolocation.getCurrentPosition(displayOnMap);


  });
};


