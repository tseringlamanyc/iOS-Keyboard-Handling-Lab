//
//  ViewController.swift
//  iOS-Keyboard-Handling-Lab
//
//  Created by Tsering Lama on 2/3/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var loginIn: UIButton!
    
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        self.view.layer.addSublayer(gradient)
        view.addSubview(imageLogo)
        view.addSubview(loginIn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pulsateLogo()
        animateView()
    }
    
    func setupGradient() {
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor(red: (255/255.0), green: (185/255.0), blue: (0/255.0), alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.locations = [0,0]
    }
    
    func animateView() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-0.5, -0.25, 0]
        animation.toValue = [1.0, 1.25, 1.5]
        animation.duration = 5.0
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        self.gradient.add(animation, forKey: nil)
    }
    
    private func pulsateLogo() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: [], animations: {
            self.imageLogo.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
        }) { (done) in
            UIView.animate(withDuration: 0.8, delay: 0.0, options: [], animations: {
            self.imageLogo.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        })
       }
    }
    
    
    func showLogin() {
        guard let loginVC = storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC else {
            fatalError()
        }
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        showLogin()
    }
    
}

