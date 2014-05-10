"use strict"
LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt) ->
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    project:
      src: "src"
      app: "app"
      assets: "<%= project.app %>/assets"
      styles: "<%= project.src %>/styles/{,*/}*.styl"
      coffee: "<%= project.src %>/scripts/{,*/}*.coffee"
      plugins: "<%= project.src %>/scripts/plugins/{,*/}*.js"
      views: "<%= project.src %>/views/{,*/}*.html"

    tag:
      banner: "/*!\n" + " * <%= pkg.name %>\n" + " * <%= pkg.title %>\n" + " * @author <%= pkg.author %>\n" + " * <%= pkg.url %>\n" + " */\n"

    connect:
      options:
        port: 9000
        hostname: "*"

      livereload:
        options:
          middleware: (connect) ->
            [
              lrSnippet
              mountFolder(connect, "app")
            ]

    concat:
      dist:
        src: ["<%= project.plugins %>"]
        dest: "<%= project.assets %>/js/plugins.js"

      options:
        stripBanners: true
        nonull: true

    uglify:
      dist:
        src: ["<%= project.assets %>/js/plugins.js"]
        dest: "<%= project.assets %>/js/plugins.min.js"

      options:
        mangle: true
        compress: true

    stylus:
      compile:
        files:
          "<%= project.assets %>/css/core.css": ["<%= project.src %>/styles/core.styl"]

        options:
          paths: [
            "<%= project.assets %>/css/"
            "<%= project.assets %>/fonts/"
            "<%= project.assets %>/img/"
          ]
          urlfunc: "data"
          import: ["nib"]
          compress: no

    coffee:
      compile:
        files:
          "<%= project.assets %>/js/core.js": ["<%= project.coffee %>"]

    autoprefixer:
      single_file:
        options:
          browsers: [
            "last 2 version"
            "ie 9"
          ]

        src: "<%= project.assets %>/css/core.css"
        dest: "<%= project.assets %>/css/core.css"

    includes:
      files:
        cwd: "<%= project.src %>/views"
        src: ["*.html"]
        dest: "<%= project.app %>"
        options:
          flatten: true
          silent: true
          filenameSuffix: ".html"

    cssmin:
      options:
        report: "gzip"

      minify:
        expand: true
        cwd: "<%= project.assets %>/css/"
        src: [
          "*.css"
          "!*.min.css"
        ]
        dest: "<%= project.assets %>/css/"
        ext: ".min.css"

    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    watch:
      stylus:
        files: "<%= project.styles %>"
        tasks: ["stylus"]

      concat:
        files: "<%= project.plugins %>"
        tasks: ["concat"]

      coffee:
        files: "<%= project.coffee %>"
        tasks: ["coffee"]

      includes:
        files: "<%= project.views %>"
        tasks: ["includes"]

      imagemin:
        files: "<%= project.src %>/images/*.{png,jpg,gif}"
        tasks: ["imagemin"]

      livereload:
        options:
          livereload: LIVERELOAD_PORT

        files: ["<%= project.app %>/**"]

  grunt.registerTask "process-styles", [
    "stylus"
    "autoprefixer"
    "cssmin"
  ]
  grunt.registerTask "process-html", ["includes"]
  grunt.registerTask "process-scripts", [
    "concat"
    "uglify"
    "coffee"
  ]
  grunt.registerTask "build", [
    "process-styles"
    "process-html"
    "process-scripts"
  ]
  grunt.registerTask "default", ["build"]
  grunt.registerTask "server", [
    "build"
    "connect:livereload"
    "open"
    "watch"
  ]
  return