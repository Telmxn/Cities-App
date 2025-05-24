//
//  CityOnMapViewModel.swift
//  CitiesPractice
//
//  Created by Telman Yusifov on 23.05.25.
//

import Foundation

class CityOnMapViewModel {
    private let inputData: CityOnMapInputData
    
    init(inputData: CityOnMapInputData) {
        self.inputData = inputData
    }
    
    func fetchData() -> CityOnMapInputData {
        return inputData
    }
}
