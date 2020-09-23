import UIKit
import KeyValueStorage

class ViewController: UIViewController {

	// MARK: - Properties

	let storage: KeyValueStorageProtocol = KeyValueStorage()

	// MARK: - IBOutlets

	@IBOutlet var storageTypeSegmentedControl: UISegmentedControl!
	@IBOutlet var keyTextField: UITextField!
	@IBOutlet var valueTextField: UITextField!
	@IBOutlet var valueSwitch: UISwitch!
	@IBOutlet var valueTypeSegmentedControl: UISegmentedControl!

	// MARK: - IBActions

	@IBAction private func setValueButtonTouchUpInside(_ sender: Any) {
		guard let key = keyTextField.text, let value = valueTextField.text else { return }
		switch valueTypeSegmentedControl.selectedSegmentIndex {
		case 0:
			set(value: value, key: key)
		case 1:
			set(value: Int(value), key: key)
		case 2:
			set(value: Double(value), key: key)
		default:
			set(value: valueSwitch.isOn, key: key)
		}
	}

	@IBAction private func loadValueButtonTouchUpInside(_ sender: Any) {
		guard let key = keyTextField.text else { return }
		switch valueTypeSegmentedControl.selectedSegmentIndex {
		case 0:
            let value: String? = load(key: key)
            print("Loaded value:", value ?? "-")
		case 1:
            let value: Int? = load(key: key)
            print("Loaded value:", value ?? "-")
		case 2:
            let value: Double? = load(key: key)
            print("Loaded value:", value ?? "-")
		default:
            let value: Bool? = load(key: key)
            print("Loaded value:", value ?? "-")
		}
	}

	@IBAction private func removeKeyButtonTouchUpInside(_ sender: Any) {
		guard let key = keyTextField.text else { return }
		remove(key: key)
	}

	@IBAction private func clearStorageButtonTouchUpInside(_ sender: Any) {
		clear()
	}

	@IBAction private func valueTypeSegmentedControlValueChanged(_ sender: Any) {
		valueTextField.isHidden = valueTypeSegmentedControl.selectedSegmentIndex >= 3
		valueSwitch.isHidden = valueTypeSegmentedControl.selectedSegmentIndex < 3
	}

	// MARK: - Features

	func chooseStorage() -> KeyValueStorageType {
		switch storageTypeSegmentedControl.selectedSegmentIndex {
		case 0:
            return .defaults
		case 1:
            return .keychain
		default:
            return .memory
		}
	}

    func set<Type: Codable>(value: Type, key: String) {
        let storageType = chooseStorage()
        let storageKey = KeyValueStorageKey(type: storageType, value: key)
        storage.set(value: value, for: storageKey)
    }

    func load<Type: Codable>(key: String) -> Type? {
        let storageType = chooseStorage()
        let storageKey = KeyValueStorageKey(type: storageType, value: key)
        valueTextField.text = ""
        valueSwitch.isOn = false
        if let value: Type = storage.get(key: storageKey) {
            if let isOn = value as? Bool {
                valueSwitch.isOn = isOn
                return value
            }
            valueTextField.text = String(describing: value)
            return value
        }
        return nil
    }

	func remove(key: String) {
        let storageType = chooseStorage()
        let storageKey = KeyValueStorageKey(type: storageType, value: key)
		storage.remove(key: storageKey)
		valueSwitch.isOn = false
		valueTextField.text = ""
	}

	func clear() {
		storage.cleanAll()
		valueSwitch.isOn = false
		valueTextField.text = ""
	}
}
