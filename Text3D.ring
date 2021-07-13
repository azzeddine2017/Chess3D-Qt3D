#------------------------------------------------
# Chess3d Qt3D      
#    20-06-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

##################
#---------Class Text3D------#
##################

	
Class Text3D

				       
						Entity	
						Text 		
						Transform 	
						Material 	
						Mesh
		//--------------------------------
		func init( TextEntity)
							
						Entity=TextEntity
						T_Entity    = new QEntity(Entity)
						Mesh        = new  QExtrudedTextMesh(T_Entity) 
						Transform = new  QTransform(T_Entity)
						Material     = new QPhongMaterial(T_Entity)
						
						T_Entity.addComponent(Mesh)
						T_Entity.addComponent(Transform)
						T_Entity.addComponent(Material)
						

						
		//--------------------------------
		func SetTextPos(Posx, Posy, posz)
	
			 		   Transform.setTranslation(new QVector3D(Posx, Posy, posz))
		//--------------------------------
		func SetTextColor(Color)
	
						Material.setDiffuse(Color)
		//--------------------------------
		func SetTextSiz(Sizx, Sizy, Sizz)
	
						Transform.setScale3D(new QVector3D(Sizx, Sizy, Sizz))
		//--------------------------------
		func SetTextDirection( Direction)
	
						oQ = new QQuaternion(0,0,0,0)
						Transform.setRotation(oQ.fromAxisAndAngle(new QVector3D(0, 1, 0), Direction))

		
					
		//--------------------------------
		func SetText3D(Text3D ,TextposY)
						
						
						Mesh{
								setText(Text3D)
								setdepth(1)
								setFont(new qfont("Times",22,-1,0))
								}
						
						TextposZ=0
						TextposX=0				
						txtdirection=0
						
						CamX = oCameraEntity.position().x()

						if CamX > 0 
			
								 	if Camturn
												 TextposZ =-190 
												 SetTextDirection(160) 
												TextposX=40
												
									else 
												TextposZ =190
												 SetTextDirection(-20) 
												TextposX=-40
						
									ok
									Transform.setTranslation(new QVector3D( TextposX, TextposY, TextposZ))
							
						else

									 if Camturn 
											TextposZ =190
											 SetTextDirection(-20) 
											TextposX=-40
										
									else 
											TextposZ =-190 
											SetTextDirection(160)
											TextposX=40
									ok
							Transform.setTranslation(new QVector3D( TextposX, TextposY, TextposZ))
							
						 ok
						 if Text3D != " "
								
										SayText(Text3D)
										
						ok
						 
						
					
	


