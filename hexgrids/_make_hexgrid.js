#! /usr/bin/env node

// https://github.com/Turfjs/turf/tree/master/packages/turf-hex-grid

const Fs = require('fs');
const turf = require("@turf/turf");

let bounds = [-104.05769800000002, 39.999998, -86.805415, 49.384358];

/********** MAIN **********/

var cellSide = 2;
var options = {units: 'miles'};

var hexgrid = turf.hexGrid(bounds, cellSide, options);

Fs.writeFile('./mn-grid.tmp.json', JSON.stringify(hexgrid), (error) => { if(error) { console.log(error) }});