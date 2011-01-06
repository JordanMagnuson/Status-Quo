package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import flash.ui.Mouse;
	
	public class Main extends Engine
	{
		public function Main() 
		{
			// Initiate the game with a 800x600 screen.
			super(640, 580, 60, false);
			FP.screen.color = Colors.BLACK;
			
			// Debug console
			//FP.console.enable();
			//FP.screen.smoothing = false;
			//FP.console.watch('col', 'row');			
			
			FP.world = new GameOverWorld;
			Mouse.hide();
		}
	}
}