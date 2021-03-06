package parseLogic;

import haxe.CallStack;
import haxe.ds.GenericStack;
import types.Symbol;
import src.graphic.Writer;
/**
 * ...
 * @author Awe66
 */
class ParseAlgo
{
	private var mainStack:GenericStack<Symbol>;
	private var writer:Writer;
	private var stackLength:Int;
	public function new(writer:Writer) 
	{
		mainStack = new GenericStack<Symbol>();
		this.writer = writer;
	}
	
	public function nextStep(symbol:Symbol) 
	{
		addToStack(symbol);
	}
	
	private function addToStack(newOperator:Symbol)
	{		
		if (!newOperator.isOperator()) {
			writer.addToOutput(newOperator);
			stackLength++;
			return;
		}
		
		var headOperator:Symbol;
		headOperator = mainStack.first();
		
		if (newOperator.getValue() == ")") {
			while (!mainStack.isEmpty() && headOperator.getValue() != "(") {
				writer.addToOutput(mainStack.pop());
				stackLength--;
				headOperator = mainStack.first();
			}
			newOperator.dontShowTextView();
			headOperator.dontShowTextView();
			stackLength--;
			mainStack.pop();
			return;
		}
		
		while (!mainStack.isEmpty() && ((headOperator.isLeft() && (headOperator.getPriority() <= newOperator.getPriority())) 
				|| (!headOperator.isLeft() && (headOperator.getPriority() > newOperator.getPriority()))) 
				&& newOperator.getValue()!=")")
		{
			writer.addToOutput(mainStack.pop());
			stackLength--;
			headOperator = mainStack.first();
		}
		mainStack.add(newOperator);
		stackLength++;
		writer.addToStack(newOperator, stackLength);
	}
	
	public function end()
	{
		var bufElement:Symbol;
		while (!mainStack.isEmpty())
		{
			bufElement = mainStack.pop();
			if (!(bufElement== null))
			{
				writer.addToOutput(bufElement);
			} else {
				break;
			}
		}
		writer.endFirstPart();
	}
	
}