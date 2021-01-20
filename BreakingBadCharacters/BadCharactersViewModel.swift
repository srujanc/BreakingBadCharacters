//
//  BadCharactersViewModel.swift
//  BreakingBadCharacters
//
//  Created by Srujan on 18/01/21.
//

import Foundation
class BadCharactersViewModel{
    var badCharacters : [BadCharacterElement] = []
    var filteredBadCharacters : [BadCharacterElement] = []
    var seasonFilters : [Int] = []
    var selectedSeasons : [Int] = []
    var searchText : String?
    
    func getData( completion :@escaping ()->()) {
        self.applyFilter(text:searchText){}
        let url = URL(string: "https://breakingbadapi.com/api/characters")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion()
                return
            }
            if self.parseBadCharacters(data: data){
                DispatchQueue.main.async {
                    self.seasonFilters = self.getSeasons()
                    self.applyFilter(text:self.searchText){}
                    completion()
                }
            }
            else{
                completion()
            }
        }.resume()
    }
    
    func parseBadCharacters(data : Data)->Bool{
        do {
            self.badCharacters = try Array.init(data: data)
            return true
        }
        catch {
            print("error parsing the data")
        }
        return false
    }
    
    func getSeasons()-> [Int]{
        let appearances = self.badCharacters.compactMap{
            return $0.appearance
        }
        let flattenedAppearances = appearances.flatMap{$0}
        let setOfAppearances = Set(flattenedAppearances)
        return Array(setOfAppearances.sorted(by: <))
    }
    
    func applyFilter(text:String? = nil,completion : ()->()){
        self.filteredBadCharacters = self.badCharacters
        if selectedSeasons.count > 0{
            self.filteredBadCharacters = self.badCharacters.filter{ character in
                if let appears = character.appearance{
                    for i in appears{
                        if selectedSeasons.contains(i){
                            return true
                        }
                    }
                    return false
                }
                return false
            }
        }
        if let txt = text{
            if txt.count > 0{
                self.filteredBadCharacters = self.filteredBadCharacters.filter{$0.name.contains(txt)}
            }
        }
        
        self.filteredBadCharacters = self.filteredBadCharacters.sorted{$0.name < $1.name}
        completion()
    }
}
