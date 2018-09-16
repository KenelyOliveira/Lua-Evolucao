local sprites = {}

local spriteChao =
{
	frames =
	{
		{ 	x = 0, y = 128, width  = 128,  height = 128 }
	}
}
local spriteNuvem = 
{
	frames = 
	{
		{	x = 947, y = 1358,  width  = 190, height = 127	},
		{	x = 934, y = 1810, 	width  = 200, height = 125	},
		{	x = 951, y = 886, 	width  = 177, height = 121	},
		{	x = 288, y = 1303,	width  = 234, height = 118	},
		{	x = 722, y = 1857,	width  = 210, height = 119 	}
	}
}
local spriteUI = 
{
	frames = 
	{
		{	name = "inventario", 	x = 1000, 	y = 2030, width = 230, height = 230 },
		{	name = "linha_tempo", 	x = 80,		y = 1600, width = 230, height = 230	},
		{	name = "menu", 			x = 1000,	y = 740,  width = 230, height = 230	}
	}
}

sprites.spriteChao  = spriteChao
sprites.spriteNuvem = spriteNuvem
sprites.spriteUI    = spriteUI


return sprites