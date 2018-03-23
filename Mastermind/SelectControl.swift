import UIKit

@IBDesignable class SelectControl: UIStackView {

    //MARK: Properties
    private var pionButtons = [UIButton]()
    var code : Array<Int> = [0,0,0,0]
    @IBInspectable var buttonSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons(code:nil)
        }
    }
    @IBInspectable var pionCount: Int = 4 {
        didSet {
            setupButtons(code:nil)
        }
    }
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons(code:nil)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons(code:nil)
    }
    
    //MARK: Button Action
    @objc func pionButtonTapped(button: UIButton) {
        code[button.tag] = Int(button.currentTitle!)!
    }
    @objc func sendCode(button: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userCode"), object: code)
    }
    //MARK: Changement couleur pion
    @objc func changePionColor(button: UIButton) {
        // Init Button Images
        let bundle = Bundle(for: type(of: self))
        let value = (Int(button.currentTitle!)! + 1) % 5
        // 0 = blue / 1 = red / 2 = yellow / 3 = green
        switch (value) {
        case 1:
            let bluePion = UIImage(named: "blue", in: bundle, compatibleWith: self.traitCollection)
            button.setImage(bluePion, for: .normal)
            button.setTitle(String(value), for: .normal)
            pionButtonTapped(button: button)
        case 2:
            let redPion = UIImage(named:"red", in: bundle, compatibleWith: self.traitCollection)
            button.setImage(redPion, for: .normal)
            button.setTitle(String(value), for: .normal)
            pionButtonTapped(button: button)
        case 3:
            let yellowPion = UIImage(named:"yellow", in: bundle, compatibleWith: self.traitCollection)
            button.setImage(yellowPion, for: .normal)
            button.setTitle(String(value), for: .normal)
            pionButtonTapped(button: button)
        case 4:
            let greenPion = UIImage(named:"green", in: bundle, compatibleWith: self.traitCollection)
            button.setImage(greenPion, for: .normal)
            button.setTitle(String(value), for: .normal)
            pionButtonTapped(button: button)
        default:
            let defaultPion = UIImage(named:"empty", in: bundle, compatibleWith: self.traitCollection)
            button.setImage(defaultPion, for: .normal)
            button.setTitle(String(value), for: .normal)
            pionButtonTapped(button: button)
        }
    }
    
    //MARK: Private Methods
    func setupButtons(code:[Int]?) {
        var index = 0
        if(code?.isEmpty == nil) {
            for _ in 0..<pionCount {
                // Create the button
                let button = UIButton()
                // Load Button Image
                let bundle = Bundle(for: type(of: self))
                let defaultPion = UIImage(named:"empty", in: bundle, compatibleWith: self.traitCollection)
                // Set the button images
                button.setImage(defaultPion, for: .normal)
                button.setTitle("0", for: .normal)
                button.tag = index
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
                // Setup the button action
                button.addTarget(self, action: #selector(SelectControl.changePionColor(button:)), for: .touchUpInside)
                // Add the button to the stack
                addArrangedSubview(button)
                // Add the new button to the rating button array
                pionButtons.append(button)
                index += 1
            }
            
            setupSendButton()
        } else {
            // clear any existing buttons
            for button in arrangedSubviews {
                removeArrangedSubview(button)
                button.removeFromSuperview()
            }
            // clear send
            pionButtons.removeAll()
            for x in 0..<pionCount {
                // Create the button
                let button = UIButton()
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
                let bundler = Bundle(for: type(of: self))
                let value = code![x]
                // 0 = blue / 1 = red / 2 = yellow / 3 = green
                switch (value) {
                case 1:
                    let bluePion = UIImage(named: "blue", in: bundler, compatibleWith: self.traitCollection)
                    button.setImage(bluePion, for: .normal)
                    button.setTitle(String(value), for: .normal)
                case 2:
                    let redPion = UIImage(named:"red", in: bundler, compatibleWith: self.traitCollection)
                    button.setImage(redPion, for: .normal)
                    button.setTitle(String(value), for: .normal)
                case 3:
                    let yellowPion = UIImage(named:"yellow", in: bundler, compatibleWith: self.traitCollection)
                    button.setImage(yellowPion, for: .normal)
                    button.setTitle(String(value), for: .normal)
                case 4:
                    let greenPion = UIImage(named:"green", in: bundler, compatibleWith: self.traitCollection)
                    button.setImage(greenPion, for: .normal)
                    button.setTitle(String(value), for: .normal)
                default:
                    let defaultPion = UIImage(named:"empty", in: bundler, compatibleWith: self.traitCollection)
                    button.setImage(defaultPion, for: .normal)
                }
                // Add the button to the stack
                addArrangedSubview(button)
                // Add the new button to the rating button array
                pionButtons.append(button)
            }
        }
    }
    private func setupSendButton() {
        let sendButton = UIButton()
        sendButton.setTitle("GO", for: .normal)
        sendButton.setTitleColor(UIColor.blue, for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        sendButton.addTarget(self, action: #selector(SelectControl.sendCode(button:)), for: .touchUpInside)
        addArrangedSubview(sendButton)
    }
}
