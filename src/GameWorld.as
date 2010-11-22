package  
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameWorld extends World
	{
		
		public function GameWorld() 
		{
			trace('game world go!');
			add(new China);
			add(new SafeZone);
			add(new LightTail);
			add(new Player);
		}
		
	}

}