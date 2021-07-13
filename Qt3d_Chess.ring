#------------------------------------------------
# Chess3d Qt3D
#   
# Author :Azzeddine Remmal 
#-------------------------------------------------
/* Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the Software), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:	
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.	
THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.*/	

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
		   if    piece != ' '  and  ((iswhitepiece(piece) and turn = 'a') or (isblackpiece(piece) and turn = 'A'))
		
						      selectionI = i
						      selectionJ = j
			
		   // -------Trying to move a selected piece--------.
		   elseif selectionI > 0 and selectionJ > 0

						

				     if validMove(board, selectionI, selectionJ, i, j, turn)
							   deletepiece(board, i, j)
						       board[i][j] = board[selectionI][selectionJ]
							   deletepiece(board, selectionI, selectionJ)					
							   redrowpiece(board, i, j)	
								board[selectionI][selectionJ] = ' '	
						         selectionI = 0
						         selectionJ = 0	
						      if turn = 'a'
						                if isCheckMate(board, 'A')
						                   MsgWhite(MSG_WIN)
						                   MsgBlack( MSG_LOSE)									
							            else
							               turn = 'A'            
							               MsgBlack(MSG_YOUR_TURN)
											Camturn = true		
							            ok				
						  		else
								         if isCheckMate(board, 'a')
								             MsgWhite( MSG_LOSE)
								             MsgBlack( MSG_WIN)						    		
								         else
								             turn = 'a'
								             MsgWhite( MSG_YOUR_TURN)
								              Camturn = true	
								         ok				
						   		ok
					 else				
							      if isCheck(board, turn)
		
									         if turn = 'a'
									            MsgWhite(MSG_CHECK)
									         else										
									            MsgBlack(MSG_CHECK)
									         ok								
							      else				
									         if turn = 'a'
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
					            if fromI - toI < 0 return false   ok	       
				        //----- White pawn------
				        elseif ispawnwhite( piece)
					            if fromI != 2 and dy > 1 return false  ok
					            if fromI = 2 and dy > 2 return false  ok
					            if fromI - toI > 0 return false  ok
				        ok
				        if dx > 0 and (dx != 1 or dy != 1 or board[toI][toJ] = ' ' ) return false  ok
				        if dy > 0 and dx = 0 and board[toI][toJ] != ' '  return false  ok
				        if not isClear(board, fromI, fromJ, toI, toJ)  return false  ok			   
				ok
			    // -----------Any rook------------
			    if  piece = 'Rr' or  piece = 'rr' or  piece = 'Rl' or  piece = 'rl'  
				        if dx > 0 and dy > 0 return false ok
				        if  not isClear(board, fromI, fromJ, toI, toJ) return false ok			   
				ok
			    // ----------Any knight-------------
			    if  piece = 'Nr' or  piece = 'nr' or  piece = 'Nl' or  piece = 'nl' 
			        	if  not ((dx = 1 and dy = 2) or (dx = 2 and dy = 1)) return false ok			    
				ok
			    // ----------Any bishop------------
			    if  piece = 'Br' or   piece = 'br' or  piece = 'Bl' or  piece = 'bl' 
				        if dx != dy return false ok
				        if  not isClear(board, fromI, fromJ, toI, toJ)  return false  ok			    
				ok
			    // --------Any queen------
			    if  piece = 'Ql' or  piece = 'qr'
			        if dx > 0 and dy > 0 and dx != dy return false ok
			        if not isClear(board, fromI, fromJ, toI, toJ) return false ok		    
				ok
			    // --------Any king--------
			    if  piece = 'Kl' or  piece = 'kr'
			        	if dx > 1 or dy > 1 return false ok
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
					            if  (player = 'a' and board[i][j] = 'kr' ) or (player = 'A' and board[i][j] = 'Kl' )
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
			            if player = 'a' and  iswhitepiece(board[i][j])
				                  if validMove(board, i, j, kingI, kingJ, 'A') 
										 return  true  
								  ok			            
			           	 elseif  player = 'A' and isblackpiece(board[i][j]) 
				               if validMove(board, i, j, kingI, kingJ, 'a')   
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
			            if (player = 'A' and board[i][j] = 'kr') or (player = 'a' and board[i][j] = 'Kl')
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
					            if player = 'a' and  isblackpiece(board[newKingI][newKingJ])    loop ok
					            if player = 'A' and  iswhitepiece(board[newKingI][newKingJ])    loop ok					
					             temp = board[newKingI][newKingJ]
					            board[newKingI][newKingJ] = king					
					            if not isChecke(board, player, newKingI, newKingJ)  nonChecks++ ok					
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
														


