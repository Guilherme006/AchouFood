
import Foundation

public protocol ViewCodeProtocol {
    func setViewHierarchy()
    func setViewConstraints()
    func setViewConfigs()
    func buildLayout()
}

public extension ViewCodeProtocol {
    func buildLayout() {
        setViewHierarchy()
        setViewConstraints()
        setViewConfigs()
    }
    
    func setViewConfigs() {
        
    }
}
