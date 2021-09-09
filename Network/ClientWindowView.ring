#------------------------------------------------
# Chess3d Qt3D      
#    15-08-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------


Load "stdlibcore.ring"
Load "guilib.ring"

import System.GUI

if IsMainSourceFile() 
	new Qapp {
			StyleFusion()
			new ClientWindowView { win.show() } 
			exec()
			}
ok

Class ClientWindowView from WindowsViewParent
		
           		 Win = new  MainWindow() { 
								setWindowTitle("Create the connection")
 						setstylesheet ( "color: # 28ff02;") // setstylesheet ( "color: # 28ff02؛ background-image: url (C: / ring / game engine / qt_3d_chess / Qt3d_chess_core / textures / SpaceLightblue.png)؛" )								setgeometry(0,0,457,201)
								setLayout(Layout1)
								show()
						Label1 = new Qlabel(Win) {
								setGeometry(42,43,136,41)
								setText("Enter IP :")	
								oFont = new qfont("",0,0,0)
								oFont.fromstring("Arial,18,-1,5,50,1,0,0,0,0,Italic")
								setfont(oFont)
								oFont.delete()	
								}
						Label2 = new Qlabel(Win) {
								setGeometry(136,120,113,40)
								oFont = new qfont("",0,0,0)
								oFont.fromstring("Arial,18,-1,5,50,1,0,0,0,0,Italic")
								setfont(oFont)
								oFont.delete()	
								}
						LineEdit1 = new Qlineedit(Win) {
								setGeometry(188,46,253,41)
								
								oFont = new qfont("",0,0,0)
								oFont.fromstring("Arial,18,-1,5,50,1,0,0,0,0,Italic")
								setfont(oFont)
								oFont.delete()	
								}
						Buttonok = new Qpushbutton(Win) {
								setgeometry(387,125,43,20)
								setText("OK")
								oFont = new qfont("",0,0,0)
								oFont.fromstring("Arial,18,-1,5,50,1,0,0,0,0,Italic")
								setfont(oFont)
								oFont.delete()	
								setClickEvent(method(:connectStart))
								}
						ButtonCancel = new Qpushbutton(Win) {
								setgeometry(287,123,84,20)
								setText("Cancel")
								oFont = new qfont("",0,0,0)
								oFont.fromstring("Arial,18,-1,5,50,1,0,0,0,0,Italic")
								setfont(oFont)
								oFont.delete()	
								setClickEvent(method(:connectCancel))	
								}
						Layout3 = new QHBoxLayout(){ 
								AddWidget(Label2)
								AddWidget(Buttonok)
								AddWidget(ButtonCancel)
								}
						Layout2 = new QHBoxLayout(){ 
								AddWidget(Label1)
								AddWidget(LineEdit1)
								}
						Layout1 = new QVBoxLayout(){ 
								AddLayout(Layout2)
								AddLayout(Layout3)
								}
				} 
				oMWLayout = new QWidget(){ setLayout(Layout1) }
		        win.setCentralWidget(oMWLayout) 
