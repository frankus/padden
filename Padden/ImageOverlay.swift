//
//  ImageOverlay.swift
//  Padden
//
//  Created by Frank Schmitt on 2015-05-13.
//  Copyright (c) 2015 Frank Schmitt. All rights reserved.
//

import MapKit

class ImageOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D // The latitude/longitude corresponding to the center of the image
    var scale: CGFloat // The ratio of the MKMapRect.size to the image.size
    var rotation: CGFloat // The number of radians by which to rotate the image from horizontal
    var image: UIImage // The image to overaly onto the map
    
    var boundingMapRect: MKMapRect {
        get {
            // FIXME: this doesn't work right now
            let imageRect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.image.size)
            let transform = CGAffineTransformRotate(CGAffineTransformMakeScale(self.scale, self.scale), self.rotation)
            let transformedRect = CGRectApplyAffineTransform(imageRect, transform)
            let mapOrigin = MKMapPoint(x: Double(transformedRect.width / 2.0), y: Double(transformedRect.height / 2.0))
            let mapSize = MKMapSize(width: Double(transformedRect.width), height: Double(transformedRect.height))
            
            return MKMapRect(origin: MKMapPointForCoordinate(self.coordinate), size: mapSize)
        }
    }
    
    var mapSize: MKMapSize {
        get {
            return MKMapSize(width: Double(self.image.size.width * scale), height: Double(self.image.size.height * scale))
        }
    }
    
    init(coordinate: CLLocationCoordinate2D, scale: CGFloat, rotation: CGFloat, image: UIImage) {
        self.coordinate = coordinate
        self.scale = scale
        self.rotation = rotation
        self.image = image
        
        super.init()
    }
}