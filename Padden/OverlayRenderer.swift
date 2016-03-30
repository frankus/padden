//
//  OverlayRenderer.swift
//  Padden
//
//  Created by Frank Schmitt on 2015-05-12.
//  Copyright (c) 2015 Frank Schmitt. All rights reserved.
//

import MapKit

class OverlayRenderer: MKOverlayRenderer {
    override func drawMapRect(mapRect: MKMapRect, zoomScale: MKZoomScale, inContext context: CGContext) {
        if let overlay = self.overlay as? ImageOverlay {
            let imageRef = overlay.image.CGImage
            
            let mapRect = self.overlay.boundingMapRect
            let rect = self.rectForMapRect(mapRect)
            
            CGContextScaleCTM(context, 1.0, -1.0)
            CGContextTranslateCTM(context, 0.0, -rect.size.height)
            CGContextTranslateCTM(context, -rect.size.width / 2.0, rect.size.height / 2.0)
            
            CGContextDrawImage(context, rect, imageRef)
        }
    }
}
