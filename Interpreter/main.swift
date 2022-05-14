import Foundation

let DEBUG = true

let toInterpret = try! String.init(contentsOfFile: "/Users/michel/Desktop/test.qs")

let start = DispatchTime.now()

let scanner = Scanner(source: toInterpret)
let (tokens, scanErrors) = scanner.scanTokens()
print("----- Scanner -----")
print("Scanned tokens")
debugPrintTokens(tokens: tokens)
print("\nErrors")
print(scanErrors)

print("----- Parser -----")
let parser = Parser(tokens: tokens)
let (stmts, classStmts, parseErrors) = parser.parse()
print("Parsed AST")
let astPrinter = AstPrinter()
print(astPrinter.printAst(stmts))
print("\nErrors")
print(parseErrors)

print("----- Templater -----")
let templater = Templater()
let (templatedStmts, templateErrors) = templater.expandClasses(statements: stmts, classStmts: classStmts)
print("Templated AST")
print(astPrinter.printAst(templatedStmts))
print("\nErrors")
print(templateErrors)

let end = DispatchTime.now()
let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
let timeInterval = Double(nanoTime) / 1_000_000

print("Execution time \(timeInterval) ms")
