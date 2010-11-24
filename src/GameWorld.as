package  
{
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameWorld extends World
	{	
		public static var gameOver:Boolean = false;
		public static var player:Player;
		public static var china:China;
		
		// keeps track of how long the player is alive
		public static var timer:TimeCounter;
		
		public function GameWorld() 
		{
			gameOver = false;
			add(china = new China);
			add(new SafeZone);
			add(new LightTail);
			add(player = new Player);
			add(new EnemyController);
			add(new SoundController);
			add(timer = new TimeCounter);
		}
		
		override public function update():void
		{
			//trace(timer.minutesPassed + ':' + timer.secondsPassed);
			if (gameOver)
				FP.world = new GameOverWorld;
			super.update();
		}		
		
	}

}