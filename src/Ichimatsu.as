package  
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Ichimatsu extends Shape 
	{
		
		public function Ichimatsu(width:int, height:int) 
		{
			drawIchimatsu(width, height);
		}
		public function drawIchimatsu(width:int, height:int):void {
			if (width == this.width && height == this.height) {
				return;
			}
			
			var bitmapData:BitmapData = new BitmapData(20, 20, false);
			bitmapData.fillRect(new Rectangle(10, 0, 10, 10), 0xCCFFCC);
			bitmapData.fillRect(new Rectangle(0, 10, 10, 10), 0xCCFFCC);
			
			for (var i:int = 0; i < 400; i++) 
			{
				if((i+Math.floor(i / 20))%2==0){
					bitmapData.setPixel(i % 20, Math.floor(i / 20), 0xCCCCCC);
				}
			}
			
			this.graphics.clear();
			this.graphics.beginBitmapFill(bitmapData, new Matrix(100, 0, 0, 100));
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
			bitmapData = null;
		}
	}

}