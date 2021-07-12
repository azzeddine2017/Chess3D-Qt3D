#------------------------------------------------
# Chess3d Qt3D      
#    20-06-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

###############################
#-----class DisplayGame-------#
###############################

class DisplayGame


	

		
    oView    = new Qt3dwindow()
    oWidget  = new QWidget()
    oView.defaultFrameGraph().setClearColor(Black)
    oContainer  = oWidget.createWindowContainer(oView,oWidget,0)
    oRootEntity = new QEntity(oContainer)
    oInput      = new QInputAspect(oRootEntity)
    oView.registerAspect(oInput)
    oCameraEntity = oView.Camera()
    oText3d = new Text3D(oRootEntity)
    PieceEntity= new QEntity(oRootEntity)
    WhitePEntity= new QEntity(PieceEntity)
    BlackPEntity= new QEntity(PieceEntity)
   
   oFrameAction = new qFrameAction(oRootEntity) {
         settriggeredevent("FrameAction()")
         }

  
	 oFilter = new qallevents(oView){
		 setKeyPressEvent("pKeyPress()")
         setmousemoveevent("pRightClick()")
         setMouseButtonPressEvent("mouseIn()")
         setMouseButtonReleaseEvent("MouseRelease()")
        }
   oView.installeventfilter(oFilter)
  

 	oLayout = new QVBoxLayout(){
          AddWidget(oContainer)
         
          }

   oWidget {
    setwindowtitle("Using Qt3D - Chees_3D")
    resize(900,600)
    setLayout(oLayout)
    showMaximized()
 	//showfullscreen() 
  	}

 /* oContainer{
    resize(oWidget.width(),oWidget.height())   
    setfocus(0)
    }*/



func StartNewGame()
			 turn = 'a'
			 SayText(MSG_WELCOME)
			 DrowCamera()
			 DrawStars()    
			 DrowPlanets()
			 DrowLight()
 			 DrowSkyboxs()			 
			 Drowlogo()		 		  
			 DrowBoard()  
			 DrowTest3D() 
			 DrowTiles()
			 Update()
			 oView.setRootEntity(oRootEntity)
		
			
//-------------------------
func DrowCamera()

   
    oCameraEntity{
       lens().setPerspectiveProjection(45, 16/9, 0.1, 10000)
       setPosition(new QVector3D(-190, 100, 0))
       setUpVector(new QVector3D(0, 10, 0))
       setViewCenter(new QVector3D(0, 20, 0))
       viewSphere(new QVector3D(0, 20, 0),65)
      }

   oCamController = new QFirstPersonCameraController(oRootEntity){
                     setCamera(oCameraEntity)
                     setEnabled(False)
                     }

//--------------------------
func DrowSkyboxs()	
		 
			//--------------------- choose one ------- Skybox  drawing --------------
			//----------- Skybox Blue -----------
			// DrowSkyBox(oRootEntity , "textures\skybox" ,"SpaceBlue_negx.png" , "SpaceBlue_negy.png" , "SpaceBlue_negz.png" , 
			//					"SpaceBlue_posx.png" , "SpaceBlue_posy.png" , "SpaceBlue_posz.png" )
			
			//----------- Skybox Lightblue ----------
			//	 DrowSkyBox(oRootEntity , "textures\skybox" ,"SpaceLightblue_negx.png" , "SpaceLightblue_negy.png" , "SpaceLightblue_negz.png" , 
			//					"SpaceLightblue_posx.png" , "SpaceLightblue_posy.png" , "SpaceLightblue_posz.png" )
		
			//-----------Skybox Red  ------------	
			 DrowSkyBox(oRootEntity , "textures\skybox" ,"SpaceRed_negx.png" , "SpaceRed_negy.png" , "SpaceRed_negz.png" ,
								"SpaceRed_posx.png" , "SpaceRed_posy.png" , "SpaceRed_posz.png" )
		 		  

//--------------------------------
func DrowTest3D()   

   oText3d{
            setTextSiz(-20, 30, -20)
            SetTextColor(Green)
          }

//-----------------------------------
func DrowTiles()

   aTile = list(8,8)

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
	                                     setclickedevent("mouseInput("+i+","+j+")")
										  }
         aTile[i][j][:oTileEntity] = new QEntity(oRootEntity){
                                          addComponent(aTile[i][j][:oTile])
                                          addComponent(aTile[i][j][:oTileMaterial])
                                          addComponent(aTile[i][j][:oTileTransform])
                                          addComponent(aTile[i][j][:oPicker ])
                                   	 }

	  DrowPiece(i,j)
	  
 	next
 next




//------------------------------------------
func DrowPiece(i,j)

 //------ For each tile on the board..---------

   piece = board[i][j]
   
	//SEE "Start APP piece: "+ piece +nl

   //Draws the correct piece.----------------

         // White piece.---------------------wk-----------------------------------
         if piece = 'kr'
            okingw = new Model3d(WhitePEntity, okingw, "models/king.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok

         // Black piece.------------------------bK-------------------------------
         if piece = 'Kl'
            okingb = new Model3d(BlackPEntity, okingb, "models/king.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok


         // White piece.-----------------------wq-----------------------------------
         if piece = 'qr'
            oqueenw = new Model3d(WhitePEntity, oqueenw, "models/queen.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.---------------------------bQ-------------------------------
         if piece = 'Ql'
            oqueenb = new Model3d(BlackPEntity, oqueenb, "models/queen.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok


         // White piece. --------------right----------------------
         if piece = 'br'
            oBishopwr = new Model3d(WhitePEntity, oBishopwr, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok

         // Black piece.----------------------right----------------------------------------
         if piece = 'Br'
            oBishopbr = new Model3d(BlackPEntity, oBishopbr, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok

		 // White piece. --------------------left--------------------------------------
         if piece = 'bl'
            oBishopwl = new Model3d(WhitePEntity, oBishopwl, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok

         // Black piece.--------------------------left-----------------------------------------
         if piece = 'Bl'
            oBishopbl = new Model3d(BlackPEntity, oBishopbl, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok
        


         //White piece.-------------------------right----------------------------------------------
         if piece = 'nr'
            oknightwr = new Model3d(WhitePEntity, oknightwr, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         // Black piece.----------------------------right--------------------------------------------------
         if piece = 'Nr'
            oknightbr = new Model3d(BlackPEntity, oknightbr, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok

		//White piece.-------------------------left------------------------------------------------
         if piece = 'nl'
            oknightwl = new Model3d(WhitePEntity, oknightwl, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         // Black piece.--------------------------left-------------------------------------------------
         if piece = 'Nl'
            oknightbl = new Model3d(BlackPEntity, oknightbl, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok


         // White piece.------------------right--------------------------------------------
         if piece = 'rr'
            orookwr = new Model3d(WhitePEntity, orookwr,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.-----------------------right---------------------------------------------
         if piece = 'Rr'
            orookbr = new Model3d(BlackPEntity, orookbr,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok
		 // White piece.-------------------------left------------------------------------------------
         if piece = 'rl'
            orookwl = new Model3d(WhitePEntity, orookwl,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.-----------------------------left-----------------------------------------------
         if piece = 'Rl'
            orookbl = new Model3d(BlackPEntity, orookbl,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok	

      // White piece.-------------------------wp1------------------------------------------------------
         if piece = 'p1'
            opawnw1 = new Model3d(WhitePEntity, opawnw1,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.---------------------------bp1--------------------------------------------------------
         if piece = 'P1'
            opawnb1 = new Model3d(BlackPEntity, opawnb1,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok

		// White piece.----------------------------wp2-----------------------------------------------
         if piece = 'p2'
            opawnw2 = new Model3d(WhitePEntity, opawnw2,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.-------------------------------bp2--------------------------------
         if piece = 'P2'
            opawnb2 = new Model3d(BlackPEntity, opawnb2,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok

		// White piece.-----------------------------wp3----------------------------------
         if piece = 'p3'
            opawnw3 = new Model3d(WhitePEntity, opawnw3,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.-------------------------------bp3---------------------------------
         if piece = 'P3'
            opawnb3 = new Model3d(BlackPEntity, opawnb3,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok
		// White piece.--------------------------------wp4---------------------------------
         if piece = 'p4'
            opawnw4 = new Model3d(WhitePEntity, opawnw4,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.----------------------------------bp4-------------------------------
         if piece = 'P4'
            opawnb4 = new Model3d(BlackPEntity, opawnb4,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok
		// White piece.------------------------------------wp5-----------------------------
         if piece = 'p5'
            opawnw5 = new Model3d(WhitePEntity, opawnw5,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.-----------------------------------bp5-------------------------------
         if piece = 'P5'
            opawnb5 = new Model3d(BlackPEntity, opawnb5,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok
		// White piece.-------------------------------------wp6-----------------------------
         if piece = 'p6'
            opawnw6 = new Model3d(WhitePEntity, opawnw6,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.-------------------------------------bp6---------------------------
         if piece = 'P6'
            opawnb6 = new Model3d(BlackPEntity, opawnb6,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok
		// White piece.-----------------------------------wp7---------------------------
         if piece = 'p7'
            opawnw7 = new Model3d(WhitePEntity, opawnw7,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.-----------------------------------bp7----------------------------
         if piece = 'P7'
            opawnb7 = new Model3d(BlackPEntity, opawnb7,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok
		// White piece.------------------------------------wp8---------------------------
         if piece = 'p8'
            opawnw8 = new Model3d(WhitePEntity, opawnw8,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
         ok
         
         // Black piece.-----------------------------------bp8-----------------------------------
         if piece = 'P8'
            opawnb8 = new Model3d(BlackPEntity, opawnb8,  "models/pawn.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
         ok

//-----Drow Light -----
func DrowLight()

   aLight=list(3)

   for  n = 1 to len(aLight)
      v = n * 2
      aLight[n] = []

         aLight[n][:oLight] = new QPointLight(aLight[n][:LightEntity]){
                              setColor(White)
                              setIntensity(1)
                              }

         aLight[n][:oLightTransform] = new QTransform(aLight[n][:oLightEntity]){
                                       setTranslation(new QVector3D(random()%500-(100),random()%-100-(10), random()%500-(100)))
                                       }

         aLight[n][:oLightEntity]  = new QEntity(oRootEntity){
                                    addComponent(aLight[n][:oLight])
                                    addComponent(aLight[n][:oLightTransform])
                                    }
   next

//------- Draw Stars--------
func DrawStars()

      aStars = list(100)

   for n = 1 to len(aStars)

      aStars[n] = []

      aStars[n][:oStars] = new QSphereMesh(aStars[n][:oStarsEntity]){
                               setRadius(1.0)
                               setRings(100)
                               setSlices(20)
			       }
	
      aStars[n][:oStarsMaterial] = new QPhongMaterial(aStars[n][:oStars]){
                                   setDiffuse(White)
                                   }

      aStars[n][:oStarsTransform] = new  QTransform(aStars[n][:oStarsEntity]){
                                    setScale(1)
                                     setTranslation(new QVector3D(random()%1000-(500),random()%-100-(-20), random()%1000-(500)))
                                    }

      aStars[n][:oStarsEntity] = new QEntity(oRootEntity){
                                     addComponent(aStars[n][:oStars])
                                     addComponent(aStars[n][:oStarsmaterial])
                                     addComponent(aStars[n][:oStarsTransform])
                                     }

   next

//------Drow Planets---------
func DrowPlanets()

   aPlanets = list(3)

   for n = 1 to len(aPlanets)

      aTexturePlanet =[ "/textures/planet_1.jpg","/textures/planet_2.jpg","/textures/planet_3.png"]

      TextPlan = RandomList(aTexturePlanet)

      aPlanets[n] = []

      aPlanets[n][:oPlanets] = new QSphereMesh(aPlanets[n][:oPlanetsEntity]){
                                    setRadius(1.0)
                                    setRings(100)
                                    setSlices(20)
                             	     }

      aPlanets[n][:oTextureLoader] = new  QTextureLoader(aPlanets[n][:oPlanets]){
                                          setSource(new QUrl("file:///"+currentdir()+TextPlan) )
                                   	 }

      aPlanets[n][:oPlanetsMaterial] = new QTextureMaterial(aPlanets[n][:oPlanets]){
                                           setTexture(aPlanets[n][:oTextureLoader])
					   }

      aPlanets[n][:oPlanetsTransform] = new  QTransform(aPlanets[n][:oPlanetsEntity]){
                                             setScale(70)
                                             setTranslation(new QVector3D(random()%1000-(900),random()%100-(-100), random()%1000-(900)))
                                       	    }

      aPlanets[n][:oPlanetsEntity] = new QEntity(oRootEntity){
                                          addComponent(aPlanets[n][:oPlanets])
                                          addComponent(aPlanets[n][:oPlanetsmaterial])
                                          addComponent(aPlanets[n][:oPlanetsTransform])
                                         }
   next


// ------  draw logo------------
func drowlogo()

	ologo = new  QPlaneMesh(oRootEntity){
							setHeight(10)
							setWidth(10)
							setmeshresolution(new qSize(10,10))
					}
	ologo_Transform = new  QTransform(ologo){
							setScale(13.6)
							setTranslation(new QVector3D(0, 0.15, 0))
							 oQ = new QQuaternion(0,0,0,0)
							SetRotation(oQ.FromAxisAndAngle(new QVector3D(0, -1,0), 270))
							}
	oTextureLoader = new  QTextureLoader(ologo){
							setSource(new QUrl("file:///"+currentdir() + "/textures/chess1.png" ) )
							}
	ologo_Material = new QTextureMaterial(ologo){
							setTexture(oTextureLoader)
							}
	ologo_Picker = new qObjectPicker(ologo){
			     setclickedevent("DeliteAdd()")
								  }
	ologo_Entity = new QEntity(oRootEntity){
							addComponent(ologo)
							addComponent(ologo_Picker)
							addComponent(ologo_Material)
							addComponent(ologo_Transform)
						    }
		

//---------------------------- Draws the board --------------------------
func DrowBoard()

   oboard = new Model3d(oRootEntity, oboard, "models/board.obj"){
                  setmodelsiz(0.23, 0.2, 0.23)
                  setmodelpos(0, 0, 0)
                  SetModelDirection(0,1,0,degreeW)
                  SetModelTexture("textures/chessboard_wood.jpg")
		  SetModelDirection( 0, 1, 0, 90)
                 }

