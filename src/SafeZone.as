package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class SafeZone extends Entity
	{
		public static const INNER_RADIUS_ORIG:Number = 117;
		public static const OUTER_RADIUS_ORIG:Number = 227;
		public static var innerRadius:Number = 117;
		public static var outerRadius:Number = 227;
		
		public static var breatheAlarm:Alarm;
		public static var breathe:NumTween;
		public static var breathing:Boolean = false;	
		
		// Delay which offsets breathing from China's breathing
		public static var breatheDelay:Alarm;
		
		public function SafeZone(x:Number = 0, y:Number = 0) 
		{
			super(x, y);
			type = 'safe_zone';
			layer = 1;			
			
			// Initial position
			this.x = FP.screen.width / 2;
			this.y = FP.screen.height / 2;	
			
			//addTween(breatheDelay = new Alarm(3 + SoundController.startingPause, breatheIn));
			//startBreathing();
		}
		
		override public function update():void
		{
			if (breathing)
			{
				innerRadius = INNER_RADIUS_ORIG * (breathe.value);
				outerRadius = OUTER_RADIUS_ORIG * (breathe.value);
			}
		}
		
		public function startBreathing():void
		{
			var timeLeft:Number;
			if (China.breathingIn)
			{
				trace('china breathing in');
				timeLeft = 3 + (1 - China.breathe.percent) * 3;
			}
			else
			{
				trace('china breathing out');
				timeLeft = (1 - China.breathe.percent) * 3;
			}
			
			addTween(breatheDelay = new Alarm(timeLeft + 0.5, breatheIn), true);
			
			// Start breathing to stay in sync with China's breathing.
			// Start by breathing in
			//if (China.breathingIn && China.breathe.percent < .84)
			//{
				//trace('china breathing in');
				//breathe = new NumTween(breatheOut);
				//addTween(breathe);
				//breathe.tween(1, 1.2, (1 - China.breathe.percent) * 3);
			//}
			// Start by breathing out
			//else
			//{
				//trace('china breathing out');
				//breathe = new NumTween(breatheIn);
				//addTween(breathe);
				//breathe.tween(1, 1, (1 - China.breathe.percent) * 3);				
			//}
			//breathing = true;
		}
		
		public function breatheIn():void
		{
			breathe = new NumTween(breatheOut);
			addTween(breathe);
			breathe.tween(1, 1.2, 3);	
			breathing = true;
		}
		
		public function breatheOut():void
		{
			breathe = new NumTween(breatheIn);
			addTween(breathe);
			breathe.tween(1.2, 1, 3);	
			breathing = true;
		}		
		
		override public function render():void
		{
			Draw.circlePlus(x, y, innerRadius, Colors.WHITE, 1, false, 1);
			Draw.circlePlus(x, y, outerRadius, Colors.WHITE, 1, false, 1);
		}
		
	}

}