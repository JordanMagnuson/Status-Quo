package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class China extends Entity
	{
		public static const LAZER_DURATION:Number = 0.2;	// How long the lazer shoots for
		
		
		public static var breatheAlarm:Alarm;
		public static var breathe:NumTween;
		public static var breathing:Boolean = false;
		public static var breathingIn:Boolean;
		// Breathe delay for safe zone
		public static var breatheDelayAlarm:Alarm;
		
		public static const RADIUS_ORIG:Number = 43;
		public static var radius:Number = RADIUS_ORIG;
		public static var shootingLazer:Boolean = false;
		public static var lazerAlarm:Alarm;
		
		// Graphic
		public var image:Image = Image.createCircle(radius, Colors.WHITE);
		
		//[Embed(source = '../assets/china.png')] private const S_CHINA:Class;
		//public var image:Image = new Image(S_CHINA);
		
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
			
			lazerAlarm = new Alarm(LAZER_DURATION, stopLazer);
			addTween(lazerAlarm);
			//breatheAlarm = new Alarm(3 + SoundController.startingPause, startBreathing);
			//addTween(breatheAlarm, true);
			
			startBreathing();
		}
		
		/**
		 * Draws a "lazer" line between China and the playe.
		 */
		public static function shootLazer():void
		{
			SoundController.music.stop();
			SoundController.soundLazer.play(2);
			shootingLazer = true;
			lazerAlarm.reset(LAZER_DURATION);
			
			// Freeze everything
			breathing = false;
			Player.breathing = false;
			LightTail.changeRotationSpeed(0);
			EnemyController.enemyAlarm.active = false;
		}
		
		public static function stopLazer():void
		{
			FP.world.remove(GameWorld.player);
			shootingLazer = false;
			GameWorld.gameOver = true;
		}
		
		public function startBreathing():void
		{
			breathing = true;
			breatheIn();
		}
		
		public function breatheIn():void
		{
			breathingIn = true;
			trace('breathingIn');
			breathe = new NumTween(breatheOut);
			addTween(breathe);
			breathe.tween(1, 1.2, 3);
		}
		
		public function breatheOut():void
		{
			breathingIn = false;
			trace('breathingOut');
			breathe = new NumTween(breatheIn);
			addTween(breathe);
			breathe.tween(1.2, 1, 3);			
		}
		
		public function animation():void
		{
			// Image scale tweening
			radius = RADIUS_ORIG * breathe.value;
			//image.scaleX = breathe.x;
			//image.scaleY = breathe.y;
			//image.smooth = true;
			
			//image = Image.createCircle(radius * (breathe.x/2), Colors.WHITE);
			//image.originX = image.width / 2;
			//image.originY = image.height / 2;
			//image.x = -image.originX;
			//image.y = -image.originY;		
			//setHitbox(image.width, image.height, image.originX, image.originY);				
			//graphic = image;
		}
		
		override public function update():void
		{
			if (breathing)
				breathe.active = true;
			else
				breathe.active = false;
			animation();
			//trace('china percent left: ' + breathe.percent);
			super.update();
		}
		
		override public function render():void
		{
			if (shootingLazer)
				Draw.line(centerX, centerY, centerX, FP.screen.height);
			Draw.circlePlus(x, y, radius, Colors.WHITE, 1);
			//super.render();
		}
		
	}

}