require.config
  paths:
    underscore: "/packages/underscore/underscore"
    backbone: "/packages/backbone/backbone"
    jquery: "/packages/jquery/jquery"

  shim:
    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"

    underscore:
      exports: "_"
