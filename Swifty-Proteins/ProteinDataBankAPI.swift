//
//  ProteinDataBankAPI.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/11/01.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class ProteinDataBankAPI {
    
    var ligand : Ligand?
    
    func getStubData() {
        ligand = process(ligandData: StubData.ligTenS)
    }
    
    private func newAtom(line : [Substring]) -> Atom {
        if let index = Int(line[1]),
        let x = Float(line[6]),
        let y = Float(line[7]),
        let z = Float(line[8]) {
            let symbol = String(line[11])
            return Atom(index: index, symbol: symbol, x: x, y: y, z: z)
        }
        return Atom()
    }
    
    private func newConnect(line : [Substring]) -> Connect {
        var i = 1
        var connections : [Int] = [Int]()
        while i < line.count {
            if let node = Int(line[i]) { connections.append(node) }
            i += 1
        }
        return Connect(connects: connections)
    }
    
    private func process(ligandData : String) -> Ligand {
        let localLigand : Ligand = Ligand()
        let lines = ligandData.split(separator: "\n")
        for line in lines {
            var token = line.split(separator: " ")
            switch token[0] {
            case "ATOM":
                if token.count == 12 { localLigand.atoms.append(newAtom(line: token)) }
                break
            case "CONECT":
                if token.count > 0 { localLigand.connections.append(newConnect(line: token))}
                break
            default:
                continue
            }
        }
        return localLigand
    }
    
    func fetch(ligand : String) {
        SVProgressHUD.show(withStatus: "Fetching data for \(ligand) ligand")
        guard let url = URL(string: "https://files.rcsb.org/ligands/view/\(ligand)_ideal.pdb") else { return }
        Alamofire.request(url, method : .get).validate().responseString(queue: DispatchQueue.main, encoding: String.Encoding.ascii) { response in
            switch response.result {
            case .success:
                self.ligand = self.process(ligandData: response.result.value!)
                SVProgressHUD.dismiss()
                break
//                for e in self.ligand!.atoms {
//                    print ("ATOM index: \(e.index) x: \(e.x) y: \(e.y) z: \(e.z) sym: \(e.symbol)")
//                }
//                for e in self.ligand!.connections {
//                    print ("CONECT : ", terminator: "")
//                    for node in e.connects { print (node, terminator: " ") }
//                    print()
//                }
            case .failure(let error):
                print(error)
                SVProgressHUD.dismiss()
            }
        }
    }
}
