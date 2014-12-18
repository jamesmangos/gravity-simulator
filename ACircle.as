package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;

	
	public class ACircle extends Sprite
	{
		private var _centreX:int;
		private var _centreY:int;
		private var _largerRadius:int;
		private var _lesserRadius:int;
		private var _lesserX:int;
		private var _lesserY:int;
		private var _theta:int; //in degrees
		private var _density:int = 1;
		
		private var dragging:Boolean = false;
		private var _startX:Number;
		private var _startY:Number;
		
		public function ACircle(xPos:int, yPos:int, larRadius:int, lessRadius:int, recX:int, recY:int):void
		{
			_centreX = xPos;
			_centreY = yPos;
			_largerRadius = larRadius;
			_lesserRadius = lessRadius;
			_lesserX = _centreX + _largerRadius + _lesserRadius;
			_lesserY = _centreY;
			_theta = 0; //in degrees
			drawACircle(recX, recY);
			
			//these handle the dragging feature 
			this.addEventListener(MouseEvent.MOUSE_DOWN,dragPressHandler);

		}
		
		public function drawACircle(recX:int, recY:int):void
		{
			if (dragging)
			{
				//note the difference from frame to frame
				_centreX = _centreX + (stage.mouseX - _startX);
				_centreY = _centreY + (stage.mouseY - _startY);
				
				//reset the differnce checker for each frame
				_startX = stage.mouseX;
				_startY = stage.mouseY;
			}
			
			_theta = Math.atan((-recY + _centreY)/(recX - _centreX)) * 180 / Math.PI; //-ve since Y is positive downwards
			if (recX - _centreX < 0)//2nd or 3rd quadrants
			{
				_theta = 180 + _theta;
			}
			if (recX - _centreX > 0 && recY - _centreY > 0)//4th quadrant
			{
				_theta = 360 + _theta;
			}
			_lesserX = _centreX + (_largerRadius + _lesserRadius) * Math.cos(_theta * Math.PI/180);
			_lesserY = _centreY - (_largerRadius + _lesserRadius) * Math.sin(_theta * Math.PI/180);
		
			graphics.clear();
			graphics.lineStyle(2,0xFFFFFF,1);//2 pixels, black, alpha=1
			graphics.drawCircle(_centreX,_centreY,_largerRadius);
			graphics.drawCircle(_lesserX,_lesserY,_lesserRadius);
		}
		
		public function dragPressHandler(event:MouseEvent):void
		{		
			//make note of where the object starts
			_startX = stage.mouseX;
			_startY = stage.mouseY;
			
			dragging = true;
		}
		
		public function dragReleaseHandler(event:MouseEvent):void
		{
			if( dragging )
			{
				//calculate the difference in positioning from the movement
				_centreX = _centreX + (stage.mouseX - _startX);
				_centreY = _centreY + (stage.mouseY - _startY);
				
				dragging = false;
			}
		}
		
		public function getArea():Number
		{
			//A = pi * r^2
			return Math.PI * Math.pow(_largerRadius,2);
		}
		
		public function set centreX(setValue:int):void
		{
			_centreX = setValue;
		}
		
		public function set centreY(setValue:int):void
		{
			_centreY = setValue;
		}
		
		public function get centreX():int
		{
			return _centreX;
		}
		
		public function get centreY():int
		{
			return _centreY;
		}
		
		public function get density():int
		{
			return _density;
		}
		
		public function get largerRadius():int
		{
			return _largerRadius;
		}
		
		public function get theta():int
		{
			return _theta;
		}
	}
}
