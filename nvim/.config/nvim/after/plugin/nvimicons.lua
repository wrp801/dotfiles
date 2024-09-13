local web_dev_ok, web_dev_icons = pcall(require, "nvim-web-devicons")
if not web_dev_ok then 
    return
end

local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")

if not material_icon_ok then
    return 
end

-- web_dev_icons.setup {
--     override = material_icon.get_icons(),
--
-- }

material_icon.setup {
    default = true;
}
