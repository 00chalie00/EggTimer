//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var likeEgg: UILabel!
    @IBOutlet weak var softEgg: UIButton!
    @IBOutlet weak var mediumEgg: UIButton!
    @IBOutlet weak var hardEgg: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var softImg: UIImageView!
    @IBOutlet weak var medImg: UIImageView!
    @IBOutlet weak var hardImg: UIImageView!
    
    
    var hardnessDic = ["Soft": 3, "Medium": 5, "Hard": 7]
    var currentTime: Int = 0
    var pastTime: Int = 0
    var currentEggTitle: String = ""
    var timer = Timer()
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    // 1) Only Active the selected button (other button was deactive)
    // 2) processbar is dosplayed while a processing
    // 3) likeEgg Label will be marked done when processbar is completed
    @IBAction func hardnessSelected(_ sender: UIButton) {
       
        let selectedEgg = sender.titleLabel?.text
        print(selectedEgg!)
        setEgg(eggTitle: selectedEgg!)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setEggTime), userInfo: nil, repeats: true)
    }
    
    func setEgg(eggTitle: String) {
        currentEggTitle = eggTitle
        let eggTime = hardnessDic[currentEggTitle]
        currentTime = eggTime!
        
        if currentEggTitle == "Soft" {
            softEgg.isEnabled = true
            softImg.alpha = 1.0
            medImg.alpha = 0.5
            hardImg.alpha = 0.5
            mediumEgg.setTitle("", for: .disabled)
            hardEgg.setTitle("", for: .disabled)
            mediumEgg.isEnabled = false
            hardEgg.isEnabled = false
            
        } else if currentEggTitle == "Medium" {
            mediumEgg.isEnabled = true
            medImg.alpha = 1.0
            softImg.alpha = 0.5
            hardImg.alpha = 0.5
            softEgg.setTitle("", for: .disabled)
            hardEgg.setTitle("", for: .disabled)
            softEgg.isEnabled = false
            hardEgg.isEnabled = false
            
        } else {
            hardEgg.isEnabled = true
            hardImg.alpha = 1.0
            softImg.alpha = 0.5
            medImg.alpha = 0.5
            softEgg.setTitle("", for: .disabled)
            mediumEgg.setTitle("", for: .disabled)
            softEgg.isEnabled = false
            mediumEgg.isEnabled = false
        }
    }
    
    
    @objc func setEggTime() {
        pastTime = pastTime + 1
        if currentTime > pastTime {
            progressBar.progress = Float(pastTime) / Float(currentTime)
            print("\(Float(pastTime) / Float(currentTime))")
        } else if currentTime == pastTime {
            likeEgg.text = "Done"
            progressBar.progress = Float(pastTime) / Float(currentTime)
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            do {
                player = try AVAudioPlayer(contentsOf: url!)
                player.play()
            } catch {
                print("Fail player")
            }
            
            print("\(Float(pastTime) / Float(currentTime))")
            
            let alert = UIAlertController(title: "Restart?", message: "Do you want to restart?", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.initEggConfigue()
            }
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func initEggConfigue() {
        self.softEgg.setTitle("Soft", for: .normal)
        self.softImg.alpha = 1.0
        self.mediumEgg.setTitle("Medium", for: .normal)
        self.medImg.alpha = 1.0
        self.hardEgg.setTitle("Hard", for: .normal)
        self.hardImg.alpha = 1.0
        
        self.softEgg.isEnabled = true
        self.mediumEgg.isEnabled = true
        self.hardEgg.isEnabled = true
        
        self.currentTime = 0
        self.pastTime = 0
        self.currentEggTitle = ""
        
        self.progressBar.progress = 0.0
        self.likeEgg.text = "How do you like your eggs? "
        
        timer.invalidate()
    }
    
    
}//End Of The Class0
