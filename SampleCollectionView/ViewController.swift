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
    //hsdvcbsjdfhvdjsfvnsjdfnvdskfv
//sfjvnskjfnvs
    
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var _collectionView: UICollectionView!
    var collectionView: UICollectionView?
    var dataValues: [String] = ["AC","-/+","%","/","7","8","9","*","4","5","6","-","1","2","3","+","0",".","="]
    var newValue: String?
    var characterArray:[Character] =  []

    var firstNumber: Int?
    var secondNumber: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    //find the operatar

    func doRespectiveOperation() {
        characterArray = newValue?.charactersArray ?? []
        var output : Int?
        for (_index, value) in characterArray.enumerated() {
            if value == "+"
            {
                commonFunction(index: _index)
                print("Add :\( doAdd(firstValue: firstNumber ?? 0, secondValue: secondNumber ?? 0))")
            }
            else if value == "-"
            {
                commonFunction(index: _index)
                print("Sub :\(doSubtract(firstValue: firstNumber ?? 0, secondValue: secondNumber ?? 0))")
            }
            else if value == "*"
            {
               commonFunction(index: _index)
               print("Muultiply :\(doMultiply(firstValue: firstNumber ?? 0, secondValue: secondNumber ?? 0))")
                
            }
            else if value == "/"
            {
                commonFunction(index: _index)
               print("Divide :\(doDivide(firstValue: firstNumber ?? 0, secondValue: secondNumber ?? 0))")
                
            }
            else if value == "%"
            {
                commonFunction(index: _index)
                print("Modulo :\(doModulo(firstValue: firstNumber ?? 0, secondValue: secondNumber ?? 0))")
                
            }
        }
        func doAdd(firstValue: Int , secondValue: Int ) -> Int {
           output = firstValue + secondValue
            return output ?? 0
          
        }
        func doSubtract(firstValue: Int , secondValue: Int ) -> Int {
            
          output = firstValue - secondValue
            return output ?? 0
            
        }
        func doDivide(firstValue: Int , secondValue: Int ) -> Int {
            output = firstValue / secondValue
            return output ?? 0
        }
        func doMultiply(firstValue: Int , secondValue: Int ) -> Int {
           output = firstValue * secondValue
            return output ?? 0
        }
        func doModulo(firstValue: Int , secondValue: Int ) -> Int {
            
            output =  firstValue % secondValue
            return output ?? 0
        }
    }
    
    func commonFunction(index: Int) {
        print(characterArray[index])
        firstNumber = getNumber(startIndex: 0, endIndex: index-1)
        secondNumber = getNumber(startIndex: index+1, endIndex: characterArray.count-1)
    }
    
    func getNumber(startIndex: Int , endIndex: Int) -> Int {
        var number : String?
        for i in startIndex...endIndex {
            number = (number ?? "") + String(characterArray[i])
            
        }
        print("number:\(number)")
        return Int(number ?? "") ?? 0
    }
    
    func clearAll() {
        label2.text = ""
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataValues.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.numbersLabel.text = self.dataValues[indexPath.row]
                
        if(indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 11 || indexPath.row == 15 || indexPath.row == 18) {
            cell.numbersLabel.backgroundColor = .systemOrange
        }
        else if(indexPath.row < 3) {
            cell.numbersLabel.backgroundColor = .darkGray
        }
        else {
            cell.numbersLabel.backgroundColor = .lightGray
        }
        return cell
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0)
        + (flowayout?.sectionInset.left ?? 0.0)
        + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (_collectionView.frame.size.width  - space) / 4.0
        
        if(indexPath.row == 16) {
            return CGSize(width: size + 99, height: size)
        }
        else {
            return CGSize(width: size+1, height: size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        newValue = label2.text
        if let _newValue = newValue, dataValues[indexPath.row] != "=" {
            newValue = _newValue + self.dataValues[indexPath.row]
        }
        label2.text = newValue
        
        if dataValues[indexPath.row] == "=" {
            doRespectiveOperation()
        } else if dataValues[indexPath.row] == "AC" {
                clearAll()
        }

    }
    
//verticalspacing for the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        return 1
    }
    
    //horizontal space for the cells
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


//func XXX{
//    firstnuumberr=
//    seccconod
//    output=
//
//}
