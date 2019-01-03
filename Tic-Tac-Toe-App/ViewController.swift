//
//  ViewController.swift
//  Tic-Tac-Toe-App
//
//  Created by Sasi on 12/16/18.
//  Copyright © 2018 Srinivasa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cellItems = [Int]()
    var possibleGroups: [[Int]] = [[0,1,2],[0,3,6],[3,4,5],[1,4,7],[6,7,8],[2,5,8],[0,4,8],[2,4,6]]
    var player_one = [Int]()
    var player_two = [Int]()
    
    var isSelectRed = false

    
    let columnLayout = ColumnLayout(
        cellsPerRow: 3,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    
    @IBOutlet weak var playerSwitch: UISwitch!
    

    
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    @IBAction func resetGame(_ sender: Any) {
        self.reset()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.cellItems = [0,1,2,3,4,5,6,7,8]
        //self.possibleGroups = [[0,1,2],[0,3,6],[3,4,5],[1,4,7],[6,7,8],[2,5,8],[0,4,8],[2,4,6]]
        definesPresentationContext = true
        collectionview.collectionViewLayout = columnLayout
        
        print(possibleGroups)

    }


    
    
    
    
    // MARK: - Winning logic
    func isWiningValidation(sourceArray: Array<Int>) -> Bool {
        var numberCount = 0
        var result = false
        
        
        for i in 0..<self.possibleGroups.count
        {
            numberCount = 0
            let newArray = self.possibleGroups[i]
            
            for j in 0..<3
            {
                let myset = sourceArray
                if myset.contains(newArray[j])
                {
                    numberCount += 1
                }
                
                if numberCount == 3
                {
                    result = true
                    break
                }
            }
            
            
        }
        return result
    }
    
    /*
     // MARK: - Winning logic
     func isWiningValidation(sourceArray: Array<Int>) -> Bool {
     var numberCount = 0
     var result = false
     
     for i in 0..<self.possibleGroups.count
     {
     numberCount = 0
     let subCount = possibleGroups[i].count
     let temp = sourceArray
     for j in 0..<subCount
     {
     
     let myset = Set(self.possibleGroups[i])
     let val: Int = temp[j]
     if myset.contains(val){
     numberCount += 1
     }
     debugPrint(numberCount)
     
     if numberCount == 3
     {
     result = true
     break
     }
     }
     if numberCount == 3 {
     break
     }
     }
     
     return result
     }
 */

    
    //Common Alert
    func ShowAlert(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            self.reset()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Reset the game

    //Reset the game
    func reset() {
        self.collectionview.reloadData()
        self.isSelectRed = false
        self.player_one = [Int]()
        self.player_two = [Int]()
        playerSwitch.setOn(false, animated: true)

    }
    
   

}

// MARK: - Collection view delegate & Datasource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TickViewCell", for: indexPath as IndexPath) as! TickViewCell
        
        cell.imageView.image = nil
        cell.backgroundColor = UIColor.lightGray
        cell.isUserInteractionEnabled = true

        return cell
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! TickViewCell
        
        
        if isSelectRed {
            //Player one
            cell.imageView.image = UIImage(named: "cross")
            isSelectRed = false
            player_one.append(indexPath.row)
            
            playerSwitch.setOn(false, animated: true)
            
            
            if player_one.count > 2 {
                if self.isWiningValidation(sourceArray: player_one)  {
                    self.ShowAlert(title: "Player #2 Win")
                    
                }
            }
            
        }else{
            cell.imageView.image = UIImage(named: "zero")
            isSelectRed = true
            player_two.append(indexPath.row)
            
            playerSwitch.setOn(true, animated: true)

            if player_two.count > 2 {
                if  self.isWiningValidation(sourceArray: player_two) {
                    self.ShowAlert(title: "Player #1 Win")
                }
            }
        }
        
        
        cell.isUserInteractionEnabled = false

        
        //Game Over Checking
        if  player_one.count + player_two.count == 9{
            self.reset()
            self.ShowAlert(title: "Game Over")
        }
        
    }
}





