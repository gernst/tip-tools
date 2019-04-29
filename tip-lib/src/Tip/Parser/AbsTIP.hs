

module Tip.Parser.AbsTIP where

-- Haskell module generated by the BNF converter




newtype UnquotedSymbol = UnquotedSymbol ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype QuotedSymbol = QuotedSymbol ((Int,Int),String)
  deriving (Eq, Ord, Show, Read)
newtype Keyword = Keyword String deriving (Eq, Ord, Show, Read)
data Start = Start [Decl]
  deriving (Eq, Ord, Show, Read)

data Decl
    = DeclareDatatypes [Symbol] [Datatype]
    | DeclareSort AttrSymbol Integer
    | DeclareConst ConstDecl
    | DeclareConstPar Par ConstDecl
    | DeclareFun FunDecl
    | DeclareFunPar Par FunDecl
    | DefineFun FunDef
    | DefineFunPar Par FunDef
    | DefineFunRec FunDef
    | DefineFunRecPar Par FunDef
    | DefineFunsRec [FunDec] [Expr]
    | Formula Assertion [Attr] Expr
    | FormulaPar Assertion [Attr] Par Expr
  deriving (Eq, Ord, Show, Read)

data Assertion = Assert | Prove
  deriving (Eq, Ord, Show, Read)

data Par = Par [Symbol]
  deriving (Eq, Ord, Show, Read)

data ConstDecl = ConstDecl AttrSymbol Type
  deriving (Eq, Ord, Show, Read)

data FunDecl = FunDecl AttrSymbol [Type] Type
  deriving (Eq, Ord, Show, Read)

data FunDef = FunDef AttrSymbol [Binding] Type Expr
  deriving (Eq, Ord, Show, Read)

data FunDec = ParFunDec Par InnerFunDec | MonoFunDec InnerFunDec
  deriving (Eq, Ord, Show, Read)

data InnerFunDec = InnerFunDec AttrSymbol [Binding] Type
  deriving (Eq, Ord, Show, Read)

data Datatype = Datatype AttrSymbol [Constructor]
  deriving (Eq, Ord, Show, Read)

data Constructor = Constructor AttrSymbol [Binding]
  deriving (Eq, Ord, Show, Read)

data Binding = Binding Symbol Type
  deriving (Eq, Ord, Show, Read)

data LetDecl = LetDecl Symbol Expr
  deriving (Eq, Ord, Show, Read)

data Type
    = TyVar Symbol
    | TyApp Symbol [Type]
    | ArrowTy [Type]
    | IntTy
    | RealTy
    | BoolTy
  deriving (Eq, Ord, Show, Read)

data Expr
    = Var PolySymbol
    | App Head [Expr]
    | Match Expr [Case]
    | Let [LetDecl] Expr
    | Binder Binder [Binding] Expr
    | Lit Lit
  deriving (Eq, Ord, Show, Read)

data Lit = LitInt Integer | LitNegInt Integer | LitTrue | LitFalse
  deriving (Eq, Ord, Show, Read)

data Binder = Lambda | Forall | Exists
  deriving (Eq, Ord, Show, Read)

data Case = Case Pattern Expr
  deriving (Eq, Ord, Show, Read)

data Pattern
    = Default | ConPat Symbol [Symbol] | SimplePat Symbol | LitPat Lit
  deriving (Eq, Ord, Show, Read)

data Head
    = Const PolySymbol
    | At
    | IfThenElse
    | And
    | Or
    | Not
    | Implies
    | Equal
    | Distinct
    | NumAdd
    | NumSub
    | NumMul
    | NumDiv
    | IntDiv
    | IntMod
    | NumGt
    | NumGe
    | NumLt
    | NumLe
    | NumWiden
  deriving (Eq, Ord, Show, Read)

data PolySymbol = NoAs Symbol | As Symbol [Type]
  deriving (Eq, Ord, Show, Read)

data AttrSymbol = AttrSymbol Symbol [Attr]
  deriving (Eq, Ord, Show, Read)

data Attr = NoValue Keyword | Value Keyword Symbol
  deriving (Eq, Ord, Show, Read)

data Symbol = Unquoted UnquotedSymbol | Quoted QuotedSymbol
  deriving (Eq, Ord, Show, Read)

