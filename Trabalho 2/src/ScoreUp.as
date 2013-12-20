package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class ScoreUp extends FlxGroup {
		
		public var text: FlxText;
		private var ativo: Boolean;
		private var iniTime: Number;
		
		public function ScoreUp() {
			text = new FlxText(FlxG.width / 2, FlxG.height / 2, 200, "", true);
			text.size = 12;
			ativo = new Boolean(false);
			iniTime = 0;
			add(text);
		}
		override public function update():void {
			if (ativo) {
				text.velocity.y -= 1;
				if (iniTime >= 2) {
					ativo = false;
					text.visible = false;
				}
				iniTime += FlxG.elapsed;
			}
			super.update();
		}
		public function scoreUp(x:Number, y:Number, s:String):void {
			text.x = x;
			text.y = y;
			text.text = s;
			text.velocity.y = 0;
			ativo = true;
			iniTime = 0;
			text.visible = true;
		}
	}
}