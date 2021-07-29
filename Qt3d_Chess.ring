#------------------------------------------------
# Chess3d Qt3D
#   
# Author :Azzeddine Remmal 
#-------------------------------------------------

Load "lib.ring"

  
oApp = new qApp {

  new DisplayGame{StartNewGame()} 
   exec()

 }
 
//--------------------------
func pRightClick()
  
		   if mouseRightClick
		
		      y = oFilter.gety()
		      x = oFilter.getx()
		      roll   = (y-motionLastY) / 10
		      rotate = (x-motionLastX) / 10
		      oQ = new QQuaternion(0,0,0,0)
		
		      oCameraEntity{
		                     tiltAboutViewCenter(roll)
		                    rotateAboutViewCenter(oQ.fromAxisAndAngle(new QVector3D(0, 1, 0), rotate))
		     				 }
		
		      motionLastX = x
		      motionLastY = y
		   ok

//--------------------------
func MouseRelease()

  			 mouseRightClick=false

//----------------
/*func DeliteAdd()
		ologo_Entity.removeComponent(ologo)
		ologo_Entity.removeComponent(ologo_Picker)
		ologo_Entity.removeComponent(ologo_Material)
		ologo_Entity.removeComponent(ologo_Transform)		
*/
//---------------------------------
func pKeyPress()
       
			nKey = oFilter.getkeycode()
			  
			oX = oCameraEntity.position().x()
			oY = oCameraEntity.position().y() 
			oZ = oCameraEntity.position().z()
			switch nKey
				on Qt_Key_Right
					//oX+=2
				on Qt_Key_Left
					//oX-=2 
				on Qt_Key_Up
					//oZ+=2 
				on Qt_Key_Down
					//oZ-=2 
				on Qt_Key_Shift
					//oZ+=2
				on Qt_Key_Control
					//oZ-=2
				on Qt_Key_Escape
					oApp.Quit()
			off
			oCameraEntity.setposition(new QVector3D(oX, oY, oZ))
		

//---------------------------
func  MsgWhite(MSG)

		   otext3d{
		            setText3D(MSG,40)
		            SetTextColor(white)
		   }
//---------------------------
func  MsgBlack(MSG)

		   otext3d{
		            setText3D(MSG,40)
		            SetTextColor(Brown)
		   }


//-------------------------------
func RandomList(aInput)

		   aOutput = []
		   while len(aInput) > 1
		      nIndex = random(len(aInput)-1)
		      nIndex++
		      aOutput = aInput[nIndex]
		      del(aInput,nIndex)
		   end
		
		return aOutput


//--------------------------------
func SayText(Text)

		   new qTextToSpeech(oView) {
		                              Say(Text)
		                              setRate(-0.2)
		   }


//--------------------------
func MsgBox(text)

		   msg = new QMessageBox(oWidget){
               setWindowTitle( oWidget.WindowTitle() )
               setText(text)
               show()
	         }

//--------------------------
func FrameAction()

   

			   if Camturn
			     
			      Camangle+=0.005
			
			      if Camangle>=1.34 Camturn = false  Camangle = 0  ok
			
				      oQ = new QQuaternion(0,0,0,0)
				      oCameraEntity.rotateAboutViewCenter(oQ.fromAxisAndAngle(new QVector3D(0, 1, 0), Camangle))
				
			   ok
			//---------------------------
			/*   for u =1 to len(aPlanets)
			      angpl+=0.0095
			      if angpl >=360  angpl = 0  ok
			
			      oQ = new QQuaternion(0,0,0,0)
			      aPlanets[u][:oPlanetsTransform].setRotation(oQ.fromAxisAndAngle(new QVector3D(0, 1, 0), angpl))
			
			   next
			//----------------------------
			  anglePlanet      += 0.0005
			   PlanetPosx  = cos(anglePlanet)*500
			   PlanetPosz  = sin(anglePlanet)*500
			   PlanetPosy  = 50.0
			   aPlanets[1][:oPlanetsTransform].setTranslation(new QVector3D(PlanetPosx , PlanetPosy , PlanetPosz))
			*/
			   if mouseRightClick  pRightClick()  ok
			
				
			
			
//----- Gets called when a player clicks on a new tile or piece.
func HandleNewSelection( i, j)

		   piece = board[i][j]
		
		   // ---------Selecting own turn's piece.----------
		   if    piece != ' '  and  ((iswhitepiece(piece) and turn = 'W') or (isblackpiece(piece) and turn = 'B'))
		
						      selectionI = i
						      selectionJ = j
			
		   // -------Trying to move a selected piece--------
		   elseif selectionI > 0 and selectionJ > 0
		   
				     if EnPassant(board, selectionI, selectionJ, i,j) ok
				      
				     if CasteleKing(board, selectionI, selectionJ, i,j) ok
				     
				     if DrawProPawn(board, selectionI, selectionJ, i,j)   ok
				     
				     if validMove(board, selectionI, selectionJ, i, j, turn)
							   deletepiece(board, i, j)
						       board[i][j] = board[selectionI][selectionJ]
							   deletepiece(board, selectionI, selectionJ)					
							   redrowpiece(board, i, j)	
								board[selectionI][selectionJ] = ' '	
						         selectionI = 0
						         selectionJ = 0	
						      if turn = 'W'
						                if isCheckMate(board, 'B')
						                   MsgWhite(MSG_WIN)
						                   MsgBlack( MSG_LOSE)									
							            else
							               turn = 'B'            
							                if not DrawPromotionPawn MsgBlack(MSG_YOUR_TURN) ok
									if not DrawPromotionPawn Camturn = true ok			
							            ok				
						  		else
								         if isCheckMate(board, 'W')
								             MsgWhite( MSG_LOSE)
								             MsgBlack( MSG_WIN)						    		
								         else
								             turn = 'W'
								             if not DrawPromotionPawn MsgWhite( MSG_YOUR_TURN) ok
								             if not DrawPromotionPawn Camturn = true ok	
								         ok				
						   		ok
					 else				
							      if isCheck(board, turn)
		
									         if turn = 'W'
									            MsgWhite(MSG_CHECK)
									         else										
									            MsgBlack(MSG_CHECK)
									         ok								
							      else				
									         if turn = 'W'
									            MsgWhite(MSG_INVALID)
									         else
									            MsgBlack(MSG_INVALID)
									         ok
					              ok						 
					      selectionI = 0
					      selectionJ = 0
				   ok					
			ok
			
		
		Update()		

//-----------------
func mouseIn()

// -----Handles mouse click inputs--------
func mouseInput(i,j)
			
			   button = oFilter.getbutton()		  
			   // ---Left click down -----
			   if button = 1	
			      if i >=1 and i <= 8 and j >=1 and j < =8		
			         HandleNewSelection(i,j)		
			      // Outside of the board.
			      else			
			          selectionI = 0
			          selectionJ = 0
			      ok		
			   //------ Right click down event. 
			   elseif button = 2
			      mouseRightClick=true
			
			   ok

//----------------------------------------------------
func CasteleKing(board, fromI, fromJ, toI,toJ)

	Piece = Board[fromI][fromJ]
    
	if Piece ='kr' and fromJ = 4 and    toJ = 2 and Board[1][1] = 'rr' and 
					Board[1][2] = ' ' and Board[1][3] = ' ' 
		deletepiece(board,1, 1)
		Board[1][1] = ' ' 
		Board[1][3]  = 'rr'
		redrowpiece(board, 1, 3)

	elseif Piece = 'kr' and fromJ = 4 and  toJ = 6 and board[1][8] = 'rl' and 
			board[1][7] = ' '  and board[1][6] = ' ' and board[1][5] = ' ' 
		deletepiece(board,1, 8)
		Board[1][8] = ' '
		Board[1][5]  = 'rl'
		redrowpiece(board, 1, 5)
		
	elseif Piece = 'Kl' and fromJ = 4 and toJ = 6 and board[8][8] = 'Rr' and
			 board[8][7] = ' ' and board[8][6] = ' '  and board[8][5] =  ' '
	 	deletepiece(board,8, 8)
		Board[8][8] = ' ' 
		Board[8][5]  = 'Rr'
		redrowpiece(board, 8, 5)
		
	
	elseif Piece = 'Kl' and fromJ = 4 and toJ = 2 and board[8][1] = 'Rl' and 
					board[8][2] =  ' ' and board[8][3] =  ' '
	    deletepiece(board,8, 1)
		Board[8][1] = ' ' 
		Board[8][3]  = 'Rl'
		redrowpiece(board, 8, 3)
	ok
//----------------------------------------------------
func EnPassant(board, fromI, fromJ, toI,toJ)

		 Piece = Board[fromI][fromJ]
		
		if ispawnwhite(Piece) and fromI = 5 and toJ =fromJ+1  and 
		   validMove(board, 7, fromJ+1, 5, toJ+1, 'B') and 
			ispawnblack(Board[fromI][fromJ+1])

				 deletepiece(board,fromI, fromJ+1)
				 Board[fromI][fromJ+1] = ' '  
		
		elseif ispawnwhite(Piece) and fromI = 5 and toJ =fromJ-1 and 
				validMove(board, 7, fromJ-1, 5, toJ-1, 'B') and
				 ispawnblack(Board[fromI][fromJ-1])

				 deletepiece(board,fromI, fromJ-1)
				 Board[fromI][fromJ-1] = ' ' 
		
		
		elseif ispawnblack(Piece) and fromI = 4 and toJ =fromJ+1  and 
			  validMove(board, 2, fromJ+1, 4, toJ+1, 'W') and 
				ispawnwhite(Board[fromI][fromJ+1])

				 deletepiece(board,fromI, fromJ+1)
				 Board[fromI][fromJ+1] = ' '  
		
		elseif ispawnblack(Piece) and fromI = 4  and toJ =fromJ-1 and 
				 validMove(board, 2, fromJ-1, 4, toJ-1, 'W') and
				 ispawnwhite(Board[fromI][fromJ-1])

				 deletepiece(board,fromI, fromJ-1)
				 Board[fromI][fromJ-1] = ' ' 
		ok	

//----------------------------------------------------
func DrawProPawn(board, fromI, fromJ, toI,toJ)

	        Piece = Board[fromI][fromJ]	

			if ispawnwhite(Piece) and fromI = 7 and toI = 8
					DrawPromotionPawn =true
					otext3d{
						       setText3D("Choose Pawn promotion",100)
						       SetTextColor(Blue)
								SetTextPos(40, 50, 190)
						   }
					 for i = 1 to 4
				     		     v = i * 15
						         aProPawn[i]=[]
						         aProPawn[i][:oProPawn] = new  QMesh(aProPawn[i][:oProPawnEntity])
						         aProPawn[i][:oProPawnTransform] = new  QTransform(aProPawn[i][:oProPawn]){
						                                               setTranslation(new QVector3D(-70+(v+v),0.1, 100))
																	   setScale(0.3)
																	   oQ = new QQuaternion(0,0,0,0)
																       SetRotation(oQ.FromAxisAndAngle(new QVector3D(0, 1, 0), 270))
							                                      	  }
						         aProPawn[i][:oProPawnLoader] = new  QTextureLoader(aProPawn[i][:oProPawn]){
														setSource(new QUrl("file:///"+currentdir() + "/textures/WhiteProPaw.png" ) )
														}
						         aProPawn[i][:oProPawnMaterial] = new QTextureMaterial(aProPawn[i][:oProPawn]){
						                                           setTexture(aProPawn[i][:oProPawnLoader])
						                                    	   }
						         aProPawn[i][:oProPawnPicker ]= new qObjectPicker(aProPawn[i][:oProPawn]){
							                                     setclickedevent("setPawnPromotion("+i+","+ toI+","+toJ+")")
																  }
						         aProPawn[i][:oProPawnEntity] = new QEntity(oRootEntity){
						                                          addComponent(aProPawn[i][:oProPawn])
						                                          addComponent(aProPawn[i][:oProPawnMaterial])
						                                          addComponent(aProPawn[i][:oProPawnTransform])
						                                          addComponent(aProPawn[i][:oProPawnPicker ])
						                                   		 }
					 next
				
					 aProPawn[1][:oProPawn].setSource(new QUrl("file:///"+currentdir() + "/models/queen.obj"))
					 aProPawn[2][:oProPawn].setSource(new QUrl("file:///"+currentdir() + "/models/bishop.obj"))
					 aProPawn[3][:oProPawn].setSource(new QUrl("file:///"+currentdir() + "/models/knight.obj"))
					 aProPawn[4][:oProPawn].setSource(new QUrl("file:///"+currentdir() + "/models/rook.obj"))
				
			elseif ispawnblack(Piece) and fromI = 2 and toI = 1
					DrawPromotionPawn =true
					otext3d{
						       setText3D("Choose Pawn promotion",100)
						       SetTextColor(Blue)
								SetTextPos(-60, 50, -190)
						   }
					 for i = 1 to 4
				     		     v = i * 15
						         aProPawn[i]=[]
						         aProPawn[i][:oProPawn] = new  QMesh(aProPawn[i][:oProPawnEntity])
						         aProPawn[i][:oProPawnTransform] = new  QTransform(aProPawn[i][:oProPawn]){
						                                               setTranslation(new QVector3D(-70+(v+v),0.1, -100))
																	   setScale(0.3)
																	   oQ = new QQuaternion(0,0,0,0)
																       SetRotation(oQ.FromAxisAndAngle(new QVector3D(0, 1, 0), 270))
							                                      	  }
						         aProPawn[i][:oProPawnLoader] = new  QTextureLoader(aProPawn[i][:oProPawn]){
														setSource(new QUrl("file:///"+currentdir() + "/textures/BlackProPaw.png" ) )
														}
						         aProPawn[i][:oProPawnMaterial] = new QTextureMaterial(aProPawn[i][:oProPawn]){
						                                           setTexture(aProPawn[i][:oProPawnLoader])
						                                    	   }
						         aProPawn[i][:oProPawnPicker ]= new qObjectPicker(aProPawn[i][:oProPawn]){
							                                     setclickedevent("setPawnPromotion("+i+","+ toI+","+toJ+")")
																  }
						         aProPawn[i][:oProPawnEntity] = new QEntity(oRootEntity){
						                                          addComponent(aProPawn[i][:oProPawn])
						                                          addComponent(aProPawn[i][:oProPawnMaterial])
						                                          addComponent(aProPawn[i][:oProPawnTransform])
						                                          addComponent(aProPawn[i][:oProPawnPicker ])
						                                   		 }
					 next
				
					 aProPawn[1][:oProPawn].setSource(new QUrl("file:///"+currentdir() + "/models/queen.obj"))
					 aProPawn[2][:oProPawn].setSource(new QUrl("file:///"+currentdir() + "/models/bishop.obj"))
					 aProPawn[3][:oProPawn].setSource(new QUrl("file:///"+currentdir() + "/models/knight.obj"))
					 aProPawn[4][:oProPawn].setSource(new QUrl("file:///"+currentdir() + "/models/rook.obj"))
			ok
			
//-------------------------------------
func RemoveProPawnComponent()

			 for i = 1 to 4
				aProPawn[i][:oProPawnEntity].removeComponent(aProPawn[i][:oProPawn])
				aProPawn[i][:oProPawnEntity].removeComponent(aProPawn[i][:oProPawnMaterial])
				aProPawn[i][:oProPawnEntity].removeComponent(aProPawn[i][:oProPawnTransform])
				aProPawn[i][:oProPawnEntity].removeComponent(aProPawn[i][:oProPawnPicker ])	
			next
	
//----------------------
func setPawnPromotion( targetID, toI, toJ)
		
	 Piece =  board[toI][toJ]	

	switch targetID

			on 1  	if ispawnwhite(Piece)		
						deletepiece(board,toI, toJ)
						Board[toI][toJ] = ' ' 
						Board[toI][toJ]  = 'ppqw'
						redrowpiece(board, toI, toJ)
						RemoveProPawnComponent()
						DrawPromotionPawn = false
						Camturn = true
				else
						deletepiece(board,toI, toJ)
						Board[toI][toJ] = ' ' 
						Board[toI][toJ]  = 'ppqb'
						redrowpiece(board, toI, toJ)
						RemoveProPawnComponent()
						DrawPromotionPawn = false
						Camturn = true
				ok
			on 2  	if ispawnwhite(Piece)		
						deletepiece(board,toI, toJ)
						Board[toI][toJ] = ' ' 
						Board[toI][toJ]  = 'ppbw'
						redrowpiece(board, toI, toJ)
						RemoveProPawnComponent()
						DrawPromotionPawn = false
						Camturn = true
				else
						deletepiece(board,toI, toJ)
						Board[toI][toJ] = ' ' 
						Board[toI][toJ]  = 'ppbb'
						redrowpiece(board, toI, toJ)
						RemoveProPawnComponent()
						DrawPromotionPawn = false
						Camturn = true
				ok
		    on 3  	if ispawnwhite(Piece)		
						deletepiece(board,toI, toJ)
						Board[toI][toJ] = ' ' 
						Board[toI][toJ]  = 'ppkw'
						redrowpiece(board, toI, toJ)
						RemoveProPawnComponent()
						DrawPromotionPawn = false
						Camturn = true
				else
						deletepiece(board,toI, toJ)
						Board[toI][toJ] = ' ' 
						Board[toI][toJ]  = 'ppkb'
						redrowpiece(board, toI, toJ)
						RemoveProPawnComponent()
						DrawPromotionPawn = false
						Camturn = true
				ok
			on 4    if ispawnwhite(Piece)		
						deletepiece(board,toI, toJ)
						Board[toI][toJ] = ' ' 
						Board[toI][toJ]  = 'pprw'
						redrowpiece(board, toI, toJ)
						RemoveProPawnComponent()
						DrawPromotionPawn = false
						Camturn = true
				else
						deletepiece(board,toI, toJ)
						Board[toI][toJ] = ' ' 
						Board[toI][toJ]  = 'pprb'
						redrowpiece(board, toI, toJ)
						RemoveProPawnComponent()
						DrawPromotionPawn = false
						Camturn = true
				ok
   		 off

		   
// ----------Check that a move attempt is valid---------	
func validMove(board, fromI, fromJ, toI, toJ, turn)
		
			     piece = board[fromI][fromJ]
			     dy = fabs(fromI - toI)
			     dx = fabs(fromJ - toJ)	 
			    //--------- Any pawn---------
			    if  ispawnpiece( piece) 
				        // ----Black pawn------
				        if ispawnblack( piece)
					            if fromI != 7 and dy > 1 return false  ok 
					            if fromI = 7 and dy > 2 return false  ok
						    if fromI != 4 and dx > 0 and (dx != 1 or dy != 1 or board[toI][toJ] = ' ') return false  ok
						    if fromI = 4 and dx > 0 and (dx != 1 or dy != 1  ) return false  ok
					            if fromI - toI < 0 return false   ok	       
				        //----- White pawn------
				        elseif ispawnwhite( piece)
					            if fromI != 2 and dy > 1 return false  ok
					            if fromI = 2 and dy > 2 return false  ok
						    if fromI != 5 and dx > 0 and (dx != 1 or dy != 1 or board[toI][toJ] = ' ') return false  ok
						    if fromI = 5 and dx > 0 and (dx != 1 or dy != 1) return false  ok
					            if fromI - toI > 0 return false  ok
				        ok
				        if dy > 0 and dx = 0 and board[toI][toJ] != ' '  return false  ok
				        if not isClear(board, fromI, fromJ, toI, toJ)  return false  ok			   
				ok
			    // -----------Any rook------------
			    if  piece = 'Rr' or piece = 'rr' or piece = 'Rl' or piece = 'rl' or piece = 'pprw' or piece = 'pprb' 
				        if dx > 0 and dy > 0 return false ok
				        if  not isClear(board, fromI, fromJ, toI, toJ) return false ok			   
				ok
			    // ----------Any knight-------------
			    if  piece = 'Nr' or piece = 'nr' or piece = 'Nl' or  piece = 'nl' or piece = 'ppkw' or piece = 'ppkb' 
			        	if  not ((dx = 1 and dy = 2) or (dx = 2 and dy = 1)) return false ok			    
				ok
			    // ----------Any bishop------------
			    if  piece = 'Br' or piece = 'br' or piece = 'Bl' or piece = 'bl' or piece = 'ppbw' or piece = 'ppbb'
				        if dx != dy return false ok
				        if  not isClear(board, fromI, fromJ, toI, toJ)  return false  ok			    
				ok
			    // --------Any queen------
			    if  piece = 'Ql' or piece = 'qr' or piece = 'ppqw' or piece = 'ppqb'
			        if dx > 0 and dy > 0 and dx != dy return false ok
			        if not isClear(board, fromI, fromJ, toI, toJ) return false ok		    
				ok
			    // --------Any king--------
			     if  piece = 'kr'
					if not (fromI =1 and fromJ =4 and dx = 2 and dy = 0) and
								 (dx >1 or dy >1)  return false ok
					elseif piece = 'Kl' 
					if not (fromI =8 and fromJ =4 and dx = 2 and dy = 0) and
								(dx >1 or dy >1)  return false ok
			   ok
			  
       			 	
			    //---- Temporarily change the board to look for check--------
			    check = false
			    temp = board[toI][toJ]
			    board[toI][toJ] = board[fromI][fromJ]
			    board[fromI][fromJ] = ' '			
			   if isCheck(board, turn)   check = true  ok			
			    // -------Return the board to normal------
			    board[fromI][fromJ] = board[toI][toJ]
			    board[toI][toJ] = temp
				
	return  !check 

// ------------Check that there are no pieces between two points on the board.--------	
func isClear( board, fromI, fromJ, toI, toJ )
	
			    dy = fromI - toI
			    dx = fromJ - toJ	
			    if  dx > 0  dx = 1  ok
			    if  dy > 0  dy = 1  ok
			    if  dx < 0  dx = -1 ok
			    if  dy < 0  dy = -1 ok
			
			    while fromI-dy != toI or fromJ-dx != toJ
				        fromI -= dy
				        fromJ -= dx	
				        if board[fromI][fromJ] != ' '
				            	return false
				        ok
			    end
			    return true


			   	
// ------Check if a player is in check---------	
func isCheck( board, player)
	
			    for  i = 1 to 8
				        for   j = 1 to 8					 
					            if  (player = 'W' and board[i][j] = 'kr' ) or (player = 'B' and board[i][j] = 'Kl' )
					                kingI = i 
					                kingJ = j 
					            ok
				        next
			    next	
			    return  isChecke(board, player, kingI, kingJ)
			
			
// -------Check if a player is in check based on the position of their king---------------	
func isChecke( board, player, kingI, kingJ)
	
			  for  i = 1 to 8
			       for  j = 1 to 8
			            if player = 'W' and  isblackpiece(board[i][j])
				                  if validMove(board, i, j, kingI, kingJ, 'B') 
										 return  true  
								  ok			            
			           	 elseif  player = 'B' and iswhitepiece(board[i][j]) 
				               if validMove(board, i, j, kingI, kingJ, 'W')   
										 return  true 
								   ok
			             ok
			       	next
			  next
			
			  return  false	
			 	
// ---------------Check if a player is in checkmate------------
func isCheckMate( board, player)
			     
			    for  i = 1 to 8
			        for  j = 1 to 8						
			            if (player = 'B' and board[i][j] = 'kr') or (player = 'W' and board[i][j] = 'Kl')
			                kingI = i 
			                kingJ = j 
			            ok
			        next
			    next			
			    king = board[kingI][kingJ]	
			    board[kingI][kingJ] = ' '
			
			    nonChecks = 0
			    for  i = -1 to 2
				for j = -1 to 2
				     newKingI = kingI + i   
				     newKingJ = kingJ + j   					
				    if  newKingI < 1 or newKingI > 8 or  newKingJ < 1 or newKingJ > 8   loop ok
				    if player = 'W' and  isblackpiece(board[newKingI][newKingJ])    loop ok
				    if player = 'B' and  iswhitepiece(board[newKingI][newKingJ])    loop ok					
				     temp = board[newKingI][newKingJ]
				    board[newKingI][newKingJ] = king					
				    if isChecke(board, player, newKingI, newKingJ)  nonChecks++ ok					
				    board[newKingI][newKingJ] = temp									
				next
			    next			
			    board[kingI][kingJ] = king
				
			    return nonChecks = 0
			
//-------Check out the white pieces---------
func iswhitepiece(piecewhite )
					
				 if  Find(awhitepiece, piecewhite) >0 return  true  else  return  false ok 	
//------Check out the black pieces----------
func isblackpiece(pieceblack)
				    
	 			if Find(ablackpiece, pieceblack) >0 return  true  else  return  false ok 		
//---------------------------------------	
func ispawnpiece(piecepawn)
				
				if Find(apawnpiece, piecepawn)	>0 return  true  else  return  false ok 
//---------------------------------------	
func ispawnblack(blackpawn)
				
				if Find(apawnblack, blackpawn)	>0 return  true  else  return  false ok 
//---------------------------------------	
func ispawnwhite(whitepawn)
				
				if Find(apawnwhite, whitepawn)	>0 return  true  else  return  false ok 
														


