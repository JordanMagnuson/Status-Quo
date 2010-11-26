package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Player extends PolarMover
	{
		/**
		 * Constants.
		 */
		public const MAX_SPEED:Number = 60;
		public const GRAV:Number = 100;
		public const ACCEL:Number = 200;
		public const STUN_TIME:Number = 0.5;	// Seconds player can't move after being hit by enemy.
		public const STUN_COLOR:uint = Colors.RED;
		public const ENEMY_MOVE_DIST:Number = 20;	// Distance player moves when hits enemy.
		
		/**
		 * Movement properties.
		 */
		public var g:Number = 0;
		public var accel_current:Number = 0;
		public var speed:Number = 0;		
		
		/**
		 * Other properties.                  
		 */
		public static var color:uint = Colors.WHITE;	// Color changes from white to black depending on where player is in LightTail.		
		public static var stunAlarm:Alarm;
		public static var canMove:Boolean = true;	// Whether the player input makes a difference.
		public static var frozen:Boolean = false; 	// Whether the player is totally frozen (no grav, etc.)
		
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
			canMove = true;
			frozen = false;
			speed = 0;
			
			
			// Stun alarm
			stunAlarm = new Alarm(STUN_TIME, restoreMovement);
			addTween(stunAlarm);
			
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
			updateColor();
			//movement();
			if (!frozen)
			{
				gravity();
				if (canMove) 
					acceleration();
				move(speed * FP.elapsed, pointDirection(x, y, FP.screen.width / 2, FP.screen.height / 2));	
				checkCollisions();
				checkSafeZone();
			}
		}
		
		/**
		 * Alternative movement with no acceleration... NOT BEING USED
		 */
		public function movement():void
		{
			speed = 50;
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
		
		public function checkCollisions():void
		{
			// Collision with enemy
			if (collide('enemy', x, y))
			{
				SoundController.soundHit.play();
				if (inDarkness())
					y -= ENEMY_MOVE_DIST;
				else
					y += ENEMY_MOVE_DIST;
				//canMove = false;
				//stunAlarm.reset(STUN_TIME);
			}			
			
			// Collision with China (game over)
			if (collide('china', x, y))
			{
				GameWorld.gameOver = true;
			}		
		}
		
		public function checkSafeZone():void
		{
			if (distanceToPoint(FP.halfWidth, FP.halfHeight) < SafeZone.innerRadius && canMove)
			{
				Globals.timeAlive = GameWorld.timer.timePassed;
				Globals.modeOfDeath = 'absorbed';				
				SoundController.music.stop();
				SoundController.soundGlitch.play();
				canMove = false;
			}
			else if (distanceToPoint(FP.halfWidth, FP.halfHeight) > SafeZone.outerRadius)
			{
				Globals.timeAlive = GameWorld.timer.timePassed;
				Globals.modeOfDeath = 'destroyed';
				if (!China.shootingLazer)
				{
					China.shootLazer();
					//FP.world.remove(this);
					frozen = true;
				}
				canMove = false;
			}			
		}
		
		public function restoreMovement():void
		{
			canMove = true;
		}
		
		public function updateColor():void
		{
			//if (!canMove)
			//{
				//if (image.color != STUN_COLOR)
				//{
					//image.color = STUN_COLOR;
				//}
			//}
			if (distanceToPoint(FP.halfWidth, FP.halfHeight) > SafeZone.outerRadius)
			{
				if (image.color != Colors.WHITE)
				{
					image.color = Colors.WHITE;
				}				
			}
			else if (inDarkness())
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
			graphic = image;
		}
		
		/**
		 * Checks whether the player is in darkness, based on position of LightTail.
		 * @return
		 */
		public function inDarkness():Boolean
		{
			if (distanceToPoint(FP.halfWidth, FP.halfHeight) < SafeZone.innerRadius)
				return true;
			else if (distanceToPoint(FP.halfWidth, FP.halfHeight) > SafeZone.outerRadius)
				return false;
			else if (LightTail.angle < 180)
				return true;
			else
				return false;
		}
		
		/**
		 * Applies gravity to the player.
		 */
		private function gravity():void
		{
			if (Math.abs(g) < GRAV)
			{
				if (g < 0) g -= 0.1;
				else g += 0.1;
			}
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
			if (accel_current < ACCEL)
				accel_current += 0.2;
			if (Input.check("RESIST") || Input.mouseDown) 
				accel += accel_current;
			
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