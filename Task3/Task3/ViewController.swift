//
//  ViewController.swift
//  Task3
//
//  Created by pavel mishanin on 9/2/24.
//

import UIKit

final class ViewController: UIViewController {

    private let slider = UISlider()
    private let rectangleView = UIView()
    
    private let rectangleWidth: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        rectangleView.clipsToBounds = true
        rectangleView.layer.cornerRadius = 8
        rectangleView.backgroundColor = .systemBlue
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.thumbTintColor = .black
        slider.minimumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = .lightGray
        slider.addTarget(self, action: #selector(valueDidChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        
        view.addSubview(rectangleView)
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rectangleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            rectangleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            rectangleView.widthAnchor.constraint(equalToConstant: rectangleWidth),
            rectangleView.heightAnchor.constraint(equalToConstant: rectangleWidth)
        ])
        
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        
    }
    
    @objc func valueDidChanged() {
        let value = CGFloat(slider.value)/100
        
        let scaledPercent = value * 0.5 + 1
        let newWidth = rectangleWidth * scaledPercent
        
        let endX = slider.frame.width + view.layoutMargins.left - newWidth / 2
        let startX = (slider.frame.origin.x + newWidth / 2)
        
        let newCenterX = endX * value + startX * (1 - value)
        rectangleView.center.x = newCenterX
        
        let rotationTransform = CGAffineTransform.init(rotationAngle: CGFloat.pi/2 * value)
        let scaledTransform = CGAffineTransform.identity.scaledBy(x: scaledPercent, y: scaledPercent)
        rectangleView.transform = CGAffineTransformConcat(rotationTransform, scaledTransform)
    }
    
    @objc func touchUpInside(_ sender: UISlider) {
         UIView.animate(withDuration: 1) {
             sender.setValue(sender.maximumValue, animated: true)
             sender.sendActions(for: .valueChanged)
         }
     }
}
