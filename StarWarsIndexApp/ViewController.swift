//
//  ViewController.swift
//  learningTableViewController
//
//  Created by Mac on 8/31/17.
//  Copyright © 2017 Mac. All rights reserved.
//
import UIKit

class ViewController: UITableViewController {
    
    var myCharacterObjectArray = [SWCharacter]()
    var currentPage = "1"
    var characterSet = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        networkCall(currentPage: currentPage)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let endOfCells = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.height
        let didReachEnd:Bool = scrollView.contentOffset.y >= endOfCells
        let numberOfCells = myCharacterObjectArray.count
        
        if didReachEnd && numberOfCells <= 88 && !characterSet.contains(numberOfCells){
            characterSet.insert(numberOfCells)
            Networking.callNetworkApi(type: NetworkCallType.apiUrl, objectName: currentPage){ [unowned self] (dictionary, error) in
                guard let results = dictionary["results"] as? [[String: Any]] else { return }
                
                let myCharacterArray = results.compactMap{
                    SWCharacter(dict:$0)
                }
                
                DispatchQueue.main.async {
                    self.myCharacterObjectArray += myCharacterArray
                    self.currentPage = String((Int(self.currentPage) ?? 0) + 1)
                    self.tableView.reloadData()
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
    
    // MARK: Private Functions
    private func networkCall(currentPage:String) {
        
        Networking.callNetworkApi(type: NetworkCallType.apiUrl,
                                  objectName: currentPage) { [unowned self] (dictionary, error) in
                                    guard let results = dictionary["results"] as? [[String: Any]] else { return }
                                    
                                    let myCharacterArray = results.compactMap {
                                        SWCharacter(dict: $0)
                                    }
                                    
                                    DispatchQueue.main.async {
                                        self.currentPage = String((Int(self.currentPage) ?? 0) + 1)
                                        self.myCharacterObjectArray = myCharacterArray
                                        self.tableView.reloadData()
                                    }
        }
    }
}

// MARK: - Table view data source

extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myCharacterObjectArray.count
    }
    
    override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        
        let name = self.myCharacterObjectArray[indexPath.row].name
        let birthYear = self.myCharacterObjectArray[indexPath.row].birthYear
        
        cell.populateCell(name: name, birthYear: birthYear)
        return cell
    }
    
}
