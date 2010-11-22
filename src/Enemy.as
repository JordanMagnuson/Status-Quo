package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Enemy extends Orbiter
	{
		public var image:Image;
		
		public function Enemy(x:Number = 0, y:Number = 0) 
		{
			super(x, y);
			type = 'enemy';
			layer = -100;		
			
			// Create graphic
			if (inDarkness())
				image = Image.createRect(8, 8, Colors.WHITE);
			else
				image = Image.createRect(8, 8, Colors.BLACK);
			graphic = image;
			
			// Initialize image, hitbox
			image.originX = image.width / 2;
			image.originY = image.height / 2;
			image.x = -image.originX;
			image.y = -image.originY;		
			setHitbox(image.width, image.height, image.originX, image.originY);				
		}
		
		/**
		 * Checks whether the entity is in darkness, based on position of LightTail.
		 * @return
		 */
		public function inDarkness():Boolean
		{
			if (LightTail.angle < 180)
				return true;
			else
				return false;
		}		
		
	}

}