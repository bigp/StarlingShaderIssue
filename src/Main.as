package{
	import app.MainStarling;
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class Main extends Sprite {
		public static var INST:Main;
		public static var STAR:Starling;
		
		public var isRotated:Boolean = false;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			INST = this;
			ButtonHelper.DEFAULT_CONTAINER = this;
			
			setupStage();
			setupStarling();
			setupUI();
		}
		
		private function setupStage():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private function setupStarling():void {
			var stage3d:Stage3D = stage.stage3Ds[0];
			var renderMode:String = Context3DRenderMode.AUTO;
			var profiles:Array = [Context3DProfile.BASELINE_EXTENDED, Context3DProfile.BASELINE];
			
			STAR = new Starling(MainStarling, stage, getStageViewport(), stage3d, renderMode, profiles);
			STAR.addEventListener(Event.ROOT_CREATED, onStarlingRootCreated);
		}
		
		private function onStarlingRootCreated(e:Event):void {
			STAR.removeEventListener(Event.ROOT_CREATED, onStarlingRootCreated);
			
			stage.addEventListener(Event.RESIZE, onResize);
			
			STAR.supportHighResolutions = true;
			STAR.start();
		}
		
		private function onResize(e:*=null):void {
			Starling.current.viewPort = getStageViewport();
		}
		
		public function getStageViewport():Rectangle {
			return new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		}
		
		private function setupUI():void {
			ButtonHelper.makeButton("Flip Orientation", 5, 5, 0x00aa00, flipOrientation);
			ButtonHelper.makeButton("Toggle Filter", 120, 5, 0xaaaa00, toggleFilter);
		}
		
		private function toggleFilter(e:*=null):void {
			MainStarling.INST.toggleFilter();
		}
		
		private function flipOrientation(e:*= null):void {
			isRotated = !isRotated;
			var angle:Number = isRotated ? Math.PI * 0.5 : 0;
			var xPos:Number = isRotated ? stage.stageWidth : 0;
			TweenMax.to(MainStarling.INST, 1.0, { x: xPos, rotation: angle, ease: Quad.easeInOut } );
		}
		
		
	}
}