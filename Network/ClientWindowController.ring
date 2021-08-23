#------------------------------------------------
# Chess3d Qt3D      
#    15-08-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

load "ClientWindowView.ring"


if IsMainSourceFile() 
	new QApp {
		StyleFusion()
		openWindow(:ClientWindowController)
		exec()
	}
ok
Class  ClientWindowController  from  windowsControllerParent	

			oView = new ClientWindowView
					oClientSocket   cOutput 
	
		//----------------------
		func connectStart()
		
						    if  isIP(oView.LineEdit1.text())=0
						        MsgBox("NetGame Client ,
										 Please check that the IP is correct.")
						        return 
						    ok
						
						    oView.Buttonok.setEnabled(false)
				
						     oClientSocket = new QTcpSocket(null)
				             oClientSocket.setconnectedevent(method(:connectSuccess))	
							 
				             oClientSocket.connectToHost(oView.LineEdit1.text(),19999,3,0)
				             oClientSocket.waitforconnected(5000)
				                        
						
		//------------------------
		func connectCancel()
					   		  oClientSocket.close()
					   		  oView.Buttonok.setEnabled(true)
					
		//-------------------------
		func connectSuccess()
									
		                        cstr= "Connected !"+ nl
								? cstr 
								oView.Label2.settext(cstr)
								 oClientSocket.setreadyreadevent(method(:receiveMessage))
							  oView.Win.hide()//.close()
										
							   
		
		//--------------------------------
		func displayError(socketError)
		    
								   switch socketError
										   on	 RemoteHostClosedError
										      		
						
										    on  HostNotFoundError
										        			MsgBox(" Client
																				 The host was not found. Please check the 
											                                    host name and port settings. ")
										   on  ConnectionRefusedError
											         		MsgBox(" Client
											                                  The connection was refused by the peer. 
										                                    Make sure the NetGame server is running, 
										                                    and check that the IP 
										                                    is correct.")
										    other
										        				MsgBox( " Client
										                                 The following error occurred: " + oClientSocket.errorString())
								     off
				  				    Buttonok.setEnabled(true)
		
		//-----------------------
		func receiveMessage()
									cstr = "Ready Read !" + nl
									? cstr
					                oView.Label2.settext(cstr)
									 ? oClientSocket.bytesAvailable()
					                cOutput = oClientSocket.readall().data() + nl
									//? cOutput
					               // oView.Label2.settext(cOutput)

									if isDisplayGame() {
									DisplayGame().readMessage(cOutput)
									ok

			
		//-----------------------		
		func sendMessage(cStr)
		  		 
									  oClientSocket.write(cStr,len(cStr))
			       					  oClientSocket.flush()
			                          oClientSocket.waitforbyteswritten(300000)
			                          //oClientSocket.close()
				
		//--------------------------
		func MsgBox(text)
			
								      msg = new QMessageBox(oView.Win)
						              msg.setWindowTitle( oView.Win.WindowTitle() )
						              msg.setText(text)
						              msg.show()
	         
		 //-----------------------
		 func isIP( str)
										exp = new qregularexpression()
									    exp.setPattern("^([1-9]|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]).(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]).(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5]).(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])$")
										match = exp.match(str ,0,0,0)
										
							        	 return match.hasmatch() 

		
		
