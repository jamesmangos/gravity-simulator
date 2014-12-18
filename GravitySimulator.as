//language: flash actionscript 3.0
package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;

	public class GravitySimulator extends MovieClip
	{
		private var circle1:ACircle;
		private var circle2:ACircle;
		private var rectangle:ARectangle;
		private var GConstant:int = 1;
		
		public function GravitySimulator():void
		{
			//optional stage allignment code
			//import flash.display.StageAlign;
      //import flash.display.StageScaleMode;
			//this.stage.scaleMode = StageScaleMode.NO_SCALE;
      //this.stage.align = StageAlign.TOP_LEFT;
			
			rectangle = new ARectangle(0,this.stage.stageHeight-5,5,5);
			circle1 = new ACircle(100,100,25,5, rectangle.recX, rectangle.recY);
			circle2 = new ACircle(300,300,25,5, rectangle.recX, rectangle.recY);
			this.addChild(rectangle);
			this.addChild(circle1);
			this.addChild(circle2);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		// Update every frame //gravity effect
		protected function enterFrameHandler(event:Event):void
		{
			calculateGravity(this.rectangle.recX, this.rectangle.recY);
			this.rectangle.drawARectangle();
			this.circle1.drawACircle(rectangle.recX, rectangle.recY);
			this.circle2.drawACircle(rectangle.recX, rectangle.recY);
		}
		
		function keyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 39) //right arrow
			{
				this.rectangle.recX += 5;
			}
			if (event.keyCode == 37) //left arrow
			{
				this.rectangle.recX -= 5;
			}
			if (event.keyCode == 38) //up arrow
			{
				this.rectangle.recY -= 5; //up is -ve Y axis
			}
			if (event.keyCode == 40) //down arrow
			{
				this.rectangle.recY += 5; //dpwn is +ve Y axis
			}
		}
		
		function calculateGravity(recX:Number, recY:Number):void
		{
			// F =   G * m1 * m2    
			//      -------------
			//           r^2
			//F = GConstant * (squareDensity * recWidth * recHeight) * (circleDensity * circleArea)
			//    -----------------------------------------------------------------------------------------------
			//                 Math.Pow((recXCentre - centreX,2)  + Math.Pow(recYCentre- centreY, 2))^2

			//magnitude of force
			var F1:Number = GConstant * rectangle.density * rectangle.getArea() * circle1.density * circle1.getArea();
			F1 = F1 / (Math.pow(((recX + rectangle.recWidth / 2) - circle1.centreX),2) + Math.pow(((recY + rectangle.recWidth / 2) - circle1.centreY),2));
			//seperate into x and y components
			var F1x:Number = Math.abs(F1 * Math.cos(circle1.theta));
			var F1y:Number = Math.abs(F1 * Math.sin(circle1.theta));
			//make components negative as nessesary
			if ((recX + rectangle.recWidth / 2) - circle1.centreX > 0)
			{
				F1x = F1x * -1;
			}
			if ((recY + rectangle.recHeight / 2) - circle1.centreY > 0)
			{
				F1y = F1y * -1;
			}
			
			//magnitude of force
			var F2:Number = GConstant * rectangle.density * rectangle.getArea() * circle2.density * circle2.getArea();
			F2 = F2 / (Math.pow(((recX + rectangle.recWidth / 2) - circle2.centreX),2) + Math.pow(((recY + rectangle.recWidth / 2) - circle2.centreY),2));
			//seperate into x and y components
			var F2x:Number = Math.abs(F2 * Math.cos(circle2.theta));
			var F2y:Number = Math.abs(F2 * Math.sin(circle2.theta));
			//make components negative as nessesary
			if ((recX + rectangle.recWidth / 2) - circle2.centreX > 0)
			{
				F2x = F2x * -1;
			}
			if ((recY + rectangle.recHeight / 2) - circle2.centreY > 0)
			{
				F2y = F2y * -1;
			}
			
			rectangle.adjustGravity(F1x + F2x, F1y + F2y, this.circle1, this.circle2);
		}
	}
}
