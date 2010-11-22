package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class China extends Entity
	{
		public static var radius:Number = 43;
		
		// Graphic
		public var image:Image = Image.createCircle(radius, Colors.WHITE);
		
		public function China(x:Number = 0, y:Number = 0) 
		{
			super(x, y);
			type = 'china';
			graphic = image;
			layer = 1;
			
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
		
	}

}