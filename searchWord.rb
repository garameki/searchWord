#encoding : shift_jis

require "fileutils.rb"

require "kconv"
lib = ENV["LIBRARY_HOME"]
lib=lib.tosjis
require lib+"/kabu_global_variables.rb"
require lib+"/kabu_modules.rb"
require lib+"errorClasses.rb"





#まず、$folda_kabudataが   c:\\.+\\.+\\.+\\.+\\.+\\.+\\   になっていなくてはならないんだよな～
#def initializeにて正規表現を使って確認する必要がある






#========================= ここに正規表現を入れる。


flag_replace = true


word = ENV["SEARCH_WORD"]
if word==nil
	puts;puts
	puts "検索する文字がありません。"
	puts "バッチファイルのローカル環境変数RUBY_WORDを設定してください"
	puts
	fail(StandardError)
end
word = word.tosjis



path = ENV["SEARCH_DIRECTORY"]#ない場合はnil
if path==nil
	puts;puts
	puts
	puts "検索先が設定されていません"
	puts "バッチファイルのローカル環境変数RUBY_KENSAKU_PATHを設定してください"
	puts
	fail(StandardError)
end
path = path.tosjis



class Kensaku
	def initialize(word,folda)
		#word........................Stringだけど表現はRegexp
		#rootfolda_kensaku...String

		if folda == nil
			puts "バッチファイルの環境変数RUBY_PATHを設定してください"
			fail(ValueInvalidError)
		end		
		if folda == ""
			puts "検索フォルダ名が空です。環境変数RUBY_PATHを設定してください"
			fail(ValueInvalidError)
		end
		if word == nil
			puts "バッチファイルの環境変数RUBY_WORDを設定してください"
			fail(ValueInvalidError)
		end		
		if word == ""
			puts "検索ワードが空です。環境変数RUBY_WORDを設定してください"
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
print /#{@word}/,"で"
print "root folda = ",folda,"内を探します";puts


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
			print @regexpString;puts "→正規表現が間違っています"
			puts
			raise(RegexpError)
		rescue
			puts
			print "filename=",filename
			puts
			print "=~のエラーです。mine-typeがことなっていませんか？"
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
			puts "フォルダが存在しません。"
			fail(StandardError)
		end
			
		f.each{|x|
			x = x.tosjis
			if x == "." || x==".."
			else
#puts folda+"\\"+x+"\\"
				if File.directory?(folda+"\\"+x)
					#フォルダの場合

					if /kabudata/=~folda
#puts folda+"\\"+x+"\\"
						search_folda(folda+"\\"+x+"\\")
					else
						search_folda(folda+"\\"+x+"\\")
					end
				else

					#ファイルの場合
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
puts "================== 検索結果 ================="
s.search_folda()
puts "================== 検索終了 ================="

