package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class SafeZone extends Entity
	{
		public static var innerRadius:Number = 117;
		public static var outerRadius:Number = 227;
		
		public function SafeZone(x:Number = 0, y:Number = 0) 
		{
			super(x, y);
			type = 'safe_zone';
			layer = 1;			
			
			// Initial position
			this.x = FP.screen.width / 2;
			this.y = FP.screen.height / 2;			
		}
		
		override public function render():void
		{
			Draw.circlePlus(x, y, innerRadius, Colors.WHITE, 1, false, 1);
			Draw.circlePlus(x, y, outerRadius, Colors.WHITE, 1, false, 1);
		}
		
	}

}