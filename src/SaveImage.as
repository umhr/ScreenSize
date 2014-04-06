package
{
	import com.adobe.images.PNGEncoder;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.ByteArray;


	public class SaveImage{
		public function SaveImage(){};
		/**
		 * PNG画像を書き出すためのメソッド
		 * @param displayObject
		 * @param is32BitColor//アルファチャンネル付きか否か
		 * 
		 */	
		public static function PNGfromDisplayObject(displayObject:DisplayObject,rect:Rectangle = null,is32BitColor:Boolean = true,fileName:String = "image.png"):void{
			if (!rect) {
				rect.width = displayObject.width;
				rect.height = displayObject.height;
			}
			var width:int = rect.width;
			var height:int = rect.height;
			var bitmapData:BitmapData = new BitmapData(width, height, is32BitColor, 0xFFFFFF);
			bitmapData.draw(displayObject);
			var byteArray:ByteArray = PNGEncoder.encode(bitmapData);
			var fileReference:FileReference = new FileReference();
			fileReference.save(byteArray, fileName);
		}

	}
}