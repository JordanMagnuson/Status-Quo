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
		public static var releaseRate:Number = 1;
		public static var enemyAlarm:Alarm;
		
		public function EnemyController() 
		{
			enemyAlarm = new Alarm(releaseRate, releaseEnemy);
			addTween(enemyAlarm, true);
		}
		
		public function releaseEnemy():void
		{
			trace('enemy released');
			enemyAlarm.reset(releaseRate);
			var ex:Number = FP.screen.width / 2;
			var ey:Number = FP.screen.height / 2 + SafeZone.outerRadius - (SafeZone.outerRadius - SafeZone.innerRadius) / 2;	
			FP.world.add(new Enemy(ex, ey));
		}
		
	}

}