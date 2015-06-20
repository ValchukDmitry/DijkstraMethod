package types;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author Awe66
 */
class Symbol extends Sprite
{
	var corX:Int=10;
	var corY:Int = 10;
	var operator:Bool;
	private var value:String;
	private var priority:Int;
	private var left:Bool;
	private var textField:TextField;
	
	public var FONT_SIZE:Int;
	public var FONT_COLOR:Int;
	
	private var symbolFormat:TextFormat;
	
	public function new(value:String, priority:Int, left:Bool) 
	{
		super();
		this.value = value;
		this.priority = priority;
		this.left = left;
		operator = (priority >= 0);
		FONT_SIZE = 100;
		FONT_COLOR = 0x000000;
		
		
	}
	
	public function createTextView() 
	{
		textField = new TextField();
		symbolFormat =  new TextFormat("Times New Roman", FONT_SIZE, FONT_COLOR, true);
		textField.defaultTextFormat = symbolFormat;
		textField.width = 100;
		textField.height = 100;
		textField.text = value;
		textField.x = corX;
		textField.y = corY;
		textField.selectable = false;
		this.addChild(textField);
		textField.visible = false;
	}
	
	public function showTextView()
	{
		textField.visible = true;
	}
	
	public function dontShowTextView()
	{
		textField.visible = false;
	}
	
	public function changeCoor(newX:Int, newY:Int)
	{
		this.corX = newX;
		this.corY = newY;
		textField.x = newX;
		textField.y = newY;
	}
	
	public function isOperator():Bool
	{
		return operator;
	}
	
	public function getValue():String
	{
		return value;
	}
	
	public function getPriority():Int {
		return priority;
	}
	
	public function isLeft():Bool {
		return left;
	}

	
}