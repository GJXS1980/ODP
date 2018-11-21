--[[
LuCI - Lua Configuration Interface

Copyright 2010 Jo-Philipp Wich <xm@subsignal.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
]]--

require("luci.sys")

m = Map("gdut_drcom", translate("Dr.com客户端"), translate(" "))

s = m:section(TypedSection, "gdut_drcom", "")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Dr.com认证"))

enabledial = s:option(Flag, "enabledial", translate("认证拨号"))
enabledial.default = enabledial.enabled

ifname = s:option(ListValue, "ifname", translate("接口名称"), translate("选择<strong>eth0.2</strong>"))
ifname:depends("enabledial", "1")
for k, v in ipairs(luci.sys.net.devices()) do
	if string.sub(v,0,3) == "eth" then
		ifname:value(v)
	end
end

username = s:option(Value, "username", translate("校园网帐号"), translate("帐号为你端口对应的<strong>学号</strong>"))
username:depends("enabledial", "1")
password = s:option(Value, "password", translate("密码"), translate("端口对应<strong>学号的密码</strong>"))
password:depends("enabledial", "1")
password.password = true

macaddr = s:option(Value, "macaddr", translate("MAC拨号"),translate("使用<strong>eth0.2的MAC</strong>，随意<strong>修改后2位数字</strong> <br> 格式：<strong>78:B4:99:88:E9:86</strong>"))
macaddr.datatype="macaddr"
remote_ip = s:option(Value, "remote_ip", translate("IP"), translate("对应你所在校区选择"))
remote_ip.default="10.0.3.2"
remote_ip.datatype="ipaddr"
remote_ip:value("10.0.3.2", translate("大学城校区"))
remote_ip:value("10.0.3.6", translate("龙洞校区/东风路校区"))
--[[
keep_alive_flag = s:option(Value, "keep_alive1_flag", translate("Keep alive1 flag"), translate("如无需更改，请保持默认"))
]]--

enable_crypt = s:option(ListValue, "enable_crypt", translate("Dr.com版本"), translate("如无需更改，请保持默认"))
enable_crypt.default="1"
enable_crypt:value("1", translate("5.2.1(P版)或6.0.0(P版)"))
enable_crypt:value("0", translate("5.2.0（P版）"))

local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/gdut-drcom restart")
end

return m

