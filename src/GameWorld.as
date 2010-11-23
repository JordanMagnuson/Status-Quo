package  
{
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameWorld extends World
	{
		public static var player:Player;
		public static var china:China;
		
		public function GameWorld() 
		{
			trace('game world go!');
			add(china = new China);
			add(new SafeZone);
			add(new LightTail);
			add(player = new Player);
			add(new EnemyController);
			add(new SoundController);
		}
		
	}

}