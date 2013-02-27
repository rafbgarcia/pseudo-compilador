class Translator

	def self.translate(operations)
		map = self.translations
		assembly = []
		assembly << ".text"

		label_counter = 1
		block = false

		operations.each_with_index do |o, i|
			if o

# IF
				if o[:code] == :if
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
					operations[i..operations.size-1].each do |o2|
						if o2 && o2[:code] == :mostre
							assembly << nil
							assembly << "\t # #{o2[:exp].strip}"
							assembly << "\t addi $4, $0, #{o2[:value1]}"
							assembly << "\t addi $2, $0, 1"
							assembly << "\t syscall"
						end

						break if o2 && o2[:code] == :end
					end

					# Label que sera usado para não entrar no IF
					assembly << "lbl#{label_counter}:"

					# Incrementa o label para não repetir
					label_counter += 1

					assembly << nil

# FOR
				elsif o[:code] == :for
					# Comentário para saber qual a expressão
					assembly << "\t # #{o[:exp]}"

					# Label de controle do for
					assembly << "lbl#{label_counter}:"

					# Insere valores nos registradores
					assembly << "\t addi $10, $0, #{o[:value1]}"
					assembly << "\t addi $11, $0, #{o[:value2]}"


					# Aqui é o código dentro do FOR
					operations[i..operations.size-1].each do |o2|
						break if o2 && o2[:code] == :end

						if o2 && o2[:code] == :mostre
							assembly << nil
							assembly << "\t # #{o2[:exp].strip}"
							assembly << "\t addi $4, $0, #{o2[:value1]}"
							assembly << "\t addi $2, $0, 1"
							assembly << "\t syscall"
						end
					end


					# Incremento
					assembly << nil
					assembly << "\t # Incremento"
					assembly << "\t addi $10, $10, 1"

					# Condição
					assembly << nil
					assembly << "\t # Enquanto for menor que $11, volta pra lbl#{label_counter}"
					assembly << "\t blt $10, $11, lbl#{label_counter}"

					# Incrementa o label para não repetir
					label_counter += 1

				end

# END
			end
		end

		assembly.join("\n")
	end

	def self.translations
		{
			op: {
				'<' => 'bge',
				'>' => 'ble',
				'==' => 'bne'
			}
		}
	end

end
