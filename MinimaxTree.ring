Load "Chessboard.ring"

class MinimaxTree 

							Aiboard                     
							TreeChildren  = []
							TreeChild = self       
	//---------------------------	
	func init(Chboard) 

						Aiboard =  Chboard
	//----------------------------------	
	func DistroyList(alist) 

								for item in alist
										 item= null
								next
	//----------------------------------	
	func IsImptyList(alist) 

								for item in alist
										 if isobject(item) != null
												  return   false
										ok 	
								next		
							return true	
	//------------------------------	
	func MakeMove( move) 
							
								newTree =null
								for TreeChild in TreeChildren	
										 thisMove = TreeChild.Aiboard.getLastMove()		
										// if this is the move we're making, reuse the subtree
										if thisMove = move		
												newTree = TreeChild   
										else
												 TreeChild = null
										ok	
								next
								if newTree != NULL
										Aiboard = newTree.Aiboard
										TreeChildren = newTree.TreeChildren				
										DistroyList(newTree.TreeChildren)  
										 newTree =null
						    	 else 
										Aiboard.MackeMove(move)
								 ok
							
								
	//--------------------------------------------------	
	func getBestMove( isTurnWhite ,  depth)
						? "getBestMove MakeChildren======"		
								MakeChildren(isTurnWhite)				
								 maxAdvantage = -1000000
								 BestMove = new Move
								for  TreeChild in TreeChildren
										 Advantage = TreeChild.minimax(isTurnWhite, !isTurnWhite, depth)					
										if Advantage > maxAdvantage
												maxAdvantage = Advantage
												BestMove = TreeChild.Aiboard.RandomItem(Aiboard.getLegalMove(isTurnWhite) ) //getLastMove()
										ok
								next		
									 				
								return BestMove			
	//-------------------------------------------------------	
	func minimax( isTurnWhite,  toMove,  steps) 
						
							// no more steps
							if steps <= 0
									return Aiboard.getAdvantage(isTurnWhite)
							ok
							? "minimax	MakeChildren========="
							MakeChildren(toMove)			
							 result = 0	
							?"------ opponent to move, so minimize"
							if toMove ^ isTurnWhite
									result = 1000000
									for TreeChild in TreeChildren
											 Advantage = TreeChild.minimax(isTurnWhite, !toMove, steps - 1)
											if Advantage < result  result = Advantage ok
									next		
							?"----- player to move, so maximize"
						 	else 
									result = -1000000
									for TreeChild in TreeChildren
											 Advantage = TreeChild.minimax(isTurnWhite, !toMove, steps - 1)
											if Advantage > result  result = Advantage ok
									next
							ok				
							return result
//------------------------------------
func MakeChildren(isTurnAI) 
						? "IsImptyList :"+IsImptyList(TreeChildren)+":" +len(TreeChildren)
							//---- only run if nothing has been added to list
											
					     if IsImptyList(TreeChildren) 
									for  LegalMove in  Aiboard.getLegalMove(isTurnWhite)
											Tree = new MinimaxTree(Aiboard) 
											Tree.makeMove(LegalMove)
											TreeChildren + Tree		
									next
			  	   		 ok
					? "len TreeChildren 2 :"+len(TreeChildren)
		
