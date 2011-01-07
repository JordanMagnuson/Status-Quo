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
		public var fadeStarted:Boolean = false;
		public static var player:Player;
		public static var china:China;
		public static var enemyController:EnemyController;
		public static var timingController:TimingController;
		public static var safeZone:SafeZone;
		
		// keeps track of how long the player is alive
		public static var timer:TimeCounter;
		
		public function GameWorld() 
		{
			gameOver = false;
			add(china = new China);
			China.radius = China.RADIUS_ORIG;
			add(safeZone = new SafeZone);
			add(new LightTail);
			LightTail.moving = false;
			LightTail.speed = LightTail.MIN_SPEED;
			LightTail.angle = 90;
			add(player = new Player);
			Player.frozen = true;
			Player.canMove = true;
			add(enemyController = new EnemyController);
			add(new SoundController);
			add(timer = new TimeCounter);
			add(timingController = new TimingController);
		}
		
		override public function update():void
		{
			//trace(timer.minutesPassed + ':' + timer.secondsPassed);
			if (gameOver && !fadeStarted)
			{
				fadeStarted = true;
				add(new FadeOut(GameOverWorld));
			}
			super.update();
		}		
		
	}

}