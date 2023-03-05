//
//  ViewController.swift
//  project-1
//
//  Created by Евгения Зорич on 07.12.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var numberOfView = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                title = "Storm Viewer"
                navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
//        print(items)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        let userDefaults = UserDefaults.standard
        numberOfView = userDefaults.object(forKey: "ViewCount") as? [String: Int] ?? [String: Int]()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "\(pictures[indexPath.row]) - Views: \(numberOfView[pictures[indexPath.row], default: 0])" 
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Bad") as? DetailViewController {
    
            vc.selectedImage = pictures[indexPath.row]
            
            numberOfView[pictures[indexPath.row], default: 0] += 1
            let userDefaults = UserDefaults.standard
            userDefaults.set(numberOfView, forKey: "ViewCount")
            
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


