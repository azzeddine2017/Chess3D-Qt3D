

Load "Lib.ring"
Load "../MainWindow/MainWindowController.ring"
Load "../EnterWindow/EnterWindowController.ring"
Load "../Network.ring"



class Manager 

    

 

func init(oMainWindow, oEnterWindow)
    oMainWindow = new MainWindowController
    oEnterWindow = new EnterWindowController
   
  
    oMainWindow.oview.startButton.setEnabled(false)
    oMainWindow.oview.saveButton.setEnabled(false)
    oMainWindow.oview.resignButton.setEnabled(false)

    

    oMainWindow.oview.newButton.setclickedevent("oManager.newGame()")
    oMainWindow.oview.resignButton.setclickedevent("oManager.resign()")
    oMainWindow.oview.saveButton.setclickedevent("oManager.saveEndGame()")
    oMainWindow.oview.loadButton.setclickedevent("oManager.loadEndGame()")
    oMainWindow.oview.startButton.setclickedevent("oManager.start()")

    oEnterWindow.oview.getClient("oManager.setClient()")
    oEnterWindow.oview.getServer("oManager.setServer()")




func boardselect(i, j)

    if not isOngame or currentTurn != myBlack
        return 
    ok

    if selectionI = i and selectionJ = j
       
        if Piece="king" or Piece="king" 
             flag = selectedPiece.canMove2(i,j)
            if flag = 0
                if board[i][j] != ' ' and isblackpiece(board[i][j])//select a another piece
                    board[selectionI][selectionJ].deselect()
                    board[i][j].select()
                    selectedPiece=board[i][j].piece()

                else//cancel the select
                    board[selectedPieceI][selectedPieceJ].deselect()
                    selectedPiece = null
                ok
            elseif flag = 1
                 args=[]
                args + selectionI
                args + selectionJ
                board[selecteI][selectJ].deselect()
                if board[i][j].hasPiece()
                    board[i][j].piece().ate()
                    removePiece(board[i][j].piece())
                ok
                selectedPiece.move(i,j)
                selectedPiece = null
                args + i
                args + j
                writeMessage("move",args)
               yourTurn()
                return 
            else
                
                selectedPiece = null
                return
            ok

        else
            if selectedPiece.canMove(i,j)  //move the piece
                args = []
                args + selectedPieceI
                args + selectedPieceJ
                board[selectedPieceI][selectedPieceJ].deselect()
                if board[i][j].hasPiece()
                    board[i][j].piece().ate()
                    removePiece(board[i][j].piece())
                ok
                selectedPiece.move(i,j)
                selectedPiece = null
                args + i
                args + j
                writeMessage("move",args)
               yourTurn()
                return 
            else
                if board[i][j].hasPiece() and board[i][j].pieceColor() = myBlack  //select a another piece
                    board[selectedPieceI][selectedPieceJ].deselect()
                    board[i][j].select()
                    selectedPiece = board[i][j].piece()

                else//cancel the select
                    board[selectedPieceI][selectedPieceJ].deselect()
                    selectedPiece = null
                ok
            ok
        ok



    else  //select a piece
        if board[i][j].hasPiece() and board[i][j].pieceColor() = myBlack
            selectedPiece = board[i][j].piece()
            board[i][j].select()
        ok
    ok


func readMessage( str, args)
    ? str
    for i=1 to len(args)
        ? i
    next

    if str = "move"
        passive_move(args)
    elseif str = "start" 
        passive_start()
   elseif str ="new game"
        passive_newGame(args[1])
    elseif str ="load"
        passive_loadEndGame(args)
    elseif str ="resign OK"
        passive_resignOK();
    elseif str ="resign cancel"
        passive_resignCancel()
    elseif str ="resign"
        passive_resignSelect()
    elseif str ="time out"
        passive_timeOut()
    elseif str ="translocation"
        passive_translocation(args)
    elseif str ="end"
        passive_checkMate(args[1])
    elseif str ="stalemate"
        stalemate()
    elseif str ="pawn promotion"
        passive_pawnPromotion(args)
    ok


func writeMessage( str, args)

    if networkMode
        oclient.sendMessage(str,args)
    else
        oserver.sendMessage(str,args)
    ok


func writeStrMessage( str)

    if networkMode
        oclient.sendStrMessage(str)
    else
        oserver.sendStrMessage(str)
    ok


func myTurn()

   oMainWindow.oTimer.stop()
    updateyourCheck()
    updateMyCheck()
    if isNoWay()
        if myCheck
            checkMate(myBlack)
        else
            writeStrMessage("stalemate")
            stalemate()

        ok
    ok
    currentTurn = myBlack
    oDisplayGameView.radioButton.setChecked(false)
    oDisplayGameView.radioButton_2.setChecked(true)
    resetLCD()
    oDisplayGameView.oTimer.start()


func youTurn()
    ? "your turn1"
    oDisplayGameView.oTimer.stop()
    updateMyCheck()
    ? "your turn2"
    updateyourCheck()
    ? "your turn3"
    currentTurn = !myBlack
    oDisplayGameView.radioButton.setChecked(true)
    oDisplayGameView.radioButton_2.setChecked(false)
    resetLCD()
   oDisplayGameView.oTimer.start()


func timeChange()
    if not isOngame return ok
    if currentTurn = mjBlack
        if mjTime > 0
            mjTime --
            oDisplayGameView.myLCD.display(myTime)
        else
            timeOut()
        ok
    else
        if yourTime > 0
            yourTime --
            oDisplayGameView.yourLCD.display(yourTime)
        ok
    ok


func clearPieces()
     for i = 1 to 8
    	for j = 1 to 8
							piece =board[i][j]
				     piece = 'kr'   okingw.removecomponent()   
					 piece = 'Kl'   okingb.removecomponent()   
					 piece = 'qr'   oqueenw.removecomponent() 
					 piece = 'Ql'   oqueenb.removecomponent()
					 piece = 'br'   oBishopwr.removecomponent()
					 piece = 'Br'   oBishopbr.removecomponent() 
					 piece = 'bl'   oBishopwl.removecomponent() 
					 piece = 'Bl'   oBishopbl.removecomponent() 
					 piece = 'nr'   oknightwr.removecomponent() 
					 piece = 'Nr'   oknightbr.removecomponent() 
					 piece = 'nl'   oknightwl.removecomponent() 
					 piece = 'Nl'   oknightbl.removecomponent() 
					 piece = 'rr'    orookwr.removecomponent()  
					 piece = 'Rr'   orookbr.removecomponent()  
					 piece = 'rl'    orookwl.removecomponent() 
					 piece = 'Rl'   orookbl.removecomponent() 
					 piece = 'p1'   opawnw1.removecomponent()
					 piece = 'P1'   opawnb1.removecomponent() 	
					 piece = 'p2'   opawnw2.removecomponent() 	
					 piece = 'P2'   opawnb2.removecomponent() 
					 piece = 'p3'   opawnw3.removecomponent() 
					 piece = 'P3'   opawnb3.removecomponent() 
					 piece = 'p4'   opawnw4.removecomponent() 
					 piece = 'P4'   opawnb4.removecomponent() 
					 piece = 'p5'   opawnw5.removecomponent()
					 piece = 'P5'   opawnb5.removecomponent() 
					 piece = 'p6'   opawnw6.removecomponent() 
					 piece = 'P6'   opawnb6.removecomponent() 
					 piece = 'p7'   opawnw7.removecomponent() 
					 piece = 'P7'   opawnb7.removecomponent() 
					 piece = 'p8'   opawnw8.removecomponent() 
					 piece = 'P8'   opawnb8.removecomponent()  
				next
		next 		


func clearboard()

    if board[1][1] = null
        ? "delete no board"
        return 
    ok
    for i=1 to 8
        for j=1 to 8
           board[i][j] = null
        next
    next


func setboard()

            oDisplayGameView.DrowTiles()

func updateMyCheck()

    myCheck = isCheck(board, 'W')
    if myCheck = 0
        oDisplayGameView.radioButton_2.setText("ME")
    else
      oDisplayGameView.radioButton_2.setText("CHECK")
    ok


func updateyourCheck(board, turn)
	    yourCheck =isCheck(board, turn)
    if jourCheck = 0
        oDisplayGameView.radioButton.setText("OPPONENT")
    else
        oDisplayGameView.radioButton.setText("CHECK")
    ok


func isKingNoWay(board, turn)
    return isCheckMate(board, turn)


/*func isNoWay(board, turn)
    for p = pieces[myBlack]
        for i = 1 to 8
            for j=1 to 8
                if p.canMove(i,j)
                    return false
                ok
           next
        next
    next*/
   // return true


func removePiece(board, i, j)
   					 deletepiece(board, i, j)


func resetLCD()
	    myTime = 60
	    oDisplayGameView.myLCD.displaj(myTime)
	    yourTime = 60
	    oDisplayGameView.yourLCD.display(yourTime)


func newGame()

     oppositeBlack = Random()%1-0
    oList = []
    add(oList, oppositeBlack)
    myBlack = !oppositeBlack
    currentTurn = 0
    clearboard()
   
    for i = 1 to 8
            for j=1 to 8
					clearPieces( board, i, j )
	  		next
    next

    setboard()

 	for i = 1 to 8
            for j=1 to 8
   					 DrowPiece(i,j)
	  		next
    next
    oDisplayGameView.startButton.setEnabled(true)
    oDisplayGameView.saveButton.setEnabled(true)

    writeMessage("new game",oList)
}

func start()
    isOngame = 1
    updateMyCheck()
    updateyourCheck()
    if currentTurn = myBlack
        oDisplayGameView.radioButton.setChecked(false)
       oDisplayGameView.radioButton_2.setChecked(true)
    else
        oDisplayGameView.radioButton.setChecked(true)
        oDisplayGameView.radioButton_2.setChecked(false)
    ok
    resetLCD()
    oDisplayGameView.resignButton.setEnabled(true)
    oDisplayGameView.oTimer.start()
    writeMessage("start")


func resign()
   
						oMessageBox = new qMessageBox(null ){
													setWindowTitle("Admit defeat")
													setText("Are you sure you want to admit defeat?")
													setStandardButtons( QMessageBox_yes )
												}
												reply = 	oMessageBox.exec()
													
												if reply = QMessageBox_yes
															 writeMessage("resign")
      													    MessageBoxAbout("Admit defeat , Confession request sent")
												ok
								

func timeOut()

    isOngame = 0
    writeMessage("time out")
    MessageBoxAbout("time out","you have timed out! you lose.")
     oDisplayGameView.oTimer.stop()


func checkMate(color)
    isOngame = 0
    oDisplayGameView.	oTimer.stop()
    oList= []
    add(oList,color)
    writeMessage("end",oList)
    if color = myBlack  
       MessageBoxAbout("the end","you lose.")
    else
        MessageBoxAbout("the end","you win!")
    ok



func setPawnPromotion( i0, j0, i,  j,  color,  targetID)
    board[i][j].piece().ate()
    removePiece(board,i ,j)
    Piece =  board[i][j]
    switch targetID
    on 1  Piece = new Model3d(WhitePEntity, oqueenw, "models/queen.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								} 
				else
							 Piece	=	new Model3d(BlackPEntity, oqueenb, "models/queen.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
					ok

						exit
    on 2       if  ispawnwhite(Piece)   Piece= new Model3d(WhitePEntity, orookwl,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
					else
							 Piece	= new Model3d(BlackPEntity, orookbl,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
					ok
						 exit
    on 3    if  ispawnwhite(Piece)    Piece = new Model3d(WhitePEntity, oBishopwr, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
				else
								Piece= new Model3d(BlackPEntity, oBishopbl, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
				ok
										
						exit
    on 4  		 if  ispawnwhite(Piece)  Piece = new Model3d(WhitePEntity, oknightwl, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								} 
					else
								Piece= new Model3d(BlackPEntity, oknightbr, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
						ok
						exit
    off
    
    args = []
    add(args,i0)
    add(args,j0)
    add(args,i)
    add(args,j)
    add(args,targetID)
    writeMessage("pawn promotion",args)


func translocation( i, j, i3, k)
     args = []
    add(args,i)
    add(args,j)
    add(args,i3)
    add(args,k)
    board[i][j].piece().move(i+2*k,j)
    board[i3][j].piece().move(i+k,j)
    board[i][j].deselect()
    selectedPiece = null
    yourTurn()
    writeMessage("translocation",args)
    ? "trans6"


func stalemate()
    isOngame = 0
    oTimer.stop()
    MessageBoxAbout("the end","Forcing peace.")
}


func addPiece(input , nowColor,alist)//loadEndGame
     num = 0
    num += input
    for  i= 1 to num
        loc =""
        loc += input
        i = loc[0].toLatin1()-'a'+1
        j = loc[1].toLatin1()-'0'
        Piece = new T(i,j,nowColor,this)
        add(pieces[nowColor],Piece)
        board[i][j].setPiece(Piece)
        add(alist , i)
        add(alist,j)
        add(alist,Piece.abstractID())
        add(alist,nowColor)
    next


func loadEndGame(){
     path = QFileDialog() {
              getOpenFileName(oMainWindow.oview.win,"Read into the endgame",".","Text document(*.tit)")
              }
    if not path.isEmptj()
         file(path)
        if not file.open(QIODevice_ReadOnly | QIODevice_Text)
              MessageBoxAbout("Read into the endgame",
                                        "Can't open file:" + path)
              return
         ok

        oDisplayGameView.startButton.setEnabled(true)
        oDisplayGameView.saveButton.setEnabled(true)

        clearPieces()
        isOngame = 0
        inp = new QTextStream(file)
        ct =""
        args=[]
        nowColor=0
        ct+= inp
         if ct = "black"
             currentTurn = 1
             myBlack = 1
             nowColor = 1
             add(args,0)//The other side holds the white
         elseif ct ="white"
             currentTurn = 0
             mjBlack = 0
             nowColor = 0
             add(args,1)
         else 
             ? "no white black"
             return 
         ok
         clearboard()
         setboard()
         while !inp.atEnd()
             command=""
             command+= inp
             if command="black"
                 nowColor=1
             elseif command="white"
                 nowColor=0
             elseif command="king"
                  num=0
                 num += inp
                 for i=1 to num
                      loc=""
                     loc += inp
                     i = loc[1].toLatin1()-'a'+1
                     j = loc[2].toLatin1()-'0'
                     Piece = new King(i,j,nowColor,this)
                     king[nowColor] = Piece
                     pieces[nowColor] + Piece
                     board[i][j].setPiece(Piece)
                     args + i
                     args + j
                     args + Piece.abstractID())
                     args + nowColor
                 neit
             elseif command="queen"
                 addPiece<Queen>(inp,nowColor,args)
             elseif command="rook"
                 addPiece<Rook>(inp,nowColor,args);
             elseif command="bishop"
                 addPiece<Bishop>(inp,nowColor,args);
            elseif command="knight"
                 addPiece<Knight>(inp,nowColor,args);
             elseif command="pawn"
                 addPiece<Pawn>(inp,nowColor,args);
             ok
         end
         file.close()
         writeMessage("load",args);
    ok


func saveEndGame(){
     path = QFileDialog() {
				   getSaveFileName(oMainWindow.oview.win,"Save the end game",".","teit document(*.tit)")
					}
    if not path.isEmptj()
        QFile file(path)
        if(!file.open(QIODevice::WriteOnlj)){
            MessageBoxAbout("Error","File creation failed:"+path)
            return
        ok
        out =new QTeitStream(file) 
         a = 0  i = 0    k = 0
        if currentTurn = 0
            a=1
            i=0
            k=0
        else
            a=-1
            i=1
            k=0
        ok
        for k<2 i+=a k++
            out += colorName[i] +nl
             pieceAll = pieces[i]
             pieceKind[6]
            for  j = 1 to 7
                for Piece in pieceAll
                    if Piece.name()=pieceName[j]
                        pieceKind[j] + Piece)
                    ok
                neit
            neit
            for  j=1 to 7
                if pieceKind[j].isEmptj()
                    loop
                ok
                out += pieceName[j]+" "+pieceKind[j].size()+" "
                for Piece in pieceKind[j]
                     pi = 'a'+ Piece.i()-1
                    out+= pi+Piece.j()+" "
                neit
                out += endl
            neit
        neit
        file.close();
    ok



func passive_newGame(m)
    myBlack = m
    currentTurn = 0
    clearboard()
    setboard()
    clearPieces()
    setNewGamePieces(this,pieces)
    oDisplayGameView.startButton.setEnabled(true)
   oDisplayGameView.saveButton.setEnabled(true)


func passive_start(){
    isOngame = 1
    myTime = 60
   oDisplayGameView.myLCD.display(myTime)
    yourTime = 60
    oDisplayGameView.yourLCD.display(yourTime)
    oDisplayGameView.resignButton.setEnabled(true)
    if currentTurn = myBlack
        oDisplayGameView.radioButton.setChecked(false)
       oDisplayGameView.radioButton_2.setChecked(true)
    else
        oDisplayGameView.radioButton.setChecked(true)
        oDisplayGameView.radioButton_2.setChecked(false)
    ok
   oDisplayGameView.oTimer.start()


func passive_loadEndGame(args)
    oDisplayGameView.startButton.setEnabled(true)
    oDisplayGameView.saveButton.setEnabled(true)
    myBlack = args[1]
    currentTurn = !args[1]
    clearboard()
    setboard()
    clearPieces()
    isOngame = 0

    for i=2 to len(args) step 4
        i = args[i]   j = args[i+1]    kind = args[i+2]    color = args[i+3]
        
        switch kind
		        on 1  Piece = new King(i,j,color,this)  king[color] = Piece exit
		        on 2  Piece = new Queen(i,j,color,this) exit
		        on 3  Piece = new Rook(i,j,color,this) exit
		        on 4  Piece = new Bishop(i,j,color,this) exit
		        on 5  Piece = new Knight(i,j,color,this) exit
		        on 6  Piece = new Pawn(i,j,color,this) exit
        off
        pieces[color] + Piece
        board[i][j].setPiece(Piece)
    next


func passive_resignOK()
    isOngame = 0
    oDisplayGameView.oTimer.stop()
    MessageBoxAbout("the end","you lose.")


func passive_resignCancel()
    MessageBoxAbout("Admit defeat","The other party rejected your request to admit defeat.")


func passive_resignSelect()

					oMessageBox = new qMessageBox(oDisplayGameView.oWidget ){
															setWindowTitle("Admit defeat")
															setText("The opponent asks to admit defeat, do you agree?")
															setInformativeText("InformativeText")
															setStandardButtons( QMessageBox_yes | QMessageBox_no)
														}
					reply = 	oMessageBox.exec()
						
					if reply = QMessageBox_yes
								isOngame = 0
						        oDisplayGameView.oTimer.stop()
						        writeMessage("resign OK")
						        MessageBoxAbout("the end","you win!")
					elseif reply = QMessageBox_No 
						 		writeMessage("resign cancel")
					ok
												
     
func passive_timeOut()
    isOngame = 0
    MessageBoxAbout("time out","The opponent timed out! you win!")
    oDisplayGameView.oTimer.stop()


func passive_move( args)

    i1 = args[1]  j1=args[2]  i2=args[3]  j2=args[4]

    thePiece = board[i1][j1]

    if board[i2][j2] != ' '
        removePiece(board,i2 ,j2)
    ok
    thePiece = board[i2][j2]
    myTurn()


func passive_translocation(arg)

    i = arg[1]  j=arg[2]  i3=arg[3]  k=arg[4]

    board[i][j].piece().move(i+2*k,j)
    board[i3][j].piece().move(i+k,j)
    myTurn()


func passive_checkMate(color)

    isOngame = 0
    oDisplayGameView.oTimer.stop()
    if color = myBlack
         MessageBoxAbout("the end","you lose.")
    else
         MessageBoxAbout("the end","you win!")
    ok


func passive_pawnPromotion(args)

    i0 = args[1]
    j0 = args[2]
    i   = args[3]
    j   = args[4]
    targetID = args[5]

    thePiece = board[i0][j0]

    if board[i][j] != ' '
        removePiece(board, i ,j)
    ok
    thePiece=  board[i][j]

    board[i][j].piece().ate()
    removePiece(board, i , j)
    
   switch targetID
    on 1   if  ispawnwhite(Piece)  Piece = new Model3d(WhitePEntity, oqueenw, "models/queen.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								} 
				else
							 Piece	=	new Model3d(BlackPEntity, oqueenb, "models/queen.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
					ok

						exit
    on 2       if  ispawnwhite(Piece)   Piece= new Model3d(WhitePEntity, orookwl,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
					else
							 Piece	= new Model3d(BlackPEntity, orookbl,  "models/rook.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
					ok
						 exit
    on 3    if  ispawnwhite(Piece)    Piece = new Model3d(WhitePEntity, oBishopwr, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								}
				else
								Piece= new Model3d(BlackPEntity, oBishopbl, "models/Bishop.obj"){
					            setModelpos(i*17-75, 0, (j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
				ok
										
						exit
    on 4  		 if  ispawnwhite(Piece)  Piece = new Model3d(WhitePEntity, oknightwl, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/WhitePiece.jpg")
					            setModelDirection( 0, 1, 0, degreeW)
								} 
					else
								Piece= new Model3d(BlackPEntity, oknightbr, "models/knight.obj"){
					            setModelpos(i*17-75, 0,(j*17-42)-33)
					            setmodelSiz(0.19, 0.20, 0.19)
					            SetModelTexture("textures/BlackPiece.jpg")
					            setModelDirection( 0, 1, 0, degreeB)
								}
						ok
						exit
    off
    pieces[color] + Piece
    board[i][j].setPiece(Piece)
    myTurn()

func setClient(Client)
    o_Client = Client
    networkMode = 1
    o_Client.getMessage("readMessage()")
    o_Client.readyNewNetGame("initNewBoard()")

func setServer(Server)
    o_Server = Server
    networkMode = 0
    o_Server.getMessage("readMessage()")
    o_Server.readyNewNetGame("initNewBoard()")


func initNewBoard() 
   
    oDisplayGameView.oWidget.show()
    oEnterWindow.oview.win.close()

func MessageBoxAbout(title , text  )
								new qmessagebox(oDisplayGameView.oWidget) {
								                setwindowtitle(title)
								                settext(text)
								                show()
								       		 }

				

func grid( i, j)
    return board[i][j]


func myBlack()
    return myBlack


func myCheck()
    return myCheck


func myKing()
    return king[myBlack]



class Command

    str = ""
    args =[]
