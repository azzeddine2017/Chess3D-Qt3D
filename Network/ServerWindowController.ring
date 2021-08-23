#------------------------------------------------
# Chess3d Qt3D      
#    15-08-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------


load "ServerWindowView.ring"

if IsMainSourceFile() 
	new QApp {
		StyleFusion()
		openWindow(:ServerWindowController)
		exec()
	}
ok

Class ServerWindowController from windowsControllerParent	

					oView = new ServerWindowView
						oTcpServer
						otcpSocket
						cOutput
					    oHostAddress = new qHostAddress()
						oHostAddress.SetAddress("0.0.0.0")   
					   oView.lineEdit1.setText(oHostAddress.tostring())

			//-----------------------
			func startServer()
                             
										   oTcpServer = new qTcpServer(null)
										   if  oTcpServer.listen(oHostAddress,9999) < 0
											        MsgBox("Server,
											                         Unable to start the server: "+ oTcpServer.errorString())
											        return
										    ok
										    ? "listen on port:"+oTcpServer.serverPort()
											oView.Label2.settext("port:"+ oTcpServer.serverPort())
										    oView.Buttonok.setEnabled(false)
											oTcpServer.setNewConnectionEvent(method(:acceptConnection))
					
			//-----------------------
			func cancelServer()

									        oTcpServer.close()
										    oView.Buttonok.setEnabled(true)
											oView.Label2.settext(" ")

			//-----------------------
			func acceptConnection()

										    otcpSocket = oTcpServer.nextPendingConnection()
										    cstr = "Ready New Game" + nl
					                		oView.Label2.settext(cstr)
											otcpSocket.setreadyreadevent(method(:receiveMessage))
										    sendMessage('aCommand=["server OK"]')
											oView.Win.hide()//.close()
											
					

			//-----------------------
			func receiveMessage()
											   cstr = "Ready Read!" + nl
												? cstr
								                oView.Label2.settext(cstr)
												 ? otcpSocket.bytesAvailable()
								                cOutput = otcpSocket.readall().data() + nl
												if isDisplayGame() {
														DisplayGame().readMessage(cOutput)
												ok
				
			//-----------------------
			func sendMessage(cStr)
					    
											    otcpSocket.write(cStr,len(cStr))
												otcpSocket.flush()
						                        otcpSocket.waitforbyteswritten(300000)
						                        //otcpSocket.close()
									
			//--------------------------
		func MsgBox(text)
			
										      msg = new QMessageBox(oView.Win)
								              msg.setWindowTitle(oView.Win.WindowTitle() )
								              msg.setText(text)
								              msg.show()
					    					
					    
