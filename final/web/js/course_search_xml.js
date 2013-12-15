var search_parameters = {
  'course_group' : '*',
  'term' : '*',
  'offered' : '*',
  'course_level' : '*',
  'course_type' : '*',
  'day' : '*',
  'time' : '*'
};

var fieldsconfig = [
		{element: 'course_group',label: 'Course Group',qsparam: 'course_group'},
		{element: 'term',label: 'Term',qsparam: 'term'},
		{element: 'day',label: 'Day',qsparam: 'day'},
		{element: 'time',label: 'Time',qsparam: 'time'},
		{element: 'offered',label: 'Offered',qsparam: 'offered'},
		{element: 'course_level',label: 'Level',qsparam: 'course_level'},
		{element: 'course_type',label: 'Type',qsparam: 'course_type'}
];

$(document).ready(function() {
      $('#createPDF').html("Create PDF " + search_parameters);
	createNavigation();
	$('input.reset').click(function(e){
		reset();
		e.preventDefault();
	});
});

function reset() {
	$('#results').empty().html('Course Search Results will appear here once fields are selected.');
	$('#navigation a.selected').removeClass('selected');
	$('#navigation a.unselectable').removeClass('unselectable');
	$('#navigation div.chosen').removeClass('chosen');
	$('#keyword').val('');	
	for (var key in search_parameters) {
		search_parameters[key] = '*';
	}
}
function createNavigation() {
    
	$.get(
   		'ajax/searchfields.xml',
    	{ },
        function(xmlData) {processSearchFieldsXML(xmlData);}
   );
}

function renderDataTable() {
	$('table.courses').dataTable(
		{
        "aoColumns": [null,{ "sType": "course-number" },null,null,null,null,null],
        "bFilter": false,
        'iDisplayLength':25,
        "aaSorting": []
        });
}

function makeTrTh() {
	var tr = $(document.createElement('tr'));
	$(document.createElement('th')).append('Catalog').appendTo(tr);
	$(document.createElement('th')).append('Course').appendTo(tr);
	$(document.createElement('th')).append('Title').appendTo(tr);
	$(document.createElement('th')).append('Term').appendTo(tr);
	$(document.createElement('th')).append('Offered').appendTo(tr);
	$(document.createElement('th')).append('Type').appendTo(tr);
	$(document.createElement('th')).append('Level').appendTo(tr);
	return tr;
}

function processSearchFieldsXML(xmlData) {
	$('#navigation').empty();
	var kdiv = $(document.createElement('div'));
 	$(document.createElement('strong')).html('Keyword:  ').appendTo(kdiv);
	var keywordfield = $(document.createElement('input')).attr('type','text').attr('name','keyword').attr('id','keyword');
 	keywordfield.blur(function(e){getCourses(search_parameters); e.preventDefault();});
 	keywordfield.keyup(function(e){if(e.keyCode == 13) {getCourses(search_parameters); e.preventDefault();}});
 	keywordfield.appendTo(kdiv);
 	
 	var searchbutton = $(document.createElement('input')).attr('value','Search').attr('type','button').attr('name','searchbutton').attr('id','searchbutton');
 	searchbutton.click(function(e){getCourses(search_parameters); e.preventDefault();});
 	searchbutton.appendTo(kdiv);
 	kdiv.appendTo('#navigation');
 	
 	var pdflink = $(document.createElement('a')).attr('href','').text('PDF').attr('id','pdflink');
 	pdflink.appendTo(kdiv);
 	kdiv.appendTo('#navigation');
 	
	for (var i = 0; i < fieldsconfig.length; i++) {		
		var myf = fieldsconfig[i];
		var mydiv = $(document.createElement('div'));
		mydiv.addClass(myf['element']);
     	$(document.createElement('strong')).html(myf['label']+':  ').appendTo(mydiv);
        var len = $(xmlData).find(myf['element']).length;
        $(xmlData).find(myf['element']).each(
       		function(eachindex,eachelement) {
       			var separator = $(document.createElement('span')).html('|');
       			var code = $(this).attr('code');
       			var display = $(this).text();
       			var qsp = myf['qsparam'];
       			var qsv = code;
       			var anchor = $(document.createElement('a'));
       			anchor.click(
       				function(e){
       					$(this).parent().children('a').removeClass('selected');
       					$(this).parent().children('a').addClass('unselectable');
       					$(this).parent().addClass('chosen');
       					$(this).attr('class','selected');
       					$(this).next().addClass('selected');
       					$(this).next().removeClass('unselectable');
       					search_parameters[qsp] = qsv; 
       					getCourses(search_parameters); 
       					e.preventDefault();
       				});
       			anchor.attr('name',display);
       			anchor.attr('href',code);
       			anchor.text(display);
       			anchor.appendTo(mydiv);
       			var removeanchor = $(document.createElement('a'));
       			removeanchor.click(
       				function(e){
       					$('#results').html("Loading...");
       					$(this).parent().children('a').removeClass('unselectable');
       					$(this).parent().children('a').removeClass('selected');
       					$(this).parent().removeClass('chosen');
       					$(this).removeClass('selected');
       					search_parameters[qsp] = '*'; 
       					getCourses(search_parameters); 
       					e.preventDefault();
       				});
       			removeanchor.addClass('remove');
       			removeanchor.attr('name','remove');
       			removeanchor.attr('href','remove');
       			removeanchor.text(' [remove]');
       			removeanchor.appendTo(mydiv); 
       			if (eachindex !== len - 1) {
       				separator.appendTo(mydiv);
       			}
       		}
       	);
       	mydiv.appendTo('#navigation');		
	}  
}

function getCourses(params) {

		    console.log(params);
	$('#results').html("Loading...");
	var keyword = $('#keyword').val();
	params['keyword'] = keyword;
	var searchfieldapplied = false;
	for (var p in params) {
		if (p !== 'keyword' && params[p] !== '*') {searchfieldapplied = true;}
		if (p == 'keyword' && params[p].length > 0) {searchfieldapplied = true;}
	}
	   //Creates a link to the pdf file of the search results
	    $('#pdflink').attr('href','ajax/searchresults.pdf?course_group=' +
		    params['course_group'] + '&term=' + params['term'] + '&offered=' 
		    + params['offered'] + '&course_level=' + params['course_level']
		    //+ "&course_type=" + params['course_type'] +
		    + '&keyword=' + params['keyword'] + '&day=' + params['day']
		    + '&time=' + params['time']);
  	if (searchfieldapplied) {
		$.get(
		    'ajax/search.xml',
		    params,
		    function(xmlData) {
		    	var table = processCourseDataXML(xmlData);
		    	modifySearchFieldsXML(xmlData);
				$('#results').empty();
				table.appendTo('#results');
				renderDataTable();
		    }
		)
	} else {
  		$('#results').html("Course Search Results will appear here once fields are selected.");
  		$('#navigation div').removeClass('chosen');
  		$('#navigation a').removeClass('unselectable');
  		$('#navigation a').removeClass('selected');		
	}
}

function startTable() {
	var table = $(document.createElement('table'));
	table.addClass('courses');
	var thead = $(document.createElement('thead'));
	var trthead = makeTrTh();
	trthead.appendTo(thead);
	thead.appendTo(table);
	var tfoot = $(document.createElement('tfoot'));
	var trtfoot = makeTrTh();
	trtfoot.appendTo(tfoot);
	tfoot.appendTo(table);
	return table
}

function processCourseDataXML(xmlData) {
	var table = startTable()
	var tbody = $(document.createElement('tbody'));

	$(xmlData).find('course').each(
		function() {
			var tr = $(document.createElement('tr'));
			$(document.createElement('td')).append($(this).find('catalog_number').text()).appendTo(tr);
			$(document.createElement('td')).append($(this).find('course_group').text() + '&#160;' + $(this).find('course_number').text()).appendTo(tr);
			$(document.createElement('td')).append($(this).find('title').text()).attr('id','title').appendTo(tr);
			$(document.createElement('td')).append($(this).find('term').text()).appendTo(tr);
			$(document.createElement('td')).append($(this).find('offered').text()).appendTo(tr);
			$(document.createElement('td')).append($(this).find('course_type').text()).appendTo(tr);
			$(document.createElement('td')).append($(this).find('course_level').text()).appendTo(tr);
			tr.appendTo(tbody);
		} // close function
	);  // close 'each' course
	tbody.appendTo(table);
	return table;
}

function modifySearchFieldsXML(xmlData) {
	/* modify navigation */
	var navpresentindata = {};
	for (var i = 0; i < fieldsconfig.length; i++) {		
		var myf = fieldsconfig[i];
		var key = myf['element'];
		var mynavanchorselector = '#navigation ' + '.' + myf['element'] + ' a';
		navpresentindata[key] = {};
		$(xmlData).find(key).each(
				function(){
					navpresentindata[key][$(this).text()] = 1;
					if ($(this).text() == 'Y') {
						navpresentindata[key]['Yes'] = 1;
					}
					if ($(this).text() == 'N') {
						navpresentindata[key]['No'] = 1;
					}
				}
			);
		$(mynavanchorselector).addClass('unselectable');
		$('a.remove').removeClass('unselectable');
		for (var c in navpresentindata[key]) {
			var myselector = mynavanchorselector + '[name = "' + c + '"]';
			$(myselector).removeClass('unselectable');
			$(myselector).addClass('selectable');
		}
	}
}