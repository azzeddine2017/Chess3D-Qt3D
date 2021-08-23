Load "Model3d.ring"
Load "stdlib.ring"


Class ChessBoard
 
		

//---------------------------- Draws the Board --------------------------
func DrowBoard()

							   oBoard = new Model3d(oRootEntity, oBoard, "models/Board.obj"){
							            setmodelsiz(0.23, 0.2, 0.23)
							            setmodelpos(0, 0, 0)
							           setModelDirection(0,1,0,degreeW)
							           setModelTexture("textures/chessBoard_wood.jpg")
									   setModelDirection( 0, 1, 0, 90)
							          }

//-----------------------------------
func DrowTiles()

							for i = 1 to 8
								     for  j = 1 to 8		
								         // -----Draws the white or black ---------
								         aTile[i][j]=[]
								         aTile[i][j][:oTile] = new  QPlaneMesh(aTile[i][j][:oTileEntity]){
					                                    setHeight(17)
					                                    setWidth(17)
					                                    setmeshresolution(new qSize(10,10))
					                            	  }
								         aTile[i][j][:oTileTransform] = new  QTransform(aTile[i][j][:oTile]){
					                                     setTranslation(new QVector3D(i*TILE_SIZE-76, 0.1, j*TILE_SIZE-76))
														 oQ = new QQuaternion(0,0,0,0)
												       SetRotation(oQ.FromAxisAndAngle(new QVector3D(0, 1, 0), 180))
					                                   }
								         aTile[i][j][:oLoader] = new  QTextureLoader(aTile[i][j][:oTile])
								         aTile[i][j][:oTileMaterial] = new QTextureMaterial(aTile[i][j][:oTile]){
					                                   setTexture(aTile[i][j][:oLoader])
					                                    }
								         aTile[i][j][:oPicker ]= new qObjectPicker(aTile[i][j][:oTile]){
					                                    setclickedevent(method("mouseInput("+i+","+j+")"))
													    }
								         aTile[i][j][:oTileEntity] = new QEntity(oRootEntity){
					                                    addComponent(aTile[i][j][:oTile])
					                                    addComponent(aTile[i][j][:oTileMaterial])
					                                    addComponent(aTile[i][j][:oTileTransform])
					                                    addComponent(aTile[i][j][:oPicker ])
					                                   	}
											 if (i+j)%2 and  isOngame = 0
										               aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/lightWood.jpg") )		
									         else					
											            aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/darkWood.jpg") )
											ok
								 	next
							 next



	
//-------------------------------												
func MackeMove( Move)
													
							 fromI = move.fromI
							 fromJ = move.fromJ
							 toI		= move.toi
							 toJ      = move.toj
							whiteAdvantage += getAdvChange(move, true)
							? "whiteAdvantage :" + whiteAdvantage	
							  if CasteleKing(Board , fromI , fromJ , ToI , ToJ) ok
							  if EnPassant(Board , fromI , fromJ , ToI , ToJ) ok	
				 			  if DrawProPawn(Board , fromI , fromJ , ToI , ToJ)   ok
							  if Board[toI][toJ] != ' '  clearPieces(Board, toI, toJ) ok
						       Board[toI][toJ] = Board[fromI][fromJ]
							   clearPieces(Board, fromI, fromJ)					
							   DrowPiece(Board, toI, toJ)
							   Board[fromI][fromJ] = ' '	
							   LastMove = Move	
			
//----------------------------------------------------
func CasteleKing(Board , fromI , fromJ , ToI , ToJ)
									
							Piece = Board[fromI][fromJ]
							if Piece ='kr' and fromJ = 4 and toJ = 2 and Board[1][1] = 'rr' and 
															Board[1][2] = ' ' and Board[1][3] = ' ' 
								clearPieces(Board,1, 1)
								Board[1][1] = ' ' 
								Board[1][3]  = 'rr'
								DrowPiece(Board, 1, 3)
						
							elseif Piece = 'kr' and fromJ = 4 and	toJ = 6 and Board[1][8] = 'rl' and 
												Board[1][7] = ' '  and Board[1][6] = ' ' and Board[1][5] = ' ' 
								clearPieces(Board,1, 8)
								Board[1][8] = ' '
								Board[1][5]  = 'rl'
								DrowPiece(Board, 1, 5)
								
							elseif Piece = 'Kl' and fromJ = 4 and toJ = 6 and Board[8][8] = 'Rr' and
													 Board[8][7] = ' ' and Board[8][6] = ' '  and Board[8][5] =  ' '
							 	clearPieces(Board,8, 8)
								Board[8][8] = ' ' 
								Board[8][5]  = 'Rr'
								DrowPiece(Board, 8, 5)
								
							
							elseif Piece = 'Kl' and fromJ = 4 and	toJ = 2 and Board[8][1] = 'Rl' and 
												Board[8][2] =  ' ' and Board[8][3] =  ' '
							    clearPieces(Board,8, 1)
								Board[8][1] = ' ' 
								Board[8][3]  = 'Rl'
								DrowPiece(Board, 8, 3)
							ok
								
//----------------------------------------------------
func EnPassant(Board , fromI , fromJ , ToI , ToJ)

							
							 Piece = Board[fromI][fromJ]
							 // ?Piece
						     //?"fromI"+ fromI+"-"+toI  ?"fromJ"+ fromJ+"-"+toJ
					
							if ispawnwhite(Piece) and fromI = 5 and toJ =fromJ+1  and 
							
								ispawnblack(Board[fromI][fromJ+1])
					
									 clearPieces(Board,fromI, fromJ+1)
									 Board[fromI][fromJ+1] = ' '  
							
							elseif ispawnwhite(Piece) and fromI = 5 and toJ =fromJ-1 and 
								
									 ispawnblack(Board[fromI][fromJ-1])
					
									 clearPieces(Board,fromI, fromJ-1)
									 Board[fromI][fromJ-1] = ' ' 
							
							
							elseif ispawnblack(Piece) and fromI = 4 and toJ =fromJ+1  and 
								
									ispawnwhite(Board[fromI][fromJ+1])
					
									 clearPieces(Board,fromI, fromJ+1)
									 Board[fromI][fromJ+1] = ' '  
							
							elseif ispawnblack(Piece) and fromI = 4  and toJ =fromJ-1 and 
									
									 ispawnwhite(Board[fromI][fromJ-1])
					
									 clearPieces(Board,fromI, fromJ-1)
									 Board[fromI][fromJ-1] = ' ' 
							ok	
					
//----------------------------------------------------
func DrawProPawn(Board , fromI , fromJ , ToI , ToJ)

							
						   Piece = Board[fromI][fromJ]	
					
							if ispawnwhite(Piece) and fromI = 7 and toI = 8
										DrawPromotionPawn =true
										otext3d{
											       setText3D("Choose Pawn promotion",100)
											       SetTextColor(Lime)
													SetTextPos(40, 40, 220)
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
												                                     setclickedevent(method("setPawnPromotion("+i+","+ toI+","+toJ+")"))
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
											       SetTextColor(Lime)
													SetTextPos(60, 40, 220)
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
												                                     setclickedevent(method("setPawnPromotion("+i+","+ toI+","+toJ+")"))
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
								
//--------------------------------------
func RemoveProPawnComponent()

							 for i = 1 to 4
								aProPawn[i][:oProPawnEntity].removeComponent(aProPawn[i][:oProPawn])
								aProPawn[i][:oProPawnEntity].removeComponent(aProPawn[i][:oProPawnMaterial])
								aProPawn[i][:oProPawnEntity].removeComponent(aProPawn[i][:oProPawnTransform])
								aProPawn[i][:oProPawnEntity].removeComponent(aProPawn[i][:oProPawnPicker ])	
							next
	

// ----------Check that a move attempt is valid---------	
func ValidMove(Board , fromI , fromJ , toi , toj ,  turn)

								
								     piece = Board[fromI][fromJ]
								     dy = fabs(fromI - toI)
								     dx = fabs(fromJ - toJ)	 
								    //--------- Any pawn---------
								    if  ispawnpiece( piece) 
									        // ----Black pawn------
									        if ispawnblack( piece)
										            if fromI != 7 and dy > 1 return false  ok 
										            if fromI = 7 and dy > 2 return false  ok
													if fromI != 4 and dx > 0 and (dx != 1 or dy != 1 or Board[toI][toJ] = ' ') return false  ok
													if fromI = 4 and dx > 0 and (dx != 1 or dy != 1) return false  ok
										            if fromI - toI < 0 return false   ok	       
									        //----- White pawn------
									        elseif ispawnwhite( piece)
										            if fromI != 2 and dy > 1 return false  ok
										            if fromI = 2 and dy > 2 return false  ok
													if fromI != 5 and dx > 0 and (dx != 1 or dy != 1 or Board[toI][toJ] = ' ') return false  ok
													if fromI = 5 and dx > 0 and (dx != 1 or dy != 1) return false  ok
										            if fromI - toI > 0 return false  ok
									        ok
									      //  if dx > 0 and (dx != 1 or dy != 1 or Board[toI][toJ] = ' ' ) return false  ok
									        if dy > 0 and dx = 0 and Board[toI][toJ] != ' ' return false  ok
									        if not isClear(Board , fromI , fromJ , toi , toj)  return false  ok			   
									ok
								    // -----------Any rook------------
								    if  piece = 'Rr' or  piece = 'rr' or  piece = 'Rl' or  piece = 'rl' or  piece = 'pprw' or  piece = 'pprb'  
									        if dx > 0 and dy > 0 return false ok
									        if  not isClear(Board , fromI , fromJ , toi , toj) return false ok			   
									ok
								    // ----------Any knight-------------
								    if  piece = 'Nr' or  piece = 'nr' or  piece = 'Nl' or  piece = 'nl' or  piece = 'ppkw' or  piece = 'ppkb' 
								        	if  not ((dx = 1 and dy = 2) or (dx = 2 and dy = 1))  return false ok
													    
									ok
								    // ----------Any bishop------------
								    if  piece = 'Br' or   piece = 'br' or  piece = 'Bl' or  piece = 'bl' or  piece = 'ppbw' or  piece = 'ppbb'
									        if dx != dy return false ok
									        if  not isClear(Board , fromI , fromJ , toi , toj)  return false  ok			    
									ok
								    // --------Any queen------
								    if  piece = 'Ql' or  piece = 'qr' or  piece = 'ppqw' or  piece = 'ppqb'
									        if dx > 0 and dy > 0 and dx != dy return false ok
									        if not isClear(Board , fromI , fromJ , toi , toj) return false ok		    
									ok
								    // --------Any king--------
								    if  piece = 'kr'
											if  not (fromI =1 and fromJ =4 and dx = 2 and dy = 0) and
																	 (dx >1 or dy >1)  return false ok
											
									elseif  piece = 'Kl' 
											if  not (fromI =8 and fromJ =4 and dx = 2 and dy = 0) and
																	 (dx >1 or dy >1)  return false ok
											
								   ok
								  
					       			 	
								    //---- Temporarily change the Board to look for check--------
								    check = false
								    temp = Board[toI][toJ]
								    Board[toI][toJ] = Board[fromI][fromJ]
								    Board[fromI][fromJ] = ' '	
											
								   if isCheck(Board, turn )   check = true  ok			
								    // -------Return the Board to normal------
								    Board[fromI][fromJ] = Board[toI][toJ]
								    Board[toI][toJ] = temp
									
						return  !check 

// ------------Check that there are no pieces between two points on the Board.--------	
func isClear(Board , fromI , fromJ , toi , toj)
						
					    dy = fromI - toI
					    dx = fromJ - toJ	
					    if  dx > 0  dx = 1  ok
					    if  dy > 0  dy = 1  ok
					    if  dx < 0  dx = -1 ok
					    if  dy < 0  dy = -1 ok
					
					    while fromI - dy != toI  or  fromJ - dx  != toJ
						        fromI -= dy
						        fromJ -= dx	
						        if Board[fromI][fromJ] != ' '
						            	return false
						        ok
					    end
					    return true
		

			   	
// ------Check if a player is in check---------	
func isCheck( Board, player)

						 for  i = 1 to 8
						       	 for   j = 1 to 8			
					   					 
							            if  (player = TurnWhite  and Board[i][j] = 'kr' ) or (player = TurnBlack  and Board[i][j] = 'Kl' )
							                kingI = i 
							                kingJ = j 
							            ok
						        next
					      next	
						
			 return  isChecke(Board, player, kingI , kingJ)
			
			
// -------Check if a player is in check based on the position of their king---------------	
func isChecke( Board, player ,kingI ,kingJ)
									
							// kingI=Move.Toi
							// kingJ=Move.Toj
							  for  i = 1 to 8
							       for  j = 1 to 8
							            if player = TurnWhite  and  isblackpiece(Board[i][j])
								                  if validMove(Board , i , j , kingI , kingJ, TurnBlack )
														 return  true  
												  ok			            
							           	 elseif  player = TurnBlack  and iswhitepiece(Board[i][j])
								               if validMove(Board , i ,j, kingI , kingJ, TurnWhite )   
														 return  true 
												   ok
							             ok
							       	next
							  next
							
				 return  false	
			 	
// ---------------Check if a player is in checkmate------------
func isCheckMate( Board, player )
							
			   	 nonChecks = 0
				    for  i = 1 to 8
				        for  j = 1 to 8						
				            if (player = TurnBlack  and Board[i][j] = 'kr') or (player = TurnWhite  and Board[i][j] = 'Kl')
				                kingI = i 
				                kingJ = j  		
				            ok
				        next
				    next	
		
				   king = Board[kingI][kingJ]	
				   Board[kingI][kingJ] = ' '	 
				    
				    for  i = -1 to 1
					        for j = -1 to 1
						             newKingI = kingI + i
						             newKingJ = kingJ + j
	 					
						            if  newKingI < 1 or newKingI > 8 or  newKingJ < 1 or newKingJ > 8   loop ok
						            if player = TurnWhite  and  isblackpiece(Board[newKingI][newKingJ])    loop ok
						            if player = TurnBlack  and  iswhitepiece(Board[newKingI][newKingJ])    loop ok	
									
						            temp = Board[newKingI][newKingJ]
						            Board[newKingI][newKingJ] =king
										
						            if isChecke(Board, player, newKingI, newKingJ )   nonChecks++  ok	
								
						            Board[newKingI][newKingJ] = temp	
									 
										 
					        next
				    next					
				  Board[kingI][kingJ] = king	
	
			 return nonChecks = 0
			
//-------Check out the white pieces---------
func iswhitepiece(piecewhite )
					
								 if  Find(awhitepiece, piecewhite) > 0
										 return  true 
								 else
										  return  false 
								ok 	
//------Check out the black pieces----------
func isblackpiece(pieceblack)
				    
	 							if Find(ablackpiece, pieceblack) > 0 
										return  true 
								 else
										  return  false 
								ok 	
//---------------------------------------	
func ispawnpiece(piecepawn)
				
								if Find(apawnpiece, piecepawn) > 0
											return  true 
								 else
										  return  false 
								ok 	
//---------------------------------------	
func ispawnblack(blackpawn)
				
								if Find(apawnblack, blackpawn) > 0
										return  true 
								 else
										  return  false 
								ok 	
//---------------------------------------	
func ispawnwhite(whitepawn)
				
								if Find(apawnwhite, whitepawn) > 0 
										return  true 
								 else
										  return  false 
								ok 	

//------------------
func clearBoard()

							    if Board[1][1] = null
							       		 ? "delete no Board"
							        return 
							    ok
							    for i=1 to 8
								        for j=1 to 8
								           		Board[i][j] = null
								        next
							    next
//------------------
func SetNewBoard()

							    for i=1 to 8
								        for j=1 to 8
								         	  Board[i][j] = StartBoard[i][j]
								        next
							    next
							    if Board[8][8] != null
							     	   ? "The Board is filled"
							     ok

//------------------																											
func clearAllPieces()

			 					for i = 1 to 8
								    	for j = 1 to 8
											clearPieces(Board, i, j)
										next		
								next

//------------------------------------------
func DrowAllPiece()

								for i = 1 to 8
								    	for j = 1 to 8
											DrowPiece(Board, i, j)
										next		
								next

//-------------------------------
func Update()

					
   // For each tile on the Board...
   for i = 1 to 8

      for  j = 1 to 8		
								
		
			
         if (i+j)%2
				
	               aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/lightWood.jpg") )
	
	                if selectionI = i and selectionJ = j
	                  	 	aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/leem.jpg") )
									 
	     			 ok
			  
         else
			
		            aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/darkWood.jpg") )
		
			            if selectionI = i and selectionJ = j
			             	  aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/leem.jpg") )
									 
		       		ok	
			
		ok
		

		
		 if selectionI > 0 and selectionJ > 0 
                  	
				if Board[i][j] = ' '
						if validMove(Board , selectionI , selectionJ , i , j , currentTurn)
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/valid.png") )	
						ok
				
				elseif iswhitepiece(Board[i][j]) and currentTurn = TurnBlack 
						if validMove(Board , selectionI , selectionJ , i , j , currentTurn)
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/enemy.png") )	
						ok
				
				elseif isblackpiece(Board[i][j]) and currentTurn = TurnWhite 
						if validMove(Board , selectionI , selectionJ , i , j , currentTurn)
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/enemy.png") )	
						ok
				
				elseif iswhitepiece(Board[i][j]) and currentTurn = TurnWhite 
						if validMove(Board , selectionI , selectionJ , i , j , currentTurn)	
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/friend.png") )	
						ok
				
				elseif isblackpiece(Board[i][j]) and currentTurn = TurnBlack
							if validMove(Board , selectionI , selectionJ , i , j , currentTurn)
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/friend.png") )	
							ok
				ok
        	   
     	 ok
		
	
      // Draws a game piece.
          piece = Board[i][j]
      
      // White piece.
      if piece = 'kr'
				         okingw{
				               SetModelTexture("textures/WhitePiece.jpg")
				         }
				         if selectionI = i and selectionJ = j
				            okingw{
				                     SetModelTexture("textures/WhitePieceCliked.jpg")
				                 }
				         ok
		      // Black piece.
		      elseif piece = 'Kl'
				         okingb{
				               SetModelTexture("textures/BlackPiece.jpg")
				         }
				         if selectionI = i and selectionJ = j
				            okingb{
				                  SetModelTexture("textures/BlackPieceCliked.jpg")
				            }
				         ok
		      //---------------------------------------------------------------------
		      // White piece.
		      elseif piece = 'qr'
				         oqueenw{
				                  SetModelTexture("textures/WhitePiece.jpg")
				               }
				         if selectionI = i and selectionJ = j
				            oqueenw{
				                     SetModelTexture("textures/WhitePieceCliked.jpg")
				                  }
				         ok
		      // Black piece.
		      elseif piece = 'Ql'
				         oqueenb{
				                  SetModelTexture("textures/BlackPiece.jpg")
				               }
				         if selectionI = i and selectionJ = j
				            oqueenb{
				                     SetModelTexture("textures/BlackPieceCliked.jpg")
				                  }
				         ok
		      //------------------------------------------------------------------------
		      // White piece.
		      elseif piece = 'br'
				         oBishopwr{
				                  SetModelTexture("textures/WhitePiece.jpg")
				                }
				               if selectionI = i and selectionJ = j
				                  oBishopwr{
				                           SetModelTexture("textures/WhitePieceCliked.jpg")
				                          }
				               ok
		      // Black piece.
		      elseif piece = 'Br'
				         oBishopbr{
				                  SetModelTexture("textures/BlackPiece.jpg")
				                }
				         if selectionI = i and selectionJ = j
				            oBishopbr{
				                     SetModelTexture("textures/BlackPieceCliked.jpg")
				                   }
				         ok
		       // White piece.
		      elseif piece = 'bl'
				         oBishopwl{
				                  SetModelTexture("textures/WhitePiece.jpg")
				                }
				               if selectionI = i and selectionJ = j
				                  oBishopwl{
				                           SetModelTexture("textures/WhitePieceCliked.jpg")
				                          }
				               ok
		      // Black piece.
		      elseif piece = 'Bl'
				         oBishopbl{
				                  SetModelTexture("textures/BlackPiece.jpg")
				                }
				         if selectionI = i and selectionJ = j
				            oBishopbl{
				                     SetModelTexture("textures/BlackPieceCliked.jpg")
				                   }
				         ok
		      //------------------------------------------------------------------------
		      // White piece.
		      elseif piece = 'nr'
				         oknightwr{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				
				         if selectionI = i and selectionJ = j
				            oknightwr{
				                     SetModelTexture("textures/WhitePieceCliked.jpg")
				                   }
				         ok  
		      // Black piece.
		      elseif piece = 'Nr'
				         oknightbr{
				                  SetModelTexture("textures/BlackPiece.jpg")
				                }
				         if selectionI = i and selectionJ = j
				            oknightbr{
				                     SetModelTexture("textures/BlackPieceCliked.jpg")
				                   }
				         ok         
		      // White piece.
		      elseif piece = 'nl'
				         oknightwl{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				         if selectionI = i and selectionJ = j
				            oknightwl{
				                     SetModelTexture("textures/WhitePieceCliked.jpg")
				                   }
				         ok 
		      // Black piece.
		      elseif piece = 'Nl'
				         oknightbl{
				                  SetModelTexture("textures/BlackPiece.jpg")
				                }
					         if selectionI = i and selectionJ = j
					            oknightbl{
					                     SetModelTexture("textures/BlackPieceCliked.jpg")
					                   }
					         ok
		      //-------------------------------------------------------------------
		         // White piece.
		         elseif piece = 'rr'
			             orookwr{
			                     SetModelTexture("textures/WhitePiece.jpg")
			                  }
			                  if selectionI = i and selectionJ = j
			                     orookwr{
			                             SetModelTexture("textures/WhitePieceCliked.jpg")
			                          }
			                  ok
		         // Black piece.
		         elseif piece = 'Rr'
				            orookbr{
				                   SetModelTexture("textures/BlackPiece.jpg")
				                 }
				                  if selectionI = i and selectionJ = j
				                     orookbr{
				                            SetModelTexture("textures/BlackPieceCliked.jpg")
				                          }
				                  ok
		         // White piece.
		         elseif piece = 'rl'
				             orookwl{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				                 if selectionI = i and selectionJ = j
				                     orookwl{
				                             SetModelTexture("textures/WhitePieceCliked.jpg")
				                          }
				                  ok
		         // Black piece.
		         elseif piece = 'Rl'
				            orookbl{
				                   SetModelTexture("textures/BlackPiece.jpg")
				                 }
				                  if selectionI = i and selectionJ = j
				                     orookbl{
				                            SetModelTexture("textures/BlackPieceCliked.jpg")
				                          }
				                  ok
		         //-------------------------------------------------------------------------
		         // White piece.
		         elseif piece = 'p1'
				            opawnw1{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnw1{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
							ok
		         // Black piece.
		         elseif piece = 'P1'
				            opawnb1{
				                     SetModelTexture("textures/BlackPiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnb1{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'p2'
				            opawnw2{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnw2{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		         // Black piece.
		         elseif piece = 'P2'
				            opawnb2{
				                     SetModelTexture("textures/BlackPiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnb2{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'p3'
				            opawnw3{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnw3{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		         // Black piece.
		         elseif piece = 'P3'
				            opawnb3{
				                     SetModelTexture("textures/BlackPiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnb3{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'p4'
				            opawnw4{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnw4{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		         // Black piece.
		         elseif piece = 'P4'
				            opawnb4{
				                     SetModelTexture("textures/BlackPiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnb4{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'p5'
				            opawnw5{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnw5{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		         // Black piece.
		         elseif piece = 'P5'
				            opawnb5{
				                     SetModelTexture("textures/BlackPiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnb5{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'p6'
				            opawnw6{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnw6{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		         // Black piece.
		         elseif piece = 'P6'
				            opawnb6{
				                     SetModelTexture("textures/BlackPiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnb6{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'p7'
				            opawnw7{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnw7{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok	
		         // Black piece.
		         elseif piece = 'P7'
				            opawnb7{
				                     SetModelTexture("textures/BlackPiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnb7{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'p8'
				            opawnw8{
				                     SetModelTexture("textures/WhitePiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnw8{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		         // Black piece.
		         elseif piece = 'P8'
				            opawnb8{
				                     SetModelTexture("textures/BlackPiece.jpg")
				                  }
				            if selectionI = i and selectionJ = j
				               opawnb8{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'ppqw'
				            oProPawQuinW{
				                     SetModelTexture("textures/WhiteProPaw.png")
				                  }
				            if selectionI = i and selectionJ = j
				               oProPawQuinW{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		         // Black piece.
		         elseif piece = 'ppqb'
				            oProPawQuinB{
				                     SetModelTexture("textures/BlackProPaw.png")
				                  }
				            if selectionI = i and selectionJ = j
				               oProPawQuinB{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'pprw'
				            oProPawRookW{
				                     SetModelTexture("textures/WhiteProPaw.png")
				                  }
				            if selectionI = i and selectionJ = j
				               oProPawRookW{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		            
		         // Black piece.
		         elseif piece = 'pprb'
				            oProPawRookB{
				                     SetModelTexture("textures/BlackProPaw.png")
				                  }
				            if selectionI = i and selectionJ = j
				               oProPawRookB{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'ppbw'
				            oProPawBishopW{
				                     SetModelTexture("textures/WhiteProPaw.png")
				                  }
				            if selectionI = i and selectionJ = j
				               oProPawBishopW{
				                        SetModelTexture("textures/WhitePieceCliked.jpg")
				                     }
				            ok
		         // Black piece.
		         elseif piece = 'ppbb'
				            oProPawBishopB{
				                     SetModelTexture("textures/BlackProPaw.png")
				                  }
				            if selectionI = i and selectionJ = j
				               oProPawBishopB{
				                        SetModelTexture("textures/BlackPieceCliked.jpg")
				                     }
				            ok
				//----------------------------------------------------------------------------
				 // White piece.
		         elseif piece = 'ppkw'
				            oProPawknightW{
				                     SetModelTexture("textures/WhiteProPaw.png")
				                  }
				            if selectionI = i and selectionJ = j
					               oProPawknightW{
					                        SetModelTexture("textures/WhitePieceCliked.jpg")
					                     }
				            ok
		         // Black piece.
		         elseif piece = 'ppkb'
				            oProPawknightB{
				                     SetModelTexture("textures/BlackProPaw.png")
				                  }
				            if selectionI = i and selectionJ = j
					               oProPawknightB{
					                        SetModelTexture("textures/BlackPieceCliked.jpg")
					                     }
				            ok

         		ok

      next  
   next     


//------------------------------------------
func DrowPiece(Board, i, j)

				 //------ For each tile on the Board..---------
				
				
				
				    piece = Board[i][j]
					//SEE "Start APP piece: "+ piece +nl
				
				   //Draws the correct piece.----------------
				
				   			  if Board[i][j] = 'kr'
						            okingw = new Model3d(WhitePEntity, okingw, "models/king.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											          	SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.------------------------bK-------------------------------
						        elseif  Board[i][j] = 'Kl'
						            okingb = new Model3d(BlackPEntity, okingb, "models/king.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
						         // White piece.-----------------------wq-----------------------------------
						         elseif Board[i][j] = 'qr'
						            oqueenw = new Model3d(WhitePEntity, oqueenw, "models/queen.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.---------------------------bQ-------------------------------
						         elseif Board[i][j] = 'Ql'
						            oqueenb = new Model3d(BlackPEntity, oqueenb, "models/queen.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
						         // White piece. --------------right----------------------
						         elseif Board[i][j] = 'br'
						            oBishopwr = new Model3d(WhitePEntity, oBishopwr, "models/Bishop.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.----------------------right----------------------------------------
						         elseif Board[i][j] = 'Br'
						            oBishopbr = new Model3d(BlackPEntity, oBishopbr, "models/Bishop.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								 // White piece. --------------------left--------------------------------------
						         elseif Board[i][j] = 'bl'
						            oBishopwl = new Model3d(WhitePEntity, oBishopwl, "models/Bishop.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.--------------------------left-----------------------------------------
						         elseif Board[i][j] = 'Bl'
						            oBishopbl = new Model3d(BlackPEntity, oBishopbl, "models/Bishop.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
						         //White piece.-------------------------right----------------------------------------------
						         elseif Board[i][j] = 'nr'
						            oknightwr = new Model3d(WhitePEntity, oknightwr, "models/knight.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.----------------------------right--------------------------------------------------
						         elseif Board[i][j] = 'Nr'
						            oknightbr = new Model3d(BlackPEntity, oknightbr, "models/knight.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								//White piece.-------------------------left------------------------------------------------
						         elseif Board[i][j] = 'nl'
						            oknightwl = new Model3d(WhitePEntity, oknightwl, "models/knight.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.--------------------------left-------------------------------------------------
						         elseif Board[i][j] = 'Nl'
						            oknightbl = new Model3d(BlackPEntity, oknightbl, "models/knight.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
						         // White piece.------------------right--------------------------------------------
						         elseif Board[i][j] = 'rr'
						            orookwr = new Model3d(WhitePEntity, orookwr,  "models/rook.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.-----------------------right---------------------------------------------
						         elseif Board[i][j] = 'Rr'
						            orookbr = new Model3d(BlackPEntity, orookbr,  "models/rook.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								 // White piece.-------------------------left------------------------------------------------
						         elseif Board[i][j] = 'rl'
						            orookwl = new Model3d(WhitePEntity, orookwl,  "models/rook.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.-----------------------------left-----------------------------------------------
						         elseif Board[i][j] = 'Rl'
						            orookbl = new Model3d(BlackPEntity, orookbl,  "models/rook.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
						      // White piece.-------------------------wp1------------------------------------------------------
						         elseif Board[i][j] = 'p1'
						            opawnw1 = new Model3d(WhitePEntity, opawnw1,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.---------------------------bp1--------------------------------------------------------
						         elseif Board[i][j] = 'P1'
						            opawnb1 = new Model3d(BlackPEntity, opawnb1,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								// White piece.----------------------------wp2-----------------------------------------------
						         elseif Board[i][j] = 'p2'
						            opawnw2 = new Model3d(WhitePEntity, opawnw2,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.-------------------------------bp2--------------------------------
						         elseif Board[i][j] = 'P2'
						            opawnb2 = new Model3d(BlackPEntity, opawnb2,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								// White piece.-----------------------------wp3----------------------------------
						         elseif Board[i][j] = 'p3'
						            opawnw3 = new Model3d(WhitePEntity, opawnw3,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.-------------------------------bp3---------------------------------
						         elseif Board[i][j] = 'P3'
						            opawnb3 = new Model3d(BlackPEntity, opawnb3,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								// White piece.--------------------------------wp4---------------------------------
						         elseif Board[i][j] = 'p4'
						            opawnw4 = new Model3d(WhitePEntity, opawnw4,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.----------------------------------bp4-------------------------------
						         elseif Board[i][j] = 'P4'
						            opawnb4 = new Model3d(BlackPEntity, opawnb4,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								// White piece.------------------------------------wp5-----------------------------
						         elseif Board[i][j] = 'p5'
						            opawnw5 = new Model3d(WhitePEntity, opawnw5,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.-----------------------------------bp5-------------------------------
						         elseif Board[i][j] = 'P5'
						            opawnb5 = new Model3d(BlackPEntity, opawnb5,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								// White piece.-------------------------------------wp6-----------------------------
						         elseif Board[i][j] = 'p6'
						            opawnw6 = new Model3d(WhitePEntity, opawnw6,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.-------------------------------------bp6---------------------------
						         elseif Board[i][j] = 'P6'
						            opawnb6 = new Model3d(BlackPEntity, opawnb6,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								// White piece.-----------------------------------wp7---------------------------
						         elseif Board[i][j] = 'p7'
						            opawnw7 = new Model3d(WhitePEntity, opawnw7,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.-----------------------------------bp7----------------------------
						         elseif Board[i][j] = 'P7'
						            opawnb7 = new Model3d(BlackPEntity, opawnb7,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								// White piece.------------------------------------wp8---------------------------
						         elseif Board[i][j] = 'p8'
						            opawnw8 = new Model3d(WhitePEntity, opawnw8,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhitePiece.jpg")
											            setModelDirection( 0, 1, 0, degreeW)
														}
						         // Black piece.-----------------------------------bp8-----------------------------------
						         elseif Board[i][j] = 'P8'
						            opawnb8 = new Model3d(BlackPEntity, opawnb8,  "models/pawn.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackPiece.jpg")
											            setModelDirection( 0, 1, 0, degreeB)
														}
						         elseif Board[i][j] = 'ppqw'
									  oProPawQuinW = new Model3d(WhiteProPawnEntity, oProPawQuinW, "models/queen.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhiteProPaw.png")
											            setModelDirection( 0, 1, 0, degreeW)
														} 
								 elseif Board[i][j] = 'ppqb'
									 oProPawQuinB	=	new Model3d(BlackProPawnEntity, oProPawQuinB, "models/queen.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackProPaw.png")
											            setModelDirection( 0, 1, 0, degreeB)
														}
											
						        elseif Board[i][j] = 'pprw'  
										oProPawRookW= new Model3d(WhiteProPawnEntity, oProPawRookW,  "models/rook.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhiteProPaw.png")
											            setModelDirection( 0, 1, 0, degreeW)
														}
								elseif Board[i][j] = 'pprb' 
										oProPawRookB	= new Model3d(BlackProPawnEntity, oProPawRookB,  "models/rook.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackProPaw.png")
											            setModelDirection( 0, 1, 0, degreeB)
														}
						 		 elseif Board[i][j] = 'ppbw'
						   				 oProPawBishopW = new Model3d(WhiteProPawnEntity, oProPawBishopW, "models/Bishop.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhiteProPaw.png")
											            setModelDirection( 0, 1, 0, degreeW)
														}
								elseif Board[i][j] = 'ppbb'
										oProPawBishopB= new Model3d(BlackProPawnEntity, oProPawBishopB, "models/Bishop.obj"){
											            setModelpos(i*17-75, 0, (j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackProPaw.png")
											            setModelDirection( 0, 1, 0, degreeB)
														}
										
						   		 elseif Board[i][j] = 'ppkw'
										  oProPawknightW = new Model3d(WhiteProPawnEntity, oProPawknightW, "models/knight.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/WhiteProPaw.png")
											            setModelDirection( 0, 1, 0, degreeW)
														} 
								elseif Board[i][j] = 'ppkb'
										oProPawknightB= new Model3d(BlackProPawnEntity, oProPawknightB, "models/knight.obj"){
											            setModelpos(i*17-75, 0,(j*17-42)-33)
											            setmodelSiz(0.19, 0.20, 0.19)
											            SetModelTexture("textures/BlackProPaw.png")
											            setModelDirection( 0, 1, 0, degreeB)
														}
								ok


					whiteAdvantage = AdvantageCalc()
				if  isOngame = 1  ? "Add-whiteAdvantage" + whiteAdvantage ok
//------------------														
func clearPieces(Board, i, j)

			
								   	 piece =Board[i][j]		
									 if piece = 'kr'   okingw.removecomponent()   
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
										elseif piece = 'ppqw'   oProPawQuinW.removecomponent()
										elseif piece = 'ppqb'   oProPawQuinB.removecomponent()
										elseif piece = 'pprw'   oProPawRookW.removecomponent()
										elseif piece = 'pprb'   oProPawRookB.removecomponent()
					  					elseif piece = 'ppbw'   oProPawBishopW.removecomponent()
										elseif piece = 'ppbb'   oProPawBishopB.removecomponent()
										elseif piece = 'ppkw'   oProPawknightW.removecomponent()
										elseif piece = 'ppkb'   oProPawknightB.removecomponent()
									  ok
								whiteAdvantage = AdvantageCalc()
						if  isOngame = 1  	? "Remove-whiteAdvantage" + whiteAdvantage ok
//------------------------	
func getLastMove() 

				return LastMove   

//------------------------------------
func getAdvantage(isTurnWhite)

								if isTurnWhite  
										return  whiteAdvantage
							    else 
									    return  -whiteAdvantage 
							   ok

//-------------------------------------
func getAdvChange(move,  isTurnWhite)
			
								 weight = 0
								if !isTurnWhite piece = Board[move.Toi][move.Toj] ok
								if isTurnWhite piece = Board[move.fromi][move.fromj] ok
								switch piece
										on 'kr'    weight = 1000 
										on 'Kl'    weight = 1000  
										on 'qr'   weight = 9   
										on 'Ql'    weight = 9   
										on 'br'    weight = 3  
										on 'Br'    weight = 3   
										on 'bl'     weight = 3   
										on 'Bl'     weight = 3   
										on 'nr'    weight = 3 
										on 'Nr'    weight = 3
										on 'nl'     weight = 3  
										on 'Nl'    weight = 3  
										on 'rr'     weight = 5  
										on 'Rr'    weight = 5    
										on  'rl'     weight = 5   
										on 'Rl'     weight = 5
										on 'p1'    weight = 1   
										on 'P1'    weight = 1 	
										on 'p2'    weight = 1 	
										on 'P2'    weight = 1  
										on 'p3'    weight = 1   
										on 'P3'    weight = 1   
										on 'p4'    weight = 1 
										on 'P4'    weight = 1  
										on 'p5'    weight = 1  
										on 'P5'    weight = 1   
										on 'p6'    weight = 1
										on 'P6'    weight = 1 
										on 'p7'    weight = 1  
										on 'P7'    weight = 1   
										on 'p8'    weight = 1 
										on 'P8'    weight = 1  
										on 'ppqw'  weight = 9
										on 'ppqb'   weight = 9
										on 'pprw'  weight = 5
										on 'pprb'   weight = 5
					  					on 'ppbw'  weight = 3  
										on 'ppbb'   weight = 3
										on 'ppkw'  weight = 3 
										on 'ppkb'  weight = 3
										other        weight = 0
								off
							if  isWhitepiece(piece) ^ isTurnWhite
									return  weight
							else 
									return    -weight
							ok

//-------------------
func AdvantageCalc()
						Advantage = 0
						for i=1 to 8
						      for j=1 to 8
									 weight = 0
									piece =Board[i][j]
									switch piece
											on 'kr'    weight = 1000 
											on 'Kl'    weight = 1000  
											on 'qr'   weight = 9   
											on 'Ql'    weight = 9   
											on 'br'    weight = 3  
											on 'Br'    weight = 3   
											on 'bl'     weight = 3   
											on 'Bl'     weight = 3   
											on 'nr'    weight = 3 
											on 'Nr'    weight = 3
											on 'nl'     weight = 3  
											on 'Nl'    weight = 3  
											on 'rr'     weight = 5  
											on 'Rr'    weight = 5    
											on  'rl'     weight = 5   
											on 'Rl'     weight = 5
											on 'p1'    weight = 1   
											on 'P1'    weight = 1 	
											on 'p2'    weight = 1 	
											on 'P2'    weight = 1  
											on 'p3'    weight = 1   
											on 'P3'    weight = 1   
											on 'p4'    weight = 1 
											on 'P4'    weight = 1  
											on 'p5'    weight = 1  
											on 'P5'    weight = 1   
											on 'p6'    weight = 1
											on 'P6'    weight = 1 
											on 'p7'    weight = 1  
											on 'P7'    weight = 1   
											on 'p8'    weight = 1 
											on 'P8'    weight = 1  
											on 'ppqw'  weight = 9
											on 'ppqb'   weight = 9
											on 'pprw'  weight = 5
											on 'pprb'   weight = 5
						  					on 'ppbw'  weight = 3  
											on 'ppbb'   weight = 3
											on 'ppkw'  weight = 3 
											on 'ppkb'  weight = 3
											other        weight = 0
									off
								if isWhitepiece(piece)
													Advantage +=  weight
								else 
													Advantage  -=   weight
								ok
					       next
					 next

						return Advantage

//-------------------------------
func RandomItem(aList)

				    if not isList(aList) raise("Error: The function expect a list!") return ok
				    if len(aList) <= 0  raise("Error: No items in the list") return ok
				    return aList[ random( len(aList) - 1 ) + 1 ]
				
//-----------------------------------
func getLegalMoves(move, isTurnWhite ) 

						fromI = move.fromI
						 fromJ = move.fromJ
	 					moves=[]
						for i=1 to 8
							 for j=1 to 8
									if validMove(Board ,fromI , fromJ , i , j  ,  isTurnWhite)		
										getMove = getLastMove() 
										moves + getMove
									ok		
							next
						next
						
						return moves

//--------------------------------------
func getLegalAttackMove( isTurnWhite) 
								Gmoves = []	
						 		Advmoves = []
								SortList = []
								AttakMove = []
								BestAdvmoves = []	
								getMove = new move 
								AdvChangeW = getAdvChange(lastMove,  isTurnWhite)
								for i=1 to 8
										for j=1 to 8
												if Board[i][j] != ' '  and  ((isWhitepiece(Board[i][j]) = isTurnWhite)  or  (!isTurnWhite =isBlackpiece(Board[i][j]) ))
														fromn=i     fromk=j
														for n=1 to 8
																for k=1 to 8
																		if validMove(Board ,fromn ,fromk  , n , k , isTurnWhite) 
																			if   (isTurnWhite and !isWhitepiece(Board[n][k]) ) or  (!isTurnWhite and !isBlackpiece(Board[n][k]) )
																			    	getMove.fromI = fromn
																					getMove.fromJ = fromk
																					getMove.Toi = n
																					getMove.Toj = k	
																					if isWhitepiece(Board[n][k])  AttakMove + getMove ok
																					AdvChangeB = getAdvChange(getMove,  !isTurnWhite)
																					//? "=====AdvChangeW======"
																			    	//? "AdvChangeW:" +AdvChangeW
																					//? "=====AdvChangeB======"
																					//	? "AdvChangeB:" +AdvChangeB
																					
																						Advmoves +[AdvChangeB,getMove]
																						//	? "=====Advmoves======"
																						//? len( Advmoves)
																						//Gmoves + Advmoves
																				ok	
																			ok		
																next
														next	   
												ok			
										next
								next
								
								? "=====Atackedvmove======"
									? AttakMove
									? len( AttakMove)
									? "=====Advmoves======"
									? len( Advmoves)
							//	? "=====SortList:======"
								SortList = sort(Advmoves , 1)
								//? "=====ReverseList:======"
								SortList =Reverse(SortList) 
								for i= 1 to len(SortList)
										if   SortList[i][1] <= AdvChangeW
												BestAdvMoves + SortList[i][2]
										ok
								next 
							
							//?"Gmoves:" +len(Gmoves	)
							//? Gmoves	
							? "====BestAdvmoves======="
							? len(BestAdvMoves)
			 if len( AttakMove) = 0 return BestAdvMoves else  return AttakMove  ok
						
					
class   Move 

					Fromi 
					Fromj 
					Toi 
					Toj 

