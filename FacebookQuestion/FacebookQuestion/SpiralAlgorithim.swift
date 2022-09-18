//
//  SpiralAlgorithim.swift
//  FacebookQuestion
//
//  Created by Peyton McKee on 1/2/22.
//

import Foundation

var matrix = [[1,2,3,4],
              [5,6,7,8],
              [9,10,11,12],
              [13,14,15,16]]
func solveMatrix(_ matrix : [[Int]]) -> [Int]
{
    var result: [Int] = []
    var extras: [Int] = []
    var matrix2 = [[Int]]()
    var rows : [Int]
    for row in 0 ..< matrix.count
    {
        rows = []
        for col in 0 ..< matrix[row].count
        {
            
            if(row == 0)
            {
                result.append(matrix[row][col])
            }
            else if(row != matrix.count - 1)
            {
                if(col != matrix[row].count - 1)
                {
                    if(col == 0)
                    {
                        extras.insert((matrix[row][col]), at: 0)
                    }
                    else
                    {
                        rows.append(matrix[row][col])
                    }
                    continue
                }
                else
                {
                    result.append(matrix[row][col])
                }
            }
            else{
                result.append(matrix[row][matrix[row].count - 1 - col])
            }
        }
        if(rows != [])
        {
            matrix2.append(rows)
        }
    }
    if (!matrix2.isEmpty)
    {
        for num in solveMatrix(matrix2)
        {
            extras.append(num)
        }
    }
    for num in extras{
        result.append(num)
    }
    return result
}

