#------------------------------------------------
# Chess3d Qt3D      
#    20-06-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

##########################################
#-----Redrow Delete piece Function-------#
##########################################




//---------Redrow piece------------
func redrowpiece(board, i, j)

		
			   //Redraws the correct piece.-----------
			
		 if board[i][j] = 'kr'
            okingw = new Model3d(WhitePEntity, okingw, "models/king.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					          	SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.------------------------bK-------------------------------
        elseif  board[i][j] = 'Kl'
            okingb = new Model3d(BlackPEntity, okingb, "models/king.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         // White piece.-----------------------wq-----------------------------------
         elseif board[i][j] = 'qr'
            oqueenw = new Model3d(WhitePEntity, oqueenw, "models/queen.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.---------------------------bQ-------------------------------
         elseif board[i][j] = 'Ql'
            oqueenb = new Model3d(BlackPEntity, oqueenb, "models/queen.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         // White piece. --------------right----------------------
         elseif board[i][j] = 'br'
            oBishopwr = new Model3d(WhitePEntity, oBishopwr, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.----------------------right----------------------------------------
         elseif board[i][j] = 'Br'
            oBishopbr = new Model3d(BlackPEntity, oBishopbr, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		 // White piece. --------------------left--------------------------------------
         elseif board[i][j] = 'bl'
            oBishopwl = new Model3d(WhitePEntity, oBishopwl, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.--------------------------left-----------------------------------------
         elseif board[i][j] = 'Bl'
            oBishopbl = new Model3d(BlackPEntity, oBishopbl, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         //White piece.-------------------------right----------------------------------------------
         elseif board[i][j] = 'nr'
            oknightwr = new Model3d(WhitePEntity, oknightwr, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.----------------------------right--------------------------------------------------
         elseif board[i][j] = 'Nr'
            oknightbr = new Model3d(BlackPEntity, oknightbr, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		//White piece.-------------------------left------------------------------------------------
         elseif board[i][j] = 'nl'
            oknightwl = new Model3d(WhitePEntity, oknightwl, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.--------------------------left-------------------------------------------------
         elseif board[i][j] = 'Nl'
            oknightbl = new Model3d(BlackPEntity, oknightbl, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         // White piece.------------------right--------------------------------------------
         elseif board[i][j] = 'rr'
            orookwr = new Model3d(WhitePEntity, orookwr,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.-----------------------right---------------------------------------------
         elseif board[i][j] = 'Rr'
            orookbr = new Model3d(BlackPEntity, orookbr,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		 // White piece.-------------------------left------------------------------------------------
         elseif board[i][j] = 'rl'
            orookwl = new Model3d(WhitePEntity, orookwl,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.-----------------------------left-----------------------------------------------
         elseif board[i][j] = 'Rl'
            orookbl = new Model3d(BlackPEntity, orookbl,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
      // White piece.-------------------------wp1------------------------------------------------------
         elseif board[i][j] = 'p1'
            opawnw1 = new Model3d(WhitePEntity, opawnw1,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.---------------------------bp1--------------------------------------------------------
         elseif board[i][j] = 'P1'
            opawnb1 = new Model3d(BlackPEntity, opawnb1,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		// White piece.----------------------------wp2-----------------------------------------------
         elseif board[i][j] = 'p2'
            opawnw2 = new Model3d(WhitePEntity, opawnw2,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.-------------------------------bp2--------------------------------
         elseif board[i][j] = 'P2'
            opawnb2 = new Model3d(BlackPEntity, opawnb2,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		// White piece.-----------------------------wp3----------------------------------
         elseif board[i][j] = 'p3'
            opawnw3 = new Model3d(WhitePEntity, opawnw3,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.-------------------------------bp3---------------------------------
         elseif board[i][j] = 'P3'
            opawnb3 = new Model3d(BlackPEntity, opawnb3,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		// White piece.--------------------------------wp4---------------------------------
         elseif board[i][j] = 'p4'
            opawnw4 = new Model3d(WhitePEntity, opawnw4,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.----------------------------------bp4-------------------------------
         elseif board[i][j] = 'P4'
            opawnb4 = new Model3d(BlackPEntity, opawnb4,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		// White piece.------------------------------------wp5-----------------------------
         elseif board[i][j] = 'p5'
            opawnw5 = new Model3d(WhitePEntity, opawnw5,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.-----------------------------------bp5-------------------------------
         elseif board[i][j] = 'P5'
            opawnb5 = new Model3d(BlackPEntity, opawnb5,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		// White piece.-------------------------------------wp6-----------------------------
         elseif board[i][j] = 'p6'
            opawnw6 = new Model3d(WhitePEntity, opawnw6,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.-------------------------------------bp6---------------------------
         elseif board[i][j] = 'P6'
            opawnb6 = new Model3d(BlackPEntity, opawnb6,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		// White piece.-----------------------------------wp7---------------------------
         elseif board[i][j] = 'p7'
            opawnw7 = new Model3d(WhitePEntity, opawnw7,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.-----------------------------------bp7----------------------------
         elseif board[i][j] = 'P7'
            opawnb7 = new Model3d(BlackPEntity, opawnb7,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
		// White piece.------------------------------------wp8---------------------------
         elseif board[i][j] = 'p8'
            opawnw8 = new Model3d(WhitePEntity, opawnw8,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         // Black piece.-----------------------------------bp8-----------------------------------
         elseif board[i][j] = 'P8'
            opawnb8 = new Model3d(BlackPEntity, opawnb8,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok



	//---------------Delete piece----------
    func deletepiece(board, i, j)

			piece =board[i][j]

			if      piece = 'kr'   okingw.removecomponent()   
			elseif piece = 'Kl'   okingb.removecomponent()   
			elseif piece = 'qr'   oqueenw.removecomponent() 
			elseif piece = 'Ql'   oqueenb.removecomponent()
			elseif piece = 'br'   oBishopwr.removecomponent()
			elseif piece = 'Br'   oBishopbr.removecomponent() 
			elseif piece = 'bl'   oBishopwl.removecomponent() 
			elseif piece = 'Bl'   oBishopbl.removecomponent() 
			elseif piece = 'nr'   oknightwr.removecomponent() 
			elseif piece = 'Nr'   oknightbr.removecomponent() 
			elseif piece = 'nl'   oknightwl.removecomponent() 
			elseif piece = 'Nl'   oknightbl.removecomponent() 
			elseif piece = 'rr'    orookwr.removecomponent()  
			elseif piece = 'Rr'   orookbr.removecomponent()  
			elseif piece = 'rl'    orookwl.removecomponent() 
			elseif piece = 'Rl'   orookbl.removecomponent() 
			elseif piece = 'p1'   opawnw1.removecomponent()
			elseif piece = 'P1'   opawnb1.removecomponent() 	
			elseif piece = 'p2'   opawnw2.removecomponent() 	
			elseif piece = 'P2'   opawnb2.removecomponent() 
			elseif piece = 'p3'   opawnw3.removecomponent() 
			elseif piece = 'P3'   opawnb3.removecomponent() 
			elseif piece = 'p4'   opawnw4.removecomponent() 
			elseif piece = 'P4'   opawnb4.removecomponent() 
			elseif piece = 'p5'   opawnw5.removecomponent()
			elseif piece = 'P5'   opawnb5.removecomponent() 
			elseif piece = 'p6'   opawnw6.removecomponent() 
			elseif piece = 'P6'   opawnb6.removecomponent() 
			elseif piece = 'p7'   opawnw7.removecomponent() 
			elseif piece = 'P7'   opawnb7.removecomponent() 
			elseif piece = 'p8'   opawnw8.removecomponent() 
			elseif piece = 'P8'   opawnb8.removecomponent()  
			ok


