//
//  PopUpViewController.swift
//  Project1-Give Me the Exchange
//
//  Created by suhail on 06/09/23.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var vwCenterPopUp: UIView!
    @IBOutlet var pickerPopUp: UIPickerView!
    
    var completion : ((String) -> ())?
    var selectedRow = 0
    var exchangeManager = ExchangeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwCenterPopUp.layer.borderColor = UIColor.yellow.cgColor
        vwCenterPopUp.clipsToBounds = true
        vwCenterPopUp.layer.borderWidth = 1
        vwCenterPopUp.layer.cornerRadius = 12
        
        pickerPopUp.dataSource = self
        pickerPopUp.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presentationController?.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.presentationController?.containerView?.backgroundColor = UIColor.clear
    }
    
    @IBAction func OkTapped(_ sender: Any) {
        self.dismiss(animated: true){
            self.completion?(self.exchangeManager.currencyArray[self.selectedRow])
        }
    }
    
}


extension PopUpViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return exchangeManager.currencyArray.count
    }
    
    // ------deledate methods---------
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
        return exchangeManager.currencyArray[row]
        
     }
    
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       selectedRow = row
       // self.completion?(self.exchangeManager.currencyArray[row])
     }

}
 
