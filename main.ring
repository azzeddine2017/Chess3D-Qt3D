# The Main File

load "lib.ring"

func main

	if IsMainSourceFile() 
			oApp = new QApp {
				StyleFusion()
				openWindow(:DisplayGameController)
				exec()
				}
	ok
