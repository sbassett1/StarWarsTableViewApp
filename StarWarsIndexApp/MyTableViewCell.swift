//
//  TableViewCell.swift
//  StarWarsIndexApp
//
//  Created by Mac on 9/3/17.
//  Copyright © 2017 Mac. All rights reserved.
//
import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellBirthYear: UILabel!
    func populateCell(name:String,birthYear:String){
        print("got to pop image")
        self.cellName.text = name
        self.cellBirthYear.text = birthYear
        if let image = Cache.shared.imageCache.object(forKey: name.components(separatedBy: .whitespaces).joined() as NSString){
            self.cellImage.image = image
        } else {
//            cellImage.image = 
            Networking.callNetworkImage(type: .imageUrl,objectName: name.components(separatedBy: .whitespaces).joined()){
                [weak self](image, error) in
                guard error == nil else {return print("error image call")}
                
                guard let image = image as? UIImage else {return print("got image")}
                Cache.shared.imageCache.setObject(image, forKey: name.components(separatedBy: .whitespaces).joined() as NSString)
                DispatchQueue.main.async {
                    self?.cellImage.image = image
                }
            }
        }
    }
}

