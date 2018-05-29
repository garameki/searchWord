#encoding : shift_jis

require "fileutils.rb"

require "kconv"
lib = ENV["LIBRARY_HOME"]
lib=lib.tosjis
require lib+"/kabu_global_variables.rb"
require lib+"/kabu_modules.rb"
require lib+"errorClasses.rb"




#for future
#�܂��A$folda_kabudata��   c:\\.+\\.+\\.+\\.+\\.+\\.+\\   �ɂȂ��Ă��Ȃ��Ă͂Ȃ�Ȃ��񂾂�ȁ`
#def initialize�ɂĐ��K�\�����g���Ċm�F����K�v������






#========================= �����ɐ��K�\��������B


flag_replace = true


word = ENV["SEARCH_WORD"]
if word==nil
	puts;puts
	puts "�������镶��������܂���B"
	puts "�o�b�`�t�@�C���̃��[�J�����ϐ�RUBY_WORD��ݒ肵�Ă�������"
	puts "Please set the word to search as environment variable SEARCH_WORD in batch file."
	puts
	fail(StandardError)
end
word = word.tosjis



path = ENV["SEARCH_DIRECTORY"]#�Ȃ��ꍇ��nil
if path==nil
	puts;puts
	puts
	puts "�����悪�ݒ肳��Ă��܂���"
	puts "�o�b�`�t�@�C���̃��[�J�����ϐ�SEARCH_PATH��ݒ肵�Ă�������"
	puts "Please set the path to be searched as environment variable SEARCH_DIRECTORY in batch file"
	puts
	fail(StandardError)
end
path = path.tosjis



class Kensaku
	def initialize(word,folda)
		#word........................String�����Ǖ\����Regexp this string class is regexp class
		#rootfolda_kensaku...String

		if folda == nil
			puts "�o�b�`�t�@�C���̊��ϐ�SEARCH_PATH��ݒ肵�Ă�������"
			puts "Please set SEARCH_PATH in batch file"
			fail(ValueInvalidError)
		end		
		if folda == ""
			puts "�����t�H���_������ł��B���ϐ�SEARCH_PATH��ݒ肵�Ă�������"
			puts "Please set SEARCH_PATH in batch file"
			fail(ValueInvalidError)
		end
		if word == nil
			puts "�o�b�`�t�@�C���̊��ϐ�SEARCH_WORD��ݒ肵�Ă�������"
			puts "Please set SEARCH_WORD in batch file"
			fail(ValueInvalidError)
		end		
		if word == ""
			puts "�������[�h����ł��B���ϐ�SEARCH_WORD��ݒ肵�Ă�������"
			puts "Please set SEARCH_WORD in batch file"
			fail(ValueInvalidError)
		end

		@folda = folda.tosjis

		@word =word.tosjis

#eee
puts;puts
print "@word="
puts @word
puts
print "[ENTER]"
gets()
puts;puts
print "@folda="
puts @folda
puts
print "[ENTER]"
gets()


		@files = []
print /#{@word}/,"��"
print "root folda = ",folda,"����T���܂� searching in ",folda;puts


	end


	def kensaku_word(filename)
		#filename...String

		text = ""
		File.open(filename,"r"){|file|

			text = file.read(file.size)

			text = text.tosjis
		}

		begin 
			if /#{@word}/=~text
			print "hit==>"
				puts filename
				@files << filename
			end
		rescue RegexpError
			puts
			print @regexpString;puts "�����K�\�����Ԉ���Ă��܂� invalid regexp"
			puts
			raise(RegexpError)
		rescue
			if false
				puts
				print "filename=",filename
				puts
				print "=~�̃G���[�ł��Bmine-type��text�ł͂Ȃ��悤�ł� unavailable mine-type"
				puts
			end

			#print "p @word="
			#p @word
			#puts
			#print "p text="
			#p text

			#print "[ENTER]"
			#gets()
			
		end

	end#def
				






	def search_folda(folda=@folda)
	

		begin
			f = Dir::entries(folda)
		rescue
			puts
			print "search=>"
			puts folda
			puts "�t�H���_�����݂��܂���Bno file exists"
			fail(StandardError)
		end
			
		f.each{|x|
			x = x.tosjis
			if x == "." || x==".."
			else
#puts folda+"\\"+x+"\\"
				if File.directory?(folda+"\\"+x)
					#�t�H���_�̏ꍇ

					if /kabudata/=~folda
#puts folda+"\\"+x+"\\"
						search_folda(folda+"\\"+x+"\\")
					else
						search_folda(folda+"\\"+x+"\\")
					end
				else

					#�t�@�C���̏ꍇ
					if x=~/.jpg|.JPG|.bmp|.BMP|.png|.PNG|.accdb|.wav|.pdf|.gif|.GIF|.PDF|.data|.xlsx|.lbr|.[a-z]+#[0-9]+|.brd|.sch|.index/m
					else
						kensaku_word(folda+"\\"+x)
					end
		
				end
			end
		}
	end


end#class






s=Kensaku.new(word,path)
puts "================== �������� ================="
s.search_folda()
puts "================== �����I�� ================="

