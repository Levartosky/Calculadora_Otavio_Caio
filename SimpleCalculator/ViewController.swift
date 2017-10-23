//
//  ViewController.swift
//  CalculadoraMackenzie
//
//  Created by Caio Marfil on 09/17/17.
//  Copyright © 2017 Caio Marfil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Operations: String{
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case None = ""
    }
    
    
    var lastNumber: Double = 0
    var lastOperation: Operations = Operations.None
    var operationActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func numberPressed(_ num: UIButton!){
        
        var currentNumbers = outputLabel.text!
        
        
        var pressedNumber = num.titleLabel!.text!
        
        
        if Double(currentNumbers) == 0 && !currentNumbers.contains("."){
            currentNumbers = ""
            
            
            if Double(pressedNumber) == 0{
                pressedNumber = "0"
            }
        }
        
        
        if operationActive{
            currentNumbers = ""
        }
        
        
        if pressedNumber == "." && currentNumbers.contains("."){
            pressedNumber = ""
        }
        
        
        outputLabel.text = "\(currentNumbers)\(pressedNumber)"
        
        
        operationActive = false
    }
    
    @IBAction func operatorPressed(_ op: UIButton!){
        
        let opPressed = op.tag
        
        switch opPressed{
        case 0:
            performOperation(Operations.Add)
        case 1:
            performOperation(Operations.Subtract)
        case 2:
            performOperation(Operations.Divide)
        case 3:
            performOperation(Operations.Multiply)
        default:
            print("No Operations")
        }
        
    }
    
    @IBAction func equalsPressed(_ btn: UIButton!){
        
        performOperation(Operations.None)
    }
    
    
    @IBAction func clearPressed(_ btn: UIButton!){
        outputLabel.text =  "0"
        lastNumber = 0
        lastOperation = Operations.None
    }
    
    
    
    func performOperation(_ op: Operations){
        
        let currentNumber = Double(outputLabel.text!)!
        
        
        var result: Double = 0
        
        if lastNumber == 0 && lastOperation == Operations.None{
            lastNumber = currentNumber
            lastOperation = op
        }else if !operationActive{
            switch lastOperation{
            case Operations.Add:
                result = lastNumber + currentNumber
            case Operations.Subtract:
                result = lastNumber - currentNumber
            case Operations.Multiply:
                result = lastNumber * currentNumber
            case Operations.Divide:
                result = lastNumber / currentNumber
            case Operations.None:
                result = lastNumber
            }
            
            result = Double(round(10000000*result)/10000000)
            
            
            outputLabel.text = String(result)
            
            
            lastNumber = result
            
            
            lastOperation = op
        }else if operationActive{
            lastOperation = op
        }
        
        
        operationActive = true
    }
    
    
    
}

