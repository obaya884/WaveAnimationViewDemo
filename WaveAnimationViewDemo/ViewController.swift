//
//  ViewController.swift
//  WaveAnimationViewDemo
//
//  Created by 大林拓実 on 2020/07/01.
//  Copyright © 2020 Obayashi Takumi. All rights reserved.
//

import UIKit
import WaveAnimationView

class ViewController: UIViewController {
    
    var waterLevel: Float = 0.0
    
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var valueSlider: UISlider!
    @IBOutlet var wrapView: UIView!
    var waveView: WaveAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 見た目を丸くする, 枠線つける, 枠の色を青にする
        wrapView.layer.cornerRadius = 120
        wrapView.layer.borderWidth = 4
        wrapView.layer.borderColor = UIColor.blue.cgColor
        wrapView.clipsToBounds = true
        
        // waveViewの設定を書いていく
        waveView = WaveAnimationView(
            frame: CGRect(x: wrapView.bounds.origin.x + 4,
                          y: wrapView.bounds.origin.y + 4,
                          width: wrapView.bounds.size.width - 8,
                          height: wrapView.bounds.size.height - 8),
            color: UIColor.blue.withAlphaComponent(0.5))
        
        // 見た目を丸くする, 枠線つける, 枠の色を青にする
        waveView.layer.cornerRadius = waveView.bounds.size.width / 2
        waveView.layer.borderWidth = 4
        waveView.layer.borderColor = UIColor.white.cgColor
        waveView.clipsToBounds = true
        
        // waveViewをwrapViewnに重ねる
        wrapView.addSubview(waveView)
        
        // 波のアニメーションをスタート
        waveView.startAnimation()
        
        waterLevel = waveView.progress
        valueLabel.text = String(waterLevel)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        waveView.stopAnimation()
    }
    
    @IBAction func slider(_ sender: UISlider) {
        waterLevel = roundf(sender.value*10)/10
        waveView.setProgress(waterLevel)
        valueLabel.text = String(waterLevel)
        checkButtonEnabled()
    }
    
    @IBAction func plus() {
        waterLevel += 0.1
        waterLevel = roundf(waterLevel*10)/10
        waveView.setProgress(waterLevel)
        valueSlider.value = waterLevel
        valueLabel.text = String(waterLevel)
        checkButtonEnabled()
    }
    
    @IBAction func minus() {
        waterLevel -= 0.1
        waterLevel = roundf(waterLevel*10)/10
        waveView.setProgress(waterLevel)
        valueSlider.value = waterLevel
        valueLabel.text = String(waterLevel)
        checkButtonEnabled()
    }
    
    func checkButtonEnabled() {
        if waterLevel >= 1.0 {
            plusButton.isEnabled = false
            minusButton.isEnabled = true
        }
        else if waterLevel <= 0.0 {
            plusButton.isEnabled = true
            minusButton.isEnabled = false
        }
        else {
            plusButton.isEnabled = true
            minusButton.isEnabled = true
        }
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            waveView.frontColor = UIColor.blue.withAlphaComponent(0.5)
            waveView.backColor = UIColor.blue.withAlphaComponent(0.5)
            wrapView.layer.borderColor = UIColor.blue.cgColor
        case 1:
            waveView.frontColor = UIColor.red.withAlphaComponent(0.5)
            waveView.backColor = UIColor.red.withAlphaComponent(0.5)
            wrapView.layer.borderColor = UIColor.red.cgColor
        case 2:
            waveView.frontColor = UIColor.orange.withAlphaComponent(0.5)
            waveView.backColor = UIColor.orange.withAlphaComponent(0.5)
            wrapView.layer.borderColor = UIColor.orange.cgColor
        default:
            break
        }
    }
    
    
}

