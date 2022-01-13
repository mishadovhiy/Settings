//
//  AppDelegate.swift
//  Indicator&Message
//
//  Created by Mikhailo Dovhyi on 27.08.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var stopTimer = true
    var window: UIWindow?
    static var shared:AppDelegate?
    
    lazy var ai: IndicatorView = {
        let newView = IndicatorView.instanceFromNib() as! IndicatorView
        return newView
    }()
    
    lazy var message: MessageView = {
        let newView = MessageView.instanceFromNib() as! MessageView
        return newView
    }()
    
    private var tillShowCounter: UILabel?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //get dev orientation
        //when message showed - allow only that orientation
        // when hides - .all (allow all)
        
        //notif sound and vibrate
        //if message showing - add to array
        
        
        AppDelegate.shared = self
        DispatchQueue.main.async {
            let mainFrame = self.window?.frame ?? .zero
            let label = UILabel(frame: CGRect(x: 5, y: 40, width: mainFrame.width - 10, height: 10))
            label.font = .systemFont(ofSize: 10, weight: .regular)
            self.tillShowCounter = label
            self.window?.addSubview(label)
        }
        
        startTimers()
        return true
    }
    
    func startTimers() {
        var count = 0
        let interval: TimeInterval = 6 * 3

        let timerShow = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            count = 0
            if !self.stopTimer {
                if self.ai.isShowing {
                    let new = {
                        self.showMessageTEST()
                    }
                    self.ai.anshowedAIS.append(new)
                } else {
                    self.showMessageTEST()
                }
            } else {
                timer.invalidate()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            count += 1
            let max = Int(interval) * 10
            let highlight = count > (max - (max / 8)) ? true: false
            DispatchQueue.main.async {
                self.tillShowCounter?.text = "\(count)"
                self.tillShowCounter?.textColor = highlight ? .red : .black
            }
            if self.stopTimer {
                self.tillShowCounter?.backgroundColor = .clear
                timerShow.invalidate()
                count = 0
                timer.invalidate()
                DispatchQueue.main.async {
                    self.tillShowCounter?.text = ""
                }
            }
        }
    }
    

    private func showMessageTEST() {
        let okButton = IndicatorView.button(title: "OK", style: .error, close: true) { _ in
            
        }
        DispatchQueue.main.async {
            self.ai.completeWithActions(buttons: (okButton, nil), title: "Message from delegate", descriptionText: nil, type: .error )
        }
    }
    
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        let okButton = IndicatorView.button(title: "OK", style: .error, close: true) { _ in
            
        }
        DispatchQueue.main.async {
            self.ai.completeWithActions(buttons: (okButton, nil), title: "applicationDidReceiveMemoryWarning".uppercased() , descriptionText: "Memory warning", type: .error )
        }
    }
    
    
    var restrictRotation:UIInterfaceOrientationMask = .all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return restrictRotation
    }
    
}

