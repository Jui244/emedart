// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

window.onload = function(){ 
	//Get submit button
	var submitbutton = document.getElementById("keywords");
	//Add listener to submit button
	if(submitbutton.addEventListener){
		submitbutton.addEventListener("click", function() {
			if (submitbutton.value == 'Search here'){//Customize this text string to whatever you want
				submitbutton.value = '';
			}
		});
	}
}

var map;
var circles = [];
var infoWindow;
function initialize(){

	var mapOptions = {
		zoom: 6,
		center: new google.maps.LatLng(-41.274001, 174.770494),
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions);
}



google.maps.event.addDomListener(window, 'load', initialize);


$(document).ready(function(){
	$("form").submit(function( event ) {
		var keywords = $("#keywords").val();
		clearMarkers();

		var cat = $("#categories_category_id").val();
		var subcat = $("#subcat").val();
		$.ajax({
			url: "/search",
			data: {
				keywords: keywords,
				cat: cat,
				subCat: subcat
			},
			success: function( data ) {
				
				populateMarkers(data);
			}
		});
		return false;
	});

	$("#categories_category_id").change(function( event ) {
		$("#subcat").html('');
		var category_id = $("#categories_category_id").val();
		//alert(category_id);
		$.ajax({
			url: "/subcategories",
			data: {
				category_id: category_id
			}
			
		});
	
	});
})

function clearMarkers(){
	for(var i in circles){
		circles[i].setMap(null);
	}
	circles = [];
}


function populateMarkers(data){
	if(!infoWindow)
		infoWindow = new google.maps.InfoWindow({
		});

	var sum = 0;
	for(var i in data){
		sum = sum + data[i].count
	}

	for(var i in data) {
		var location = regions[data[i].region]
		var circle = new google.maps.Circle({
			strokeColor: '#FF0000',
    		strokeOpacity: 0.8,
    		strokeWeight: 2,
    		fillColor:'#FF0000',
    		fillOpacity: 0.35,
    		map: map,
    		center: location,
    		position: location,
    		data: data[i],
    		radius: Math.log(data[i].count)/Math.log(sum)*100000
		});
		
		google.maps.event.addListener(circle, 'click', 
            function(event)
            {
                map.panTo(event.latLng);
                var contentString = '<h1>'+ this.data.region +'</h1>' +
				'<p>Number of Listings: </p>' +
				'<p style="font-size:42pt; color: orange; margin: 0px; padding-bottom: 25px">' + this.data.count + '</p>';
				var contentElement = document.createElement("div");
				contentElement.innerHTML = contentString;
				contentElement.style.width = "200px";
				contentElement.style.textAlign = "center";
				
                infoWindow.setContent(contentElement);
                infoWindow.open(map, this);
            }
        );

		circles.push(circle);

	}
}


regions ={
	"Northland": new google.maps.LatLng(-35.556809, 173.874664),
	"Auckland": new google.maps.LatLng(-36.856549, 174.764786),
	"Waikato": new google.maps.LatLng(-38.043765, 175.467224),
	"Bay of Plenty": new google.maps.LatLng(-38.117272, 176.598816),
	"Gisborne": new google.maps.LatLng(-38.658035, 178.014879),
	"Hawke's Bay": new google.maps.LatLng(-39.410733, 176.741638),
	"Taranaki": new google.maps.LatLng(-39.355538,174.44046),
	"Wanganui": new google.maps.LatLng(-39.931064, 175.048199),
	"Manawatu": new google.maps.LatLng(-40.148439, 175.678024),
	"Wairarapa": new google.maps.LatLng(-41.23238, 175.455551),
	"Wellington": new google.maps.LatLng(-41.266453, 174.778519),
	"Nelson Bays": new google.maps.LatLng(-41.292254, 173.278656),
	"Marlborough": new google.maps.LatLng(-41.539422, 173.934342),
	"West Coast": new google.maps.LatLng(-42.431566, 171.6156),
	"Canterbury": new google.maps.LatLng(-43.55651, 171.714477),
	"Timaru": new google.maps.LatLng(-44.382766, 171.199493),
	"Oamaru": new google.maps.LatLng(-44.382766, 171.199493),
	"Otago": new google.maps.LatLng(-44.902578, 169.714966),
	"Southland": new google.maps.LatLng(-45.782848, 167.814331)
};
