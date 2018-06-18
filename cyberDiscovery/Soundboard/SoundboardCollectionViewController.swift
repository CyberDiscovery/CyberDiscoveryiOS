//
//  CollectionViewController.swift
//  cyberDiscovery
//
//  Created by Joseph Bywater on 17/06/2018.
//  Copyright © 2018 Joseph Bywater. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import AVFoundation

private let reuseIdentifier = "SBCell"

class SoundboardCollectionViewController: UICollectionViewController {
    
    var ref:DatabaseReference!
    
    var player:AVPlayer?
    
    struct soundStruct {
        let link: String!
        let name: String!
    }
    
    var sounds: [String: [soundStruct]] = [:]
    var tabs = [String]()

    
    func loadSounds() {
        ref = Database.database().reference()
        
        ref.child("Soundboard").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let tabsValue = value?["Tabs"] as? NSDictionary
            let count = tabsValue?["count"] as! Int
            
            for i in 0..<count {
                let tabName = tabsValue?[String(i)] as? String ?? ""
                self.tabs.insert(tabName, at: 0)
                self.sounds[tabName] = [soundStruct]()
            }
            
            let soundsValue = value?["Sounds"] as? NSDictionary

            
            for tab in self.tabs {
                let currValue = soundsValue![tab] as? NSDictionary
                let count = currValue?["count"] as! Int
                
                
                for i in 0..<count {
                    let currValue = currValue![String(i)] as? NSDictionary
                    
                    let name = currValue?["name"] as? String ?? ""
                    let link = currValue?["link"] as? String ?? ""
                    
                    self.sounds[tab]?.append(soundStruct(link: link, name: name))
                }
            }
            
            //Reload collectionView
            self.collectionView?.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        self.collectionView?.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SBCell")
        
        loadSounds()
        
        view.isUserInteractionEnabled = true


    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        print("TAPPED")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (self.tabs.count)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (self.sounds[self.tabs[section]]?.count ?? 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SoundboardCollectionReusableView{
            sectionHeader.sectionHeaderlabel.text = "\(self.tabs[indexPath.section])"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SBCell",
                                                 for: indexPath) as! SoundboardCollectionViewCell
        
        //Change based on tab selected
        cell.name.text = sounds[tabs[indexPath.section]]![indexPath.row].name
        cell.audioUrl = sounds[tabs[indexPath.section]]![indexPath.row].link
        
    cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell

    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView?.indexPathForItem(at: location)
        
        if let index = indexPath {
            //get cell
            let cell = collectionView?.cellForItem(at: index) as! SoundboardCollectionViewCell
            //play audio
            let url = URL(string: cell.audioUrl)
            
            let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
            player = AVPlayer(playerItem: playerItem)
            player!.play()
            
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
