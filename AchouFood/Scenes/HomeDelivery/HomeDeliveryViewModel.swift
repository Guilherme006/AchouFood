
class HomeDeliveryViewModel {
    let homeDeliveryService: HomeDeliveryService
    
    public init(service: HomeDeliveryService) {
        self.homeDeliveryService = service
    }
    
    public func fetchPlaces(completion: @escaping FetchPlacesCompletion) {
        homeDeliveryService.fetchPlaces { result in
            completion(result)
        }
    }
}
