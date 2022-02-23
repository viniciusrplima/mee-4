package com.pacheco.mee_4;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import java.lang.*;
import java.io.InputStreamReader;
import java_cup.runtime.Symbol;
import java.io.InputStream;


%%

%class Lexer
%type java_cup.runtime.Symbol
%line
%column

%{
    private ComplexSymbolFactory symbolFactory;

    public Lexer(ComplexSymbolFactory f, InputStream is) {
        this(is);
        symbolFactory = f;
    }

    public Symbol symbol(String name, int type) {
        return symbolFactory.newSymbol(name, type);
    }

    public Symbol symbol(String name, int type, Object value) {
        return symbolFactory.newSymbol(name, type, value);
    }

    public Boolean boolValue(String val) {
        if (val.equals("True")) return true;
        else return false;
    }
%}

digit   = [0-9]
int     = {digit}+
real    = {digit}+\.{digit}+
bool    = (True|False)
space   = [ \t\n]
letter  = [_a-zA-Z]
id      = {letter}({letter}|{digit})*
type    = (real|int|str|bool)

%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%%

{int}       { return symbol("INT", sym.INT, Integer.valueOf(yytext())); }
{real}      { return symbol("REAL", sym.REAL, Double.valueOf(yytext())); }
{bool}      { return symbol("BOOL", sym.BOOL, boolValue(yytext())); }
"+"         { return symbol("ADD", sym.ADD); }
"-"         { return symbol("MINUS", sym.MINUS); }
"*"         { return symbol("MULT", sym.MULT); }
"/"         { return symbol("DIV", sym.DIV); }
"and"       { return symbol("AND", sym.AND); }
"or"        { return symbol("OR", sym.OR); }
"not"       { return symbol("NOT", sym.NOT); }
"**"        { return symbol("POW", sym.POW); }
"("         { return symbol("L_BRACKET", sym.L_BRACKET); }
")"         { return symbol("R_BRACKET", sym.R_BRACKET); }
";"         { return symbol("SEMI COLON", sym.SC); }
"="         { return symbol("EQUAL", sym.EQ); }
"print"     { return symbol("PRINT", sym.PRINT); }
{type}      { return symbol("TYPE", sym.TYPE, yytext()); }
{id}        { return symbol("ID", sym.ID, yytext()); }
{space}     {}
.           { System.out.println(String.format("error: unexpected char |%s|\n", yytext())); }
