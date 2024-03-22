-- Section 1.1. Evaluating expressions
#eval 1000*(1+0.74*4.45/1200)
#eval String.append "Hello, " "Lean!"
#eval String.append "Hello" (String.append ", " "new Lean!")
#eval String.append "It is " (if 1>2 then "1>2" else "2>1")

-- Section 1.1 exercises
#eval 42+19
#eval String.append "A" (String.append "B" "C")
#eval String.append (String.append "A" "B") "C"
#eval if 3 == 3 then 5 else 7
#eval if 3 == 4 then "equal" else "not equal"

-- Section 1.2. Types
#eval (1 + 2 : Nat) -- Natural numbers, arbitrary precision, unsigned
#eval (1 - 2 : Nat) -- Defaults to 0 as unsigned
#eval (1 - 2 : Int) -- Integers are signed --> -1
#check (1 - 2 : Int)
#check (1 - 2 : Nat)

-- Section 1.3. Functions and Definitions
def hello := "Hello"

def lean : String := "Lean"

#eval String.append hello (String.append " " lean)

-- Section 1.3. Defining Functions
def add1 (n : Nat) : Nat := n + 1

#eval add1 7

def maximum (n : Nat) (k : Nat) : Nat := if n < k then k else n

#eval maximum 3 89
#eval maximum (4 + 190) (34* 10)
#check maximum
#check add1
#check maximum 3
#eval maximum 3
#check (maximum) -- trick lean to show the function type

-- Section 1.3 exercises
def joinStringsWith (sep : String) (first : String) (second : String) :=
String.append first (String.append sep second)

#eval joinStringsWith ", " "one" "and another"
#check joinStringsWith
#check (joinStringsWith)
#check joinStringsWith ": "

 def volume (a : Nat) (b : Nat) (c : Nat)
  : Nat := a* b* c

#check volume
#eval volume 3 4 5

-- Section 1.3. Defining types
def Str : Type := String
def aStr : Str := "Pippo"

#eval aStr
#check aStr
#check (aStr)

def NaturalNumber : Type := Nat

def thirtyEight : NaturalNumber := 38

def thirtyEight : NaturalNumber := (38 : Nat)

abbrev N : Type := Nat

def thirtyNine : N := 39

-- Various stuff off sequence

def rat_transf (a : Float) (b : Float) (c : Float) (d : Float) (x : Float) : Float :=
(a * x + b) / (c * x + d)

#eval rat_transf 1 2 3 4 1 -- .40
#eval rat_transf 1 2 3 4 7 -- .36
#eval rat_transf 1 2 3 4 12 -- .35
#eval rat_transf 1 2 3 4 32 -- .34

-- 1.4. Structures
#check 1.2
#check  -454.2123215
#check 0.0
#check 0
#check (0 : Float)

structure Point where
  x : Float
  y : Float
deriving Repr

def origin : Point := { x := 0.0, y := 0.0 }
#eval origin
#eval origin.x

def addPoints (p1 : Point) (p2 : Point) : Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }

#eval addPoints { x := 1.5, y := 32 } { x := -8, y := 0.2 }

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt (((p2.x - p1.x) ^ 2.0) + ((p2.y - p1.y) ^ 2.0))

#eval distance {x := 8, y := 9} {x := -1, y := 12}

structure Point3D where
  x : Float
  y : Float
  z : Float
deriving Repr

def origin3D : Point3D := { x := 0.0, y := 0.0, z := 0.0 }
#check { x := 0.0, y := 0.0 }
#check ({ x := 0.0, y := 0.0 } : Point)
#check { x := 0.0, y := 0.0  : Point}

-- 1.4 Updating structures
def zeroX ( P : Point) : Point := { x := 0, y := P.y }

#eval zeroX { x := 9, y := 45 : Point}

def zeroX_v2 (p : Point) : Point :=
  { p with x := 0 }

#eval zeroX_v2 { x := 9, y := 45 : Point}

def fourAndThree : Point :=
  { x := 4.3, y := 3.4 }

#eval fourAndThree
#eval zeroX fourAndThree

-- 1.4 Behind the scene
#eval Point.mk 3 5

structure Point where
  point ::
  x : Float
  y : Float
deriving Repr

def Point.modifyBoth (f : Float → Float) (p : Point) : Point :=
  { x := f p.x, y := f p.y }

structure RectangularPrism where
  height : Float
  width : Float
  depth : Float
 deriving Repr

def volume1 (p : RectangularPrism) : Float :=
 p.height * p.width * p.depth

def p := { height := 2, width := 3, depth := 4 : RectangularPrism}
#check (p)

#eval volume1 p

structure Segment where
 a : Point
 b : Point
deriving Repr

def length (s : Segment) : Float :=
distance s.a s.b

def a := {x := 21, y := 33 : Point}
def b := {x := 33, y := 44 : Point}
def s : Segment := {a, b : Segment}
#eval length s


structure Hamster where
  name : String
  fluffy : Bool

structure Book where
  makeBook ::
  title : String
  author : String
  price : Float

#check Hamster
#check Book
