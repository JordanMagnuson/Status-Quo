package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Player extends PolarMover
	{
		/**
		 * Movement constants.
		 */
		public const MAX_SPEED:Number = 150;
		public const GRAV:Number = 100;
		public const ACCEL:Number = 200;
		
		/**
		 * Movement properties.
		 */
		public var g:Number = GRAV;
		public var speed:Number = 50;		
		
		/**
		 * Other properties.
		 */
		public static var color:uint = Colors.WHITE;	// Color changes from white to black depending on where player is in LightTail.		
		
		/**
		 * Image.
		 */
		public var image:Image = Image.createCircle(8, Colors.WHITE);			
		
		public function Player(x:Number = 0, y:Number = 0) 
		{
			type = 'player';
			graphic = image;
			layer = 0;
			
			// Initial position
			this.x = FP.screen.width / 2;
			this.y = FP.screen.height / 2 + SafeZone.outerRadius - (SafeZone.outerRadius - SafeZone.innerRadius) / 2;			
			
			// Initialize image, hitbox
			image.originX = image.width / 2;
			image.originY = image.height / 2;
			image.x = -image.originX;
			image.y = -image.originY;		
			setHitbox(image.width, image.height, image.originX, image.originY);	
			
			// Define input
			Input.define("R", Key.RIGHT);
			Input.define("L", Key.LEFT);		
			Input.define("RESIST", Key.SPACE);
		}
		
		override public function update():void 
		{
			changeColor();
			//movement();
			gravity();
			acceleration();
			move(speed * FP.elapsed, pointDirection(x, y, FP.screen.width / 2, FP.screen.height / 2));	
		}
		
		public function movement():void
		{
			if (inDarkness())
			{
				if (Input.check("RESIST"))
					move(speed * FP.elapsed, pointDirection(FP.screen.width / 2, FP.screen.height / 2, x, y));
				else
					move(speed * FP.elapsed, pointDirection(x, y, FP.screen.width / 2, FP.screen.height / 2));		
			}
			else 
			{
				if (Input.check("RESIST"))
					move(speed * FP.elapsed, pointDirection(x, y, FP.screen.width / 2, FP.screen.height / 2));
				else
					move(speed * FP.elapsed, pointDirection(FP.screen.width / 2, FP.screen.height / 2, x, y));				
			}
		}
		
		public function changeColor():void
		{
			if (inDarkness())
			{
				if (image.color != Colors.WHITE)
				{
					image.color = Colors.WHITE;
				}
			}
			else if (image.color != Colors.BLACK)
			{
				image.color = Colors.BLACK;
			}
		}
		
		/**
		 * Checks whether the player is in darkness, based on position of LightTail.
		 * @return
		 */
		public function inDarkness():Boolean
		{
			if (LightTail.angle < 180)
				return true;
			else
				return false;
		}
		
		/**
		 * Applies gravity to the player.
		 */
		private function gravity():void
		{
			// Reverse gravity depending on LightTail.
			if (inDarkness())
			{
				if (g < 0)
				{
					speed = 0;
					g *= -1;
				}
			}
			else if (g > 0)
			{
				speed = 0;
				g *= -1;
			}
			speed += g * FP.elapsed;
			if (speed > MAX_SPEED) 
				speed = MAX_SPEED;
		}
		
		/**
		 * Accelerates the player based on input.
		 */
		private function acceleration():void
		{
			// evaluate input
			var accel:Number = 0;
			if (Input.check("RESIST")) accel += ACCEL;
			
			// Reverse gravity depending on LightTail.
			if (inDarkness())
			{
				if (accel > 0)
				{
					//speed = 0;
					accel *= -1;
				}
			}
			else if (accel < 0)
			{
				//speed = 0;
				accel *= -1;
			}			
			
			// handle acceleration
			if (accel != 0)
			{
				// accelerate
				if (speed < MAX_SPEED)
				{
					speed += accel * FP.elapsed;
					if (speed > MAX_SPEED) speed = MAX_SPEED;
				}
				else accel = 0;
			}
			
		}		
		
	}

}