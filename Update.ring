#------------------------------------------------
# Chess3d Qt3D      
#    20-06-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

##################
#-----Update Function------#
##################





//-------------------------------
func Update()


   // For each tile on the board...
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
                  	
				if board[i][j] = ' '
						if validMove(board, selectionI, selectionJ, i, j, turn)
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/valid.png") )	
						ok
				
				elseif iswhitepiece(board[i][j]) and turn = 'B'
						if validMove(board, selectionI, selectionJ, i, j, turn)
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/enemy.png") )	
						ok
				
				elseif isblackpiece(board[i][j]) and turn = 'W'
						if validMove(board, selectionI, selectionJ, i, j, turn)
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/enemy.png") )	
						ok
				
				elseif iswhitepiece(board[i][j]) and turn = 'W'
						if validMove(board, selectionI, selectionJ, i, j, turn)	
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/friend.png") )	
						ok
				
				elseif isblackpiece(board[i][j]) and turn = 'B'
							if validMove(board, selectionI, selectionJ, i, j, turn)
								 aTile[i][j][:oLoader].setSource(new QUrl("file:///"+currentdir()+"/textures/friend.png") )	
							ok
				ok
        	   
     	 ok
			
      // Draws a game piece.
      piece = board[i][j]
      
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
      ok      
      // Black piece.
      if piece = 'Kl'
         okingb{
               SetModelTexture("textures/BlackPiece.jpg")
         }

         if selectionI = i and selectionJ = j
            okingb{
                  SetModelTexture("textures/BlackPieceCliked.jpg")
            }
         ok
      ok
      //---------------------------------------------------------------------
      // White piece.
      if piece = 'qr'
         oqueenw{
                  SetModelTexture("textures/WhitePiece.jpg")
               }
         if selectionI = i and selectionJ = j
            oqueenw{
                     SetModelTexture("textures/WhitePieceCliked.jpg")
                  }
         ok
      ok      
      // Black piece.
      if piece = 'Ql'
         oqueenb{
                  SetModelTexture("textures/BlackPiece.jpg")
               }
         if selectionI = i and selectionJ = j
            oqueenb{
                     SetModelTexture("textures/BlackPieceCliked.jpg")
                  }
         ok
      ok
      //------------------------------------------------------------------------
      // White piece.
      if piece = 'br'
         oBishopwr{
                  SetModelTexture("textures/WhitePiece.jpg")
                }
               if selectionI = i and selectionJ = j
                  oBishopwr{
                           SetModelTexture("textures/WhitePieceCliked.jpg")
                          }
               ok
      ok       
      // Black piece.
      if piece = 'Br'
         oBishopbr{
                  SetModelTexture("textures/BlackPiece.jpg")
                }
         if selectionI = i and selectionJ = j
            oBishopbr{
                     SetModelTexture("textures/BlackPieceCliked.jpg")
                   }
         ok
      ok
       // White piece.
      if piece = 'bl'
         oBishopwl{
                  SetModelTexture("textures/WhitePiece.jpg")
                }
               if selectionI = i and selectionJ = j
                  oBishopwl{
                           SetModelTexture("textures/WhitePieceCliked.jpg")
                          }
               ok
      ok        
      // Black piece.
      if piece = 'Bl'
         oBishopbl{
                  SetModelTexture("textures/BlackPiece.jpg")
                }

         if selectionI = i and selectionJ = j
            oBishopbl{
                     SetModelTexture("textures/BlackPieceCliked.jpg")
                   }
         ok
      ok
           
      //------------------------------------------------------------------------

      // White piece.
      if piece = 'nr'
         oknightwr{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }

         if selectionI = i and selectionJ = j
            oknightwr{
                     SetModelTexture("textures/WhitePieceCliked.jpg")
                   }
         ok
      ok  
      // Black piece.
      if piece = 'Nr'
         oknightbr{
                  SetModelTexture("textures/BlackPiece.jpg")
                }
         if selectionI = i and selectionJ = j
            oknightbr{
                     SetModelTexture("textures/BlackPieceCliked.jpg")
                   }
         ok
      ok      
      // White piece.
      if piece = 'nl'
         oknightwl{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }
         if selectionI = i and selectionJ = j
            oknightwl{
                     SetModelTexture("textures/WhitePieceCliked.jpg")
                   }
         ok
      ok  
      // Black piece.
      if piece = 'Nl'
         oknightbl{
                  SetModelTexture("textures/BlackPiece.jpg")
                }
         if selectionI = i and selectionJ = j
            oknightbl{
                     SetModelTexture("textures/BlackPieceCliked.jpg")
                   }
         ok
      ok  
      //-------------------------------------------------------------------
         // White piece.
         if piece = 'rr'
             orookwr{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }
                  if selectionI = i and selectionJ = j
                     orookwr{
                             SetModelTexture("textures/WhitePieceCliked.jpg")
                          }
                  ok
         ok    
         // Black piece.
         if piece = 'Rr'
            orookbr{
                   SetModelTexture("textures/BlackPiece.jpg")
                 }
                  if selectionI = i and selectionJ = j
                     orookbr{
                            SetModelTexture("textures/BlackPieceCliked.jpg")
                          }
                  ok
         ok       
         // White piece.
         if piece = 'rl'
             orookwl{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }
                 if selectionI = i and selectionJ = j
                     orookwl{
                             SetModelTexture("textures/WhitePieceCliked.jpg")
                          }
                  ok
         ok         
         // Black piece.
         if piece = 'Rl'
            orookbl{
                   SetModelTexture("textures/BlackPiece.jpg")
                 }
                  if selectionI = i and selectionJ = j
                     orookbl{
                            SetModelTexture("textures/BlackPieceCliked.jpg")
                          }
                  ok
         ok      
         //-------------------------------------------------------------------------
         // White piece.
         if piece = 'p1'
            opawnw1{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }
            if selectionI = i and selectionJ = j
               opawnw1{
                        SetModelTexture("textures/WhitePieceCliked.jpg")
                     }
			ok
         ok   
         // Black piece.
         if piece = 'P1'
            opawnb1{
                     SetModelTexture("textures/BlackPiece.jpg")
                  }
            if selectionI = i and selectionJ = j
               opawnb1{
                        SetModelTexture("textures/BlackPieceCliked.jpg")
                     }
			
            ok
         ok
		//----------------------------------------------------------------------------
		 // White piece.
         if piece = 'p2'
            opawnw2{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }
            if selectionI = i and selectionJ = j
               opawnw2{
                        SetModelTexture("textures/WhitePieceCliked.jpg")
                     }
            ok
         ok   
         // Black piece.
         if piece = 'P2'
            opawnb2{
                     SetModelTexture("textures/BlackPiece.jpg")
                  }
            if selectionI = i and selectionJ = j
               opawnb2{
                        SetModelTexture("textures/BlackPieceCliked.jpg")
                     }
            ok
         ok
		//----------------------------------------------------------------------------
		 // White piece.
         if piece = 'p3'
            opawnw3{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }
            if selectionI = i and selectionJ = j
               opawnw3{
                        SetModelTexture("textures/WhitePieceCliked.jpg")
                     }
            ok
         ok   
         // Black piece.
         if piece = 'P3'
            opawnb3{
                     SetModelTexture("textures/BlackPiece.jpg")
                  }
            if selectionI = i and selectionJ = j
               opawnb3{
                        SetModelTexture("textures/BlackPieceCliked.jpg")
                     }
            ok
         ok
		//----------------------------------------------------------------------------
		 // White piece.
         if piece = 'p4'
            opawnw4{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }

            if selectionI = i and selectionJ = j
               opawnw4{
                        SetModelTexture("textures/WhitePieceCliked.jpg")
                     }
            ok
         ok   
         // Black piece.
         if piece = 'P4'
            opawnb4{
                     SetModelTexture("textures/BlackPiece.jpg")
                  }

            if selectionI = i and selectionJ = j
               opawnb4{
                        SetModelTexture("textures/BlackPieceCliked.jpg")
                     }
            ok
         ok
		//----------------------------------------------------------------------------
		 // White piece.
         if piece = 'p5'
            opawnw5{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }
            if selectionI = i and selectionJ = j
               opawnw5{
                        SetModelTexture("textures/WhitePieceCliked.jpg")
                     }
            ok
         ok   
         // Black piece.
         if piece = 'P5'
            opawnb5{
                     SetModelTexture("textures/BlackPiece.jpg")
                  }

            if selectionI = i and selectionJ = j
               opawnb5{
                        SetModelTexture("textures/BlackPieceCliked.jpg")
                     }
            ok
         ok
		//----------------------------------------------------------------------------
		 // White piece.
         if piece = 'p6'
            opawnw6{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }

            if selectionI = i and selectionJ = j
               opawnw6{
                        SetModelTexture("textures/WhitePieceCliked.jpg")
                     }
            ok
         ok   
         // Black piece.
         if piece = 'P6'
            opawnb6{
                     SetModelTexture("textures/BlackPiece.jpg")
                  }

            if selectionI = i and selectionJ = j
               opawnb6{
                        SetModelTexture("textures/BlackPieceCliked.jpg")
                     }
            ok
         ok
		//----------------------------------------------------------------------------
		 // White piece.
         if piece = 'p7'
            opawnw7{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }

            if selectionI = i and selectionJ = j
               opawnw7{
                        SetModelTexture("textures/WhitePieceCliked.jpg")
                     }
            ok
         ok   		
         // Black piece.
         if piece = 'P7'
            opawnb7{
                     SetModelTexture("textures/BlackPiece.jpg")
                  }
            if selectionI = i and selectionJ = j
               opawnb7{
                        SetModelTexture("textures/BlackPieceCliked.jpg")
                     }
            ok
         ok
		//----------------------------------------------------------------------------
		 // White piece.
         if piece = 'p8'
            opawnw8{
                     SetModelTexture("textures/WhitePiece.jpg")
                  }

            if selectionI = i and selectionJ = j
               opawnw8{
                        SetModelTexture("textures/WhitePieceCliked.jpg")
                     }
            ok
         ok   
         // Black piece.
         if piece = 'P8'
            opawnb8{
                     SetModelTexture("textures/BlackPiece.jpg")
                  }

            if selectionI = i and selectionJ = j
               opawnb8{
                        SetModelTexture("textures/BlackPieceCliked.jpg")
                     }
            ok
         ok

      next  
   next     

 
