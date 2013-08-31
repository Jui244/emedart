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
		$.ajax({
			url: "/search",
			data: {
				keywords: keywords
			},
			success: function( data ) {
				alert(data);
			}
		});
		return false;
	});
})

