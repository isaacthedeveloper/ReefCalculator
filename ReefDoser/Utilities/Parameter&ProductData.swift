//
//  File.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-09-09.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import Foundation
import UIKit
// Alkalinity

let aquaForestKHPlus        = ProductName(name: "Aquaforest KH Plus",   productType: .liquid, productRatio: 0.660268,productCategory: .alkalinity)
let aquaForestKHBuffer      = ProductName(name: "Aquaforest KH Buffer", productType: .powder, productRatio: 0.89936, productCategory: .alkalinity)
let brightwellAlk           = ProductName(name: "Brightwell Alkaline 8.3", productType: .liquid, productRatio: 3.08, productCategory: .alkalinity)
let brightwellAlkP          = ProductName(name: "Brightwell Alkaline 8.3", productType: .powder, productRatio: 6.804, productCategory: .alkalinity)
let brightwellReefCodeB     = ProductName(name: "Brightwell ReefCode Part B", productType: .liquid, productRatio: 2.212, productCategory: .alkalinity)
let brightwellReefCodeBP    = ProductName(name: "Brightwell ReefCode Part B", productType: .powder, productRatio: 8.288, productCategory: .alkalinity)
let brightwellNanoCodeB     = ProductName(name: "Brightwell Nano Code B", productType: .liquid, productRatio: 1.670004, productCategory: .alkalinity)
let redseaReefFoundationB   = ProductName(name: "Red Sea Foundation B KH/Alkalinity", productType: .liquid, productRatio: 2.6627216, productCategory: .alkalinity)
let esvp1                   = ProductName(name: "ESV B-Ionic Part 1", productType: .liquid, productRatio: 2.24, productCategory: .alkalinity)
let redseaReefFoundationBP  = ProductName(name: "Red Sea Foundation B KH/Alkalinity", productType: .powder, productRatio: 8.875748, productCategory: .alkalinity)
let seachemReefBuffer       = ProductName(name: "SeaChem Reef Buffer", productType: .powder, productRatio: 0.14, productCategory: .alkalinity)
let seachemReefBuilder      = ProductName(name: "SeaChem Reef Builder", productType: .powder, productRatio: 1.493324, productCategory: .alkalinity)
let seachemReefCarb         = ProductName(name: "SeaChem Reef Carbonate", productType: .liquid, productRatio: 2.8, productCategory: .alkalinity)
let seachemReefFusion2      = ProductName(name: "SeaChem Fusion Part 2", productType: .liquid, productRatio: 3.276, productCategory: .alkalinity)
// Calcium
let aquaForestCAPlus        = ProductName(name: "Aquaforest Ca Plus", productType: .liquid, productRatio: 26.42, productCategory: .calcium)
let aquaForestCAP           = ProductName(name: "Aquaforest Calcium", productType: .powder, productRatio: 92.45, productCategory: .calcium)
let bwCalcionLiq            = ProductName(name: "Brightwell Calcion", productType: .liquid, productRatio: 40.0, productCategory: .calcium)
let bwCalcionPow            = ProductName(name: "Brightwell Calcion", productType: .powder, productRatio: 95.3968, productCategory: .calcium)
let bwReefCodeALiq          = ProductName(name: "Brightwell ReefCode Part A Calcium", productType: .liquid, productRatio: 16.0, productCategory: .calcium)
let bwReefCodeAPow          = ProductName(name: "Brightwell ReefCode Part A Calcium", productType: .powder, productRatio: 87.0, productCategory: .calcium)
let bwNanoCodeA             = ProductName(name: "Brightwell Nano Code A (Calcium)", productType: .liquid, productRatio: 11.9, productCategory: .calcium)
let esvp2                   = ProductName(name: "ESV B-Ionic Part 2", productType: .liquid, productRatio: 16, productCategory: .calcium)
let fpCalChlo               = ProductName(name: "Fritz ProAquatics Calcium Chloride", productType: .powder, productRatio: 95.3968, productCategory: .calcium)
let tlfCa                   = ProductName(name: "Two Little Fishies C-Balance Part A", productType: .liquid, productRatio: 10.0, productCategory: .calcium)
let esvbc2                  = ProductName(name: "ESV B-Ionic Bicarbonate Syst Pt 2", productType: .liquid, productRatio: 16.0, productCategory: .calcium)
let kentTurbo               = ProductName(name: "Kent TurboCalcium", productType: .powder, productRatio: 95.3968, productCategory: .calcium)
let kentTech                = ProductName(name: "Kent's Tech.CB Part A Calcium", productType: .liquid, productRatio: 14.7, productCategory: .calcium)
let redseaReefFoundationA   = ProductName(name: "Red Sea Foundation A Calcium+", productType: .liquid, productRatio: 52.831784, productCategory: .calcium)
let redseaReefFoundationAPow = ProductName(name: "Red Sea Foundation A Calcium+", productType: .powder, productRatio: 87.0, productCategory: .calcium)
let seachemReefAdv          = ProductName(name: "SeaChem Reef Adv Calcium", productType: .powder, productRatio: 0.019, productCategory: .calcium)
let seachemReefComp         = ProductName(name: "SeaChem Reef Complete", productType: .liquid, productRatio: 0.25, productCategory: .calcium)
let seachemReefFusion1L     = ProductName(name: "SeaChem Fusion Part 1 Calcium", productType: .liquid, productRatio: 26.42, productCategory: .calcium)
// Magnesium
let aquaforestMgP           = ProductName(name: "Aquaforest Magnesium", productType: .powder, productRatio: 30.86133, productCategory: .magnesium)
let bwMgLiq                 = ProductName(name: "Brightwell Aquatics Magnesion", productType: .liquid, productRatio: 26.0, productCategory: .magnesium)
let bwMgP                   = ProductName(name: "Brightwell Aquatics Magnesion-P", productType: .powder, productRatio: 64.0, productCategory: .magnesium)
let kentTechM               = ProductName(name: "Kent's Tech M (Liq) 18.4 ppm/ml/gal", productType: .liquid, productRatio: 18.4, productCategory: .magnesium)
let esvmg                   = ProductName(name: "ESV B-Ionic Magnesium (Liq)", productType: .liquid, productRatio: 10.0, productCategory: .magnesium)
let rsmgliq                 = ProductName(name: "Red Sea Foundation C Magnesium", productType: .liquid, productRatio: 26.415892, productCategory: .magnesium)
let rsmgpw                  = ProductName(name: "Red Sea Foundation C Magnesium", productType: .powder, productRatio: 35.397295	, productCategory: .magnesium)
// Phosphate
let brightwellPhosphate     = ProductName(name: "Brightwell Aquatics Phosphate-E", productType: .liquid, productRatio: 0.25, productCategory: .phosphate)
let redseaNoPox             = ProductName(name: "Red Sea NO3:PO4-X", productType: .liquid, productRatio: 0.08, productCategory: .phosphate)
let aquaforestPhosphateMinus = ProductName(name: "Aquaforest Phosphate Minus", productType: .liquid, productRatio: 3.7037, productCategory: .phosphate)
// Trace Elements
let afFluorine              = ProductName(name: "Aquaforest Fluorine", productType: .liquid, productRatio: 0.03703, productCategory: .trace)
let afIodium                = ProductName(name: "Aquaforest Iodium", productType: .liquid, productRatio: 0.03703, productCategory: .trace)
let afIron                  = ProductName(name: "Aquaforest Iron", productType: .liquid, productRatio: 0.03703, productCategory: .trace)
let afKilum                 = ProductName(name: "Aquaforest Kalium", productType: .liquid, productRatio: 0.03703, productCategory: .trace)
let afMicroE                = ProductName(name: "Aquaforest Micro-E", productType: .liquid, productRatio: 0.03703, productCategory: .trace)
let afnppro                 = ProductName(name: "Aquaforest NP Pro", productType: .liquid, productRatio: 0.03703, productCategory: .trace)
let afStrontium             = ProductName(name: "Aquaforest Strontium", productType: .liquid, productRatio: 0.03703, productCategory: .trace)




func parameterData() -> [Parameter] {
  return[
    Parameter(parameterName: "Alkalinity", parameterSymbol: "Kh",productName: [aquaForestKHPlus,aquaForestKHBuffer,brightwellAlk,brightwellAlkP,brightwellReefCodeB,brightwellReefCodeBP,brightwellNanoCodeB, esvp1,redseaReefFoundationB,redseaReefFoundationBP,seachemReefBuffer,seachemReefBuilder,seachemReefCarb,seachemReefFusion2]),
    Parameter(parameterName: "Calcium", parameterSymbol: "Ca",productName: [aquaForestCAPlus,aquaForestCAP,bwCalcionLiq,bwCalcionPow,bwReefCodeALiq,bwReefCodeAPow,bwNanoCodeA,fpCalChlo,tlfCa,esvbc2,esvp2,kentTurbo,kentTech,redseaReefFoundationA,redseaReefFoundationAPow,seachemReefAdv,seachemReefComp,seachemReefFusion1L]),
    Parameter(parameterName: "Magnesium", parameterSymbol: "Mg",productName: [aquaforestMgP,bwMgLiq,bwMgP,kentTechM,esvmg,rsmgliq,rsmgpw]),
    Parameter(parameterName: "Phosphate", parameterSymbol: "PO3",productName: [brightwellPhosphate, redseaNoPox, aquaforestPhosphateMinus]),
    Parameter(parameterName: "Trace Elements", parameterSymbol: "Te",productName: [afFluorine, afIodium, afIron, afKilum, afMicroE, afnppro, afStrontium])
  ]
}



