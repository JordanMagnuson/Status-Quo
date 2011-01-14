package  
{
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.net.navigateToURL;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameOverWorld extends World
	{
		
		//[Embed(source = '../assets/CasualEncounter.ttf', embedAsCFF = "false", fontFamily = 'CasualEncounter')] private var CasualEncounter:Class;		
		//[Embed(source = '../assets/verdana.ttf', embedAsCFF = "false", fontFamily = 'verdana')] private var Verdana:Class;	
		
		[Embed(source = '../assets/ch_lasted.png')] private const CH_LASTED:Class;
		public var chLasted:Image = new Image(CH_LASTED);
		
		[Embed(source = '../assets/ch_absorbed.png')] private const CH_ABSORBED:Class;
		public var chAbsorbed:Image = new Image(CH_ABSORBED);	
		
		[Embed(source = '../assets/ch_destroyed.png')] private const CH_DESTROYED:Class;
		public var chDestroyed:Image = new Image(CH_DESTROYED);			
		
		[Embed(source = '../assets/ch_press_space.png')] private const CH_PRESS:Class;
		public var chPress:Image = new Image(CH_PRESS);				
		
		public var learnMoreURL:String = "http://www.gametrekking.com/about-taiwan";
		
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
				modeOfDeathString = "before getting too close to and being absorbed by a larger circle."
			else
				modeOfDeathString = "before antagonizing and being destroyed by a larger circle."
			
			// Print text to screen
			if (minutesAlive > 0)
				add(new TextEntity("You managed to keep the status quo for " + minutesAliveString + " and " + secondsAliveString + ",", FP.halfWidth, FP.halfHeight - 65));
			else
				add(new TextEntity("You managed to keep the status quo for " + secondsAliveString + ", ", FP.halfWidth, FP.halfHeight - 65));
		
			add(new TextEntity(modeOfDeathString, FP.halfWidth, FP.halfHeight - 35));
				
			add(new TextEntity("Press space to try again.", FP.halfWidth, FP.halfHeight + 35));
			
			add(new TextEntity("Press X to learn more about Taiwan.", FP.halfWidth, FP.halfHeight + 65));
			
			// Chinese text
			trace(Globals.timeAlive);
			add(new TextEntity(String(int(Globals.timeAlive)), FP.halfWidth + 39, 118));
			add(new Entity(FP.halfWidth - chLasted.width / 2, 112, chLasted));
			if (Globals.modeOfDeath == 'absorbed')
			{
				add(new Entity(FP.halfWidth - chAbsorbed.width / 2, 140, chAbsorbed));
			}
			else
			{
				add(new Entity(FP.halfWidth - chDestroyed.width / 2, 140, chDestroyed));
			}
			add(new Entity(FP.halfWidth - chPress.width / 2, 433, chPress));
		}
		
		override public function begin():void
		{
			add(new FadeIn);
		}
		
		override public function update():void
		{
			if (Input.released(Key.SPACE) || Input.mouseReleased)
			{
				FP.world = new GameWorld;
			}
			if (Input.pressed(Key.X))
			{
				var request:URLRequest = new URLRequest(learnMoreURL);
				try {
				  navigateToURL(request, '_blank'); // second argument is target
				} catch (e:Error) {
				  trace("Error occurred!");
				}
			}
			super.update();
		}
	}

}