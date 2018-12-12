#! /usr/bin/env node

// https://github.com/Turfjs/turf/tree/master/packages/turf-hex-grid

const Fs = require('fs');
const turf = require("@turf/turf");
const stations = require('./stations/ghcnd-stations.json');

/********** MAIN **********/

var voronoiPolygons = turf.voronoi(stations);

Fs.writeFile('./ghcnd-voronoi.tmp.json', JSON.stringify(voronoiPolygons), (error) => { if(error) { console.log(error) }});