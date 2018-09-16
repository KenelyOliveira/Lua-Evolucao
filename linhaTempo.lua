local composer 	= require( "composer" )
local scene 	= composer.newScene()
local physics 	= require("physics")
local widget 	= require("widget")

local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

local function onPlayBtnRelease()
	composer.gotoScene( "menu", "fade", 400 )
	return true
end

function scene:create( event )

	local sceneGroup = self.view
	physics.start()
	physics.setGravity( 0, 0 )
	
	local background = display.newImageRect("assets/fundos/5.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	--local botao = widget.newButton{
	--	label		= "- jogar -",
	--	labelColor 	= { default={255}, over={128} },
	--	fontSize 	= 30,
	--	width		= 154, 
	--	height		= 50,	 
	--	onRelease 	= onPlayBtnRelease
	--}
	--botao.x = display.contentCenterX
	--botao.y = display.contentHeight - 150
	
	sceneGroup:insert(background)
	--sceneGroup:insert(botao)
	
	local caveSheet = graphics.newImageSheet( "assets/caveman.png", { width=332, height=309, numFrames=12 } )
	local caveman	= display.newSprite( caveSheet, { name="man", start=1, count=12, time=1600 } )
	caveman.x 		= -100
	caveman.y 		= 120
	caveman.xScale 	= .8
	caveman.yScale 	= .8
	caveman:play()
	
	physics.addBody(caveman)
	caveman:setLinearVelocity(180, 0 )
	sceneGroup:insert(caveman)
	
	local function mostraGato( event )
		local gatoSheet = graphics.newImageSheet( "assets/runningcat.png", { width=512, height=256, numFrames=8 } )
		local gato 		= display.newSprite( gatoSheet, { name="cat", start=1, count=8, time=1000 } )
		gato.x 			= -250
		gato.y 			= 160
		gato.xScale 	= .5
		gato.yScale 	= .5
		gato:play()

		physics.addBody(gato)
		gato:setLinearVelocity(200, 0 )
		
		sceneGroup:insert(gato)
	end
	
	timer.performWithDelay( 1400, mostraGato )
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