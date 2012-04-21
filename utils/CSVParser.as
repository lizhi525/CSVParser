package utils 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class CSVParser 
	{
		public var data:Array = [];
		public var keyData:Array = [];
		public function CSVParser(str:String,tab:String=",",enter:String="\r\n") 
		{
			var temp:Array = str.split(enter);
			var headers:Array = (temp[0] as String).split(tab);
			var pkey:RegExp =/\(key\)/;
			var types:Array = [[/\(int\)/,int],[/\(string\)/,String]];
			var vheaders:Array = [];
			for each(var hstr:String in headers) {
				var header:Header = new Header;
				
				for each(var type:Array in types) {
					var p:RegExp = type[0];
					var tclass:Class = type[1];
					var obj:Object = p.exec(hstr);
					if (obj) {
						hstr = hstr.replace(p, "");
						header.type = tclass;
						break;
					}
				}
				
				if (header.type == null) header.type = String;
				
				obj = pkey.exec(hstr);
				if (obj) {
					hstr = hstr.replace(pkey, "");
					header.iskey = true;
				}
				header.name = hstr;
				vheaders.push(header);
			}
			
			for (var i:int = 1; i < temp.length; i++ ) {
				if (temp[i] == "") continue;
				var datas:Array = (temp[i] as String).split(tab);
				var vdataArr:Array = [];
				data.push(vdataArr);
				for (var j:int = 0; j < vheaders.length;j++ ) {
					header = vheaders[j];
					var datastr:String = datas[j];
					var vdata:* = header.type(datastr);
					vdataArr[header.name] = vdata;
					if (header.iskey) keyData[vdata] = vdataArr;
				}
			}
		}
		
		public function getDataLine(id:*):Array {
			return keyData[id];
		}
		
		public function getData(id:*, name:String):*{
			if(getDataLine(id))
			return getDataLine(id)[name];
		}
		
		public function searchDataLine(key:String,value:*):Array {
			for each(var arr:Array in data) {
				if (arr[key] == value) return arr;
			}
			return null;
		}
		
		public function searchData(key:String,value:*,retKey:String):* {
			var arr:Array = searchDataLine(key, value);
			if (arr) return  arr[retKey];
			return null;
		}
		
	}

}
class Header {
	public var type:Class;
	public var name:String;
	public var iskey:Boolean;
}