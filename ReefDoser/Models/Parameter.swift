//
//  Parameter.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-08-29.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import Foundation

struct Parameter{
    var parameterName:   String
    var parameterSymbol: String
    var productName:     [ProductName]
}

struct ProductName {
    var name:            String
    var productType:     ProductComposition
    var productRatio:    Double
    var productCategory: ProductType
}

enum ProductType: String {
    case alkalinity
    case calcium
    case magnesium
    case phosphate
    case trace = "Trace Elements"
}

enum ProductComposition: String {
    case liquid = "Liquid"
    case powder = "Powder"
}
