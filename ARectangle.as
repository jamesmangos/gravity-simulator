package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	public class ARectangle extends Sprite
	{
		private var _recX:Number;
		private var _recY:Number;
		private var _recWidth:int;
		private var _recHeight:int;
		private var _density:int = 1;
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		
		
		public function ARectangle(recX:Number, recY:Number, recWidth:int, recHeight:int)
		{
			_recX = recX;
			_recY = recY;
			_recWidth = recHeight;
			_recHeight = recHeight;
			
			drawARectangle();
		}
		
		public function drawARectangle():void
		{
			graphics.clear();
			graphics.beginFill(0xFF0000);
			graphics.drawRect(_recX, _recY, _recWidth, _recHeight);
			graphics.endFill();
		}
		
		public function adjustGravity(Fx:Number, Fy:Number, object1:Sprite, object2:Sprite):void
		{
			_speedX += Fx / (_density * getArea());
			_speedY += Fy / (_density * getArea());
			
			//test if collision detected
			if (this.hitTestObject(object1) || this.hitTestObject(object2))
			{
				_speedX = 0;
				_speedY = 0;
			}
			else
			{
				_recX += _speedX;
				_recY += _speedY;
			}
		}
		
		public function getArea():int
		{
			return _recWidth * _recHeight;
		}
		
		public function set recX(setValue:Number):void
		{
			_recX = setValue;
		}
		
		public function set recY(setValue:Number):void
		{
			_recY = setValue;
		}
		
		public function get recX():Number
		{
			return _recX;
		}
		
		public function get recY():Number
		{
			return _recY;
		}

		public function get density():int
		{
			return _density;
		}
		
		public function set recWidth(setValue:int):void
		{
			_recWidth = setValue;
		}
		
		public function get recWidth():int
		{
			return _recWidth;
		}
		
		public function set recHeight(setValue:int):void
		{
			_recHeight = setValue;
		}
		
		public function get recHeight():int
		{
			return _recHeight;
		}
		
	}
}
