package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameOverWorld extends World
	{
		
		[Embed(source = '../assets/CasualEncounter.ttf', embedAsCFF="false", fontFamily = 'CasualEncounter')] private var CasualEncounter:Class;		
		
		public function GameOverWorld() 
		{
			// Get minutes and seconsd alive, format strings.
			var minutesAlive:int = Math.floor(Globals.timeAlive / 60);
			var secondsAlive:int = Math.floor(Globals.timeAlive % 60);
			var minutesAliveString:String;
			var secondsAliveString:String;
			if (minutesAlive > 0)
			{
				if (minutesAlive == 1) minutesAliveString = '1 minute';
				else minutesAliveString = String(minutesAlive) + ' minutes';
			}
			if (secondsAlive == 1) secondsAliveString = '1 second';
			else secondsAliveString = String(secondsAlive) + ' seconds';
			
			// Mode of death
			var modeOfDeathString:String;
			if (Globals.modeOfDeath == 'absorbed')
				modeOfDeathString = "before getting too close and being absorbed by a larger circle."
			else
				modeOfDeathString = "before antagonizing and being destroyed by a larger circle."
			
			// Print text to screen
			if (minutesAlive > 0)
				add(new TextEntity("You managed to keep the status quo for " + minutesAliveString + " and " + secondsAliveString + ",", FP.halfWidth, FP.halfHeight - 100));
			else
				add(new TextEntity("You managed to keep the status quo for " + secondsAliveString + ", ", FP.halfWidth, FP.halfHeight - 100));
		
			add(new TextEntity(modeOfDeathString, FP.halfWidth, FP.halfHeight - 70));
				
			add(new TextEntity("Press space to try again", FP.halfWidth, FP.halfHeight));
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.SPACE))
			{
				FP.world = new GameWorld;
			}
			super.update();
		}
	}

}