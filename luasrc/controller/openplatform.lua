--[[
LuCI - Lua Configuration Interface

Copyright(C) 2014 Ruijie Network. All rights reserved.

]]--

module("luci.controller.openplatform", package.seeall)

require("luci.sys")
local uci = require "luci.model.uci".cursor()

function index()
	local page

	page = entry({"admin", "network", "openplatform"}, cbi("openplatform"), _("应用商店"), 54)
	page.dependent = false

	page = entry({"admin", "network", "openplatform_reg"}, call("openplatform_reg"), nil)
	page.leaf = true
end

function openplatform_reg()
	local mac = ""
	local ip = ""

	local file = io.popen("ifconfig br-lan 2>/dev/null | grep 'HWaddr' | awk -F 'HWaddr ' '{print $2 }' | awk '{print $1}' | sed 's/://g'")
	if file then
        while true do
            local ln = file:read("*l")
            if not ln then
                break
            else
                mac = luci.util.pcdata(ln)
            end
        end

        file:close()
    end

    require("uci")
    local rserver
    uci.cursor():foreach("openplatform","openplatform",function(s) rserver=s.server end)
    if rserver==nil or rserver=='' then
            rserver='124.127.116.178'
     end

    local rurl
    uci.cursor():foreach("openplatform","openplatform",function(s) rurl=s.url end)
    if rurl==nil or rurl=='' then
            rserver= 'login_session'
    end


    local rinet
    uci.cursor():foreach("openplatform","openplatform",function(s) rinet=s.inet end)
    if rinet==nil or rinet=='' then
            rinet= '1'
    end

    local url = "http://" .. rserver  .. "/" .. rurl ..  "?mac=" .. mac .. "&inet=" .. rinet .. ""
	luci.http.redirect(url)
    return
end
