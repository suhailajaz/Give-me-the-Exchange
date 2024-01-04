//
//  ExchangeManager.swift
//  Project1-Give Me the Exchange
//
//  Created by suhail on 06/09/23.
//

import Foundation
protocol ExchangeManagerDelegate{
    func updateUI(rate:String)
}

struct ExchangeManager{
    var delegate: ExchangeManagerDelegate?
    
    let baseURL = "https://api.api-ninjas.com/v1/exchangerate"
            var currencyArray  = ["TTD", "SAR", "PLN", "SLL", "AZN", "NGN", "HKD", "NAD", "MWK", "DZD", "XAF", "BGN", "MVR", "ANG", "GTQ", "UZS", "RUB", "HNL", "AED", "EGP", "KYD", "HRK", "LBP", "YER", "THB", "TNA", "AFN", "PKR", "COP", "OMR", "BZD", "BOB", "SHP", "EUR", "MGA", "BMD", "ZMW", "AUD", "CNY", "NIO", "SGD", "GHS", "IDR", "HUF", "MZN", "GNF", "KES", "LRD", "BTN", "ZWL", "VES", "JPY", "STD", "TZS", "KZT", "PAB", "SRD", "NZD", "AMD", "PEN", "DKK", "USD", "SEK", "SVC", "CZK", "TND", "UAH", "TRY", "GMD", "GBP", "BIF", "SCR", "KMF", "DJF", "CHF", "MRO", "KRW", "LYD", "CRC", "SDG", "AWG", "PYG", "UGX", "RON", "ZAR", "RSD", "VND", "ERN", "BWP", "BRL", "MUR", "TWD", "UYU", "VEF", "TMT", "PHP", "ILS", "ARS", "NOK", "XPF", "CAD", "AOA", "BSD", "ETB", "ISK", "CDF", "MYR", "XOF", "CVE", "BHD", "SOS", "GYD", "TJS", "QAR", "BBD", "XCD", "KGS", "RWF", "SZL", "MXN", "LSL", "JMD", "INR", "CLP", "LKR", "KWD", "BDT", "MAD"].sorted()
   
    
    
    
    func fetchExchangeRate(for currency: String){
      
        let exchaneURLString = baseURL+"?pair=\(currency)"
        let headers = [ "X-Api-Key" : "EuKGp/7HW71i+6I5svCn6A==dKSCzLEFeSNlNPXp" ]
        
        
       // let bodyParameters: [String:String] = ["pair":"USD_INR"]
       // let jsonBodyParameters = try! JSONSerialization.data(withJSONObject: bodyParameters,options: .fragmentsAllowed)
        
        
        
        // making the URL
        if let url = URL(string: exchaneURLString){
            //making the request and attaching all the things
            var request = URLRequest(url: url)
           // request.httpBody = jsonBodyParameters
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
           
            
            //making a session
            let session = URLSession.shared
            
            //giving the session a data task
            let task = session.dataTask(with: request) { data, response, error in
           
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                if let data = data{
                  //  print(response)
                    
                    if let parsedData = self.parseJSON(data){
                        print("%%%%%%%%")
                        print(parsedData.currency_pair)
                        print(parsedData.exchange_rate)
                        let finalRAte = String(format: "%.3f", parsedData.exchange_rate)
                        delegate?.updateUI(rate: finalRAte)
                        
                    }
                }
            }
            task.resume()
            
            
        }
    }
    func parseJSON(_ unparsedData: Data)-> ExchangeModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ExchangeModel.self, from: unparsedData)
            return decodedData
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
}
