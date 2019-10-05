//
//  UIView+Snapshot.swift
//  ReefDoser
//
//  Created by Isaac Ballas on 2019-10-03.
//  Copyright © 2019 Isaacballas. All rights reserved.
//

import UIKit

extension UIView {
    // render the view within the view bounds, then capture it as an img
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { (rendererContext) in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
