type Vector* = tuple[x, y: int]

const origin*: Vector = (x: 0, y: 0)
const up*: Vector = (x: 0, y: -1)
const down*: Vector = (x: 0, y: 1)
const left*: Vector = (x: -1, y: 0)
const right*: Vector = (x: 1, y: 0)
const cardinals* = [up, right, down, left]

func `+`*(a, b: Vector): Vector = (x: a.x + b.x, y: a.y + b.y)
func `+`*(a: Vector, b: int): Vector = (x: a.x + b, y: a.y + b)
func `+=`*(a: var Vector, b: Vector) = a = a + b

func `*`*(a, b: Vector): Vector = (x: a.x * b.x, y: a.y * b.y)
func `*`*(a: Vector, b: int): Vector = (x: a.x * b, y: a.y * b)

func `-`*(a, b: Vector): Vector = (x: a.x - b.x, y: a.y - b.y)
func `-`*(a: Vector, b: int): Vector = (x: a.x - b, y: a.y - b)

func `/`*(a, b: Vector): Vector = (x: a.x div b.x, y: a.y div b.y)
func `/`*(a: Vector, b: int): Vector = (x: a.x div b, y: a.y div b)

func `==`*(a, b: Vector): bool = a.x == b.x and a.y == b.y
func `!=`*(a, b: Vector): bool = a.x != b.x or a.y != b.y

func `>`*(a, b: Vector): bool = a.x > b.x and a.y > b.y
func `<`*(a, b: Vector): bool = a.x < b.x and a.y < b.y

iterator items*(slice: HSlice[Vector, Vector]): Vector =
  for y in slice.a.y .. slice.b.y:
    for x in slice.a.x .. slice.b.x:
      yield (x, y)
