//
//  ViewController.swift
//  learningTableViewController
//
//  Created by Mac on 8/31/17.
//  Copyright © 2017 Mac. All rights reserved.
//
import UIKit

class ViewController: UITableViewController {
    var myCharacterObjectArray:[SWCharacter] = []
    var currentPage:String = "1"
    var characterSet = Set<Int>()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        networkCall(currentPage: currentPage)
    }
    func networkCall(currentPage:String){
        Networking.callNetworkApi(type: NetworkCallType.apiUrl, objectName: currentPage){
            [unowned self](dictionary, error) in
            guard let results = dictionary["results"] as? [[String:Any]] else {return}
            let myCharacterArray = results.flatMap{
                SWCharacter(dict:$0)
            }
            DispatchQueue.main.async {
                self.currentPage = String((Int(self.currentPage) ?? 0) + 1)
                self.myCharacterObjectArray = myCharacterArray
                print(self.myCharacterObjectArray.count)
                self.tableView.reloadData()
            }
        }
    }
    //    func callAgain(){
    //        Networking.callNetworkApi(type: NetworkCallType.apiUrl, objectName: currentPage){
    //            [unowned self](dictionary, error) in
    //            guard let results = dictionary["results"] as? [[String:Any]] else {return}
    //            _ = results.flatMap{
    //                self.myCharacterObjectArray.append(SWCharacter(dict:$0)!)
    //            }
    //            let updatedPage = String((Int(self.currentPage) ?? 0) + 1)
    //            self.networkCall(currentPage: updatedPage)
    //        }
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.myCharacterObjectArray.count)
        return self.myCharacterObjectArray.count
    }
    override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyTableViewCell else {fatalError("bad cell")}
        let name = self.myCharacterObjectArray[indexPath.row].name
        let birthYear = self.myCharacterObjectArray[indexPath.row].birthYear
        print("this is in cell", self.myCharacterObjectArray.count)
        cell.populateCell(name: name, birthYear: birthYear)
        return cell
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let endOfCells = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.height
        let didReachEnd:Bool = scrollView.contentOffset.y >= endOfCells
        let numberOfCells = myCharacterObjectArray.count
        print(didReachEnd)
        activityIndicator.startAnimating()
        if didReachEnd && numberOfCells <= 88 && !characterSet.contains(numberOfCells){
            characterSet.insert(numberOfCells)
            Networking.callNetworkApi(type: NetworkCallType.apiUrl, objectName: currentPage){
                [unowned self](dictionary, error) in
                guard let results = dictionary["results"] as? [[String:Any]] else {return}
                let myCharacterArray = results.flatMap{
                    SWCharacter(dict:$0)
                }
                print("\ninside more cells")
                print(myCharacterArray.map{$0.name})
//                let hasNext = dictionary["next"] as? String
                DispatchQueue.main.async {
                    self.myCharacterObjectArray += myCharacterArray
                    self.currentPage = String((Int(self.currentPage) ?? 0) + 1)
                    print("\n\n\ncurent page -> -> \(self.currentPage)")
//                    if hasNext != nil {
//                        let updatedPage = String((Int(self.currentPage) ?? 0) + 1)
//                        self.networkCall(currentPage: updatedPage)
//                    }
//                    if numberOfCells == 87{
//                        self.myCharacterObjectArray.append(contentsOf: myCharacterArray[0...87])
//                    } else {
//                        self.myCharacterObjectArray.append(contentsOf: myCharacterArray)
//
//                    }
//                    self.myCharacterObjectArray = swArray ?? []
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail") {
            if let detailViewController = segue.destination as? DetailViewController {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    detailViewController.details = self.myCharacterObjectArray[indexPath.row]
                }
            }
        }
    }
}

