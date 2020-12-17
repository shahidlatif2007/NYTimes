//
//  Label.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import UIKit

extension UILabel {
    static func imageWithText(image: UIImage, text:String) -> NSAttributedString {
        let textAttachment = NSTextAttachment(image: image)
        let attachmentString = NSAttributedString(attachment: textAttachment)
        
        let attributedString = NSMutableAttributedString(attributedString: attachmentString)
        attributedString.append(NSAttributedString(string: " " + text))
        return attributedString
    }
}
