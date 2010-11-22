package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class LightTail extends Entity
	{
		public static var speed:Number = 10;
		public static var angle:Number = 0;
		
		// Player graphic
		[Embed(source='../assets/light_tail.png')] private const S_LIGHT_TAIL:Class;
		public var image:Image = new Image(S_LIGHT_TAIL);			
		
		public function LightTail() 
		{
			type = 'light_tail';
			graphic = image;
			image.smooth = true;
			layer = 10;
			
			// Initial position
			this.x = FP.screen.width / 2;
			this.y = FP.screen.height / 2;			
			
			// Initialize image, hitbox
			image.originX = image.width / 2;
			image.originY = image.height / 2;
			image.x = -image.originX;
			image.y = -image.originY;		
			setHitbox(image.width, image.height, image.originX, image.originY);	
		}
		
		override public function update():void
		{
			angle = angle % 360;
			if (Math.floor(angle) % 360 == 0)
			{
				trace('yep');
				speed += 10
			}
			//trace(angle);
			angle += FP.elapsed * speed;
			image.angle = angle;
		}
		
	}

}