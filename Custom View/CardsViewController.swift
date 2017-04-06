//
//  CardsViewController.swift
//  Custom View
//
//  Created by Yinrong Liang on 4/3/17.
//  Copyright © 2017 Yinrong Liang. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    var cardInitialCenter: CGPoint!
    
    @IBOutlet weak var profileView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var firstTouch: CGPoint!
    @IBAction func didDrag(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        firstTouch = sender.location(in: view)
        print(firstTouch)
        
        if(sender.state == .began) {
            cardInitialCenter = profileView.center
        } else if(sender.state == .changed) {
            if(firstTouch.y < profileView.frame.height/2 ) {
                profileView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                profileView.transform = CGAffineTransform(rotationAngle: CGFloat(Double(translation.x) * M_PI / 560))
            } else {
                profileView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                profileView.transform = CGAffineTransform(rotationAngle: CGFloat(-1.0 * Double(translation.x) * M_PI / 560))
            }
            
            if(translation.x > 50 || translation.x < -50) {
                UIView.animate(withDuration: 0.4, animations: { 
                    self.profileView.alpha = 0
                })
            }
        } else if(sender.state == .ended) {
            profileView.center = CGPoint(x: cardInitialCenter.x, y: cardInitialCenter.y)
            profileView.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
        }
    }

    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profileSegue", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ProfileViewController
        destinationViewController.avatarImageView = profileView
    }

}
