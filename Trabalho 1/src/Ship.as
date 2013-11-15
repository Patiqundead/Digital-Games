package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class Ship extends FlxSprite
	{
		[Embed(source = "../assets/images/ship1 32x44.png")] private var shipPNG: Class;
		[Embed(source = "../assets/sounds/FX-Lazer285.mp3")] private var laserMP3: Class;
		private var T_X: int = 32;
		private var T_Y: int = 44;
		private var alvo :FlxSprite;
		
		public function Ship(nX:int, nY:int) {
			loadGraphic(shipPNG, true, false, T_X, T_Y, false);
			addAnimation("frente", [0, 1], 30, false);
			this.x = nX;
			this.y = nY;
			
			maxAngular = 120;
			angularDrag = 400;
			
			velocity.x = 0;
			velocity.y = 0;
			maxVelocity.x = 300;
			maxVelocity.y = 300;
		}
		
		override public function update(): void {
			if (FlxG.keys.justPressed("SPACE")) {
				var bullet: Bullet = (FlxG.state as GameState).playerBullets.getFirstAvailable() as Bullet;
 				bullet.reset(this.x + this.width / 2 - bullet.width / 2, this.y + this.height / 2 - bullet.height / 2);
				
				FlxG.play(laserMP3, 0.6, false, true);
				
				bullet.velocity.x = 170 * Math.sin(this.angle * 3.14 / 180);
				bullet.velocity.y = 170 * -Math.cos(this.angle * 3.14 / 180);
			}
			
			if (this.x > FlxG.width + T_X) {
				this.x = 1;
			}
			if (this.x + T_X < 0) {
				this.x = FlxG.width;
			}
			if (this.y > FlxG.height + T_Y) {
				this.y = 1;
			}
			if (this.y + T_Y < 0) {
				this.y = FlxG.height;
			}
			
			acceleration.x = 0;
			acceleration.y = 0;
			
			
			if (FlxG.keys.pressed("UP")) {
				play("frente");
				FlxU.rotatePoint(0, 100, 0, 0, angle, acceleration);
			}
			if (FlxG.keys.pressed("LEFT")) {
				play("frente");
				this.angle-=2;
			}
			
			if (FlxG.keys.pressed("RIGHT")) {
				play("frente");
				this.angle+=2;
			}
			
			super.update();
		}
	}

}