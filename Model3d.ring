#------------------------------------------------
# Chess3d Qt3D      
#    20-06-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

###################
#----------Class Model3d------#
###################


		
Class Model3d


						MEntity
						Entity 
						
						Model 
						Path
						Transform
						TextureLoader
						TextureMaterial
						
						
	
		func init( ModelEntity, ModelName, ModelPath )
				
					Entity=ModelEntity
					Model=ModelName		
					Path=ModelPath

					Model = new qmesh(MEntity)
					Model.setsource(new qURL("file:///"+currentdir()+"/" + path) ) 
					TextureLoader = new  QTextureLoader(Model)
					TextureMaterial = new QTextureMaterial(Model)
					
					Transform = new  QTransform(Model){
											setScale3D(new QVector3D(0.2, 0.2, 0.2))
											setTranslation(new QVector3D(0, 0, 0))
											}
					MEntity = new QEntity(Entity)
					MEntity.addComponent(Model)
					
					MEntity.addComponent(TextureMaterial)
					MEntity.addComponent(Transform)

				
		
		//--------------------------------
		func SetModelPos(Posx, Posy, posz)
	
					Transform.setTranslation(new QVector3D(Posx, Posy, posz))

		//--------------------------------
		func SetModelTexture(Path)
							
					TextureLoader.setSource(new QUrl("file:///"+currentdir()+"/"+Path ) )
					TextureMaterial.setTexture(TextureLoader)
		//--------------------------------
		
		//--------------------------------
		func SetModelSiz(Sizx, Sizy, Sizz)
	
					Transform.setScale3D(new QVector3D(Sizx, Sizy, Sizz))

		//--------------------------------
		func SetModelDirection( AxisX, AxisY, AxisZ, Angle)
	
					oQ = new QQuaternion(0,0,0,0)
					Transform.setRotation(oQ.fromAxisAndAngle(new QVector3D(AxisX, AxisY, AxisZ), Angle))
		//--------------------------------	
		func RotateFromAngle(Speed)
					
					 Angle=0
					 Angle+=Speed
				 	 if Angle >=100  Angle = 0  ok
				
					 oQ = new QQuaternion(0,0,0,0)
					Transform.SetRotation(oQ.FromAxisAndAngle(new QVector3D(0, 1, 0), Angle))
		//-------------------------------------
		func removeComponent()
					
						MEntity.removeComponent(Model)
						MEntity.removeComponent(TextureMaterial)
						MEntity.removeComponent(Transform)					
						
	                

		






