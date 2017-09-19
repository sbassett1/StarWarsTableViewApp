//
//  Networking.swift
//  StarWarsIndexApp
//
//  Created by Mac on 9/8/17.
//  Copyright © 2017 Mac. All rights reserved.
//
import Foundation
import UIKit

enum NetworkingErrors:Error{
    case UrlIsBad
    case NoDataOnUrl
    case DataHasNoImage
}
enum NetworkCallType{
    case apiUrl
    case individualCall
    case imageUrl
    case character
    case starship
    func getUrl()->String{
        switch self {
        case .apiUrl:
            return Constants.kApiUrl + "?page="
        case .individualCall:
            return Constants.kApiUrl
        case .imageUrl:
            return Constants.kImageUrl
        default:
            return "didnt get url in enum func!"
        }
    }
}

class Networking {
    static func callNetworkApi(type:NetworkCallType, objectName: String, closure:@escaping([String:Any],Error?) -> ()){
        switch type{
        case .apiUrl:
            callApi(url: type.getUrl() + objectName, completion: closure)
        default:
            return
        }
    }
    private static func callApi(url:String, completion:@escaping ([String:Any], Error?) -> ()) {
        print("first guard")
        guard let url = URL(string:url) else {
//            completion(nil, NetworkingErrors.UrlIsBad)
            return
        }
        print("pre session")
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {return}
            print("post task")
            guard let response = response as? HTTPURLResponse else {return}
            print("post response")
            guard response.statusCode == 200 else {
                print("200 fail \(response.statusCode)")
                return
            }
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                guard let dictionary = json as? [String:Any] else {return}
//                guard let results = dictionary["results"] as? [[String:Any]] else {return}
//                let hasNext = dictionary["next"] as? String
//                if hasNext != nil {
//                    callNetworkApi(type: .apiUrl, objectName: <#T##String#>, closure: <#T##([SWCharacter]?, Error?) -> ()#>)
//                }
//                let myCharacterArray = results.flatMap{
//                    SWCharacter(dict:$0)
//                }
//                print(myCharacterArray)
                completion(dictionary, error)
            } catch {
                print("something went wrong")
            }
        }
        task.resume()
    }
    static func callNetworkImage(type:NetworkCallType, objectName:String, closure:@escaping(Any?,Error?) -> ()){
        switch type {
        case .imageUrl:
            downloadImage(url: type.getUrl() + objectName + ".png", closure: closure)
            print("image downloaded success")
        default:
            return
        }
    }
    private static func downloadImage(url:String, closure:@escaping (UIImage?,Error?) -> ()){
        guard let url = URL(string:url) else {
            closure(nil, NetworkingErrors.UrlIsBad)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url){(data,response,error) in
            guard error == nil else {
                closure(nil, error)
                return
            }
            guard let response = response as? HTTPURLResponse else {return}
            guard response.statusCode == 200 else {
                print(response.statusCode)
                return
            }
            guard let data = data else {
                closure(nil, NetworkingErrors.NoDataOnUrl)
                return
            }
            print("data returned \(data)")
            guard let image = UIImage(data:data) else {
                closure(nil, NetworkingErrors.DataHasNoImage)
                return
            }
            print("image returned")
            closure(image, nil)
        }
        task.resume()
    }
    static func homeworldCall(url:String, completion:@escaping ([String:Any], Error?) -> ()) {
        print("first guard")
        guard let url = URL(string:url) else {
            //            completion(nil, NetworkingErrors.UrlIsBad)
            return
        }
        print("pre session")
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {return}
            print("post task")
            guard let response = response as? HTTPURLResponse else {return}
            print("post response")
            guard response.statusCode == 200 else {
                print("200 fail \(response.statusCode)")
                return
            }
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                guard let dictionary = json as? [String:Any] else {return}
                //                guard let results = dictionary["results"] as? [[String:Any]] else {return}
                //                let hasNext = dictionary["next"] as? String
                //                if hasNext != nil {
                //                    callNetworkApi(type: .apiUrl, objectName: <#T##String#>, closure: <#T##([SWCharacter]?, Error?) -> ()#>)
                //                }
                //                let myCharacterArray = results.flatMap{
                //                    SWCharacter(dict:$0)
                //                }
                //                print(myCharacterArray)
                completion(dictionary, error)
            } catch {
                print("something went wrong")
            }
        }
        task.resume()
    }
}
