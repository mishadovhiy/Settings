//
//  MessageView.swift
//  Indicator&Message
//
//  Created by Mikhailo Dovhyi on 28.08.2021.
//

import UIKit

class MessageView: UIView {


    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBAction func closePressed(_ sender: Any) {
        hideMessage()
    }
    
  /*  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let subviews = self.subviews
        var hitView:UIView? = nil
        for i in 0..<subviews.count {
            print("description: ", subviews[i].debugDescription, " i: ", i)
            hitView = subviews[i]
        }
        return hitView
    }*/
    
    
    override func draw(_ rect: CGRect) {
        self.mainView.layer.shadowColor = UIColor.black.cgColor
        self.mainView.layer.shadowOpacity = 0.3
        self.mainView.layer.shadowOffset = .zero
        self.mainView.layer.shadowRadius = 6
        self.mainView.layer.cornerRadius = 6
        let swipeTop = UISwipeGestureRecognizer(target: self, action: #selector(closeSwipe(_:)))
        swipeTop.direction = .up
        self.mainView.addGestureRecognizer(swipeTop)
        self.translatesAutoresizingMaskIntoConstraints = true
       // self.mainView.translatesAutoresizingMaskIntoConstraints = true
    }

    @objc private func closeSwipe(_ sender: UISwipeGestureRecognizer) {
        hideMessage()
    }
    
    
    
    
    func show(title: String, description: String?, type:viewType, customImage: UIImage? = nil, autohide: TimeInterval? = 7.0) {

        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow ?? UIWindow()
            self.frame = window.frame
            window.addSubview(self)
            
            let top = self.mainView.frame.maxY
            print("message appeare from top:", top)
            self.mainView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, (top + 10) * (-1), 0)
            
            
            
            self.titleLabel.text = title
            self.descriptionLabel.text = description
            self.descriptionLabel.isHidden = description ?? "" == "" ? true : false
            
            switch type {
            case .error:
                self.mainView.backgroundColor = self.errorColor
                self.mainImage.image = self.errorImage
            case .succsess:
                self.mainView.backgroundColor = self.succsessColor
                self.mainImage.image = self.succsessImage
            case .standart:
                self.mainView.backgroundColor = .white
            }
            self.alpha = 1
            
            UIView.animate(withDuration: 0.3) {
                self.mainView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 0)
            } completion: { _ in
                self.frame = self.mainView.frame
                
                if let hideTimer = autohide {
                    self.startTimer(secs: hideTimer)
                }
                
            }

        }
        
    }
    
    private var timer: Timer?
    private func startTimer(secs: TimeInterval) {
        let timerr = Timer.scheduledTimer(withTimeInterval: secs, repeats: false) { tim in
            tim.invalidate()
            self.hideMessage()
        }
        timer = timerr
    }

    
    private func hideMessage() {
        DispatchQueue.main.async {
            let top = self.mainView.frame.maxY
            print("message appeare from top:", top)
            UIView.animate(withDuration: 0.3) {
                self.mainView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, (top + 10) * (-1), 0)
            } completion: { _ in
                self.removeFromSuperview()
            }

        }
    }
    
    private var unshowedMessages: [Any] = []
    
    
    private var errorImage = UIImage(named: "warning")
    private var succsessImage = UIImage(named: "success")
    private var errorColor: UIColor = .red
    private var succsessColor: UIColor = .green
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Message", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    enum viewType {
        case error
        case succsess
        case standart
    }
}
