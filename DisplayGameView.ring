#------------------------------------------------
# Chess3d Qt3D      
#    15-08-2021
# Author : Azzeddine Remmal    
#-------------------------------------------------

Load "stdlibcore.ring"
Load "guilib.ring"

import System.GUI

if IsMainSourceFile() { 
	new Qapp {
			StyleFusion()
			new DisplayGameView { win.show() } 
			exec()
			}
ok

class DisplayGameView from WindowsViewParent




	    win  =  new QMainwindow() { 
				 setwindowtitle("Using Qt3D - Chees_3D")
				  setstylesheet("color:#28ff02;background: #194a38;")
	  			 resize(1100,600)
				 showmaximized()		

		owidget3d =new Qwidget()  
		oMenuWidget =new Qwidget()   	
	    oView3d    = new Qt3dwindow()
	    oView3d.defaultFrameGraph().setClearColor(black)
	    oContainer  = owidget3d.createwindowContainer(oView3d,owidget3d,0)
	    oRootEntity = new QEntity(oContainer)
	    oInput      = new QInputAspect(oRootEntity)
	    oView3d.registerAspect(oInput)
	    oCameraEntity = oView3d.Camera()
	    oText3d = new Text3D(oRootEntity)
	    PieceEntity= new QEntity(oRootEntity)
	    WhitePEntity= new QEntity(PieceEntity)
	    BlackPEntity= new QEntity(PieceEntity)
		WhiteProPawnEntity= new QEntity(PieceEntity)
	    BlackProPawnEntity= new QEntity(PieceEntity)
	
	   oFrameAction = new QFrameAction(oRootEntity) {
	           settriggeredevent(method(:FrameAction))
	         }
	  oFilter = new Qallevents(oView3d){
			 setKeyPressEvent(method(:pKeyPress))
	         setmousemoveevent(method(:pRightClick))
	         setMouseButtonPressEvent(method(:mouseIn))
	         setMouseButtonReleaseEvent(method(:MouseRelease))
	        }
	    oView3d.installeventfilter(oFilter)
//---------------	
		yourLCD = new Qlcdnumber(win) {
			move(0,15)
			resize(44,16)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,30,-1,5,87,0,0,0,0,0,Black")
			setfont(oFont)
			oFont.delete()
			Display(0)	
		   }
		RadioButton = new Qradiobutton(win) {
			move(0,55)
			resize(101,35)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,16,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("OPPONENT")
		   }
		startButton = new Qpushbutton(win) {
			move(0,111)
			resize(80,21)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("Start to fight")
			setClickEvent(method(:StartGame))
			setBtnImage(startButton,"")	
		    }
		newButton = new Qpushbutton(win) {
			move(0,149)
			resize(80,20)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("new game")
			setClickEvent(method(:newGame))
			setBtnImage(newButton,"")
		   }
		loadButton = new Qpushbutton(win) {
			move(0,323)
			resize(162,27)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("Loading the endgame")
			setClickEvent(method(:loadEndGame))
			setBtnImage(loadButton,"")	
		   }
		saveButton = new Qpushbutton(win) {
			move(0,278)
			resize(142,22)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("Save the endgame")
			setClickEvent(method(:saveEndGame))
			setBtnImage(saveButton,"")
			}	
		resignButton = new Qpushbutton(win) {
			move(0,232)
			resize(80,22)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("Surrender")
			setClickEvent(method(:resign))
			setBtnImage(resignButton,"")	
	  	    }
		cleerButton = new Qpushbutton(win) {
			move(0,183)
			resize(80,22)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("Cleer")
			setClickEvent(method(:cleer))
			setBtnImage(sueButton,"")		
	  	   }
		myLCD = new Qlcdnumber(win) {
			move(0,371)
			resize(42,29)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,30,-1,5,87,0,0,0,0,0,Black")
			setfont(oFont)
			oFont.delete()
			Display(0)	
			}
		RadioButton_2 = new Qradiobutton(win) {
			move(0,416)
			resize(80,33)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,16,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("ME")
			}
		VS_HUMAN_Button = new Qpushbutton(oMenuWidget) {
			move(0,371)
			resize(42,29)
			setstylesheet("color:#28ff02;background: #194a38;")
			setClickEvent(method(:PLAY_VS_HUMAN))
			oImage = new Qpixmap(currentdir()+"/textures/PLAY_VS_HUMAN.png") 
			nImageWidth	 = oImage.Width()		 
			nImageHeight = oImage.Height()		
			oImage = oImage.scaled(nImageWidth , nImageHeight ,0,0) 
			setIcon(new QIcon(oImage)) 
			setIconSize(new QSize(nImageWidth , nImageHeight ))	
			}
		ON_LINE_Button = new Qpushbutton(oMenuWidget) {
			move(0,371)
			resize(42,29)
			setstylesheet("color:#28ff02;background: #194a38;")
			setClickEvent(method(:PLAY_ON_LINE))
			oImage = new Qpixmap(currentdir()+"/textures/PLAY_ON_LINE.png")	 
			nImageWidth	 = oImage.Width()		
			nImageHeight = oImage.Height()	
			oImage = oImage.scaled(nImageWidth , nImageHeight ,0,0) 
			setIcon(new QIcon(oImage)) 
			setIconSize(new QSize(nImageWidth , nImageHeight ))		
			}
		VS_AI_Button = new Qpushbutton(oMenuWidget) {
			move(0,371)
			resize(42,29)
			setstylesheet("color:#28ff02;background: #194a38;")
			setClickEvent(method(:PLAY_VS_AI))
			oImage = new Qpixmap(currentdir()+"/textures/PLAY_VS_AI.png")	 
			nImageWidth	 = oImage.Width()		 
			nImageHeight = oImage.Height()	
			oImage = oImage.scaled(nImageWidth , nImageHeight ,0,0) 
			setIcon(new QIcon(oImage)) 
			setIconSize(new QSize(nImageWidth , nImageHeight ))		
			}	
		
		PlayHistoryButton = new Qpushbutton(win) {
			move(0,183)
			resize(80,22)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("PlayHistory")
			setClickEvent(method(:PlayHistory))
			setBtnImage(sueButton,"")	
		}
		ScreenShotButton = new Qpushbutton(win) {
			move(0,278)
			resize(142,22)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("ScreenShot")
			setClickEvent(method(:SaveScreen))
			setBtnImage(saveButton,"")	
		     }
		clientButton = new Qpushbutton(win) {
			move(0,278)
			resize(142,22)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("Start Client")
			setClickEvent(method(:setclient))
			setBtnImage(saveButton,"")
			}
		serverButton = new Qpushbutton(win){
			move(0,278)
			resize(142,22)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("Start Server")
			setClickEvent(method(:setServer))
			setBtnImage(saveButton,"")
			}		
		Slider1 = new Qslider(win) {
			move(46,143)
			resize(90,31)
			setstylesheet("color:#28ff02;background: #194a38;")
			setvalue(20)
			setOrientation(1)
			setMinimum(0)
			setMaximum(100)	
		    }
		GameMusicButton = new Qpushbutton(win){
			move(0,278)
			resize(142,22)
			setstylesheet("color:#28ff02;background: #194a38;")
			oFont = new Qfont("",0,0,0)
			oFont.fromstring("Arial,14,-1,5,50,1,0,0,0,0,Italic")
			setfont(oFont)
			oFont.delete()
			setText("GameMusic")
			setClickEvent(method(:ActiveMusic))
			setBtnImage(saveButton,"")
			}
		
		Toolbar1 = win.addToolBar(""){
			AddWidget(yourLCD)
			AddWidget(RadioButton)			
			AddWidget(startButton)
			AddWidget(newButton)			
			AddWidget(loadButton)
			AddWidget(saveButton)
			AddWidget(resignButton)
			AddWidget(cleerButton)	
			AddWidget(myLCD)
			AddWidget(RadioButton_2)
		    }
		Toolbar2 = win.addToolBar(""){
			AddWidget(ScreenShotButton)
			AddWidget(PlayHistoryButton)		
			AddWidget(serverButton)
			AddWidget(clientButton)		
			AddWidget(GameMusicButton)
			AddWidget(Slider1)
			}
		
  	   omediaplayer =new Qmediaplayer()
	   omediaplayer1 =new Qmediaplayer()
	   oTimer= new Qtimer(win) {
			   setInterval(1000)
         	    settimeoutevent(method(:timeChange))
			     }
	   oHistoryTimer= new Qtimer(win) {
			   setInterval(3000)
         	    settimeoutevent(method(:HistryTimer))			
			     }
		
		Layout4 = new QVBoxLayout() {
		addwidget(oContainer)	
		}
		Layout3 = new QVBoxLayout(){
		         AddWidget(owidget3d)
		         }
		Layout2 = new QVBoxLayout(){
		         AddWidget(VS_HUMAN_Button)	
				 AddWidget(ON_LINE_Button)
				 AddWidget(VS_AI_Button)	
		         }
		
		Layout5 = new QHBoxLayout() { 
			     AddLayout(Layout2)	 
		        }
		Layout1 = new QHBoxLayout() { 
			     AddLayout(Layout3)
			     AddWidget(oMenuWidget)			
		        }
		oMenuWidget{ 
                setlayout(Layout5)	
			      }
		owidget3d{ 
                setlayout(Layout4)		
			      }
		//oWidget
	}
		oMWLayoutWidget = new QWidget() { setLayout(Layout1) }
		win.setCentralWidget(oMWLayoutWidget) 
//------------------

