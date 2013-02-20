class Translator

	def self.translate(operations)
		map = self.translations
		assembly = []
		assembly << ".text"

		label_counter = 1
		block = false

		operations.each_with_index do |o, i|
			if o && o[:code] == :if
				# Comentário para saber qual a expressão
				assembly << "\t # #{o[:exp]}"

				# Insere valores nos registradores
				assembly << "\t addi $8, $0, #{o[:value1]}"
				assembly << "\t addi $9, $0, #{o[:value2]}"

				# Condição
				# Se true, não entrará no if, pois o teste é feito ao contrário
				# Ex: op "se 1 < 2" torna-se "se 1 >= 10"
				assembly << "\t #{map[:op][o[:op]]} $8, $9, lbl#{label_counter}"

				# Aqui é o código dentro do IF
				operations[i..operations.size-1].each do |o|
					if o && o[:code] == :mostre
						assembly << nil
						assembly << "\t # #{o[:exp].strip}"
						assembly << "\t addi $4, $0, #{o[:value1]}"
						assembly << "\t addi $2, $0, 1"
						assembly << "\t syscall"
					end

					break if o && o[:code] == :end
				end

				# Label que sera usado para não entrar no IF
				assembly << "lbl#{label_counter}:"

				# Incrementa o label para não repetir
				label_counter += 1
			end
		end

		assembly.join("\n")
	end

	def self.translations
		{
			op: {
				'<' => 'bge'
			}
		}
	end

end
