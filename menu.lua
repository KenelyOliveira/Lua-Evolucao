local composer  = require("composer")
local physics 	= require("physics")
local audio 	= require("audio")
local timer 	= require("timer")
local widget 	= require("widget")

local scene 	= composer.newScene()

local function onPlayBtnRelease()
	composer.gotoScene( "level1", "fade", 400 )
	return true
end

function scene:create( event )
	local sceneGroup = self.view
	
	physics.start()
	physics.setGravity(0, 0)
	
	--fundo
	local background = display.newImageRect( "assets/fundo.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	local musica = audio.loadStream("assets/sound.mp3")
	local backgroundMusicChannel = audio.play( musica, { channel=1, loops=-1, fadein=0 } )
	
	sceneGroup:insert(background)
	 
	--homem
	local function mostraCaveman()
		local caveSheet = graphics.newImageSheet( "assets/caveman.png", { width=332, height=309, numFrames=12 } )
		local caveman	= display.newSprite( caveSheet, { name="man", start=1, count=12, time=1600 } )
		caveman.x 		= -100
		caveman.y 		= 150
		caveman.xScale 	= .8
		caveman.yScale 	= .8
		caveman:play()
		
		physics.addBody(caveman)
		caveman:setLinearVelocity(180, 0 )
		
		sceneGroup:insert(caveman)
	end
	
	mostraCaveman()
	
	--gato
	local function mostraGato( event )
		local gatoSheet = graphics.newImageSheet( "assets/runningcat.png", { width=512, height=256, numFrames=8 } )
		local gato 		= display.newSprite( gatoSheet, { name="cat", start=1, count=8, time=1000 } )
		gato.x 			= -250
		gato.y 			= 180
		gato.xScale 	= .5
		gato.yScale 	= .5
		gato:play()

		physics.addBody(gato)
		gato:setLinearVelocity(200, 0 )
		
		sceneGroup:insert(gato)
	end
	
	timer.performWithDelay( 1400, mostraGato )
	
	--logo e botão
	local function mostraLogo()
		local logo 	= display.newEmbossedText("Evolução", 264, 42, "vtks_tilt", 80 )
		local color = {	shadow = { r=0, g=0, b=0 } }
		logo.x = display.contentCenterX
		logo.y = 100
		logo:setEmbossColor( color )
		
		local botao = widget.newButton{
			label		= "- jogar -",
			labelColor 	= { default={255}, over={128} },
			fontSize 	= 30,
			width		= 154, 
			height		= 50,	 
			onRelease 	= onPlayBtnRelease
		}
		botao.x = display.contentCenterX
		botao.y = display.contentHeight - 150
		
		sceneGroup:insert(logo)
		sceneGroup:insert(botao)
	end 
	
	timer.performWithDelay( 6000, mostraLogo )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	if botao then
		botao:removeSelf()
		botao = nil
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene