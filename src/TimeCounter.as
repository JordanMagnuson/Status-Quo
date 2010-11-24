package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class TimeCounter extends Entity
	{
		public var timePassed:Number = 0;
		public var minutesPassed:Number = 0;
		public var secondsPassed:Number = 0;
		
		public function TimeCounter() 
		{
			
		}
		
		override public function update():void
		{
			timePassed += FP.elapsed;
			minutesPassed = Math.floor(timePassed / 60);
			secondsPassed = Math.floor(timePassed % 60);
			super.update();
		}
		
	}

}