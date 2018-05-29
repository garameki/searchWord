#encoding:shift_jis

class HolidayError < Exception

	attr_reader :name,:message,:exception,:inspect,:backtrace

	def initialize
		super()
		n_caller = caller.size
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-1).first
			file1 = $1
			line1 = $2.to_i
			method1 = $3
		end
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-2).first
			file2 = $1
			line2 = $2.to_i
			method2 = $3
		end
		@message = "in `"+method1+"' : using holiday  for `"+method2+"':Object"
	end
end




class FileNotFoundError < Exception

	attr_reader :name,:message,:exception,:inspect,:backtrace

	def initialize
		super()
		n_caller = caller.size
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-1).first
			file1 = $1
			line1 = $2.to_i
			method1 = $3
		end
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-2).first
			file2 = $1
			line2 = $2.to_i
			method2 = $3
		end
		@message = "in `"+method1+"' : file not found  for `"+method2+"':Object"
	end
end



class DateInvalidError < Exception

	attr_reader :name,:message,:exception,:inspect,:backtrace

	def initialize
		super()
		n_caller = caller.size
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-0).first
			file1 = $1
			line1 = $2.to_i
			method1 = $3
		end
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-0).first
			file2 = $1
			line2 = $2.to_i
			method2 = $3
		end
		@message = "in `"+method1+"' : 日付が適当ではありません  for `"+method2+"':Object"
	end
end


class ValueInvalidError < Exception

	attr_reader :name,:message,:exception,:inspect,:backtrace

	def initialize
		super()
		n_caller = caller.size
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-0).first
			file1 = $1
			line1 = $2.to_i
			method1 = $3
		end
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-0).first
			file2 = $1
			line2 = $2.to_i
			method2 = $3
		end
		@message = "in `"+method1+"' : 値が適当ではありません  for `"+method2+"':Object"
	end
end


class EnvironmentNilError < Exception

	attr_reader :name,:message,:exception,:inspect,:backtrace

	def initialize
		super()
		n_caller = caller.size
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-0).first
			file1 = $1
			line1 = $2.to_i
			method1 = $3
		end
		if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(n_caller-0).first
			file2 = $1
			line2 = $2.to_i
			method2 = $3
		end
		@message = "in `"+method1+"' : 環境変数の値がnilです  for `"+method2+"':Object"
	end
end
