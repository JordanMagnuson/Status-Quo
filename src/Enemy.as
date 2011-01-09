package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Enemy extends Orbiter
	{
		public static const FADE_IN_DURATION:Number = 2;
		public static const FADE_OUT_DURATION:Number = 2;	
		public static const DARK_COLOR:uint = Colors.BLACK;
		public static const LIGHT_COLOR:uint = Colors.WHITE;
		
		public var fadeTween:ColorTween;
		
		public var image:Image = Image.createRect(8, 8, Colors.WHITE);
		
		// The last angle this enemy was at, relative to its rotation center;
		// used for calculating number of rotations.
		public var lastAngle:Number;
		
		// Number of rotations this enemy has made since inception.
		public var rotations:Number = 0;
		
		public function Enemy(x:Number = 0, y:Number = 0, speed:Number = 0) 
		{
			super(x, y, speed);
			reset(x, y, speed);		
		}
		
		override public function added():void
		{
			super.added();
			fadeIn();
		}		
		
		public function reset(x:Number, y:Number, speed:Number):void
		{
			type = 'enemy';
			this.x = x;
			this.y = y;
			this.speed = speed;
			layer = -100;
			
			// Create graphic
			if (inDarkness())
				image.color = LIGHT_COLOR;
			else
				image.color = DARK_COLOR;
			image.alpha = 0;
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
			super.update();
			(graphic as Image).alpha = fadeTween.alpha;
			updateRotations();
			if (lastAngle > 300)
				fadeOut();
				
			// Check to see if we need to update the color	
			if (!LightTail.moving)	
			{
				if (inDarkness())
				{
					if (image.color != LIGHT_COLOR)
					{
						image.color = LIGHT_COLOR;
					}
				}
				else if (image.color != DARK_COLOR)
				{
					image.color = DARK_COLOR;
				}		
			}
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
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, 1);
		}
		
		public function fadeOut():void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, image.alpha, 0);				
		}
		
		public function destroy():void
		{
			//clearTweens();
			//removeTween(fadeTween);
			//removeTween(motionTween);
			//FP.world.recycle(this);
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
			if (Math.abs(LightTail.angle - angle) > 88 && Math.abs(LightTail.angle - angle) < 270)
				return true;
			else
				return false;
		}		
		
	}

}