//
//  String+Extension.swift
//  MovieDB
//
//  Created by Bhargavi on 27/04/22.
//

import Foundation

extension String {
    
    static func replaceHttpToHttps(with urlString: String) -> String? {
        // split into array
        let separateCriteria = "://"
        var parts = urlString.components(separatedBy: separateCriteria)
        // do checking and join
        for (index, part) in parts.enumerated() {
            print("\(index) : \(part)")
        }
        parts[0] = "https"
        guard let firstpart = parts.first, let lastPart = parts.last else {
            print("AFString+Extension: replaceHttpToHttps: failed")
            return nil
        }
        let finalString = firstpart + separateCriteria + lastPart
        return finalString
    }
    
}
