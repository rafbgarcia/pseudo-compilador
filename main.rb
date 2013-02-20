require './brazler.rb'
require './translator.rb'
require './parser.rb'

code = Parser.parse_file('assets/brazler_code.br')

operations = Brazler.get_operations(code)

assembly = Translator.translate(operations)

File.open("out.asm", 'w+') {|f| f.write(assembly) }
