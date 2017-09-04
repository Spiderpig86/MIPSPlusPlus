// Automate my builds

var gulp = require('gulp');
var prop = require('./package.json');
var $ = require('gulp-load-plugins')();
var head = '#\r\n# MIPS++ ' + prop.version + '\r\n# Stanley Lim, Copyright 2017\r\n# https://spiderpig86.github.io/MIPSPlusPlus\r\n#\r\n';

gulp.task('compile', ['funcs'], function() {
    return gulp.src('./src/macros/*.asm')
        .pipe($.concat('mpp.asm'))
        .pipe($.header(head))
        .pipe($.size())
        .pipe(gulp.dest('./dist/'));
});

gulp.task('funcs', function() {
    return gulp.src('./src/functions/*.asm')
        .pipe($.concat('mppf.asm'))
        .pipe($.size())
        .pipe(gulp.dest('./dist/'));
});