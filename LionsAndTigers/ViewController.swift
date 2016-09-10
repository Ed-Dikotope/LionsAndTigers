//
//  ViewController.swift
//  LionsAndTigers
//
//  Created by Ed Dikotope on 2014/09/24.
//  Copyright (c) 2014 Morwamoche. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblBreed: UILabel!
    @IBOutlet weak var imgAnimalImage: UIImageView!
    
    var tigerList:[Tiger] = [];
    var animationsList:[UIViewAnimationOptions] = [];
    var currentTigerIndex:Int = 0;
    
    //playlist randomisation algorithm
    var showIndex:Int = 0;
    var playlistIndex:Int = 0;
    var playList:[Int] = [0,0,0,0];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //some Tigers
        let aTiger = Tiger(name: "Tigger",  age: 3, breed: "Bengal", image: UIImage(named: "BengalTiger.jpg")!);
        let bTiger = Tiger(name: "Hobbet",  age: 5, breed: "Indochinese",   image: UIImage(named: "IndochineseTiger.jpg")!);
        let cTiger = Tiger(name: "Lucy",    age: 7, breed: "Malayan",       image: UIImage(named: "MalayanTiger.jpg")!);
        let dTiger = Tiger(name: "Ranchi",  age: 2, breed: "Siberian",      image: UIImage(named: "SiberianTiger.jpg")!);
        
        tigerList.append(aTiger);
        tigerList.append(bTiger);
        tigerList.append(cTiger);
        tigerList.append(dTiger);
        
        //show the first Tiger
        print(aTiger);
        print("name:\(aTiger.name), age:\(aTiger.age), breed:\(aTiger.breed), image:\(aTiger.image)");
        
        lblName.text = aTiger.name;
        lblAge.text = "\(aTiger.age)";
        lblBreed.text = aTiger.breed;
        imgAnimalImage.image = aTiger.image;
        
        //some playlist initialisation
        showIndex = 1;
        playlistIndex = 1;
        playList[0] = playlistIndex;
        
        //add animations to the pot
        animationsList.append(UIViewAnimationOptions.TransitionCrossDissolve);
        animationsList.append(UIViewAnimationOptions.TransitionCurlDown);
        animationsList.append(UIViewAnimationOptions.TransitionFlipFromLeft);
        animationsList.append(UIViewAnimationOptions.TransitionFlipFromTop);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNextRandom(seed: Int, currentIndex: Int) ->Int{
        var randomNumber: Int;
        repeat
        {
            randomNumber = Int(arc4random_uniform(UInt32(seed)));
            
        }while randomNumber == currentIndex;
        
        return randomNumber;
    }
    
    @IBAction func btnPressedNext(sender: UIBarButtonItem) {
        
        var randomTiger = Tiger();
        var canShow = false;
        
        repeat{
            let randomNumber: Int = self.getNextRandom(tigerList.count, currentIndex: currentTigerIndex);
            currentTigerIndex = randomNumber;
            
            if playList[currentTigerIndex] < playlistIndex {
                
                //show the tiger
                randomTiger = tigerList[currentTigerIndex];
                canShow = true;
                
                showIndex += 1;
                playList[currentTigerIndex] += 1;
                
                print("First time we show this tiger in this playlist (\(playlistIndex))");
                print("Name: \(randomTiger.name),  Index: \(currentTigerIndex), ShowIndex: \(showIndex), PlaylistIndex: \(playlistIndex)");
                print("Current Playlist: [\(playList[0])], [\(playList[1])], [\(playList[2])], [\(playList[3])]");
   
            }
            else {
                
                if showIndex < playList.count {
                    //randomise
                    print("We have shown them all in this drill (\(playlistIndex))");
                }
                else {
                    //reset and update the playlist count
                    //the only issue now is that the tiger last shown can be shown first again by the randomiser ;)
                    print("Resetting the showindex and updating the playlist run");
                    showIndex = 1;
                    playlistIndex += 1;
                    //randomise
                }
                
                canShow = false;
            }

        }while canShow == false;
        
        //let randomTiger = tigerList[curentTigerIndex];
        
        UIView.transitionWithView(view, duration: 2, options: animationsList[currentTigerIndex],
            animations: {
            
                self.lblName.text = randomTiger.name;
                self.lblAge.text = "\(randomTiger.age)";
                self.lblBreed.text = randomTiger.breed;
                self.imgAnimalImage.image = randomTiger.image;
                print(randomTiger.chuff());
            
            },
            completion: { (finished: Bool) -> () in
        
        });
        
    }
}

