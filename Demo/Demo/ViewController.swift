import UIKit
import KeyValueStorage

extension StorageKey {
	static var dummy = StorageKey(rawValue: "dummy")
}

class ViewController: UIViewController {
	
	// MARK: - Properties
	
	let userDefaults: KeyValueStorage = UserDefaultsKeyValueStorage()
	let keychain: KeyValueStorage = KeychainKeyValueStorage()
	let memory: KeyValueStorage = MemoryKeyValueStorage()
	
	// MARK: - IBOutlets
	
	@IBOutlet weak var storageTypeSegmentedControl: UISegmentedControl!
	@IBOutlet weak var keyTextField: UITextField!
	@IBOutlet weak var valueTextField: UITextField!
	@IBOutlet weak var valueSwitch: UISwitch!
	@IBOutlet weak var valueTypeSegmentedControl: UISegmentedControl!
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print("--------------------")
		print("KeyValueStorage Demo")
		print("--------------------")
		print("The best way to use this module is creating static vars in extensions for the StorageKey struct:\n")
		print("extension StorageKey {")
		print("    static var dummy = StorageKey(rawValue: \"dummy\")")
		print("}")
		print("memory.set(string: \"something awesome!\", for: .dummy)")
		print("let dummyValue = memory.getString(for: .dummy)\n")
		
		memory.set(string: "something awesome!", for: .dummy)
		let dummyValue = memory.getString(for: .dummy)
		
		print("As you can see, you can use type-safe code instead of strings:", dummyValue ?? "nil")
	}
	
	// MARK: - IBActions
	
	@IBAction func setValueButtonTouchUpInside(_ sender: Any) {
		guard let key = keyTextField.text else { return }
		let value = valueTextField.text
		switch(valueTypeSegmentedControl.selectedSegmentIndex) {
		case 0:
			set(string: value, key: key)
		case 1:
			set(int: value, key: key)
		case 2:
			set(double: value, key: key)
		default:
			set(bool: valueSwitch.isOn, key: key)
		}
	}
	
	@IBAction func loadValueButtonTouchUpInside(_ sender: Any) {
		guard let key = keyTextField.text else { return }
		switch(valueTypeSegmentedControl.selectedSegmentIndex) {
		case 0:
			loadString(key: key)
		case 1:
			loadInt(key: key)
		case 2:
			loadDouble(key: key)
		default:
			loadBool(key: key)
		}
	}
	
	@IBAction func removeKeyButtonTouchUpInside(_ sender: Any) {
		guard let key = keyTextField.text else { return }
		remove(key: key)
	}
	
	@IBAction func clearStorageButtonTouchUpInside(_ sender: Any) {
		clear()
	}
	
	@IBAction func valueTypeSegmentedControlValueChanged(_ sender: Any) {
		valueTextField.isHidden = valueTypeSegmentedControl.selectedSegmentIndex >= 3
		valueSwitch.isHidden = valueTypeSegmentedControl.selectedSegmentIndex < 3
	}
	
	// MARK: - Features
	
	func chooseStorage() -> KeyValueStorage {
		switch(storageTypeSegmentedControl.selectedSegmentIndex) {
		case 0:
			return userDefaults
		case 1:
			return keychain
		default:
			return memory
		}
	}
	
	func set(string: Any?, key: String) {
		guard let value = string as? String else { return }
		let storage = chooseStorage()
		storage.set(string: value, for: key)
	}
	
	func set(int: Any?, key: String) {
		guard let int = int as? String, let value = Int(int) else { return }
		let storage = chooseStorage()
		storage.set(int: value, for: key)
	}
	
	func set(double: Any?, key: String) {
		guard let double = double as? String, let value = Double(double) else { return }
		let storage = chooseStorage()
		storage.set(double: value, for: key)
	}
	
	func set(bool: Bool, key: String) {
		let storage = chooseStorage()
		storage.set(bool: bool, for: key)
	}
	
	func loadString(key: String) {
		let storage = chooseStorage()
		if let value = storage.getString(for: key) {
			valueTextField.text = value
		} else {
			valueTextField.text = ""
		}
		valueSwitch.isOn = false
	}
	
	func loadInt(key: String) {
		let storage = chooseStorage()
		if let value = storage.getInt(for: key) {
			valueTextField.text = "\(value)"
		} else {
			valueTextField.text = ""
		}
		valueSwitch.isOn = false
	}
	
	func loadDouble(key: String) {
		let storage = chooseStorage()
		if let value = storage.getDouble(for: key) {
			valueTextField.text = "\(value)"
		} else {
			valueTextField.text = ""
		}
		valueSwitch.isOn = false
	}
	
	func loadBool(key: String) {
		let storage = chooseStorage()
		if let value = storage.getBool(for: key) {
			valueSwitch.isOn = value
			valueTextField.isHidden = true
			valueSwitch.isHidden = false
		}
		valueTextField.text = ""
	}
	
	func remove(key: String) {
		let storage = chooseStorage()
		storage.remove(key: key)
		valueSwitch.isOn = false
		valueTextField.text = ""
	}
	
	func clear() {
		let storage = chooseStorage()
		storage.clear()
		valueSwitch.isOn = false
		valueTextField.text = ""
	}
}

