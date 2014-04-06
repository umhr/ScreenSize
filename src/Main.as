package 
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Main extends Sprite 
	{
		private var _mousePoint:Shape;
		private var _infoCanvas:Sprite = new Sprite();
		private var _uiCanvas:Sprite = new Sprite();
		private var _textField:TextField = new TextField();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.scaleMode = "noScale";
			stage.align = "TL";
			_mousePoint = new Shape();
			_mousePoint.graphics.beginFill(0xFF0000);
			_mousePoint.graphics.drawCircle(0, 0, 50);
			_mousePoint.graphics.beginFill(0x999999);
			_mousePoint.graphics.drawCircle(0, 0, 25);
			_mousePoint.graphics.beginFill(0xFFFFFF);
			_mousePoint.graphics.drawCircle(0, 0, 5);
			_mousePoint.graphics.endFill();
			_infoCanvas.addChild(_mousePoint);
			
			addChild(_infoCanvas);
			addChild(_uiCanvas);
			addButton(0, 0, "FullScreen\n(F / Ctrl + F)", MouseEvent.MOUSE_DOWN, stage_mouseDown);
			addButton(200, 0, "Copy to clipbord\n(C)", MouseEvent.MOUSE_DOWN, textCopy);
			addButton(400, 0, "Save\n(S)", MouseEvent.MOUSE_DOWN, save);
			
			stage_resize(null);
			stage.addEventListener(Event.RESIZE, stage_resize);
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDown);
			
			//stage_mouseDown(null);
		}
		
		private function stage_keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.C) {
				textCopy(null);
			}else if (e.keyCode == Keyboard.F) {
				stage_mouseDown(null);
			}else if (e.keyCode == Keyboard.S) {
				save(null);
			}
			
		}
		
		private function addButton(x:int,y:int,text:String,type:String,listener:Function):void {
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0x666666,0.7);
			sprite.graphics.drawRoundRect(0, 0, 190, 90, 8, 8);
			sprite.graphics.beginFill(0xCCCCCC,0.7);
			sprite.graphics.drawRoundRect(4, 4, 182, 82, 6, 6);
			sprite.graphics.endFill();
			var textField:TextField = new TextField();
			textField.defaultTextFormat = new TextFormat("_sans", 24);
			textField.wordWrap = textField.multiline = true;
			textField.width = sprite.width-8;
			textField.height = sprite.height-8;
			textField.text = text;
			textField.selectable = false;
			textField.mouseEnabled = false;
			textField.x = 4;
			textField.y = 4;
			sprite.addChild(textField);
			sprite.x = x+4;
			sprite.y = y+4;
			sprite.addEventListener(type, listener);
			_uiCanvas.addChild(sprite);
		}
		
		private function save(e:MouseEvent):void 
		{
			var fileName:String = "";
			fileName += new Date().fullYear;
			fileName += ketaawase(new Date().month + 1);
			fileName += ketaawase(new Date().date);
			fileName += ketaawase(new Date().hours);
			fileName += ketaawase(new Date().minutes);
			fileName += ketaawase(new Date().seconds);
			fileName += ".png";
			SaveImage.PNGfromDisplayObject(this,new Rectangle(0,0,stage.stageWidth,stage.stageHeight),false,fileName);
		}
		private function ketaawase(suji:int, num:int = 2):String {
			var str:String = suji.toString();
			var s:String = "";
			var n:int = num;
			for (var i:int = 0; i < n; i++) 
			{
				s += "0";
			}
			str = s + str;
			
			return str.substr(str.length - num, num);
		}
		
		private function textCopy(e:MouseEvent):void 
		{
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT , _textField.text);
		}
		
		private function stage_mouseMove(e:MouseEvent):void 
		{
			_mousePoint.x = stage.mouseX;
			_mousePoint.y = stage.mouseY;
		}
		
		private function stage_mouseDown(e:MouseEvent):void 
		{
			if(stage.displayState == "normal"){
				stage.displayState = "fullScreen";
			}else{
				stage.displayState = "normal";
			}
			stage_resize(null);
		}
		
		private function stage_resize(e:Event):void 
		{
			_infoCanvas.removeChildren();
			_infoCanvas.addChild(new Ichimatsu(stage.stageWidth, stage.stageHeight));
			_infoCanvas.addChild(_mousePoint);
			
			_textField.defaultTextFormat = new TextFormat("_sans", stage.stageWidth * 0.03);
			_textField.text = getText();
			_textField.width = stage.stageWidth;
			_textField.height = stage.stageHeight;
			_textField.y = 100;
			//textField.border = true;
			_textField.wordWrap = true;
			_infoCanvas.addChild(_textField);
			
		}
		public function getText():String {
			
			var result:String = "";
			result += "stage:" + stage.stageWidth + "x" + stage.stageHeight + ",";
			result += "fullScreen:" + stage.fullScreenWidth + "x" + stage.fullScreenHeight + "\n";
			result += "stage3Ds.length:" + stage.stage3Ds.length + ",";
			result += "stageVideos.length:" + stage.stageVideos.length + "\n";
			result += "loaderURL:" + stage.loaderInfo.loaderURL + "\n";
			result += "Capabilities.serverString:" + Capabilities.serverString + "\n";
			result += "Date:" + new Date().toString();
			return result;
		}
		
		
	}
	
}