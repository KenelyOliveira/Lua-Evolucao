local composer 	= require( "composer" )
local scene 	= composer.newScene()
local physics 	= require("physics")
local widget 	= require("widget")

local ui 		= require("ui")

local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

local function abrirInventario()
	--composer.gotoScene( "inventario" )
end

local function abrirLinhaTempo()
	composer.gotoScene( "linhaTempo" )
end

local function abrirMenu()
	composer.gotoScene( "menu" )
end

function scene:create( event )

	local sceneGroup = self.view
	local interface	 = display.newGroup() 
	
	physics.start()
	physics.setGravity( 0, 0 )
	
	local background = display.newImageRect("assets/fundo.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX 	= 0
	background.anchorY 	= 0
	background.x 		= 0 + display.screenOriginX 
	background.y 		= 0 + display.screenOriginY
	background.alpha 	= 0.8
	
	local paramBotoes = 
	{
		group			= interface,
		abrirInventario	= abrirInventario,
		abrirLinhaTempo = abrirLinhaTempo,
		abrirMenu		= abrirMenu
		
	}
	ui.criaBotoes(paramBotoes)
	
	sceneGroup:insert(background)
	sceneGroup:insert(interface)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		physics.stop()
	elseif phase == "did" then
	end	
	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene