#------------------------------------------------
# Chess3d Qt3D      
#    20-06-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

#############################
#-----Globale Variable------#
#############################






	BlackProPawnEntity=null		WhiteProPawnEntity=null
	oProPawnEntity=null	oProPawn=null	oProPawnMaterial=null	oProPawnPicker=null	oProPawnTransform=null
	oProPawQuinW=null	 oProPawQuinB=null	oProPawRookW=null	oProPawRookB=null		oProPawBishopW=null
	oProPawBishopB=null	oProPawknightW=null	oProPawknightB=null
	oview    = null 	oWidget = null	oRootEntity = null	oCameraEntity = null
	oCamController = null	aStars = null	aLight = null	ologo = null
	oboard = null	oText3d = null    PieceEntity = null 	WhitePEntity = null
	BlackPEntity = null 	oFrameAction = null 	btn1 = null 	oFilter = null
	oLayout = null 	oContainer = null 	aTile= null 	piece= null 	okingw= null 
	okingb= null 	oqueenw= null 	oqueenb= null 	oBishopwr= null 	oBishopwl= null 
	oBishopbl= null 	oBishopbr= null	oknightwr= null 	oknightwl= null 	oknightbr= null 
	oknightbl= null 	orookwr= null 	orookwl= null 	orookbr= null 	orookbl= null 	opawnw1= null 
	opawnw2= null 	opawnw3= null 	opawnw4= null 	opawnw5= null 	opawnw6= null 
	opawnw7= null 	opawnw8= null 	opawnb1= null 	opawnb2= null 	opawnb3= null 
	opawnb4= null 	opawnb5= null 	opawnb6= null 	opawnb7= null 	opawnb8= null 	
	aplanets = null    ologo_Entity= null   ologo_picker= null	  ologo_material= null		
	ologo_Transform= null

	VisionLevel =0
    CamraMenuelaAngle = 0
    TilePicked = false  
    mouseRightClick =false 
    motionLastX = 0  
    motionLastY = 0
    kingI = 0
    kingJ = 0
    selectionI = 0
    selectionJ = 0
    degreeW = 270      
    degreeB = 90  
    Camturn = false  
    anglePlanet=0  
	angpl=0   
	Camangle =0  
	angleCam=0
	turn=""
   aProPawn=list(4)
    aTile = list(8,8)
	TILE_SIZE      = 17
   board=list(8,8)
	   board = [
		    ['rr', 'nr', 'br', 'kr', 'qr', 'bl', 'nl', 'rl'],
		    ['p8', 'p7', 'p6', 'p5', 'p4', 'p3', 'p2', 'p1'],
		    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
		    ['P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8'],
		    ['Rl', 'Nl', 'Bl', 'Kl', 'Ql', 'Br', 'Nr', 'Rr']
		   ]

	awhitepiece  = ['rr', 'nr', 'br', 'kr', 'qr', 'bl', 'nl', 'rl', 
						'p8', 'p7', 'p6', 'p5', 'p4', 'p3', 'p2', 'p1', 'ppqw', 'pprw', 'ppbw', 'ppkw']

	ablackpiece = ['P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8',
						   'Rl', 'Nl', 'Bl', 'Kl', 'Ql', 'Br', 'Nr', 'Rr', 'ppqb', 'pprb', 'ppbb', 'ppkb']

	apawnpiece = [ 'P1','p1','P2','p2','P3','p3','P4','p4',
							'P5','p5','P6','p6', 'P7','p7','P8','p8' ]

	apawnblack = [ 'P1','P2','P3','P4','P5','P6','P7','P8' ]

	apawnwhite = [ 'p1','p2','p3','p4','p5','p6','p7','p8' ]

 	  MSG_WELCOME = "
		 Welcome to the game  cheess developed in the Ring language,
		 to start ,click the left buttonin the middle of Image ,
		  to correct the position of the board,
		 click the right button in the middle of the board, edit,
		 and then another click,
		 We hope you enjoy.
 		"		
								   		
	   MSG_YOUR_TURN  = 'Your turn!'
	   MSG_INVALID    = 'Invalid..'
	   MSG_CHECK      = 'Check..'
	   MSG_WIN        = 'YOU WIN!'
	   MSG_LOSE       = 'Sorry..'
   				
