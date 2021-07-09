#------------------------------------------------
# Chess3d Qt3D      
#    20-06-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

##################
#---------DrowSkyBox--------#
##################


func DrowSkyBox(RootEntity , Path , negx , negy , negz , posx , posy , posz ) 

				

		skybox_RootEntity= new QEntity(RootEntity)

		//-------------------- oskybox_negy -----------اسفل------------------
		
		 	oskybox_negy = new  QPlaneMesh(skybox_RootEntity){
						setHeight(10)
						setWidth(10)
						setmeshresolution(new qSize(10,10))
		                }
			oskybox_negy_Transform = new  QTransform(oskybox_negy){
									setScale(201)
									setTranslation(new QVector3D(0, -800, 0))
									 oQ = new QQuaternion(0,0,0,0)
									SetRotation(oQ.FromAxisAndAngle(new QVector3D(0, 1, 0), 180))
									}
			oTextureLoader = new  QTextureLoader(oskybox_negy){
									setSource(new QUrl("file:///"+currentdir() + "/" + Path +"/" + negy ) )
									}
			oskybox_negy_Material = new QTextureMaterial(oskybox_negy){
									setTexture(oTextureLoader)
									}
			oskybox_negy_Entity = new QEntity(skybox_RootEntity){
									addComponent(oskybox_negy)
									addComponent(oskybox_negy_Material)
									addComponent(oskybox_negy_Transform)
								    }
		
		//-----------------------skybox_negx------------يمين-----------------
		
			oskybox_negx = new  QPlaneMesh(skybox_RootEntity){
						setHeight(10)
						setWidth(10)
						setmeshresolution(new qSize(10,10))
		                }
			oskybox_negx_Transform = new  QTransform(oskybox_negx){
									setScale(201)
									setTranslation(new QVector3D(-999, 200, 0))
									 oQ = new QQuaternion(0,0,0,0)
									SetRotation(oQ.FromAxisAndAngle(new QVector3D(1, 1, 1), 240))
									}
			oTextureLoader = new  QTextureLoader(oskybox_negx){
									setSource(new QUrl("file:///"+currentdir() + "/" + Path +"/" +negx ) )
									}
			oskybox_negx_Material = new QTextureMaterial(oskybox_negx){
									setTexture(oTextureLoader)
									}
			oskybox_negx_Entity = new QEntity(skybox_RootEntity){
									addComponent(oskybox_negx)
									addComponent(oskybox_negx_Material)
									addComponent(oskybox_negx_Transform)
								    }
		
		//------------------------skybox_negz----------------امام--------------------
		
			skybox_negz = new  QPlaneMesh(skybox_RootEntity){
						setHeight(10)
						setWidth(10)
						setmeshresolution(new qSize(10,10))
		                }
			skybox_negz_Transform = new  QTransform(skybox_negz){
									setScale(201)
									setTranslation(new QVector3D(0, 200, -999))
									 oQ = new QQuaternion(0,0,0,0)
									SetRotation(oQ.FromAxisAndAngle(new QVector3D(0, 1, 1),180))
									}
			oTextureLoader = new  QTextureLoader(skybox_negz){
									setSource(new QUrl("file:///"+currentdir() + "/" + Path +"/" + negz ) )
									}
			skybox_negz_Material = new QTextureMaterial(skybox_negz){
									setTexture(oTextureLoader)
									}
			skybox_negz_Entity = new QEntity(skybox_RootEntity){
									addComponent(skybox_negz)
									addComponent(skybox_negz_Material)
									addComponent(skybox_negz_Transform)
								    }
		
		//----------------skybox_posx---------------يسار---------------
		
			skybox_posx = new  QPlaneMesh(skybox_RootEntity){
						setHeight(10)
						setWidth(10)
						setmeshresolution(new qSize(10,10))
		                }
			skybox_posx_Transform = new  QTransform(skybox_posx){
									setScale(201)
									setTranslation(new QVector3D(999, 200, 0))
									 oQ = new QQuaternion(0,0,0,0)
									SetRotation(oQ.FromAxisAndAngle(new QVector3D(-1, 1, 1), 120))
									}
			oTextureLoader = new  QTextureLoader(skybox_posx){
									setSource(new QUrl("file:///"+currentdir() + "/" + Path +"/" + posx ) )
									}
			skybox_posx_Material = new QTextureMaterial(skybox_posx){
									setTexture(oTextureLoader)
									}
			skybox_posx_Entity = new QEntity(skybox_RootEntity){
									addComponent(skybox_posx)
									addComponent(skybox_posx_Material)
									addComponent(skybox_posx_Transform)
								    }
		
		//-------------------------- skybox_posy ---------اعلى-----------
		
			skybox_posy = new  QPlaneMesh(skybox_RootEntity){
						setHeight(10)
						setWidth(10)
						setmeshresolution(new qSize(10,10))
		                }
			skybox_posy_Transform = new  QTransform(skybox_posy){
									setScale(201)
									setTranslation(new QVector3D(0,1200, 0))
									 oQ = new QQuaternion(0,0,0,0)
									SetRotation(oQ.FromAxisAndAngle(new QVector3D(0, 0, 180), 180))
									}
			oTextureLoader = new  QTextureLoader(skybox_posy){
									setSource(new QUrl("file:///"+currentdir() + "/" + Path +"/" +posy ) )
									}
			skybox_posy_Material = new QTextureMaterial(skybox_posy){
									setTexture(oTextureLoader)
									}
			skybox_posy_Entity = new QEntity(skybox_RootEntity){
									addComponent(skybox_posy)
									addComponent(skybox_posy_Material)
									addComponent(skybox_posy_Transform)
								    }
		//--------------------- skybox_posz ------------------الخلف---------------------
		
			skybox_posz = new  QPlaneMesh(skybox_RootEntity){
									setHeight(10)
									setWidth(10)
									setmeshresolution(new qSize(10,10))
					                }
			skybox_posz_Transform = new  QTransform(skybox_posz){
									setScale(201)
									setTranslation(new QVector3D(-2.5, 200, 999))
									 oQ = new QQuaternion(0,0,0,0)
									SetRotation(oQ.FromAxisAndAngle(new QVector3D(180, -0.1, -0.5), 270))
									}
			oTextureLoader = new  QTextureLoader(skybox_posz){
									setSource(new QUrl("file:///"+currentdir() + "/" + Path +"/" +posz ) )
									}
			skybox_posz_Material = new QTextureMaterial(skybox_posz){
									setTexture(oTextureLoader)
									}
			skybox_posz_Entity = new QEntity(skybox_RootEntity){
									addComponent(skybox_posz)
									addComponent(skybox_posz_Material)
									addComponent(skybox_posz_Transform)
								    }
		
		
