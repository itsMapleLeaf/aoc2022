import vector

type Rect* = tuple[x: int, y: int, width: int, height: int]

func rect*(x, y, width, height: int): Rect = (x, y, width, height)

func left*(rect: Rect): int = rect.x
func top*(rect: Rect): int = rect.y
func right*(rect: Rect): int = rect.x + rect.width - 1
func bottom*(rect: Rect): int = rect.y + rect.height - 1

func topLeft*(rect: Rect): Vector = (rect.left, rect.top)
func topRight*(rect: Rect): Vector = (rect.right, rect.top)
func bottomLeft*(rect: Rect): Vector = (rect.left, rect.bottom)
func bottomRight*(rect: Rect): Vector = (rect.right, rect.bottom)

func size*(rect: Rect): Vector = (rect.width, rect.height)

func contains*(rect: Rect, point: Vector): bool =
  point.x >= rect.x and point.x < rect.x + rect.width and
  point.y >= rect.y and point.y < rect.y + rect.height

func isAtEdge*(rect: Rect, point: Vector): bool =
  point.x == rect.x or point.x == rect.x + rect.width - 1 or
  point.y == rect.y or point.y == rect.y + rect.height - 1

iterator points*(rect: Rect): Vector =
  for pos in pointsBetween(rect.topLeft, rect.bottomRight):
    yield pos

iterator raycastToEdge*(rect: Rect, start: Vector, direction: Vector): Vector =
  var pos = start
  while rect.contains(pos):
    yield pos
    pos += direction
