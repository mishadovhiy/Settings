//
//  ViewController.swift
//  Indicator&Message
//
//  Created by Mikhailo Dovhyi on 27.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var ai = AppDelegate.shared?.ai ?? IndicatorView(frame: .zero)
    lazy var message = AppDelegate.shared?.message ?? MessageView(frame: .zero)
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        mem2 = MemoryTest(s: "popupVCtestAppeare")
        
        if tableView != nil {
            tableView.delegate = self
            tableView.dataSource = self
            loadData()
        }
        
    }
    
    func loadData() {
        tableData = [
            TableDataSections(title: "Activity indicator", cells: createAISection(), hidden: false, headerSwitch: nil, errorText: "some test error some test error some test error some test error some test error"),
            TableDataSections(title: "message", cells: createMessageSection(), hidden: false, headerSwitch: nil, errorText: ""),
            TableDataSections(title: "Segues", cells: createSequesSection(), hidden: false, headerSwitch: nil, errorText: "")
        ]
    }
    
    var mem1:MemoryTest?
    var mem2:MemoryTest?
    func memoryLeakTestSection() -> [ViewController.TableDataCell] {
        let leakOne = buttonDataType(title: "createLeak", activityLoading: false, type: .standartButton, enabled: true) {
            self.mem1 = MemoryTest(s: "1:\(self.appDelegate?.globals?.memoryLeakCount ?? -1)")
            self.loadData()
        }
        
        let leakTwo = buttonDataType(title: "createLeak", activityLoading: false, type: .standartButton, enabled: true) {
            self.mem1?.memory = Memoryy(s: "memoryyy")
            self.loadData()
        }

        return [
            TableDataCell(cellType: .button, button: leakOne),
            TableDataCell(cellType: .button, button: leakTwo),
        ]
        
    }
    
    override func didReceiveMemoryWarning() {
        close(1)
    }
    
    var tableData: [TableDataSections] {
        set {
            _tableData = newValue
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        get {
            return _tableData
        }
    }

    
    

    lazy var appDelegate:AppDelegate? = {
        return AppDelegate.shared
    }()
    
    
    func showAlertsTESTS(n: Int) {
        for i in 0..<n {
            showActionsTESTS(title: "Showing", text: "\(i)")
        }
    }
    
    func showActionsTESTS(title: String, text: String, needNext: Bool = false, type: IndicatorView.ViewType = .standard, backTimer: Int? = nil) {
        let okButton = IndicatorView.button(title: "close", style: (type == .error || type == .standardError) ? .error : .standart, close: true) { _ in
            
        }
        
        let nextButton = IndicatorView.button(title: "go", style: .success, close: false) { _ in
                self.performSegue(withIdentifier: "toNav", sender: self)

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                if let hideTimer = backTimer {
                   // self.ai.show { _ in

                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(hideTimer))) {
                        self.navigationController?.popToRootViewController(animated: true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                            self.ai.fastHide { _ in
                                
                            }
                        }
                    }
                            
                            
                        
                  //  }
                } else {
                    self.ai.fastHide { _ in
                        
                    }
              }
            }
                    
    }
        
        
     //   DispatchQueue.main.async {
            if needNext {
                self.ai.completeWithActions(buttons: (nextButton, okButton), title: title, descriptionText: text, type: type)
            } else {
                self.ai.completeWithActions(buttons: (okButton, nil), title: title, descriptionText: text, type: type)
            }
            
      //  }
    }
    
    
    func createAISection() -> [TableDataCell] {
        
        let clearAI = buttonDataType(title: "clearAI", activityLoading: false, type: .standartButton, enabled: true) {
            
            DispatchQueue.main.async {
                self.ai.show(title: nil, description: nil) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                        self.showActionsTESTS(title: "Error", text: "Some error", type: .succsess)
                    }
                }
            }
        }
        
        let errorButton = buttonDataType(title: "error", activityLoading: false, type: .standartButton, enabled: true) {
            
            DispatchQueue.main.async {
                self.ai.show { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                        self.showActionsTESTS(title: "Error", text: "Some error", type: .error)
                    }
                }
            }
        }
        let errorRapButton = buttonDataType(title: "error", activityLoading: false, type: .standartButton, enabled: true) {
            
            DispatchQueue.main.async {
                self.showActionsTESTS(title: "Error", text: "Some error", type: .error)
            }
        }
        let succsRapButton = buttonDataType(title: "scs", activityLoading: false, type: .standartButton, enabled: true) {
            
            DispatchQueue.main.async {
                self.showActionsTESTS(title: "sucss", text: "Some sucss", type: .succsess)
            }
        }
        let scssButton = buttonDataType(title: "scss", activityLoading: false, type: .standartButton, enabled: true) {
            
            
            
            DispatchQueue.main.async {
                self.showActionsTESTS(title: "scss", text: "Some scss", type: .succsess)
            }
            
        }
        let nextButton = buttonDataType(title: "ai between vcs", activityLoading: false, type: .standartButton, enabled: true) {
            
            DispatchQueue.main.async {
                self.ai.show { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.showActionsTESTS(title: "Error", text: "Close or next", needNext: true, type: .standard)
                    }
                }
            }
        }
        
        let nextBack = buttonDataType(title: "ai between vcs and back", activityLoading: false, type: .standartButton, enabled: false) {
            DispatchQueue.main.async {
                self.ai.show { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.showActionsTESTS(title: "Error", text: "Close or nect", needNext: true, type: .standard, backTimer: 2)
                    }
                }
            }
        }
        
        
        let aLotButtons = buttonDataType(title: "Many buttons", activityLoading: false, type: .standartButton, enabled: true) {
            self.showAlertsTESTS(n: 10)
        }
        
        let timer = appDelegate?.stopTimer ?? false
        let stopTimer = buttonDataType(title: (timer ? "Start" : "Stop") + " timer", activityLoading: false, type: .standartButton, enabled: true) {
            self.appDelegate?.stopTimer = timer ? false : true
            if timer {
                self.appDelegate?.startTimers()
            }
            self.loadData()
            DispatchQueue.main.async {
                self.message.show(title: "Timer: \(timer ? "started" : "stopped")", description: nil, type: .succsess)
            }
        }

        return [
            //clearAI
            TableDataCell(cellType: .button, button: clearAI),
            TableDataCell(cellType: .button, button: errorButton),
            TableDataCell(cellType: .button, button: scssButton),
            TableDataCell(cellType: .button, button: nextButton),
            TableDataCell(cellType: .button, button: nextBack),
            TableDataCell(cellType: .button, button: aLotButtons),
            TableDataCell(cellType: .button, button: stopTimer),
            TableDataCell(cellType: .button, button: errorRapButton),
            TableDataCell(cellType: .button, button: succsRapButton),
        ]
    }
    func createMessageSection() -> [TableDataCell] {
        //message
        //show error
        //show scss
        let errorButton = buttonDataType(title: "error", activityLoading: false, type: .standartButton) {
            DispatchQueue.main.async {
                self.message.show(title: "Error", description: "You have some error", type: .error)
            }
        }
        let succsessButton = buttonDataType(title: "succsess", activityLoading: false, type: .standartButton) {
            DispatchQueue.main.async {
                self.message.show(title: "sucsess", description: "some additionalText", type: .succsess)
            }
        }
        let standartButton = buttonDataType(title: "standart", activityLoading: false, type: .standartButton) {
            DispatchQueue.main.async {
                self.message.show(title: "standart", description: "some additionalText", type: .standart)
            }
        }
        let largButton = buttonDataType(title: "standart with img", activityLoading: false, type: .standartButton) {
            self.toggle = self.toggle ? false : true
            DispatchQueue.main.async {
                self.message.show(title: "Some title", description: "Some additionalText with large text in a few lines and other stuff", type: self.toggle ? .error : .succsess)
            }
        }
        return [
            TableDataCell(cellType: .button, button: errorButton),
            TableDataCell(cellType: .button, button: succsessButton),
            TableDataCell(cellType: .button, button: standartButton),
            TableDataCell(cellType: .button, button: largButton),
        ]
    }
    var toggle = false
    func createSequesSection() -> [TableDataCell] {
        let navButton = buttonDataType(title: "nav", activityLoading: false, type: .standartButton) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toNav", sender: self)
            }
        }
        
        let popover = buttonDataType(title: "popup", activityLoading: false, type: .standartButton) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toModal", sender: self)
            }
        }
        
        return [
            TableDataCell(cellType: .button, button: navButton),
            TableDataCell(cellType: .button, button: popover)
        ]
    }
    
    
    
    @objc func showFooter(_ sender: UITapGestureRecognizer) {
        if let section = Int(sender.name ?? "") {
            showActionsTESTS(title: tableData[section].title, text: tableData[section].errorText, type: .error)
        }
        
    }
    
//toModal
//toNav
var _tableData: [TableDataSections] = []
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData[section].cells.count == 0 ? nil : tableData[section].title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return tableData[section].errorText == "" ? nil : tableData[section].errorText
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableData[section].errorText != "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableFooter") as! tableFooter
            print("tableData[section].errorText", tableData[section].errorText)
            cell.mainLabel.text = tableData[section].errorText
            let tap = UITapGestureRecognizer(target: self, action: #selector(showFooter(_:)))
            tap.name = "\(section)"
            cell.contentView.addGestureRecognizer(tap)
            return cell.contentView
        } else {
            return nil
        }
    }
    
  /* height not changing when text.lines > 0  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableData[section].errorText != "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableFooter") as! tableFooter
            return cell.contentView.frame.height
        } else {
            return 0
        }
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
        
        let data = tableData[indexPath.section].cells[indexPath.row].button
        
        cell.buttonTitle = data?.title ?? "-"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let action = tableData[indexPath.section].cells[indexPath.row].button?.pressAction {
            tableView.deselectRow(at: indexPath, animated: true)
            action()
        } else {
            print("error")
        }
    }
    
}


class ButtonCell: UITableViewCell {
    
    @IBOutlet private weak var mainButton: UIButton!
    
    
    
    private var _buttonTitle: String?
    var buttonTitle: String {
        set {
            _buttonTitle = newValue
            DispatchQueue.main.async {
                self.mainButton.setTitle(newValue, for: .normal)
                
            }
        }
        get {
            return _buttonTitle ?? ""
        }
    }
}


class tableHeaderCell: UITableViewCell {
    
}

class tableFooter: UITableViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
}



extension ViewController {
    enum cellType {
        case textfield
        case segmented
        case button
    }
    
    struct textFieldDataType {
        let title: String
        let text: String
        let placeHolder: String
        var textHidden: Bool = false
        let endEditingAction:(String) -> ()
        var pressAction:(() -> ())? = nil
    }
    
    struct segmentedDataType {
        let title: String
        let values:[String]
        let selectedAt:Int
        let endEditingAction:(Int) -> ()
    }
    
    /**
    - activityLoading: usage: didSelectRaw: show ai if true
     */
    struct buttonDataType {
        
        let title: String
        let activityLoading: Bool
        let type: ButtonType
        var enabled: Bool = true
        let pressAction:() -> ()
        
        enum ButtonType {
            case cornerButton
            case standartButton
        }

    }
    
    
    struct TableDataCell {
        let cellType: cellType
        var textfields: [textFieldDataType] = []
        var segmented: segmentedDataType? = nil
        var button: buttonDataType? = nil
        var isFree: Bool = true
        var proProductID: String = ""
    }
    
    struct TableDataSections {
        let title: String
        let cells: [TableDataCell]
        var hidden: Bool = false
        var headerSwitch:SectionSwitch? = nil
        var errorText: String = ""
        
    }


    struct SectionSwitch {
        let switchName: String
        var ifOn: Bool? = nil
        let togglePressed: (Bool) -> ()
        
    }

}


