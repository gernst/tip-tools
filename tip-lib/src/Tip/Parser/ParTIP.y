-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module Tip.Parser.ParTIP where
import Tip.Parser.AbsTIP
import Tip.Parser.LexTIP
import Tip.Parser.ErrM

}

%name pStart Start
%name pListDecl ListDecl
%name pDecl Decl
%name pAssertion Assertion
%name pPar Par
%name pConstDecl ConstDecl
%name pFunDecl FunDecl
%name pFunDef FunDef
%name pFunDec FunDec
%name pInnerFunDec InnerFunDec
%name pDatatype Datatype
%name pConstructor Constructor
%name pBinding Binding
%name pLetDecl LetDecl
%name pType Type
%name pExpr Expr
%name pLit Lit
%name pBinder Binder
%name pCase Case
%name pPattern Pattern
%name pHead Head
%name pPolySymbol PolySymbol
%name pAttr Attr
%name pListLetDecl ListLetDecl
%name pListCase ListCase
%name pListExpr ListExpr
%name pListDatatype ListDatatype
%name pListConstructor ListConstructor
%name pListBinding ListBinding
%name pListSymbol ListSymbol
%name pListType ListType
%name pListFunDecl ListFunDecl
%name pListFunDef ListFunDef
%name pListFunDec ListFunDec
%name pListAttr ListAttr
%name pSymbol Symbol
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '(' { PT _ (TS _ 1) }
  ')' { PT _ (TS _ 2) }
  '*' { PT _ (TS _ 3) }
  '+' { PT _ (TS _ 4) }
  '-' { PT _ (TS _ 5) }
  '/' { PT _ (TS _ 6) }
  '<' { PT _ (TS _ 7) }
  '<=' { PT _ (TS _ 8) }
  '=' { PT _ (TS _ 9) }
  '=>' { PT _ (TS _ 10) }
  '>' { PT _ (TS _ 11) }
  '>=' { PT _ (TS _ 12) }
  '@' { PT _ (TS _ 13) }
  'Bool' { PT _ (TS _ 14) }
  'Int' { PT _ (TS _ 15) }
  'Real' { PT _ (TS _ 16) }
  '_' { PT _ (TS _ 17) }
  'and' { PT _ (TS _ 18) }
  'assert' { PT _ (TS _ 19) }
  'case' { PT _ (TS _ 20) }
  'declare-const' { PT _ (TS _ 21) }
  'declare-datatypes' { PT _ (TS _ 22) }
  'declare-fun' { PT _ (TS _ 23) }
  'declare-sort' { PT _ (TS _ 24) }
  'default' { PT _ (TS _ 25) }
  'define-fun' { PT _ (TS _ 26) }
  'define-fun-rec' { PT _ (TS _ 27) }
  'define-funs-rec' { PT _ (TS _ 28) }
  'distinct' { PT _ (TS _ 29) }
  'div' { PT _ (TS _ 30) }
  'exists' { PT _ (TS _ 31) }
  'false' { PT _ (TS _ 32) }
  'forall' { PT _ (TS _ 33) }
  'ite' { PT _ (TS _ 34) }
  'lambda' { PT _ (TS _ 35) }
  'let' { PT _ (TS _ 36) }
  'match' { PT _ (TS _ 37) }
  'mod' { PT _ (TS _ 38) }
  'not' { PT _ (TS _ 39) }
  'or' { PT _ (TS _ 40) }
  'par' { PT _ (TS _ 41) }
  'prove' { PT _ (TS _ 42) }
  'to_real' { PT _ (TS _ 43) }
  'true' { PT _ (TS _ 44) }

L_integ  { PT _ (TI $$) }
L_UnquotedSymbol { PT _ (T_UnquotedSymbol _) }
L_QuotedSymbol { PT _ (T_QuotedSymbol _) }
L_Keyword { PT _ (T_Keyword $$) }


%%

Integer :: { Integer } : L_integ  { (read ( $1)) :: Integer }
UnquotedSymbol    :: { UnquotedSymbol} : L_UnquotedSymbol { UnquotedSymbol (mkPosToken $1)}
QuotedSymbol    :: { QuotedSymbol} : L_QuotedSymbol { QuotedSymbol (mkPosToken $1)}
Keyword    :: { Keyword} : L_Keyword { Keyword ($1)}

Start :: { Start }
Start : ListDecl { Tip.Parser.AbsTIP.Start $1 }
ListDecl :: { [Decl] }
ListDecl : {- empty -} { [] } | '(' Decl ')' ListDecl { (:) $2 $4 }
Decl :: { Decl }
Decl : 'declare-datatypes' '(' ListSymbol ')' '(' ListDatatype ')' { Tip.Parser.AbsTIP.DeclareDatatypes (reverse $3) (reverse $6) }
     | 'declare-sort' Symbol ListAttr Integer { Tip.Parser.AbsTIP.DeclareSort $2 (reverse $3) $4 }
     | 'declare-const' ConstDecl { Tip.Parser.AbsTIP.DeclareConst $2 }
     | 'declare-const' '(' Par '(' ConstDecl ')' ')' { Tip.Parser.AbsTIP.DeclareConstPar $3 $5 }
     | 'declare-fun' FunDecl { Tip.Parser.AbsTIP.DeclareFun $2 }
     | 'declare-fun' '(' Par '(' FunDecl ')' ')' { Tip.Parser.AbsTIP.DeclareFunPar $3 $5 }
     | 'define-fun' FunDef { Tip.Parser.AbsTIP.DefineFun $2 }
     | 'define-fun' '(' Par '(' FunDef ')' ')' { Tip.Parser.AbsTIP.DefineFunPar $3 $5 }
     | 'define-fun-rec' FunDef { Tip.Parser.AbsTIP.DefineFunRec $2 }
     | 'define-fun-rec' '(' Par '(' FunDef ')' ')' { Tip.Parser.AbsTIP.DefineFunRecPar $3 $5 }
     | 'define-funs-rec' '(' ListFunDec ')' '(' ListExpr ')' { Tip.Parser.AbsTIP.DefineFunsRec (reverse $3) (reverse $6) }
     | Assertion ListAttr Expr { Tip.Parser.AbsTIP.Formula $1 (reverse $2) $3 }
     | Assertion ListAttr '(' Par Expr ')' { Tip.Parser.AbsTIP.FormulaPar $1 (reverse $2) $4 $5 }
Assertion :: { Assertion }
Assertion : 'assert' { Tip.Parser.AbsTIP.Assert }
          | 'prove' { Tip.Parser.AbsTIP.Prove }
Par :: { Par }
Par : 'par' '(' ListSymbol ')' { Tip.Parser.AbsTIP.Par (reverse $3) }
ConstDecl :: { ConstDecl }
ConstDecl : Symbol ListAttr Type { Tip.Parser.AbsTIP.ConstDecl $1 (reverse $2) $3 }
FunDecl :: { FunDecl }
FunDecl : Symbol ListAttr '(' ListType ')' Type { Tip.Parser.AbsTIP.FunDecl $1 (reverse $2) (reverse $4) $6 }
FunDef :: { FunDef }
FunDef : Symbol ListAttr '(' ListBinding ')' Type Expr { Tip.Parser.AbsTIP.FunDef $1 (reverse $2) (reverse $4) $6 $7 }
FunDec :: { FunDec }
FunDec : '(' Par InnerFunDec ')' { Tip.Parser.AbsTIP.ParFunDec $2 $3 }
       | InnerFunDec { Tip.Parser.AbsTIP.MonoFunDec $1 }
InnerFunDec :: { InnerFunDec }
InnerFunDec : '(' Symbol ListAttr '(' ListBinding ')' Type ')' { Tip.Parser.AbsTIP.InnerFunDec $2 (reverse $3) (reverse $5) $7 }
Datatype :: { Datatype }
Datatype : '(' Symbol ListAttr ListConstructor ')' { Tip.Parser.AbsTIP.Datatype $2 (reverse $3) (reverse $4) }
Constructor :: { Constructor }
Constructor : '(' Symbol ListAttr ListBinding ')' { Tip.Parser.AbsTIP.Constructor $2 (reverse $3) (reverse $4) }
Binding :: { Binding }
Binding : '(' Symbol Type ')' { Tip.Parser.AbsTIP.Binding $2 $3 }
LetDecl :: { LetDecl }
LetDecl : '(' Symbol Expr ')' { Tip.Parser.AbsTIP.LetDecl $2 $3 }
Type :: { Type }
Type : Symbol { Tip.Parser.AbsTIP.TyVar $1 }
     | '(' Symbol ListType ')' { Tip.Parser.AbsTIP.TyApp $2 (reverse $3) }
     | '(' '=>' ListType ')' { Tip.Parser.AbsTIP.ArrowTy (reverse $3) }
     | 'Int' { Tip.Parser.AbsTIP.IntTy }
     | 'Real' { Tip.Parser.AbsTIP.RealTy }
     | 'Bool' { Tip.Parser.AbsTIP.BoolTy }
Expr :: { Expr }
Expr : PolySymbol { Tip.Parser.AbsTIP.Var $1 }
     | '(' Head ListExpr ')' { Tip.Parser.AbsTIP.App $2 (reverse $3) }
     | '(' 'match' Expr ListCase ')' { Tip.Parser.AbsTIP.Match $3 (reverse $4) }
     | '(' 'let' '(' ListLetDecl ')' Expr ')' { Tip.Parser.AbsTIP.Let (reverse $4) $6 }
     | '(' Binder '(' ListBinding ')' Expr ')' { Tip.Parser.AbsTIP.Binder $2 (reverse $4) $6 }
     | Lit { Tip.Parser.AbsTIP.Lit $1 }
Lit :: { Lit }
Lit : Integer { Tip.Parser.AbsTIP.LitInt $1 }
    | '-' Integer { Tip.Parser.AbsTIP.LitNegInt $2 }
    | 'true' { Tip.Parser.AbsTIP.LitTrue }
    | 'false' { Tip.Parser.AbsTIP.LitFalse }
Binder :: { Binder }
Binder : 'lambda' { Tip.Parser.AbsTIP.Lambda }
       | 'forall' { Tip.Parser.AbsTIP.Forall }
       | 'exists' { Tip.Parser.AbsTIP.Exists }
Case :: { Case }
Case : '(' 'case' Pattern Expr ')' { Tip.Parser.AbsTIP.Case $3 $4 }
Pattern :: { Pattern }
Pattern : 'default' { Tip.Parser.AbsTIP.Default }
        | '(' Symbol ListSymbol ')' { Tip.Parser.AbsTIP.ConPat $2 (reverse $3) }
        | Symbol { Tip.Parser.AbsTIP.SimplePat $1 }
        | Lit { Tip.Parser.AbsTIP.LitPat $1 }
Head :: { Head }
Head : PolySymbol { Tip.Parser.AbsTIP.Const $1 }
     | '@' { Tip.Parser.AbsTIP.At }
     | 'ite' { Tip.Parser.AbsTIP.IfThenElse }
     | 'and' { Tip.Parser.AbsTIP.And }
     | 'or' { Tip.Parser.AbsTIP.Or }
     | 'not' { Tip.Parser.AbsTIP.Not }
     | '=>' { Tip.Parser.AbsTIP.Implies }
     | '=' { Tip.Parser.AbsTIP.Equal }
     | 'distinct' { Tip.Parser.AbsTIP.Distinct }
     | '+' { Tip.Parser.AbsTIP.NumAdd }
     | '-' { Tip.Parser.AbsTIP.NumSub }
     | '*' { Tip.Parser.AbsTIP.NumMul }
     | '/' { Tip.Parser.AbsTIP.NumDiv }
     | 'div' { Tip.Parser.AbsTIP.IntDiv }
     | 'mod' { Tip.Parser.AbsTIP.IntMod }
     | '>' { Tip.Parser.AbsTIP.NumGt }
     | '>=' { Tip.Parser.AbsTIP.NumGe }
     | '<' { Tip.Parser.AbsTIP.NumLt }
     | '<=' { Tip.Parser.AbsTIP.NumLe }
     | 'to_real' { Tip.Parser.AbsTIP.NumWiden }
PolySymbol :: { PolySymbol }
PolySymbol : Symbol { Tip.Parser.AbsTIP.NoAs $1 }
           | '(' '_' Symbol ListType ')' { Tip.Parser.AbsTIP.As $3 (reverse $4) }
Attr :: { Attr }
Attr : Keyword { Tip.Parser.AbsTIP.NoValue $1 }
     | Keyword Symbol { Tip.Parser.AbsTIP.Value $1 $2 }
ListLetDecl :: { [LetDecl] }
ListLetDecl : {- empty -} { [] }
            | ListLetDecl LetDecl { flip (:) $1 $2 }
ListCase :: { [Case] }
ListCase : {- empty -} { [] } | ListCase Case { flip (:) $1 $2 }
ListExpr :: { [Expr] }
ListExpr : {- empty -} { [] } | ListExpr Expr { flip (:) $1 $2 }
ListDatatype :: { [Datatype] }
ListDatatype : {- empty -} { [] }
             | ListDatatype Datatype { flip (:) $1 $2 }
ListConstructor :: { [Constructor] }
ListConstructor : {- empty -} { [] }
                | ListConstructor Constructor { flip (:) $1 $2 }
ListBinding :: { [Binding] }
ListBinding : {- empty -} { [] }
            | ListBinding Binding { flip (:) $1 $2 }
ListSymbol :: { [Symbol] }
ListSymbol : {- empty -} { [] }
           | ListSymbol Symbol { flip (:) $1 $2 }
ListType :: { [Type] }
ListType : {- empty -} { [] } | ListType Type { flip (:) $1 $2 }
ListFunDecl :: { [FunDecl] }
ListFunDecl : {- empty -} { [] }
            | ListFunDecl FunDecl { flip (:) $1 $2 }
ListFunDef :: { [FunDef] }
ListFunDef : {- empty -} { [] }
           | ListFunDef FunDef { flip (:) $1 $2 }
ListFunDec :: { [FunDec] }
ListFunDec : {- empty -} { [] }
           | ListFunDec FunDec { flip (:) $1 $2 }
ListAttr :: { [Attr] }
ListAttr : {- empty -} { [] } | ListAttr Attr { flip (:) $1 $2 }
Symbol :: { Symbol }
Symbol : UnquotedSymbol { Tip.Parser.AbsTIP.Unquoted $1 }
       | QuotedSymbol { Tip.Parser.AbsTIP.Quoted $1 }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
}

