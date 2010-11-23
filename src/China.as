package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class China extends Entity
	{
		public static const LAZER_DURATION:Number = 0.2;	// How long the lazer shoots for
		
		public static var radius:Number = 43;
		public static var shootingLazer:Boolean = false;
		public static var lazerAlarm:Alarm;
		
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
			
			lazerAlarm = new Alarm(LAZER_DURATION, stopLazer);
			addTween(lazerAlarm);
		}
		
		/**
		 * Draws a "lazer" line between China and the playe.
		 */
		public static function shootLazer():void
		{
			SoundController.music.stop();
			SoundController.soundLazer.play();
			shootingLazer = true;
			lazerAlarm.reset(LAZER_DURATION);
		}
		
		public static function stopLazer():void
		{
			FP.world.remove(GameWorld.player);
			shootingLazer = false;
		}
		
		override public function render():void
		{
			if (shootingLazer)
				Draw.line(centerX, centerY, centerX, FP.screen.height);
			super.render();
		}
		
	}

}