// Automate my builds

var gulp = require('gulp');
var prop = require('./package.json');
var minify = require('gulp-minify-css');
var $ = require('gulp-load-plugins')();
var head = '\/*\r\n* MIPS++ ' + prop.version + '\r\n* Stanley Lim, Copyright 2017\r\n* https://spiderpig86.github.io/MIPS-\r\n*/\r\n';

gulp.task('compile', function() {
    return gulp.src([
        './src/consts.asm',
        './src/stdio.asm'
    ])
        .pipe($.concat('mpp.asm'))
        .pipe($.header(head))
        .pipe($.size())
        .pipe(gulp.dest('./dist/'));
});