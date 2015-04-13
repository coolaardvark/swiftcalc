//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Mark Keightley on 12/04/2015.
//  Copyright (c) 2015 Hyperion Systems. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)";
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var operandStack = Array<Double>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        operandStack.append(displayValue)
        userIsInTheMiddleOfTypingANumber = false
        println("Operand stack = \(operandStack)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
        case "+": performBinaryOperation { $0 + $1 }
        case "−": performBinaryOperation { $1 - $0 }
        case "×": performBinaryOperation { $0 * $1 }
        case "÷": performBinaryOperation { $1 / $0 }
        case "√": performUniaryOperation { sqrt($0) }
        default: break
        }
    }
    
    func performBinaryOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    func performUniaryOperation(operation: Double -> Double ) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
}