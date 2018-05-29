#encoding : shift_jis

require "fileutils.rb"

require "kconv"
lib = ENV["LIBRARY_HOME"]
lib=lib.tosjis
require lib+"/kabu_global_variables.rb"
require lib+"/kabu_modules.rb"
require lib+"errorClasses.rb"





#�܂��A$folda_kabudata��   c:\\.+\\.+\\.+\\.+\\.+\\.+\\   �ɂȂ��Ă��Ȃ��Ă͂Ȃ�Ȃ��񂾂�ȁ`
#def initialize�ɂĐ��K�\�����g���Ċm�F����K�v������






#========================= �����ɐ��K�\��������B


flag_replace = true


word = ENV["SEARCH_WORD"]
if word==nil
	puts;puts
	puts "�������镶��������܂���B"
	puts "�o�b�`�t�@�C���̃��[�J�����ϐ�RUBY_WORD��ݒ肵�Ă�������"
	puts
	fail(StandardError)
end
word = word.tosjis



path = ENV["SEARCH_DIRECTORY"]#�Ȃ��ꍇ��nil
if path==nil
	puts;puts
	puts
	puts "�����悪�ݒ肳��Ă��܂���"
	puts "�o�b�`�t�@�C���̃��[�J�����ϐ�RUBY_KENSAKU_PATH��ݒ肵�Ă�������"
	puts
	fail(StandardError)
end
path = path.tosjis



class Kensaku
	def initialize(word,folda)
		#word........................String�����Ǖ\����Regexp
		#rootfolda_kensaku...String

		if folda == nil
			puts "�o�b�`�t�@�C���̊��ϐ�RUBY_PATH��ݒ肵�Ă�������"
			fail(ValueInvalidError)
		end		
		if folda == ""
			puts "�����t�H���_������ł��B���ϐ�RUBY_PATH��ݒ肵�Ă�������"
			fail(ValueInvalidError)
		end
		if word == nil
			puts "�o�b�`�t�@�C���̊��ϐ�RUBY_WORD��ݒ肵�Ă�������"
			fail(ValueInvalidError)
		end		
		if word == ""
			puts "�������[�h����ł��B���ϐ�RUBY_WORD��ݒ肵�Ă�������"
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
print "root folda = ",folda,"����T���܂�";puts


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
			print @regexpString;puts "�����K�\�����Ԉ���Ă��܂�"
			puts
			raise(RegexpError)
		rescue
			puts
			print "filename=",filename
			puts
			print "=~�̃G���[�ł��Bmine-type�����ƂȂ��Ă��܂��񂩁H"
			puts
			#print "p @word="
			#p @word
			#puts
			#print "p text="
			#p text
			print "[ENTER]"
			gets()
			
		end

	end#def
				






	def search_folda(folda=@folda)
	

		begin
			f = Dir::entries(folda)
		rescue
			puts
			print "search=>"
			puts folda
			puts "�t�H���_�����݂��܂���B"
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

