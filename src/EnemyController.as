package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.FP;
	
	/**
	 * Static class that controls the release of enemies.
	 */
	public class EnemyController extends Entity
	{
		public static const MIN_RLEASE_RATE:Number = 0.5;
		public static const RELEASE_RATE_CHANGE:Number = 0.02
		
		public static var releaseRate:Number = 2;
		public static var releaseAngle:Number = 0;
		public static var enemyAlarm:Alarm;
		
		public function EnemyController() 
		{
			enemyAlarm = new Alarm(releaseRate, releaseEnemy);
			addTween(enemyAlarm, true);
		}
		
		public function releaseEnemy():void
		{
			// Reset the alarm
			releaseRate = Math.max(releaseRate - RELEASE_RATE_CHANGE, MIN_RLEASE_RATE);
			enemyAlarm.reset(releaseRate);
			//trace('release rate: ' + releaseRate);
			
			// Choose a radius to release at, between safe zone outer radius and inner radius
			var r:Number = SafeZone.innerRadius + FP.random * (SafeZone.outerRadius - SafeZone.innerRadius);
			
			// Convert polar coordinates (r + theta) to cartesian
			var ex:Number = FP.halfWidth + r * Math.cos(releaseAngle * Math.PI / 180)
			var ey:Number = FP.halfHeight - r * Math.sin(releaseAngle * Math.PI / 180);	
			
			// Set the speed equal to lighttail speed (v = angular velocity in radians * r)
			var speed:Number = (LightTail.speed * Math.PI / 180) * r;
			
			FP.world.add(new Enemy(ex, ey, speed));
		}
		
	}

}