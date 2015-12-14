package app {
	import app.smudgefx.SmudgeFilter;
	import app.smudgefx.SmudgeRestoreData;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.FragmentFilter;
	import starling.textures.Texture;

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class MainStarling extends Sprite {
		public static var INST:MainStarling;
		public var theFilter:FragmentFilter;
		public var canvas:Sprite;
		public var background:Quad;
		
		public function MainStarling() {
			super();
			
			INST = this;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			stage.color = 0xdddddd;
			
			canvas = new Sprite();
			
			background = new Quad(stage.stageWidth, stage.stageHeight, 0xff0000);
			canvas.addChild(background);
			
			var imgTest:Image = new Image( Texture.fromEmbeddedAsset(Assets.STARLING_LOGO) );
			canvas.addChild(imgTest);
			
			addChild(canvas);
			
			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			
			setupFilter(w, h);
			
			touchable = true;
			touchGroup = true;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function setupFilter(w:int, h:int):void {
			//SmudgeRestoreData

			//theFilter = new SmudgeFilter(1, 1);
			//theFilter.restoreData = new SmudgeRestoreData(w, h);
			
			theFilter = new BlurFilter(100, 0, 1);
			
			//canvas.filter = smudger;
		}
		
		public function toggleFilter():void {
			if (canvas.filter == null) { 
				canvas.filter = theFilter;
			} else {
				canvas.filter = null;
			}
		}
		
		private function onTouch(e:TouchEvent):void {
			if (e.touches == null || e.touches.length == 0) return;
			
			var touch:Touch = e.touches[0];
			
			if (touch.phase == TouchPhase.MOVED) {
				trace("!!!");
			}
		}
	}
}