//
//  ViewController.swift
//  lyh2019
//
//  Created by Chen Lu on 2019/2/13.
//  Copyright © 2019年 Chen Lu. All rights reserved.
//

import UIKit
import AVFoundation
//import MediaPlayer

class ViewController: UIViewController, AVAudioPlayerDelegate ,AVSpeechSynthesizerDelegate{

    var randomDiceIndex1:Int = 0
    var randomDiceIndex2:Int = 0
    let diceArray = ["t1","t2","t3","t4","t1","t3"]
    let dicePictureArray = ["bj1","wh2","cmu3","kns4","shahu3","xyt3"]
    let diceLabelArray = ["人在旅途","路在脚下","家在心中","天任我飞","努力工作","收获成果"]
    let diceTextArray = ["北京、 我的家在这","武汉 、 读书的地方","CMU、 计算机学校","喀纳斯、风景很好","沙湖 、 不一样的风景","西雅图、努力工作"]

    let diceTextColorArray = [0.5,0.6,0.7,0.8,0.9,1.0]
    var audioPlayer: AVAudioPlayer!
    let soundArray = ["note1","note2","note3","note4","note5","note6","note7"]
    let synth = AVSpeechSynthesizer() //TTS对象
    let audioSession = AVAudioSession.sharedInstance() //语音引擎
    fileprivate let avSpeech = AVSpeechSynthesizer()
    var speedstr: String = "北京、上海、广州、深圳、武汉 "
    @IBOutlet weak var diceImageView1: UIImageView!
    
    @IBOutlet weak var diceImageView2: UIImageView!
    
    @IBOutlet weak var diceLabelCap1: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "文字转语音"
        avSpeech.delegate = self

        updateImage()
    }


    @IBAction func rollButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        updateImage()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        updateImage()
        
        
    }
    
    func updateImage(){
        playSound(soundFileName: soundArray[randomDiceIndex1])
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))
        print(randomDiceIndex1)
        print("kkk")
        print(randomDiceIndex2)
        diceImageView1.image = UIImage(named:diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named:dicePictureArray[randomDiceIndex2])
        
        diceLabelCap1.textColor = UIColor.init(white:CGFloat( diceTextColorArray[randomDiceIndex2]), alpha: 1.0)
        
        diceLabelCap1.text = diceLabelArray[randomDiceIndex1]
        textView.text = diceTextArray[randomDiceIndex2]
         startTranslattion()
    }
    func playSound(soundFileName: String) {
        
        let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "wav")
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        }catch {
            print(error)
        }
        
        audioPlayer.play()
    }
    


    //开始转换
    fileprivate func startTranslattion(){
        //1. 创建需要合成的声音类型
        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
        
        //2. 创建合成的语音类
        
        let utterance = AVSpeechUtterance(string: textView.text)
        //let utterance = AVSpeechUtterance(string: speedstr)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = voice
        utterance.volume = 1
        utterance.postUtteranceDelay = 0.1
        utterance.pitchMultiplier = 1
        //开始播放
        avSpeech.speak(utterance)
    }
    
    //暂停播放
    fileprivate func pauseTranslation(){
        avSpeech.pauseSpeaking(at: .immediate)
    }
    
    //继续播放
    fileprivate func continueSpeek(){
        avSpeech.continueSpeaking()
    }
    
    //取消播放
    fileprivate func cancleSpeek(){
        avSpeech.stopSpeaking(at: .immediate)
    }
}

