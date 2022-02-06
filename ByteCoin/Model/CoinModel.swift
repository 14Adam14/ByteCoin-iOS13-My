//
//  CoinModel.swift
//  ByteCoin
//
//  Created by user213083 on 2/6/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation


struct CoinModel {
    let mainResultCurrency: Double
    let labelResultCurrency: String
    
    
    var resultCurrency: String {
        return String(format: "%.2f", mainResultCurrency)
    }
    
    
}
