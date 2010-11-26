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
		public var musicAlarm:Alarm = new Alarm(1, playMusic);	
		
		// Music
		[Embed(source = '../assets/Sabrepulse - Braver - trimmed.mp3')] private static const MUSIC:Class;
		public static var music:Sfx = new Sfx(MUSIC);
		
		// lazer (destroyed)
		[Embed(source = '../assets/96190__IFartInUrGeneralDirection__lazer_shot.mp3')] private static const LAZER:Class;
		public static var soundLazer:Sfx = new Sfx(LAZER);
		
		// glitch (absorbed)
		[Embed(source = '../assets/109070__Dymewiz__glitch_SFX_107.mp3')] private static const GLITCH:Class;
		public static var soundGlitch:Sfx = new Sfx(GLITCH);
		
		// enemy hit
		[Embed(source='../assets/hit.mp3')] private static const HIT:Class;
		public static var soundHit:Sfx = new Sfx(HIT);		
		
		public function SoundController() 
		{
			
		}
		
		override public function added():void
		{
			addTween(musicAlarm, true);
		}
		
		public function playMusic():void
		{
			music.loop();
		}
		
	}

}