
import Foundation



protocol CoinManagerDelegate {
    
    func didUpdateResult(_ coinManager: CoinManager, resultAll: CoinModel)
    func didFailWithError(error: Error)
     
        
    }





struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C9F24651-7B4A-4ED2-81CC-E36F061BB84A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    var delegate: CoinManagerDelegate?
    
    
    func getCoinPrice(for currency: String)  {
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
        
    }
    
    
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let resultAll = self.parseJSON(safeData) {
                        self.delegate?.didUpdateResult(self, resultAll: resultAll)
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
    

    
    func parseJSON (_ coinData: Data)  -> CoinModel? {
        
        let decoder = JSONDecoder()
        
        do {
         let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            let rate = decodedData.rate
    
            let asset_id_quote = decodedData.asset_id_quote
            
            let resultAll = CoinModel(mainResultCurrency: Double(rate), labelResultCurrency: asset_id_quote)
            return resultAll
        } catch {
            return nil
        }
    }
    
    
}















// https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=C9F24651-7B4A-4ED2-81CC-E36F061BB84A
