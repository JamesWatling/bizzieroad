var personData = [];

var myMap = function() {

	var	options = {
		zoom: 14,
		center: new google.maps.LatLng(-41.2313186,174.8813756),
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}

	/*
		Load the map then markers
		@param object settings (configuration options for map)
		@return undefined
	*/	
	function init(settings) {
		map = new google.maps.Map(document.getElementById( settings.idSelector ), options);
		var styles = [   {featureType: "poi", elementType: "labels", stylers: [{ visibility: "off" } ] },{"featureType":"administrative","elementType":"all","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2e5d4"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#c5dac6"}]},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{"featureType":"road","elementType":"all","stylers":[{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#c5c6c6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#e4d7c6"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#fbfaf7"}]},{"featureType":"water","elementType":"all","stylers":[{"visibility":"on"},{"color":"#acbcc9"}]}]; map.setOptions({styles: styles});
		markerLocation = settings.markerLocation;
		getCompanyData();
	}

	/*
		=======
		MARKERS
		=======
	*/
	markers = {};
	markerList = [];

	function getCompanyData(){

		$.getJSON("api/get")
		  .done(function( json ) {
		  	personData = json;
			loadMarkers(json);
		    console.log("success");
		  })
		  .fail(function( jqxhr, textStatus, error ) {
		    var err = textStatus + ", " + error;
		    console.log( "Request Failed: " + err );
		});
	};

	/*
		Load markers onto the Google Map from a provided array or demo personData (data.js)
		@param array personList [optional] (list of people to load)
		@return undefined
	*/
	function loadMarkers(personList) {

		// optional argument of person
		var people = ( typeof personList !== 'undefined' ) ? personList : personData;

		var j = 1; // for lorempixel

		for( i=0; i < people.length; i++ ) {
			var person = people[i];

			// if its already on the map, dont put it there again
			if( markerList.indexOf(person.id) !== -1 ) continue;

			var lat = person.lat,
				lng = person.lng,
				markerId = person.id;

			var infoWindow = new google.maps.InfoWindow({
				maxWidth: 400
			});

			var icon = person.logo

			var marker = new google.maps.Marker({
				position: new google.maps.LatLng( lat, lng ),
				title: person.name,
				markerId: markerId,
				icon: icon,
				map: map
			});

			markers[markerId] = marker;
			markerList.push(person.id);

			if( j > 10 ) j = 1; // for lorempixel, the thumbnail image
			var content = ['<div class="iw-text"><strong>', person.company,
				'</strong><br>Address: ', person.address,
				'<br>Decision Maker: ', person.decision_maker, 
				'<br>Decision Maker Position: ', person.decision_maker_position, 
				'<br>Decision Maker Location: ', person.decision_maker_location, 
				'<br>Phone Number: ', person.phone_number, 
				'<br>email: ', person.email, 
				'<br>Connections: ', person.connections, 
				'<br>Connection Type: ', person.connection_type, 
				'<br>Interest Level: ', person.interest_level, 
				'<br>Notes: ', person.notes, 
				'</div></div>'].join('');
			j++; // lorempixel
			
			google.maps.event.addListener(marker, 'click', (function (marker, content) {
				return function() {
					infoWindow.setContent(content);
					infoWindow.open(map, marker);
				}
			})(marker, content));	
		}
	}

	/*
		Remove marker from map and our list of current markers
		@param int id (id of the marker element)
		@return undefined
	*/
	function removePersonMarker(id) {
		if( markers[id] ) {
			markers[id].setMap(null);
			loc = markerList.indexOf(id);
			if (loc > -1) markerList.splice(loc, 1);
			delete markers[id];
		}
	}

	/*
		======
		FILTER
		======
	*/

	// default all filters off
	var filter = {
		followers: 0,
		college: 0,
		from: 0
	}
	var filterMap;

	/*
		Helper function
		@param array a (array of arrays)
		@return array (common elements from all arrays)
	*/
	function reduceArray(a) {
		r = a.shift().reduce(function(res, v) {
			if (res.indexOf(v) === -1 && a.every(function(a) {
				return a.indexOf(v) !== -1;
			})) res.push(v);
			return res;
		}, []);
		return r;
	}

	/*
		Helper function
		@param string n
		@return bool
	*/
	function isInt(n) {
	    return n % 1 === 0;
	}


	/*
		Decides which filter function to call and stacks all filters together
		@param string filterType (the property that will be filtered upon)
		@param string value (selected filter value)
		@return undefined
	*/
	function filterCtrl(filterType, value) {
		// result array
		var results = [];

		if( isInt(value) ) {
			filter[filterType] = parseInt(value);
		} else {
			filter[filterType] = value;
		}
		
		for( k in filter ) {
			if( !filter.hasOwnProperty(k) && !( filter[k] !== 0 ) ) {
				// all the filters are off
				loadMarkers();
				return false;
			} else if ( filter[k] !== 0 ) {
				// call filterMap function and append to r array
				results.push( filterMap[k]( filter[k] ) );
			} else {
				// fail silently
			}
		}

		if( filter[filterType] === 0 ) results.push( personData );
		
		/*
			if there is 1 array (1 filter applied) set it,
			else find markers that are common to every results array (pass every filter)
		*/
		if( results.length === 1 ) {
			results = results[0];
		} else {
			results = reduceArray( results );
		}
		
		loadMarkers( results );

	}
	
	/* 
		The keys in this need to be mapped 1-to-1 with the keys in the filter variable.
	*/
	filterMap = {
		rep_name: function( value ) {
			return filterByString('rep_name', value);
		},

		isp: function( value ) {
			return filterByString('isp', value);
		},

		interest: function( value ) {
			return filterByString('interest_level', value);
		}
	}

	/*
		Filters marker data based upon a string match
		@param string dataProperty (the key that will be filtered upon)
		@param string value (selected filter value)
		@return array (people that made it through the filter)
	*/
	function filterByString( dataProperty, value ) {
		var people = [];

		for( var i=0; i < personData.length; i++ ) {
			var person = personData[i];
			if( person[dataProperty] == value ) {
				people.push( person );
			} else {
				removePersonMarker( person.id );
			}
		}
		return people;
	}


	/*
		Filters out integers that are under the provided value
		@param string dataProperty (the key that will be filtered upon)
		@param int value (selected filter value)
		@return array (people that made it through the filter)
	*/
	function filterIntsLessThan( dataProperty, value ) {
			var people = [];

			for( var i=0; i < personData.length; i++ ) {
				var person = personData[i];
				if( person[dataProperty] > value ) {
					people.push( person )
				} else {
					removePersonMarker( person.id );
				}
			}
			return people;
	}

	// Takes all the filters off
	function resetFilter() {
		filter = {
			followers: 0,
			college: 0,
			from: 0
		}
	}

	return {
		init: init,
		loadMarkers: loadMarkers,
		filterCtrl: filterCtrl,
		resetFilter: resetFilter

	};
}();


$(function() {

	var mapConfig = {
		idSelector: 'map-canvas',
		markerLocation: 'assets/red-fat-marker.png'
	}

	myMap.init( mapConfig );

	$('.load-btn').on('click', function() {
		var $this = $(this);
		// reset everything
		$('select').val(0);
		myMap.resetFilter();
		myMap.loadMarkers();

		if( $this.hasClass('is-success') ) {
			$this.removeClass('is-success').addClass('is-default');
		}
	});


	$('.isp-select').on('change', function() {
		myMap.filterCtrl('isp', this.value);
	});

	$('.users-select').on('change', function() {
		myMap.filterCtrl('rep_name', this.value);
	});

	$('.interest-select').on('change', function() {
		myMap.filterCtrl('interest', this.value);
	});


});




