package = "website"
version = "dev-1"
source = {
   url = "git+https://github.com/osis-smpit-alqalam/website.git"
}
description = {
   homepage = "https://github.com/osis-smpit-alqalam/website",
   license = "*** please specify a license ***"
}
dependencies = {
    "lapis",
    "cmark"
}
build = {
   type = "builtin",
   modules = {
      app = "app.lua",
      config = "config.lua",
      models = "models.lua"
   }
}
