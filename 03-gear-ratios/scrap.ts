// 467..114..
// ...*......
// ..35..633.
// ......#...
// 617*......
// .....+.58.
// ..592.....
// ......755.
// ...$.*....
// .664.598..

type Row = number;
type Column = number;
type Coordinate = [Row, Column];

// Coordinate (l, c)
const test = [
  "467..114..",
  "...*......",
  "..35..633.",
  "......#...",
  "617*......",
  ".....+.58.",
  "..592.....",
  "......755.",
  "...$.*....",
  ".664.598..",
];

const isSymbol = (char: string) => char !== "." && isNaN(Number(char));
const isDigit = (char: string) => !isNaN(Number(char));

const mapAllChars = (lines: string[]) =>
  lines.flatMap((line, row) =>
    line
      .split("")
      .map((symbol, column) => isSymbol(symbol) && [row, column])
      .filter(Boolean)
  ) as Coordinate[];


const offSets: Coordinate[] = [
  [-1, -1],
  [-1, 0],
  [0, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1],
];

const getCoordinageFromOffset = (coord: Coordinate, os: Coordinate) => [
  coord[0] + os[0],
  coord[1] + os[1],
];

const getAdjacent = (coord: Coordinate): Coordinate[] => {
  return offSets
    .map((os) => {
      const [row, col] = [coord[0] + os[0], coord[1] + os[1]];

      const dataSet = test;

      if (row < 0 || col < 0 || row >= dataSet.length) return false;

      const currentRow = dataSet[row];

      if (col >= currentRow.length) return false;

      const strVal = currentRow[col];

      return isDigit(strVal) ? ([row, col] as Coordinate) : false;
    })
    .filter(Boolean) as Coordinate[];
};

console.log(mapAllChars(test).flatMap(getAdjacent));
