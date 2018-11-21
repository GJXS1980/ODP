module("luci.controller.gdut-drcom", package.seeall)

--function index()--
--	entry({"admin","gdut-drcom"}, cbi("gdut-drcom"), _("Dr.com"), 2)--
--	end--
function index()
	entry({"admin", "services", "gdut-drcom"}, cbi("gdut-drcom"), _("Dr.com"), 58)
	end







