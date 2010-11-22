package 
{
	import flash.geom.Point;
	import net.flashpunk.tweens.motion.CircularMotion;
	import net.flashpunk.FP;

	public class Orbiter extends PolarMover
	{
		
		public var center:Point = new Point(FP.halfWidth, FP.halfHeight);
		public var radius:Number;
		public var speed:Number;
		
		public var motionTween:CircularMotion = new CircularMotion(continueOrbit);
		
		public function Orbiter(x:Number, y:Number, speed:Number) 
		{
			super(x, y);
			this.speed = speed;
		}
		
		override public function added():void
		{			
			radius = distanceToPoint(center.x, center.y);
			motionTween.setMotionSpeed(center.x, center.y, radius, getAngle(), false, speed);
			FP.world.addTween(motionTween, true);
		}
		
		override public function update():void 
		{
			super.update();
			x = motionTween.x;
			y = motionTween.y;
		}
		
		public function continueOrbit():void
		{
			motionTween.setMotionSpeed(FP.halfWidth, FP.halfHeight, distanceToPoint(FP.halfWidth, FP.halfHeight), getAngle(), false, speed);
		}	
		
		public function getAngle():Number
		{
			return pointDirection(center.x, center.y, x, y);
		}
	}

}