//
//  ViewController.swift
//  SampleCollectionView
//
//  Created by Fiuser on 27/12/22.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var numbersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var _collectionView: UICollectionView!
    //    var collectionView: UICollectionView?
    var dataValues: [String] = ["AC","-/+","%","/","7","8","9","*","4","5","6","-","1","2","3","+","0",".","="]
    var newValue: String = ""
    //var newValue: Double = 0.0
    var characterArray:[Character] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataValues.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    //Adding background color for the label first row is darkgrey,last column is systemorange,remaining all the cells are lightgrey
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.numbersLabel.text = self.dataValues[indexPath.row]
        if(indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 15 || indexPath.row == 18) {
            cell.numbersLabel.backgroundColor = .systemOrange
        }else if(indexPath.row < 3) {
            cell.numbersLabel.backgroundColor = .darkGray
        }else {
            cell.numbersLabel.backgroundColor = .gray
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = flowayout?.minimumInteritemSpacing ?? 0.0
        let size:CGFloat = (_collectionView.frame.size.width - space) / 4.0
        
        let cellHeight:CGFloat = 100
        //the size of 0th cell is higher than all the other cell
        if(dataValues[indexPath.row] == "0") {
            return CGSize(width: size+size+1, height: cellHeight)
        } else {
            return CGSize(width: size, height: cellHeight)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        //      newValue = label2.text ?? ""
        if dataValues[indexPath.row] != "=" {
            newValue = newValue + self.dataValues[indexPath.row]
        }
        label2.text = newValue
        if dataValues[indexPath.row] == "=" {
            doRespectiveOperation()
        }
                else if dataValues[indexPath.row] == "AC" {
            clearAll()
        }
    }
    

    
//
//    {
//        newValue = label2.text ?? ""
//        if let _newValue = newValue, dataValues[indexPath.row] != "=" {
//            if (dataValues[indexPath.row] == "." && !newValue.contains(".")) {
//                newValue = _newValue + self.dataValues[indexPath.row]
//            } else if (dataValues[indexPath.row] != ".") {
//                newValue = _newValue + self.dataValues[indexPath.row]
//            }
//        }
//        label2.text = newValue
//        if dataValues[indexPath.row] == "=" {
//            doRespectiveOperation()
//        } else if dataValues[indexPath.row] == "AC" {
//            //clearLabel()
//        }
//    }
    
    
    
    
    
    
    //verticalspacing for the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //horizontalspacing for the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
public extension String {
    /// SwifterSwift: Array of characters of a string.
    var charactersArray: [Character] {
        return Array(self)
    }
}

extension ViewController {
    
    enum Operation: String {
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case modulo = "%"
    }
    
    func doRespectiveOperation() {
        //chaange         characterArray = newValue.charactersArray

        characterArray = newValue.charactersArray
//        label2.text = "\(result)"
//           clearLabel()
        
        for (_index, value) in characterArray.enumerated() {
            if let operation = Operation(rawValue: String(value)) {
                switch operation {
                case .add:
                    doAdd(_index: _index)
                case .subtract:
                    doSubtract(_index: _index)
                case .multiply:
                    doMultiply(_index: _index)
                case .divide:
                    doDivide(_index: _index)
                case .modulo:
                    doModulo(_index: _index)
                }
            }
        }
        
        //perfoms addition  operation
        func doAdd(_index: Int) {
            let operands = getOperands(index: _index)
            let result:Double = Double(operands.firstNumber + operands.secondNumber)
            label2.text = newValue  + "\n" + String(result)
            newValue = ""
        }
        
        //perfoms subraction  operation
        func doSubtract(_index: Int) {
            let operands = getOperands(index: _index)
            let result:Double =  Double(operands.firstNumber - operands.secondNumber)
            label2.text =  newValue  + "\n" + String(result)
            newValue = ""
            
        }
        
        //perfoms division ooperation
        func doDivide(_index: Int)  {
             let operands = getOperands(index: _index)
             let result:Double =  Double(operands.firstNumber / operands.secondNumber)
             label2.text = newValue + "\n" + String(result)
            newValue = ""
            
        }
        
        //perfoms multiply  operation
        func doMultiply(_index: Int) {
            let operands = getOperands(index: _index)
            let result:Double = Double(operands.firstNumber * operands.secondNumber)
            label2.text =  newValue  + "\n" + String(result)
            newValue = ""
            
        }
        
        //perfoms modulo  operation
        func doModulo(_index: Int) {
            let operands = getOperands(index: _index)
            let result:Double = Double(operands.firstNumber.truncatingRemainder(dividingBy: operands.secondNumber))
            label2.text =  newValue   + "\n" + String(result)
            newValue = ""
            
        }
    }
    
    func getOperands(index: Int) -> (firstNumber: Double, secondNumber: Double){
        let _firstNumber = getNumberFromString(startIndex: 0, endIndex: index-1)
        let _secondNumber = getNumberFromString(startIndex: index+1, endIndex: characterArray.count-1)
        return (_firstNumber, _secondNumber )
    }
    
    func getNumberFromString(startIndex: Int, endIndex: Int) -> Double {
        var number: String?
        for i in startIndex...endIndex {
            number = (number ?? "") + String(characterArray[i])
        }
        return Double(number ?? "") ?? 0.0
    }
    
    func clearAll() {
        label2.text = " "
        newValue = ""
    }
}





