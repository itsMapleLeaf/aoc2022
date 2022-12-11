import sets
import options
import sequtils

template sum*(nums: untyped): int =
  var result = 0
  for x in nums: result += x
  result

template isEmpty*(s: seq[auto]): bool =
  s.len == 0

func last*[T](a: openArray[T]): T =
  a[a.high]

proc deleteLast*[T](items: var seq[T], count: Natural): seq[T] =
  if count == 0: return @[]

  let deletedRange = (items.high - count + 1) .. items.high
  let removed = items[deletedRange]
  items.delete deletedRange
  removed

func findWhere*[T](s: seq[T], pred: proc(x: T): bool {.closure.}): Option[T] =
  for i, x in s:
    if pred(x): return some(x)
  none(T)

func hasUniqueValues*[T](s: openArray[T]): bool =
  s.len == s.toHashSet.len

func unique*[T](s: openArray[T]): seq[T] =
  s.toHashSet.toSeq
