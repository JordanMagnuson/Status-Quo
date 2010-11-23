package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine
	{
		public function Main() 
		{
			// Initiate the game with a 800x600 screen.
			super(800, 600, 60, false);
			FP.screen.color = Colors.BLACK;
			
			// Debug console
			FP.console.enable();
			//FP.console.watch('col', 'row');			
			
			FP.world = new GameWorld;
		}
	}
	
}