-- Better thirdperson, sync both alive and dead, and you can differ fov's for firstperson and thirdperson, made by zinn#0001
local fov_ref = ui.reference("MISC", "Miscellaneous", "Override FOV")
local fov_zoom_ref = ui.reference("MISC", "Miscellaneous", "Override zoom FOV")
local override_fov = ui.new_checkbox("VISUALS", "Effects", "Thirdperson FOV override")
local override_fov_slider = ui.new_slider("VISUALS", "Effects", "Thirdperson FOV", 1, 135, 90, true, "°")
local override_fp_fov_slider = ui.new_slider("VISUALS", "Effects", "Firstperson FOV", 1, 135, 90, true, "°")
local force_trd_alive, force_trd_alive_key = ui.reference("VISUALS", "Effects", "Force third person (alive)")
local force_trd_dead = ui.reference("VISUALS", "Effects", "Force third person (dead)")
local override_zoom_fov = ui.new_checkbox("VISUALS", "Player ESP", "No zoom on thirdperson")

--Scope fov override
client.set_event_callback("setup_command", function(cmd)
	if not ui.get(override_zoom_fov) then
		return
	else
		if ui.get(force_trd_alive_key) and ui.get(force_trd_alive) then
			ui.set(fov_zoom_ref, 0)
		else
			ui.set(fov_zoom_ref, 100)
		end
	end
end)

-- FOV
client.set_event_callback("setup_command", function(cmd) 
	if not ui.get(override_fov) or not ui.get(force_trd_alive) then
		return
	else
		if ui.get(force_trd_alive_key) then
			ui.set(fov_ref, ui.get(override_fov_slider))
		else
			ui.set(fov_ref, ui.get(override_fp_fov_slider))
		end
	end
end)

-- Sync
client.set_event_callback("net_update_end", function(cmd) 
	if ui.get(force_trd_alive_key) then
		ui.set(force_trd_dead, true)
	else
		ui.set(force_trd_dead, false)
	end
end)

local function menu_call()
	ui.set_visible(override_fov_slider, ui.get(override_fov))
	ui.set_visible(override_fp_fov_slider, ui.get(override_fov))
end
menu_call()
ui.set_callback(override_fov, menu_call)