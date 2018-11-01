//
//  ProteinDataBankAPI.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/11/01.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import Foundation
import Alamofire

class ProteinDataBankAPI {
    
    var ligand : Ligand = Ligand()
    
    private func splitOnNewLine(str : String) -> [String] {
        var lines: [String] = []
        str.enumerateLines { line, _ in
            lines.append(line)
        }
        return lines
    }
    
    private func splitOnWhiteSpace(str : String) -> [String] {
        return str.components(separatedBy: " ")
    }
    
    private func newAtom(line : [Substring]) -> Atom {
        if line.count ==  11 {
            
        }
    }
    
    private func newConnect(line : [Substring]) -> Connect {
        
    }
    
    private func process(ligandData : String){
        let lines = splitOnNewLine(str: ligandData)
        for line in lines {
            var token = line.split(separator: " ")
            switch token[0] {
            case "ATOM":
                ligand.atoms.append(newAtom(line: token))
            case "CONECT":
                ligand.connections.append(newConnect(line: token))
            case "END":
                return
            default:
                continue
            }
        }
    }
    
    func get(ligand : String) -> Ligand? {
        guard let url = URL(string: "https://files.rcsb.org/ligands/view/\(ligand)_ideal.pdb") else { return nil }
        Alamofire.request(url, method : .get).validate().responseString(queue: DispatchQueue.main, encoding: String.Encoding.ascii) { response in
            switch response.result {
            case .success:
                self.process(ligandData: response.result.value!)
//                if let ligand = self.process(ligandData: response.result.value!) { return ligand }
//                else { return nil }
            case .failure(let error):
                print(error)
            }
        }
    }
}
