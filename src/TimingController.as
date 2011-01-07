package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class TimingController extends Entity
	{
		public const START_THE_ACTION_TIME:Number = 6;
		public const PAUSE_CHINA_BREATHING_TIME:Number = 99 + START_THE_ACTION_TIME; //99
		public const START_ALL_BREATHING_TIME:Number = 107 + START_THE_ACTION_TIME;  //107
		
		public const START_THE_ACTION_ALARM:Alarm = new Alarm(START_THE_ACTION_TIME, startTheAction);
		public const PAUSE_CHINA_BREATHING_ALARM:Alarm = new Alarm(PAUSE_CHINA_BREATHING_TIME, pauseChinaBreathing);
		public const START_ALL_BREATHING_ALARM:Alarm = new Alarm(START_ALL_BREATHING_TIME, startAllBreathing)
		
		public function TimingController() 
		{
			
		}
		
		override public function added():void
		{
			addTween(START_THE_ACTION_ALARM, true);
			addTween(PAUSE_CHINA_BREATHING_ALARM, true);
			addTween(START_ALL_BREATHING_ALARM, true);
		}
		
		public function startTheAction():void
		{
			trace('start the action');
			SoundController.music.loop();
			LightTail.moving = true;
			Player.frozen = false;
			EnemyController.releaseEnemy();			
		}
		
		public function pauseChinaBreathing():void
		{
			trace('pause china breathing');
			China.breathing = false;
			LightTail.moving = false;
		}
		
		public function startAllBreathing():void
		{
			trace('start all breathing');
			China.breathing = true;
			GameWorld.safeZone.startBreathing();
			LightTail.moving = true;
			//SafeZone.startBreathing();
		}
		
	}

}