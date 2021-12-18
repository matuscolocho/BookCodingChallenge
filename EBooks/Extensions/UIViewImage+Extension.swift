//
//  ImageCachew.swift
//  EBooks
//
//  Created by JoshuaMatus on 17/12/21.
//

import Foundation
import UIKit
extension UIImageView {
    
    func setImage(url: String?) {
        
        if url == nil {return}
        if url!.isEmpty{return}
        if let cachedImage = ImageCache.shared.object(forKey:(url! as NSString)) {
            self.image = cachedImage
            
            
        }else{
            URLSession.shared.dataTask( with: NSURL(string:url!)! as URL, completionHandler: {
                (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if let data = data {
                        
                        self.image = UIImage(data: data)
                    }
                }
            }).resume()
        }
        
        
    }
    
    
    
    
}

class ImageCache{
    private init() {}
    
    static let shared = NSCache<NSString, UIImage>()
}

