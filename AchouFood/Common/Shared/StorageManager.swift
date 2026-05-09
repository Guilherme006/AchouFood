
import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    func save<T>(value: T, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func get<T>(forKey key: String) -> T? {
        return UserDefaults.standard.value(forKey: key) as? T
    }
}
