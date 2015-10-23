--[[
LuCI - Lua Configuration Interface

Copyright(C) 2014 Ruijie Network. All rights reserved.

]]--

require("luci.http")
require("luci.sys")
local fs   = require "nixio.fs"

m = Map("openplatform", translate("应用商店"), translate("点击互联网路由器应用商店"))

m:section(SimpleSection).template = "openplatform"
  s = m:section(TypedSection, "openplatform", "")
  s.addremove = false
  s.anonymous = true


 local apply = luci.http.formvalue("cbi.apply")
 if apply then
 end

return m
