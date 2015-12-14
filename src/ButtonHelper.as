package {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class ButtonHelper {
		public static var DEFAULT_CONTAINER:Sprite;
		
		public static var DEFAULT_FORMAT:TextFormat = new TextFormat("Arial", 12, 0xffffff, true);
		public static var COLOR_OVER:ColorTransform = new ColorTransform(0.8,0.8,0.8,1,64,64,64);
		public static var COLOR_OUT:ColorTransform = new ColorTransform();
		
		public static function makeButton(text:String, x:Number = 0, y:Number = 0, color:int = 0x008800, callback:Function = null):Sprite {
			DEFAULT_FORMAT.letterSpacing = 1;
			
			var btn:Sprite = new Sprite();
			var label:TextField = new TextField();
			label.defaultTextFormat = DEFAULT_FORMAT;
			label.autoSize = TextFieldAutoSize.LEFT;
			label.mouseEnabled = false;
			label.text = text;
			
			btn.x = x;
			btn.y = y;
			btn.buttonMode = true;
			btn.addChild(label);
			btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseInteraction);
			btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseInteraction);
			
			var gap:int = 2;
			var gap2:int = gap<<1;
			label.x = gap;
			label.y = gap;
			
			var g:Graphics = btn.graphics;
			g.lineStyle(2, 0xffffff, 1, true);
			g.beginFill(color, 1);
			g.drawRect(0, 0, label.width + gap2, label.height + gap2);
			
			if (DEFAULT_CONTAINER != null) {
				DEFAULT_CONTAINER.addChild(btn);
			}
			
			if (callback != null) {
				btn.addEventListener(MouseEvent.CLICK, callback);
			}
			return btn;
		}
		
		private static function onMouseInteraction(e:MouseEvent):void {
			var btn:Sprite = Sprite(e.target);
			switch(e.type) {
				case MouseEvent.MOUSE_OUT: btn.transform.colorTransform = COLOR_OUT; break;
				case MouseEvent.MOUSE_OVER: btn.transform.colorTransform = COLOR_OVER; break;
			}
		}
	}
}