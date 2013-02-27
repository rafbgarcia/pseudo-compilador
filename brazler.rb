module Brazler

	def self.get_operations(code_lines)
		operacoes = []

		code_lines.each do |line|
			code = self.get_operation(line)
			if code != nil
				operacoes << code
			end
		end

		operacoes
	end


	private

	def self.get_operation(text)
		operations = self.operations

		operations.each do |code, regex|
			vars = regex.match(text)

			next if vars == nil

			return case code
				when :if then {code: code, value1: vars[1], op: vars[2], value2: vars[3], exp: vars[0]}
				when :for then {code: code, value1: vars[1], value2: vars[2], exp: vars[0]}
				when :var then {code: code}
				when :end then {code: code}
				when :mostre then {code: code, value1: vars[1], exp: vars[0]}
				when :atribuicao then {code: code}
				when :var_com_atribuicao then {code: code}

				# DEBUG
				else throw "Code: #{code} ; Text: #{text} ; Regex: #{regex}"
			end
		end

		return nil
	end

	# só está aceitando numeros como valores
	# declaração de variavel apenas do tipo inteiro
	def self.operations
		{
			:if => /^se\s+(\d+)\s+(<|>|==)\s+(\d+)$/i,
			:for => /^para\s+(\d+)\s+ate\s+(\d+)$/i,
			:var => /^int\s+(\w)$/,
			:atribuicao => /^(\w)\s*\=\s*(\d+)$/,
			:var_com_atribuicao => /^int\s+(\w)\s*\=\s*(\d+)$/,
			:mostre => /^\s+mostre\s+(\d+)$/,
			:end => /^fim$/
		}
	end

end
