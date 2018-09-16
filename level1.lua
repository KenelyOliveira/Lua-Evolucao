local composer 	= require( "composer" )
local scene 	= composer.newScene()
local physics 	= require("physics")
local widget 	= require("widget")

local sprites 	= require("sprites")
local ui 		= require("ui")

local pararUpd  = false

local nuvensTable = {}
local cenario 	  = display.newGroup()
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

local minX, minY = display.screenOriginX, display.screenOriginY
local maxX, maxY = display.viewableContentWidth + -1* display.screenOriginX, display.viewableContentHeight + -1* display.screenOriginY

local function abrirInventario()
	pararUpd = true
	composer.gotoScene( "inventario" )
end

local function abrirLinhaTempo()
	pararUpd = true
	composer.gotoScene( "linhaTempo" )
end

local function abrirMenu()
	pararUpd = true
	composer.gotoScene( "menu" )
end

local function novaNuvem()
	print("collide")
end

local function criaCenario(params)
	
	local sheet 	= graphics.newImageSheet(params.sheetName, params.spriteName)
	local object 	= display.newImageRect(sheet, params.frameId or 1, params.width, params.height)
	
	object.objTable 	= params.objTable
	object.index 		= #object.objTable + 1
	object.myName 		= "cenario_" .. object.index
	object.x 			= params.x
	object.y			= params.y
	object.dentroDaTela = params.dentroDaTela or false

	if params.hasBody then
		object.density  = params.density  or 0
		object.friction = params.friction or 0
		object.bounce   = params.bounce   or 0
		object.isSensor = params.isSensor or false
		object.bodyType = params.bodyType or "dynamic"

		physics.addBody(object, object.bodyType, {density = object.density, friction = object.friction, bounce = object.bounce, isSensor = object.isSensor, filter  = {maskBits = 2, categoryBits = 4}})
		
		if params.type == "nuvem" then
			object:addEventListener("collide", novaNuvem)
		
			object:setLinearVelocity(params.velX, 0 )
			transition.to( object, {  time = 400, y = params.y - 3, iterations = 0, easing = easing.continuousLoop } )
		end
	end

	object.group = params.group or nil
	object.group:insert(object)

	object.objTable[object.index] = object
	object:toBack()

	return object
end

local function update()
	
	if pararUpd == false then
		for i = #nuvensTable, 1, -1 do
			local obj = nuvensTable[i]
			
			if nuvensTable[i].dentroDaTela == true then
				local vx, vy 	= obj:getLinearVelocity()
				
				if obj.x + 32 + (vx * -1) < minX then
					
					nuvensTable[i].dentroDaTela = false
					local spawns = criaCenario(
					{
						objTable 	 = nuvensTable,
						dentroDaTela = true,
						type		 = "nuvem",
						hasBody  	 = true,
						group    	 = display.newGroup(),
						x			 = 200 + (i * 200),
						y			 = 40 + (i * 3),
						frameId		 = math.random(1, 5),
						sheetName	 = "assets/background-elements.png",
						spriteName   = sprites.spriteNuvem,
						width		 = 120, 
						height		 = 70,
						velX		 = math.random(-40, -10)
					} )
				end
			end
		end
	end
end

function scene:create( event )

	local sceneGroup = self.view
	local interface	 = display.newGroup()
	
	physics.start()
	physics.setGravity( 0, 0 )
	
	local background = display.newImageRect("assets/ceu.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX, background.anchorY = 0, 0
	background.x, background.y = 0 + display.screenOriginX ,  display.screenOriginY
	
	local paramBotoes = 
	{
		group			= interface,
		abrirInventario	= abrirInventario,
		abrirLinhaTempo = abrirLinhaTempo,
		abrirMenu		= abrirMenu
	}
	ui.criaBotoes(paramBotoes)
	
	for i = 1, 3 do
		local spawns = criaCenario(
		{
			objTable 	 = nuvensTable,
			dentroDaTela = true,
			type		 = "nuvem",
			hasBody  	 = true,
			group    	 = display.newGroup(),
			x			 = display.actualContentWidth + (i * 100),
			y			 = 40 + (i * 3),
			frameId		 = math.random(1, 5),
			sheetName	 = "assets/background-elements.png",
			spriteName   = sprites.spriteNuvem,
			width		 = 120, 
			height		 = 70,
			velX		 = math.random(-40, -10)
		} )
	end
	
	local chaoTable = {}
	for i = 15, 525, 85 do
		local spawns = criaCenario(
		{
			objTable 	= chaoTable,
			hasBody  	= true,
			friction 	= 0.4,
			bounce   	= 0.4,
			bodyType 	= "static",
			group    	= cenario,
			x 			= i,
			y			= display.contentHeight - 30,
			sheetName	= "assets/ground.png",
			spriteName  = sprites.spriteChao,
			width		= 128, 
			height		= 70
		}	)
	end
	
	sceneGroup:insert(background)
	sceneGroup:insert(cenario)
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

Runtime:addEventListener("enterFrame", update)

return scene