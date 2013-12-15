jQuery.fn.dataTableExt.oSort['course-number-asc']  = function(a,b) {
    var x = (a == "-") ? 0 : a.replace( /\D+/g, "" );
    var y = (b == "-") ? 0 : b.replace( /\D+/g, "" );
    x = parseFloat( x );
    y = parseFloat( y );
    return ((x < y) ? -1 : ((x > y) ?  1 : 0));
};
 
jQuery.fn.dataTableExt.oSort['course-number-desc'] = function(a,b) {
    var x = (a == "-") ? 0 : a.replace( /\D+/g, "" );
    var y = (b == "-") ? 0 : b.replace( /\D+/g, "" );
    x = parseFloat( x );
    y = parseFloat( y );
    return ((x < y) ?  1 : ((x > y) ? -1 : 0));
};