#------------------------------------------------
# Chess3d Qt3D      
#    15-08-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

Load "DisplayGameView.ring"


/*if IsMainSourceFile() 
	oApp = new QApp {
		StyleFusion()
		openWindow(:DisplayGameController)
		exec()
		}
ok*/

class DisplayGameController from windowsControllerParent
			
						
						 oView =	new DisplayGameView
						 oView.win.addToolBar_2(Qt_BottomToolBarArea , oView.Toolbar2)
			 			 oView{	
								 startButton.setEnabled(false)
								 saveButton.setEnabled(false)
								 loadButton.setEnabled(true)   
								 newButton.setEnabled(false)
								 PlayHistoryButton.setEnabled(false)
							 	 serverButton.setEnabled(false)		
								 clientButton.setEnabled(false)
								 cleerButton.setEnabled(false)
								 resignButton.setEnabled(false)
								 GameMusicButton.setEnabled(true)
						        }
						 oMove = new Move
						 oChessboard = new Chessboard
					    AiTree = new MinimaxTree(oChessboard)
	              
					StartBaseGame()

//--------------------------------
func  PLAY_VS_HUMAN()

						? "PLAY_VS_HUMAN-Mode"
						playSoudMove("KingMove.mp3")  
						SayText( "PLAY VS HUMAN Mode")
						PLAY_VS_HUMAN = true	 
						PLAY_ON_LINE = false
						PLAY_VS_AI = false
						oView{
							oMenuWidget.hide()
							owidget3d.show()
							saveButton.setEnabled(true)
							loadButton.setEnabled(true)   
							newButton.setEnabled(true)
							}

//------------------------------
func  PLAY_ON_LINE()
	
						? "PLAY_ON_LINE-Mode"
						playSoudMove("KingMove.mp3")  
						SayText( "PLAY ON LINE  Mode")
					    PLAY_VS_HUMAN = false	 
						PLAY_ON_LINE = true
						PLAY_VS_AI = false
						
						oView{
							 oMenuWidget.hide()
							 owidget3d.show()
							 serverButton.setEnabled(true)		
							 clientButton.setEnabled(true)
							 GameMusicButton.setEnabled(true)
							 saveButton.setEnabled(true)
						 	 loadButton.setEnabled(true)   
							 newButton.setEnabled(true)
							 }	

//------------------------------
func  PLAY_VS_AI()

						? "PLAY_VS_AI-Mode"
						playSoudMove("KingMove.mp3")  
						SayText( "PLAY VS AI Mode")		
						PLAY_VS_HUMAN = false	 
						PLAY_ON_LINE = false
						PLAY_VS_AI = true
						oView{
							oMenuWidget.hide()
							owidget3d.show()
							saveButton.setEnabled(true)
							//loadButton.setEnabled(true)   
							newButton.setEnabled(true)
							}
//---------------
func StartGame()       
							oView{
	                            startButton.setEnabled(false)
								saveButton.setEnabled(true)
								loadButton.setEnabled(false)   
								newButton.setEnabled(false)
								PlayHistoryButton.setEnabled(false)
								cleerButton.setEnabled(true)
								resignButton.setEnabled(true)
								 serverButton.setEnabled(false)		
								 clientButton.setEnabled(false)
								}
							SayText("Enter the final playing time in seconds ")
						 	TimeInput = New QInputDialog(oView.win){
					                setwindowtitle("Enter the final playing time in seconds ?")	
					                setgeometry(400,200,400,200)
					                setlabeltext("final playing time - 60 = 1M")		
					                settextvalue("300")
					                lcheck = exec()
									}
									
					                if lcheck  
											myTime = 0+ TimeInput.textvalue()
										   oView.myLCD.display(myTime)
										    yourTime = 0+ TimeInput.textvalue()
										    oView.yourLCD.display(yourTime)
										ok
					       			  
						    isOngame = 1
						    if currentTurn = TurnWhite 
								oView{
								       radioButton.setChecked(false)
								       radioButton_2.setChecked(true)
										}
						    else
								oView{
								        radioButton.setChecked(true)
								        radioButton_2.setChecked(false)
										}
						    ok
						    oView.oTimer.start()
									
							if PLAY_ON_LINE
										aList = []
										aList + "start"
									    aList + TimeInput.textvalue()
										Message = listToCode(aList)
										? Message
									    writeMessage(Message)		
							ok

	
//---------------
func StartBaseGame()
								oView{
									 oMenuWidget.show()
									 owidget3d.hide()
									}
							     isOngame = 0
								 DrowCamera()
								 DrowLight()
					 			 DrowSkyboxs()	 		  
								 DrowTest3D() 
								oChessboard.DrowBoard() 
								oChessboard.DrowTiles()
								  // SayText(MSG_WELCOME)
				    			 oView.oView3d.setRootEntity(oRootEntity)
								
								
//------------------------			
func newGame()
								oView{
										//oMenuWidget.hide()
										//owidget3d.show()
										startButton.setEnabled(true)
										saveButton.setEnabled(true)
										loadButton.setEnabled(false)   
										newButton.setEnabled(false)
										PlayHistoryButton.setEnabled(false)
										cleerButton.setEnabled(true)
										resignButton.setEnabled(true)
										 serverButton.setEnabled(false)		
										 clientButton.setEnabled(false) 
										}
								if PLAY_ON_LINE or PLAY_VS_HUMAN
										OppositeTurn = oChessboard.RandomItem(aOppositeTurn)
										? "OppositeTurn:" + OppositeTurn
										if OppositeTurn = TurnWhite
												  currentTurn = TurnBlack
										 else
												  currentTurn = TurnWhite
										 ok
								elseif PLAY_VS_AI
										 currentTurn = TurnWhite
								ok
								oChessboard.clearAllPieces()
								oChessboard.clearboard()
								
								oChessboard.SetNewBoard()
								oChessboard.DrowAllPiece()
								oChessboard.Update()
								if PLAY_ON_LINE
											aList = []
											aList + "new game"
										    aList + OppositeTurn
											Message = listToCode(aList)
											? Message
										    writeMessage(Message)		
								ok

//------------------------			
func loadEndGame()
								oView{
										owidget3d.show()
										startButton.setEnabled(true)
										 saveButton.setEnabled(true)
										 loadButton.setEnabled(false)   
										 newButton.setEnabled(true)
										 PlayHistoryButton.setEnabled(false)
										 cleerButton.setEnabled(true)
										 resignButton.setEnabled(true)	
										 serverButton.setEnabled(false)		
										 clientButton.setEnabled(false) 
										} 
								 
								
								oChessboard.clearAllPieces()
								oChessboard.clearboard()
								 try	
										  oFiledialog = new Qfiledialog(oView.win) 
										  cFile = oFiledialog.getopenfilename(oView.win,"Save the end game",CurrentDir() +
																					 "/saveGame","source files(*.txt)")
									  	  eval(read(cFile)) 
								 catch
        									  ?  "Can't open file"
												SayText("Can't open file")
								 done
								 if PLAY_ON_LINE or PLAY_VS_HUMAN
										OppositeTurn = oChessboard.RandomItem(aOppositeTurn)
										? "OppositeTurn:" + OppositeTurn
										if OppositeTurn = TurnWhite
												  currentTurn = TurnBlack
										 else
												  currentTurn = TurnWhite
										 ok
								 ok
								 oChessboard.DrowAllPiece()
								 oChessboard.Update() 
								 if PLAY_ON_LINE
											 alist =[]
											 alist + "load"
											 alist + OppositeTurn
											 alist + Board	
											 oView.resignButton.setEnabled(true)
										     Message = listToCode(aList)
											? Message
										    writeMessage(Message)
								 ok

//------------
func cleer()
						oView{
								loadButton.setEnabled(true)   
								newButton.setEnabled(true)
								PlayHistoryButton.setEnabled(true)
								}
						oChessboard.clearAllPieces()
						oChessboard.clearboard()
						 isOngame = 0
						oView.oTimer.stop()
						oView.oHistoryTimer.stop()
						resetLCD()
						oView.owidget3d.hide()
						oView.oMenuWidget.show()
						
//----------------------
func PlayHistory()
						oView{
								oMenuWidget.hide()
								owidget3d.show()
								cleerButton.setEnabled(true)
								 newButton.setEnabled(true)
								}
						oChessboard.clearAllPieces()
						oChessboard.clearboard()
						oChessboard.SetNewBoard()
						oChessboard.DrowAllPiece()
						try
								 oFiledialog1 = new Qfiledialog(oView.win) 
								 cFile1 = oFiledialog1.getopenfilename(oView.win,"Play History",CurrentDir() +
																			 "/saveGame/SaveAllMoves","source files(*.txt)")
							  	 eval(read(cFile1) ) 
								 oView.oHistoryTimer.start()	
						catch
        						?  "Can't open file"
								SayText("Can't open file")
								oView.oHistoryTimer.stop()
						done
						
//-----------------------					
func HistryTimer()

						nIndex++ // see list_History_all_moves
						if nIndex >=len(list_History_all_moves)  oView.oHistoryTimer.stop() ok
								 oView.yourLCD.display(nIndex)	
								 SelectionI=list_History_all_moves[nIndex][:fromi]
								 SelectionJ=list_History_all_moves[nIndex][:fromj]
								 i = list_History_all_moves[nIndex][:toi]
								 j = list_History_all_moves[nIndex][:toj]
								
									HandleNewSelection( i, j)
											 /*   deletepiece(board, i, j)
										       board[i][j] = board[selectionI][selectionJ]
											   deletepiece(board, selectionI, selectionJ)					
											   redrowpiece(board, i, j)
											   board[selectionI][selectionJ] = ' '	*/
										selectionI =  null
									    selectionJ =  null
										
//-------------------------
func DrowCamera()

					   oCameraEntity{
					       		lens().setPerspectiveProjection(45, 16/9, 0.1, 15000)
					       	    setPosition(new QVector3D(30, 80, -90))
					            setUpVector(new QVector3D(0, 10, 0))
					            setViewCenter(new QVector3D(0, 20, 0))
					           viewSphere(new QVector3D(0, 15, 0) , 70 )
					           }
					     oCamController = new QFirstPersonCameraController(oRootEntity){
					     			setCamera(oCameraEntity)
					     			//setEnabled(False)
					                 }    
//------------------
func SaveScreen()

								cRecordImageFolder = CurrentDir() + "/textures/shots"
								oView.win{
									x = x()	y = y()
									screen = windowhandle().screen()
								   }									
						        pixmap = screen.grabwindow(0,0,55,oView.win.width() , oView.win.height()-55 )
						        image = pixmap.toimage()		
								cFile = cRecordImageFolder + "/screenshot_" + substr(date(),"/","_") +
																												 "_" + substr(time(),":","_") + ".png"
								image.save(cFile,"png",30)
								oView.win.move(x,y)

//----------------------------
func DisplayRecord()

				                RecordWin = new Qwidget()
				                RecordImage = new Qlabel(RecordWin) {
										SetScaledContents( True )
				                        setGeometry(0,0,800,600)
										setstylesheet("color:black;background-color:;")
										setPixMap(New QPixMap(""))
				                        }
				                RecordTimer = new Qtimer(RecordWin) {
				                        setinterval(2000)            
				                        settimeoutevent("TimerEvent()")  
				                        start()
				                        }
							   RecordLayout = new QVBoxLayout(){
										AddWidget(RecordImage)
										}
								RecordMainLayout = new QHBoxLayout() { 
										AddLayout(RecordLayout)
										}
								 RecordWin {
						                setgeometry(50,50, 800,600)
						                setwindowtitle("Displayrecord")
										setLayout(RecordMainLayout)
						                 showMaximized()
						                }
				
							
	
//-------Display record Timer-----------	
func TimerEvent() 
							 nIndex ++
							 aImages = listAllFiles("textures/shots","png")	
							if nIndex >=len(aImages) nIndex=1 ok
							cFile = AppFile(aImages[nIndex])
							RecordImage {
									SetScaledContents( True )
									image = new Qpixmap(cFile)
					                setpixmap(image)
									image.delete()
									}		

//--------------------------
func DrowSkyboxs()	
		 
								//--------------------------- Skybox  draoWidgetg --------------
								DrowSkyBox(oRootEntity , "textures\skybox" ,"skybox_negx.jpg" , "skybox_negy.jpg" , 
																		"skybox_negz.jpg" , "skybox_posx.jpg" , 
																		"skybox_posy.jpg" , "skybox_posz.jpg" )
							

//--------------------------------
func DrowTest3D()   

					   oText3d{
					            setTextSiz(-14, 25, -14)
					            SetTextColor(Green)
					          }


//-----Drow Light -----
func DrowLight()

							   aLight=list(2)
							   for  n = 1 to len(aLight)
									      v = n * 2
									      aLight[n] = []
									      aLight[n][:oLight] = new QPointLight(aLight[n][:LightEntity]){
					                                 setColor(White)
					                                 setIntensity(2)
					                           		}
									      aLight[n][:oLightTransform] = new QTransform(aLight[n][:oLightEntity]){
					                                setTranslation(new QVector3D(random()%200-(100),random()%-100-(10), random()%200-(100)))
					                                }								
									      aLight[n][:oLightEntity]  = new QEntity(oRootEntity){
					                                addComponent(aLight[n][:oLight])
					                                addComponent(aLight[n][:oLightTransform])
					                               }
			  					 next
			

								
//-------------------
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
//---------------------------------
func pKeyPress()
       
							nKey = oView.oFilter.getkeycode()  
							switch nKey
									on Qt_Key_Right
										CamraMenuelaAngle += 0.005
									on Qt_Key_Left
										CamraMenuelaAngle -= 0.005 
									on Qt_Key_Up
										//VisionLevel+= 0.005 
									on Qt_Key_Down
										//VisionLevel-= 0.005 
									on Qt_Key_Shift
										//oZ+=2
									on Qt_Key_Control
										//oZ-=2
									on Qt_Key_Escape
										oApp.Quit()
							off	
							oQ = new QQuaternion(0,0,0,0)
							oCameraEntity.rotateAboutViewCenter(oQ.fromAxisAndAngle(new QVector3D(0, 1, 0),
																												 CamraMenuelaAngle))
				
//---------------------------
func  MsgWhite(MSG)

					   otext3d{
					            setText3D(MSG,30)
					            SetTextColor(white)
					   }
					SayText(MSG)

//---------------------------
func  MsgBlack(MSG)

					   otext3d{
					            setText3D(MSG,30)
					            SetTextColor(Brown)
					   }
						SayText(MSG)
//--------------------------------
func SayText(Text)

					   new QTextToSpeech(oWidget) {
					                              Say(Text)
					                              setRate(-0.2)
					  							 }	
//--------------------------
func FrameAction()
						     
						  Camangle+=0.000001
						
						   if Camangle>=1.34 Camturn = false  Camangle = 0  ok
									oCameraEntity{   	
							     		   oQ = new QQuaternion(0,0,0,0)
										   rotateAboutViewCenter(oQ.fromAxisAndAngle(new QVector3D(0, 1, 0), Camangle))
										   }

						   if mouseRightClick  pRightClick()  ok		

							 oView.omediaplayer1.setvolume(oView.Slider1.value())  

							 if  PLAY_VS_AI = true 
										
										  TurnBlack = TurnAI									
						    else 
									
										 TurnBlack != TurnAI
						    ok

							
							 if  PLAY_VS_AI = true and currentTurn = TurnBlack  and isTurnWhite = false 
												sleep(2)
											AiNewMove()  
										    currentTurn = TurnWhite  
							ok
								
							/* if  PLAY_ON_LINE 
 											networkMode = true
							ok */

//------------------------------
func AiNewMove()
								
								? "1_currentTurn :" + currentTurn	

								AiMove = oChessboard.getLegalAttackMove(0)

								if len(AiMove) =1	
										AiBestMove = AiMove[1]
								else
										 AiBestMove =oChessboard.RandomItem(AiMove)
								ok
								// AiBestMove =Aitree.getBestMove(true, 1) 
								?  AiBestMove
									selectionI = AiBestMove.fromI
									selectionJ = AiBestMove.fromJ
									i = AiBestMove.ToI
									j = AiBestMove.ToJ

								HandleNewSelection( i, j)
								//oChessboard.MackeMove( AiBestMove)
						
					  
//----------------------------------------- 
func HandleNewSelection( i, j)
						
						   piece = board[i][j]

						   // ---------Selecting own turn's piece.----------
						   if  isOngame = 1 and  piece != ' '  and  ((oChessboard.iswhitepiece(piece) and 
																								currentTurn = TurnWhite) or 
																								(oChessboard.isblackpiece(piece) and
								 																currentTurn = TurnBlack))

												      selectionI = i
												      selectionJ =  j
										    		// playSoudMove("SlectionPiece.wav")

						   // -------Trying to move a selected piece--------
						   elseif selectionI > 0 and selectionJ > 0
										
											
								   	  if  oChessboard.ValidMove(board , selectionI , selectionJ , i , j , currentTurn)  
													/*  if Board[i][j] = ' '
																DistrbutMoveSound(Board , selectionI , selectionJ)
													   else
																playSoudMove("KingMove.mp3")           
													   ok	*/
														oMove.fromI =selectionI
														oMove.fromJ = selectionJ
														oMove.Toi = i
														oMove.Toj = j
														oChessboard.MackeMove(oMove)
													? oChessboard.getLastMove()
																//? listToCode(LastMove)
														list_all_moves + LastMove
													//?ListToCode(oChessboard.getLegalMove( 1))
												  //? ListToCode(list_all_moves)
											
												if PLAY_ON_LINE	
															  alist = []
										    				  alist +"Move"
										  					  alist + LastMove
															  Message = listToCode(aList)
															? "Message Move:"+Message
															  writeMessage(Message)
												ok
										       selectionI =  0
										       selectionJ =  0	
												
											  if currentTurn = TurnWhite
													    
										                if oChessboard.isCheckMate(board, TurnBlack)
															oView.oTimer.stop()
										                   MsgWhite(MSG_WIN)
										                   MsgBlack( MSG_LOSE)	

								
											           else 
																    //currentTurn = TurnBlack     
											               if not DrawPromotionPawn currentTurn = TurnBlack  ok//MsgBlack(" ") ok //MSG_BLACK_TURN
												
															oView.radioButton.setChecked(true)
															oView.radioButton_2.setChecked(false)
															//resetLCD()
															// oView.oTimer.start()
																 		
											            ok		
										  		else
													
												         if oChessboard.isCheckMate(board, TurnWhite)
															oView.oTimer.stop()
												             MsgWhite( MSG_LOSE)
												             MsgBlack( MSG_WIN)						    		
												         else
																		 // currentTurn = TurnWhite 
												              if not DrawPromotionPawn   currentTurn = TurnWhite ok//MsgWhite( " ") ok  //MSG_WHITE_TURN
												               	 	
																oView.radioButton.setChecked(false)
																oView.radioButton_2.setChecked(true)
																//resetLCD()
																 //oView.oTimer.start()
												         ok	
															
										   	   ok
									 else				
											      if oChessboard.isCheck(board, currentTurn)
						
													         if currentTurn = TurnWhite 
													            MsgWhite(MSG_CHECK)
													         else										
													            MsgBlack(MSG_CHECK)
													         ok								
											      else				
													         if currentTurn = TurnWhite 
													            MsgWhite(MSG_INVALID)
													         else
													            MsgBlack(MSG_INVALID)
													         ok
														
									              ok	
									 
									     selectionI =  0
										 selectionJ =  0	
										 
								   ok					
							
						  ok
						oChessboard.Update()		

//----------------------------
func ActiveMusic()
									       
								     try	
											  oFiledialog = new Qfiledialog(oView.win) 
											  cFile = oFiledialog.getopenfilename(oView.win,"Open Music File ","c:\","source files(*.mp3)")
										  	  oView.omediaplayer1.setmedia(new QUrl("file:///" + cFile))  
									 catch
	        									  ?  "Can't open file"
													SayText( "Can't open file")
									 done
									  oView.omediaplayer1.play() 
//---------------------------------
func playSoudMove( FileName)
									 
								   oView.omediaplayer.setmedia(new QUrl("file:///"+currentdir()+"/"+ "textures/sound/"+FileName ))  
								   oView.omediaplayer.setvolume(oView.Slider1.value())
									oView.omediaplayer.play()

//------------------------------------------------
func  DistrbutMoveSound(board, i, j)

										 piece =board[i][j]	
								switch piece
										on 'kr'   playSoudMove( "KingMove.mp3")   
										on 'Kl'    playSoudMove( "KingMove.mp3")   
										on 'qr'   playSoudMove( "QueenMove.wav")    
										on 'Ql'    playSoudMove( "QueenMove.wav")   
										on 'br'    playSoudMove( "BishoMove.mp3")   
										on 'Br'    playSoudMove( "BishoMove.mp3")    
										on 'bl'    playSoudMove( "BishoMove.mp3")   
										on 'Bl'    playSoudMove( "BishoMove.mp3")    
										on 'nr'    playSoudMove( "knightMove.mp3")   
										on 'Nr'    playSoudMove( "knightMove.mp3")   
										on 'nl'     playSoudMove( "knightMove.mp3")    
										on 'Nl'     playSoudMove( "knightMove.mp3")   
										on 'rr'     playSoudMove( "BishoMove.mp3")     
										on 'Rr'     playSoudMove( "BishoMove.mp3")     
										on  'rl'      playSoudMove( "BishoMove.mp3")   
										on 'Rl'      playSoudMove( "BishoMove.mp3")   
										on 'p1'     playSoudMove( "pawnMove.wav")    
										on 'P1'      playSoudMove( "pawnMove.wav")   	
										on 'p2'      playSoudMove( "pawnMove.wav")   	
										on 'P2'      playSoudMove( "pawnMove.wav")   
										on 'p3'      playSoudMove( "pawnMove.wav")   
										on 'P3'      playSoudMove( "pawnMove.wav")   
										on 'p4'      playSoudMove( "pawnMove.wav")   
										on 'P4'      playSoudMove( "pawnMove.wav")   
										on 'p5'      playSoudMove( "pawnMove.wav")   
										on 'P5'       playSoudMove( "pawnMove.wav")   
										on 'p6'   	  playSoudMove( "pawnMove.wav")   
										on 'P6'    	  playSoudMove( "pawnMove.wav")   
										on 'p7'       playSoudMove( "pawnMove.wav")   
										on 'P7'   	  playSoudMove( "pawnMove.wav")   
										on 'p8'       playSoudMove( "pawnMove.wav")   
										on 'P8'    	  playSoudMove( "pawnMove.wav")   
										on 'ppqw'  playSoudMove( "PawnPromotionMouve.wav")  
										on 'ppqb'   playSoudMove( "PawnPromotionMouve.wav")  
										on 'pprw'   playSoudMove( "PawnPromotionMouve.wav")  
										on 'pprb'    playSoudMove( "PawnPromotionMouve.wav")  
					  					on 'ppbw'   playSoudMove( "PawnPromotionMouve.wav")  
										on 'ppbb'   playSoudMove( "PawnPromotionMouve.wav")  
										on 'ppkw'   playSoudMove( "PawnPromotionMouve.wav")  
										on 'ppkb'   playSoudMove( "PawnPromotionMouve.wav")  
								off

//-----------------------       
func saveEndGame()	

									SaveGame(board) 
									save_list_all_moves()
//-----------------------       
func save_list_all_moves()

									cFileName = "SaveGame/SaveAllMoves/ AllMoves"+substr(date(),"/","_")+
																									"_"+substr(time(),":","_") +".txt"
									cStr = "list_History_all_moves ="
									cStr += ListToCode(list_all_moves)
									write(cFileName,cStr)
		

//-------------------------------------       
func SaveGame(aList)
						 
									cFileName = "SaveGame/Save the end game"+substr(date(),"/","_")+
																						"_"+substr(time(),":","_") +".txt"
									cStr = "board ="
									cStr += ListToCode(aList)
									write(cFileName,cStr)


//--------------------------
func ListToCode(aList)
   						
						cCode ="["
						lStart = True
						for item in aList 
							if !lStart  cCode += "," +Windowsnl() else lStart = False ok
							if isString(item)  cCode += char(39)+ item +char(39)
							but isnumber(item)  cCode += ""+item
							but islist(item)  cCode += ListToCode(item)
							but isobject(item) 
										aAttribut = attributes(item) 
											cCode += '['
											lStart = True
										for attribut in aAttribut
												if !lStart  cCode += "," else lStart = False ok				
												value = getattribute(item,attribut)
												cCode +=':'+ attribut + '='
												if isString(value)
														cCode += '"' + value + '"' 
												but isNumber(value)
														cCode += value 
												but isList(value)
														cCode += ListToCode(value) 
												but isobject(value)
														cCode += ListToCode(value) 
												ok	
												
										next
										cCode += " ]"
							ok
						next
						cCode += "]"+Windowsnl()
						return cCode
//-----------------
func mouseIn()

// -----Handles mouse click inputs--------
func mouseInput(i,j)

							   button = oView.oFilter.getbutton()		  
							   if button = 1	
								      if i >=1 and i <= 8 and j >=1 and j < =8		
								       		  HandleNewSelection(i,j)		
								      else			
										          selectionI = 0
										          selectionJ = 0
								      ok		
							   elseif button = 2
							      mouseRightClick=true
							
							   ok
//---------------------------------------------------
func setPawnPromotion( targetID, toI, toJ)
							
							 Piece =  Board[toI][toJ]	
						
							switch targetID
						
									on 1  	if oChessboard.ispawnwhite(Piece)		
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppqw'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												else
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppqb'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												ok
									on 2  	if oChessboard.ispawnwhite(Piece)		
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppbw'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												else
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppbb'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												ok
								    on 3  	if oChessboard.ispawnwhite(Piece)		
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppkw'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												else
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppkb'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												ok
									on 4    if oChessboard.ispawnwhite(Piece)		
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'pprw'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												else
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'pprb'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												ok
						   		 off

							if PLAY_ON_LINE
										  alist = []
					    				  alist +"pawn promotion"
					  					  alist + toi
					  					  alist + toj
					    				  alist + targetID
										  Message = list2Code(aList)
										  ? Message
										  writeMessage(Message)
							ok
		
//---- read Tcp Message -----
func readMessage(Message)

								Try
							        eval(Message)
								Catch
									  ? "cant red Message"
									SayText("cant red Message")
								Done
							
								? aCommand
								str = aCommand[1]
							    ? str
								SayText(str)
								args = []
							    for i=2 to len(aCommand)
							        ? i
									args + i
							    next
							
							    if str = "move"
							        passive_move(args)
							    elseif str = "start" 
							        passive_start(args[1])
							   elseif str ="new game"
							        passive_newGame(args[1])
							    elseif str ="load"
							        passive_loadEndGame(args)
							    elseif str ="resign OK"
							        passive_resignOK()
							    elseif str ="resign cancel"
							        passive_resignCancel()
							    elseif str ="resign"
							        passive_resignSelect()
							    elseif str ="time out"
							        passive_timeOut()
							    elseif str ="end"
							        passive_checkMate(args[1])
							    elseif str ="stalemate"
							        stalemate()
							    elseif str ="pawn promotion"
							        passive_pawnPromotion(args)
							    ok
							
//--- Write Tcp Message -----
func writeMessage(cStr)

									Message ="aCommand="
									Message += cStr
								    if networkMode 
											if isMethod(self,:IsClientWindow) 
													if IsClientWindow() {
														ClientWindow().sendMessage(Message)
													ok
											ok
								      
								    else
											if isMethod(self,:IsServerWindow) 
													if IsServerWindow() {
														ServerWindow().sendMessage(Message)
													ok
											ok
								    ok
		
//--Manege MyTurn ---
func myTurn()

							    oView.oTimer.stop()
							    updateyourCheck(board, TurnWhite)
							    updateMyCheck(board, TurnBlack)
							    if isNoWay(board, TurnWhite)
							       
							          checkMate( Board , TurnWhite)
							    else
							         if PLAY_ON_LINE writeMessage('["stalemate"]') ok
							           stalemate()
							        
							    ok
							    currentTurn = TurnBlack
							    oView.radioButton.setChecked(false)
							    oView.radioButton_2.setChecked(true)
							   // resetLCD()
							  //  oTimer.start()
								
//---- Manege Your Turn---
func youTurn()
					
							    ? "your turn1"
							    oView.oTimer.stop()
							    updateMyCheck(board, TurnWhite)
							    ? "your turn2"
							    updateyourCheck(board, TurnBlack)
							    ? "your turn3"
							    currentTurn = TurnBlack
							    oView.radioButton.setChecked(true)
							    oView.radioButton_2.setChecked(false)
							   // resetLCD()
							   //oTimer.start()
		
//---Timer Change----
func timeChange()

						    if not isOngame return ok
		
						    if currentTurn =  TurnWhite		
						        if myTime > 0
						            myTime --
						            oView.myLCD.display(myTime)
									isTurnWhite = true
						        else
						            timeOut()
						        ok
						    else
						        if yourTime > 0
						            yourTime --
						            oView.yourLCD.display(yourTime)  
									 isTurnWhite = false 	
						       else
						            timeOut()
						       ok
						  ok

//-------------------------------------------------------
func updateMyCheck(board, currentTurn)

						    myCheck = isCheck(board, currentTurn)
						    if myCheck = 0
						        oView.radioButton_2.setText("ME")
						    else
						        oView.radioButton_2.setText("CHECK")
								SayText("Check")
						    ok

//---------------------------------------------------------
func updateyourCheck(board, currentTurn)

						   yourCheck =isCheck(board, currentTurn)
					  	   if yourCheck = 0
					        	oView.radioButton.setText("OPPONENT")
					      else
					        	oView.radioButton.setText("CHECK")
								SayText("Check")
					      ok

//---------------------------------------------------
func isKingNoWay(board, currentTurn)

    					return isCheckMate(board, currentTurn)


//----------------
func resetLCD()

					    myTime = 0 
					    oView.myLCD.display(myTime)
					    yourTime = 0 
					    oView.yourLCD.display(yourTime)


//------------
func resign()
   
							oMessageBox = new qMessageBox(null){
									setWindowTitle("Admit defeat")
									setText("Are you sure you want to admit defeat?")
									setStandardButtons( QMessageBox_yes )
								}
								
							reply = oMessageBox.exec()
								
							if reply = QMessageBox_yes
									if PLAY_ON_LINE writeMessage('["resign"]') ok
      								 MessageBoxAbout("Admit defeat ", "Confession request sent")
									
							ok
							
//----------------
func timeOut()
									
						               playSoudMove("tada.wav")
									    isOngame = 0
									   if PLAY_ON_LINE	 writeMessage('["time out"]') ok
									    MessageBoxAbout("time out","you have timed out! you lose.")
									    oView.oTimer.stop()
										
									   
//-----------------------------------------
func checkMate(board, currentTurn)

									    isOngame = 0
									   	oView.oTimer.stop()
										 if PLAY_ON_LINE
											    aList= []
												aList + "end"
											    aList + currentTurn
												Message = listToCode(aList)
											 	writeMessage(Message)
										 ok

									    if currentTurn = TurnWhite  
									       MessageBoxAbout("the end","you lose.")
											
									    else
									        MessageBoxAbout("the end","you win!")
											
									    ok

//-----------------
func stalemate()

								    isOngame = 0
								    oView.oTimer.stop()
								    MessageBoxAbout("the end","Forcing peace.")
						
//-------------------------------
func passive_newGame( Turn )

						    	isOngame = 0
								currentTurn = Turn
							   
							    oChessboard.clearAllPieces()
								oChessboard.clearboard()
								Board = StartBoard
								oChessboard.DrowAllPiece()
								oChessboard.Update()
							    oView.startButton.setEnabled(true)
							    oView.saveButton.setEnabled(true)
							
//------------------------
func passive_start(Time)

							    isOngame = 1
							    myTime = 0+ Time
							    oView.myLCD.display(myTime)
							    yourTime = 0+ Time
							    oView{
									yourLCD.display(yourTime)
							    	resignButton.setEnabled(true)
									}
							    if currentTurn = TurnWhite
							        oView{
										radioButton.setChecked(true)
							        	radioButton_2.setChecked(false)
										}
							    else
									oView{
								        radioButton.setChecked(false)
								        radioButton_2.setChecked(true)
										}
							    ok
							    oView.oTimer.start()
							
//------------------------------------
func passive_loadEndGame(args)

								isOngame = 0
								oView{
								    startButton.setEnabled(true)
								    saveButton.setEnabled(true)
									}
							   
							    currentTurn = args[1]
							    oChessboard.clearAllPieces()
								oChessboard.clearboard()
								eval( args[2])
								
								oChessboard.DrowAllPiece()
								oChessboard.Update()
							   
							

//--------------------------
func passive_resignOK()

							    isOngame = 0
							    oView.oTimer.stop()
							    MessageBoxAbout("the end","you lose.")
							
//-----------------------------
func passive_resignCancel()

   								 MessageBoxAbout("Admit defeat","The other party rejected your request to admit defeat.")

//-----------------------------
func passive_resignSelect()

									oMessageBox = new qMessageBox(oView.oWidget ){
											setWindowTitle("Admit defeat")
											setText("The opponent asks to admit defeat, do you agree?")
											setInformativeText("InformativeText")
											setStandardButtons( QMessageBox_yes | QMessageBox_no)
										}
									reply = 	oMessageBox.exec()		
									if reply = QMessageBox_yes
												isOngame = 0
										        oView.oTimer.stop()
								   				  writeMessage('["resign OK"]') 
										        MessageBoxAbout("the end","you win!")
									elseif reply = QMessageBox_No 
										 		writeMessage('["resign cancel"]') 
									ok
												
//-------------------------     
func passive_timeOut()

							    isOngame = 0
							    MessageBoxAbout("Time Out","The Opponent Timed Out! You Win!")
							    oView.oTimer.stop()

//----------------------------
func passive_move(args)

							    selectionI = args[:selectionI]  selectionJ = args[:selectionJ]  I = args[:I]  J = args[:J]
							
							  HandleNewSelection( i, j)
							 /*  oChessboard.deletepiece(board, I, J)
						       board[I][J] = board[selectionI][selectionJ]
							   oChessboard.deletepiece(board, selectionI, selectionJ)					
							   oChessboard.redrowpiece(board, I, J)
							   board[selectionI][selectionJ] = ' '	*/
							    myTurn()
							

//---------------------------------
func passive_checkMate(currentTurn)

							    isOngame = 0
							    oView.oTimer.stop()
							    if  currentTurn = TurnWhite
								         MessageBoxAbout("the end","you lose.")
										
							    else
							         	MessageBoxAbout("the end","you win!")
										
							    ok
							
//---------------------------------------
func passive_pawnPromotion(args)

						    
						    I  = args[1]
						    J  = args[2]
						    targetID = args[3]

						 Piece =  board[I][J]	
							switch targetID
									on 1  	if oChessboard.ispawnwhite(Piece)		
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppqw'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												else
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppqb'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												ok
									on 2  	if oChessboard.ispawnwhite(Piece)		
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppbw'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												else
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppbb'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												ok
								    on 3  	if oChessboard.ispawnwhite(Piece)		
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppkw'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												else
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'ppkb'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												ok
									on 4    if oChessboard.ispawnwhite(Piece)		
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'pprw'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												else
														oChessboard.clearPieces(Board,toI, toJ)
														Board[toI][toJ] = ' ' 
														Board[toI][toJ]  = 'pprb'
														oChessboard.DrowPiece(Board, toI, toJ)
														oChessboard.RemoveProPawnComponent()
														DrawPromotionPawn = false
														Camturn = true
												ok
						   		 off
						    myTurn()

//----------------
func setClient()
   							networkMode = true
							SayText("network Mode is true.")
   						 openWindowAndLink(:ClientWindowController, self)
   
//------------------
func setServer()
  							networkMode = false
    					openWindowAndLink(:ServerWindowController, self)
   
//---------------------------------------
func MessageBoxAbout(title, text)

								new Qmessagebox(oview.win) {
								                setwindowtitle(title)
								                settext(text)
								                show()
								       		 }
								SayText(text)











