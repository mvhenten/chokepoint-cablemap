var fs = require('fs'),
    _ = require('lodash'),
    util = require('util'),
    source = process.argv[2];

if( ! source ) {
    console.error('Usage: %s <input.json>', process.argv[1] );
    process.exit();
}

function point( points ){
    return points.join( ' ' );
}

function multiline( coords ){
    var strs = coords.map(function(poly){
        var points;

        if( poly[0] instanceof Array ) points = poly.map(point).join(', ');
        else points = point(poly);

        return util.format( '(%s)', points );
    });

    return util.format( '(%s)', strs.join(',') );
}

function sql( feature ){
    var sql = '',
        mapping = {
        Id: 'id',
        Name: 'name',
        Capacity_G: 'capacity',
        Distance_K: 'distance',
        OverLand: 'over_land',
        NotLive: 'not_live',
        precise: 'precise',
        Notes: 'notes'
    }, cols = [], values = [];

    _.each( mapping, function( value, key ){
        cols.push( value );
        values.push( util.format( '"%s"', feature.properties[key] ) );
    });

    cols.push('in_service');
    values.push(util.format('"%s-01-01"', feature.properties.InService ));

    var geo = util.format( "GeomFromText('MultiLineString%s')", multiline( feature.geometry.coordinates ) );

    cols.push('geometry');
    values.push(geo);

    return util.format( 'INSERT INTO cablemap_cable (%s) VALUES (%s);', cols.join(', '), values.join(', ') );
}

var json = JSON.parse(fs.readFileSync(source));

json.features.forEach(function(feature){
    console.log( sql(feature) );
});
