local ui = {}

local function criaBotoes(params)
	local btnInventario = display.newImageRect(params.group, "assets/botoes/menuGrid.png", 40, 40 )
	btnInventario.x = -10
	btnInventario.y = 30
	btnInventario.group = params.group or nil
	btnInventario:toFront()
	
	btnInventario:addEventListener( "tap", params.abrirInventario )
	
	local btnLinhaTempo	= display.newImageRect(params.group, "assets/botoes/linha_tempo.png", 40, 40 )
	btnLinhaTempo.x = 40
	btnLinhaTempo.y = 30
	btnLinhaTempo.group = params.group or nil
	btnLinhaTempo:toFront()
	
	btnLinhaTempo:addEventListener( "tap", params.abrirLinhaTempo )
	
	local btnMenu 	= display.newImageRect(params.group, "assets/botoes/home.png", 40, 40 )
	btnMenu.x = 490
	btnMenu.y = 30
	btnMenu.group = params.group or nil
	btnMenu:toFront()
	
	btnMenu:addEventListener( "tap", params.abrirMenu )
end

ui.criaBotoes = criaBotoes

return ui