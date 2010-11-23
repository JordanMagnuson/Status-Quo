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
			image.originX = image.width / 2 - 1;
			image.originY = image.height / 2 - 1;
			image.x = -image.originX - 1;
			image.y = -image.originY - 1;		
			setHitbox(image.width - 2, image.height - 2, image.originX, image.originY);				
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
		
		/**
		 * Updates the speed of this enemy so that it will rotate at the same rate as light tail
		 */
		public function speedMatchLightTail():void
		{
			speed = (LightTail.speed * Math.PI / 180) * radius;
			
			// Have to update the motion tween, which is actually governing the movement
			motionTween.setMotionSpeed(center.x, center.y, radius, getAngle(), false, speed);
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
			var angle:Number = pointDirection(center.x, center.y, x, y);
			if (angle < 0)
				angle += 360;			
			if ((LightTail.angle - angle) > 90 && (LightTail.angle - angle) < 270)
				return true;
			else
				return false;
		}		
		
	}

}