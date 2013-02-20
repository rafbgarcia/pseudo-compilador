module Parser

	# Pega as linhas do arquivo e retira
	# as linhas que não têm código
	def self.parse_file(filename)
		file_lines = File.readlines(filename)
		file_lines.delete_if { |line| line == "\n" }
	end

end
