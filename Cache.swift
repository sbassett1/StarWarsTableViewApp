//
//  Cache.swift
//  StarWarsIndexApp
//
//  Created by Mac on 9/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
import UIKit

class Cache{
    static var shared = Cache()
    var imageCache = NSCache<NSString,UIImage>()
}
