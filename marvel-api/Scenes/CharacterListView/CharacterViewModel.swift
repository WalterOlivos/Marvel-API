import UIKit
import Moya

class CharacterViewModel {
    
    let provider = MoyaProvider<Marvel>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    var currentOffset: Int = 0
    var characters: [Character] = []
    var totalCharacters: Int = 0
    
    // MARK: - Initializers
    
    func loadMoreCharacters(completion: @escaping (Bool) -> ()) {
        provider.request(.characters(offset: currentOffset)) {
            [weak self] result in guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let characters = try response.map(MarvelResponse<Character>.self).data.results
                    let total = try response.map(MarvelResponse<Character>.self).data.total
                    self.totalCharacters = total
                    self.currentOffset += 20
                    self.characters.append(contentsOf: characters)
                    completion(false)
                } catch {
                    completion(true)
                }
            case .failure:
                completion(true)
            }
        }
    }
}

