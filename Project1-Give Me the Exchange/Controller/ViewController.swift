//
//  ViewController.swift
//  Project1-Give Me the Exchange
//
//  Created by suhail on 06/09/23.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet var vwTopItems: UIView!
    @IBOutlet var btnBaseCurrency: UIView!
    @IBOutlet var lblExchangeRate: UILabel!
    @IBOutlet var imgExchangeLogo: UIImageView!
    @IBOutlet var currencyPicker: UIPickerView!
  
    @IBOutlet var baseCurrencyLabel: UILabel!
    var baseCurrencySelected = "USD"{
        didSet{
            //currencySelected = exchangeManager.currencyArray[row]
            exchangeManager.fetchExchangeRate(for: "\(baseCurrencySelected)_\(currencySelected)")
        }
    }
    var currencySelected = "USD"
   
    var exchangeManager = ExchangeManager()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        giveBordersAndCorners()
        
        exchangeManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    
    @IBAction func changeBaseCurrencyTapped(_ sender: UIControl) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "popUp") as? PopUpViewController{
            
            vc.completion = { status in
                print("%%%%%")
                print(status)
                self.baseCurrencySelected = status
                self.baseCurrencyLabel.text = "1\(status)"
                
            }
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async(){ [weak self] in
                self?.navigationController?.present(vc, animated: true)
            }
       
        }
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
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
         currencySelected = exchangeManager.currencyArray[row]
         exchangeManager.fetchExchangeRate(for: "\(baseCurrencySelected)_\(currencySelected)")
     }

}
//user defined methods
extension ViewController{
    func giveBordersAndCorners(){
        vwTopItems.layer.cornerRadius = vwTopItems.frame.height/2
        vwTopItems.clipsToBounds = true
        vwTopItems.layer.borderColor = UIColor.white.cgColor
        vwTopItems.layer.borderWidth = 1
        
        imgExchangeLogo.layer.cornerRadius = imgExchangeLogo.frame.height/2
        imgExchangeLogo.clipsToBounds = true
        
        btnBaseCurrency.layer.borderColor = UIColor.white.cgColor
        btnBaseCurrency.layer.borderWidth = 1
        btnBaseCurrency.layer.cornerRadius = 12
        
        lblExchangeRate.layer.borderColor = UIColor.white.cgColor
        lblExchangeRate.layer.borderWidth = 1
        lblExchangeRate.layer.cornerRadius = lblExchangeRate.frame.height/2
        
        currencyPicker.layer.borderColor = UIColor.darkGray.cgColor
        currencyPicker.layer.borderWidth = 1
        currencyPicker.layer.cornerRadius = 12
    }
    
    
}
extension ViewController: ExchangeManagerDelegate{
    
    func updateUI(rate:String){
        
        DispatchQueue.main.async(){ [weak self] in
            self?.lblExchangeRate.text = "\(self!.currencySelected)   \(rate)"
        }
    }
    
    
}
