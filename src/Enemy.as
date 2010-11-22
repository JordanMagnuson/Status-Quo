package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Enemy extends Orbiter
	{
		public var image:Image;
		
		// The last angle this enemy was at, relative to its rotation center;
		// used for calculating number of rotations.
		public var lastAngle:Number;
		
		// Number of rotations this enemy has made since inception.
		public var rotations:Number = 0;
		
		public function Enemy(x:Number, y:Number, speed:Number) 
		{
			super(x, y, speed);
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
		
		override public function update():void
		{
			updateRotations();
			if (rotations > 0)
				fadeOut();
			
			super.update();
		}
		
		public function updateRotations():void
		{
			var currentAngle:Number = pointDirection(center.x, center.y, x, y);
			if (currentAngle < 0)
				currentAngle += 360;
			if (currentAngle < lastAngle && currentAngle > EnemyController.releaseAngle)
			{
				rotations++;
			}
			lastAngle = currentAngle;			
		}
		
		public function fadeOut():void
		{
			FP.world.remove(this);
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