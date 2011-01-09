package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class SoundController extends Entity
	{
		// How long to wait before playing music at start
		public static var startingPause:Number = 6;
		public var musicAlarm:Alarm = new Alarm(startingPause, playMusic);	
		
		// Music
		[Embed(source = '../assets/Sounds.swf', symbol = 'music')] private static const MUSIC:Class;
		//[Embed(source='../assets/Sabrepulse - Braver - trimmed02 - 90 start.mp3')] private static const MUSIC:Class;
		public static var music:Sfx = new Sfx(MUSIC);
		
		// lazer (destroyed)
		[Embed(source='../assets/Sounds.swf', symbol='lazer')] private static const LAZER:Class;
		public static var soundLazer:Sfx = new Sfx(LAZER);
		
		// glitch (absorbed)
		[Embed(source='../assets/Sounds.swf', symbol='glitch')] private static const GLITCH:Class;
		public static var soundGlitch:Sfx = new Sfx(GLITCH);
		
		// enemy hit
		[Embed(source='../assets/Sounds.swf', symbol='hit')] private static const HIT:Class;
		public static var soundHit:Sfx = new Sfx(HIT);		
		
		public function SoundController() 
		{
			
		}
		
		override public function added():void
		{
			//addTween(musicAlarm, true);
		}
		
		public function playMusic():void
		{
			music.loop();
			LightTail.moving = true;
			Player.frozen = false;
			EnemyController.releaseEnemy();
		}
		
	}

}