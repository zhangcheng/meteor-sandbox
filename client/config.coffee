require.config
  paths:
    jquery: "/packages/jquery/jquery"
    underscore: "/packages/underscore/underscore"
    backbone: "/packages/backbone/backbone"

  shim:
    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"

    underscore:
      exports: "_"
