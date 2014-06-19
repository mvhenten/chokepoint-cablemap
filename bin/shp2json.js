#!/usr/bin/env node

var fs = require('fs'),
    Path = require('path'),
    shp2json = require('shp2json'),
    source = Path.resolve(process.argv[2]);

shp2json(fs.createReadStream(source)).pipe(process.stdout);
