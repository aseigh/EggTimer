//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
//  Updated by Ariana Seigh on 03/05/2025.
//
//  Enhancements:
//  1) Alarm sound when "Done!" is printed
//  2) Change header to display "One second left!"
//  3) Change progress bar color at one second
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Single dictionary as a constant for egg times
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    // Add in audio for timer
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
                
        timer.invalidate()
        
        // Adding ! makes integers not optional anymore
        let hardness = sender.currentTitle!  // Soft, Medium, Hard
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Update timer functon
    @objc func updateTimer() {
        
        // Change header when one second is left
        let timeOneSec = totalTime - secondsPassed
        if timeOneSec == 1 {
            titleLabel.text = "One second left!"
        }
        
        // Update progress bar
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float (totalTime)
            
            // Change progress bar color
            changeProgressBar()
        }
        else {
            timer.invalidate()
            titleLabel.text = "Done!"
            
            // Alarm goes off when "Done!" is printed
            let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3")!
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
    }
    
    // Progress bar color change function
    func changeProgressBar() {
        if secondsPassed == totalTime - 1 {
            progressBar.trackTintColor = .orange
        }
        else {
            progressBar.trackTintColor = .gray
        }
            
    }
    
}
