package  
{
	import flash.display.Sprite;
	import utils.CSVParser;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Test extends Sprite
	{
		
		public function Test() 
		{
			var csvdata:String = "id(key)(int),name(string),phone(string)\r\n" +
								"0,jim,18600039143\r\n" +
								"1,alex,1234567\r\n" +
								"2,albert,688323\r\n" +
								"3,gino,984343\r\n" +
								"4,hunk,677676" 
								;
			var parser:CSVParser = new CSVParser(csvdata);
			
			trace("line data of id == 1");
			traceobj(parser.getDataLine(1));
			trace()
			trace("name of id==2");
			trace(parser.getData(2,"name"));
			trace()
			trace("line data of phone == 984343");
			traceobj(parser.searchDataLine("phone",984343));
			trace()
			trace("id of name==hunk");
			trace(parser.searchData("name","hunk","id"));
		}
		
		private function traceobj(obj:Object):void {
			for (var str:* in obj) {
				trace(str,obj[str])
			}
		}
	}

}