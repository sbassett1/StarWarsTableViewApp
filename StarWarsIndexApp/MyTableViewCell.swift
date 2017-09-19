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
        self.cellName.text = name
        self.cellBirthYear.text = birthYear
        let name = (name.components(separatedBy: .whitespaces).joined() as NSString).replacingOccurrences(of: "é", with: "e") as NSString
        if let image = Cache.shared.imageCache.object(forKey: name){
            self.cellImage.image = image
        } else {
//            cellImage.image = 
            Networking.callNetworkImage(type: .imageUrl,objectName: name as String){
                [weak self, weak name](image, error) in
                guard error == nil else {return}
                
                guard let image = image as? UIImage else {return}
                Cache.shared.imageCache.setObject(image, forKey: name ?? "")
                DispatchQueue.main.async {
                    self?.cellImage.image = image
                }
            }
        }
    }
}

