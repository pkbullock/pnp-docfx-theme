const {
    src,
    dest,
    watch,
    series,
    parallel
} = require('gulp');

isProd = process.env.NODE_ENV === 'production' ? true : false;

console.debug("Production Mode :::: ", isProd);

const gulpLoadPlugins = require('gulp-load-plugins');

const $ = gulpLoadPlugins();
const autoprefixer = require('autoprefixer');

const sass = require('gulp-sass')(require('sass'));

// const baseWatch = async (cb) => {

//     watch(['source/styles/**/*.scss'], styles);

//     cb();

// }

const styles = () => {

    return src('scss/*.scss')
        .pipe($.plumber())
        .pipe($.if(!isProd, $.sourcemaps.init()))
        // .pipe($.sourcemaps.init())
        .pipe(
            $.if(!isProd, sass.sync({
                outputStyle: 'expanded',
                precision: 6,
                includePaths: ['.']
            }))
            .on('error', sass.logError))
        .pipe(
            $.if(isProd, sass.sync({
                outputStyle: 'compressed',
                precision: 6,
                includePaths: ['.']
            }))
            .on('error', sass.logError))
        .pipe($.postcss([
            autoprefixer()
        ]))
        .pipe($.if(!isProd, $.sourcemaps.write()))
        .pipe(dest('../templates/pnp/styles'));

};

// if (isProd) {
//     exports.default = parallel(styles);
//     return;
// }
//exports.default = parallel(styles, baseWatch);
exports.default = styles;