//
//  ImageView.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func loadImageWithURLString(urlString: String, completion: @escaping () -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (imageData, resp, error) in
                completion()
                if error != nil || imageData == nil {
                    return
                }
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData!)
                }
            }.resume()
        }
    }
}
