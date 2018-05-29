#encoding: shift_jis

require "open-uri"
require "kconv"
require "date"

#注意 ここはモジュールなので汎用性を高めるため、グローバル変数、静的な変数は使わない。では、環境変数はどうなの？




	#フォルダを移動する
	def moveFile(path_old,path_new)
		#path_old.....String 移動元のファイルのフルネーム
		#path_new...String 移動先のファイルのフルネーム

		#成功true
		#失敗false
		

		print path_new
		if File.exist?(path_new)
			puts "→存在。移動及び置き換えをしない"
		else
			puts "→非存在。続行。"
	
			print path_old
			if File.exist?(path_old)
				puts "→存在。移動します"

				if File.rename(path_old,path_new)
				else
					puts "ファイルの移動に失敗しました"
					print "移動前:",path_old;puts
					print "移動後:",path_new;puts				
					return false
				end
			else
				puts "→非存在。移動元がありません。"
				return false
			end
		end

		return true
	end#def





	#フィールドが変化していないかチェックする
	def checkFields(fieldsUpToNow,fields)
		#fieldsUpToNow.....一次元配列[String,.....]
		#fields........................ハッシュ

		flag = true
		fieldsUpToNow.each{|x|
			if fields.include?(x)
			else
				print "今まであったフィールド名が存在しません→",x;puts
				flag = false
			end
		}
		fields.each{|name,value|#fieldsはハッシュです
			if fieldsUpToNow.include?(name)
			else
				print "今までになかったフィールド名が存在します→",name;puts
				flag = false
			end
		}

		return flag

	end#def





	#バッチファイルのリダイレクションを用いたパイプを使って、標準入力から日付を取り込むtangen.batなどを参照してください。
	def gets_hiduke()

		if ENV["RUBY_REDIRECT"]=="on"
			print "リダイレクトから日付を読みます。ファイル名：";puts ENV["RUBY_FILENAME"]

			stdin_temp = $stdin.dup
			$stdin.reopen(ENV["RUBY_FILENAME"])

			y = gets.to_i
			m = gets.to_i
			d = gets.to_i

			$stdin.reopen stdin_temp

			print "redirection===",y,",",m,",",d
			puts

			flag_te = false


		else
			puts "手動で入力します"

			flag_te = true
		end


		while true
			if !flag_te
				begin
print "日付の評価：　"
					date = Date.new(y,m,d)
				rescue
					print y,"年",m,"月",d,"日";puts "←入力された日付が適当ではありません。確認してください。"
					y = nil
					m = nil
	
					d = nil

				else
puts "ok。リターンだ"
					return date
				end
			end
print "wwwwwwwwwwwwww y=====";p y
			print  y,"wwww年" if y!=nil
			print m,"wwww月" if m!=nil
			print d,"wwww日" if d!=nil
			puts
		
			if y==nil
				print "年 ?  "
				y = gets.to_i
			end
			if m==nil
				print "の何月 ?  "
				m = gets.to_i
			end
			if d==nil
				print "の何日 ?  "
				d = gets.to_i
			end
			flag_te = false#初期設定やリダイレクションで読み込んだのと同じ状態になったことを示す
		end#while true
	end#def




	#2016-06-09 04:55:28 +0900をTimeクラスにする

	def timeFromString(string)

		a = /(?<year>[0-9][0-9][0-9][0-9])-(?<month>[0-9][0-9])-(?<day>[0-9][0-9]).(?<hour>[0-9][0-9]):(?<min>[0-9][0-9]):(?<sec>[0-9][0-9]).(?<hh>[+,-][0-9][0-9])(?<mm>[0-9][0-9])/.match(string)
		if a == nil
			print "string="
			p string
			puts "stringの構文が間違っています。"
			puts "正しい例：\"2016-06-09 04:55:28 +0900\""
			fail(StandardError)
		end
		time = Time.new(a["year"],a["month"],a["day"],a["hour"],a["min"],a["sec"],a["hh"]+":"+a["mm"])

		return time

	end#def


	#2016-06-09 をDateクラスにする

	def dateFromString(string)

		a = /(?<year>[0-9][0-9][0-9][0-9])-(?<month>[0-9][0-9])-(?<day>[0-9][0-9])/.match(string)
		if a == nil
			puts
			print string,"は日付のStringではありません"
			エラー
		end
		date = Date::new(a["year"].to_i,a["month"].to_i,a["day"].to_i)

		return date

	end#def








	#ある日の前の営業日を帰す
	def zenEigyoubi(day,hyouji=true)
		#day...Date

		while true

			if weekday?(day,hyouji)
				ystday = day -1
				while true
					if weekday?(ystday,hyouji)
						break
					else
						ystday -= 1
						next
					end#if
				end#while2
				break
			else
				day -= 1
				next
				
			end#if


		end#while1


		return ystday
	
	end#def




	def makeInnerConnect(table1,n1,table2,n2,members)
		#table1....Array 	@hiashi日足ファイルデータ
		#n1........Numeric 	コードの列番号（要素番号）
		#table2....Array 	@tangen単元ファイルデータ
		#n2........Numeric 	コードの列番号（要素番号）
		#members...Array 	コードが入った配列→最小集合

		#コードをキーとした内部結合を返す

		keys = Array.new
		0.upto(members.size-1){|j|
			x=members[j]
#print "x=";puts x

			n_table1 = nil
			0.upto(table1.size-1){|i|
				if table1[i][n1] == x
					n_table1 = i
					break	
				end
				
			}

			n_table2 = nil
			0.upto(table2.size-1){|i|
				if table2[i][n2] == x
					n_table2 = i
					break	
				end
			}
			if n_table1 == nil || n_table2 == nil
				print "code=",x;puts
				エラーです。コードが存在しません。
			end
			keys << [x,n_table1,n_table2,j]
		}
print "keys=";p keys
		return keys

	end#def


	def intoHashFromFieldsOfArray(arr)#フィールド名が配列番号を返すための処理
		hash = Hash.new
		i = 0
		while true
			field = arr[i]
			if field != nil
				hash.store(field,i)
				i += 1
			else
				break
			end
		end
		
		return hash

	end#def

	
	def sliceFields(arr)
		#arr...[][] 二次元
		
		#return []


		#１行目にフィールド名だったらそれを返す
		#フィールド部分は配列から取り除かれる
		
		if /[0-9][0-9][0-9][0-9]/=~arr[0][0]
			#１行１列目がコードの場合
			puts "フィールドがない"
			ストップ
			return nil
		else
			ret = arr[0]
			arr.delete_at(0)
			return ret
		end

	end



	def print_today()
		tdy = Date::today
		tdy_time = Time.now
		wdays = ["日","月","火","水","木","金","土","日"]
		print "今日は",tdy.to_s,"(",wdays[tdy_time.wday],")です。";puts
	end


	def check_wday(ddd,flag_print=true)#日付を読み込んで祝日かチェック####################################
		#input
			#ddd...Dateクラス

		#output
			#false...dddがshukujituに入ってる場合
			#true....それ以外の場合


		shukujitsu =[	[2013,[
					[1,[1,2,3,4,14]],
					[2,[11]],
					[3,[20]],
					[4,[29]],
					[5,[3,6]],
					[6,[]],
					[7,[15]],
					[8,[]],
					[9,[16,23]],
					[10,[14]],
					[11,[4]],
					[12,[23,31]]
				]],
				[2014,[
					[1,[1,2,3,13]],
					[2,[11]],
					[3,[21]],
					[4,[4,5,6,7,8,29]],
					[5,[5,6]],
					[6,[16,17]],#事情
					[7,[21]],
					[8,[]],
					[9,[15,23]],
					[10,[13]],
					[11,[3,24]],
					[12,[23,31]]
				]],
				[2016,[
					[1,[1,2,3,11]],
					[2,[11]],
					[3,[21]],
					[4,[29]],
					[5,[3,4,5]],
					[6,[]],
					[7,[18]],
					[8,[11]],
					[9,[19,22]],
					[10,[10]],
					[11,[3,23]],
					[12,[23,31]]
				]],
				[2017,[
					[1,[1,2,3,9]],
					[2,[11]],
					[3,[20]],
					[4,[29]],
					[5,[3,4,5]],
					[6,[]],
					[7,[17]],
					[8,[11]],
					[9,[18,23]],
					[10,[9]],
					[11,[3,23]],
					[12,[23,31]]
				]]

		]



#　※注2014年４月の4,5,6,7,8は情報提供サイトのせいで読み込めなくなりました。
#  ※注2014年６月16,17はミスにより個別銘柄を読み込んでいません。
		yy = ddd.year
		mm = ddd.month
		dd = ddd.day

		shukujitsu.each{|x|#各年について
			if x[0].to_i==yy
				x[1].each{|y|#各月について
					if y[0].to_i==mm
						y[1].each{|z|#その月の祝日について
							if z.to_i==dd
								puts "holiday" if flag_print
								return false
							end#if
						}
					end#if
				}
			end#if
		}
		return true

	end#def


	def weekday?(ddd,pri = true)#日付を読み込んで市場がやっているかどうかを判断する##############################
		#input--
		#ddd...Dateクラス
		        #祝日データは手入力です。
	
		#output--
			#true.....平日
			#flase....土日祝祭日

		print ddd.to_s," " if pri
		f = ddd.wday	
		if f == 0 || f == 6 #日曜日or土曜日 の場合
			puts "市場は休み" if pri
			return false
		else
			if check_wday(ddd,pri) #祝日ではない場合
				puts "平日" if pri
				return true
			else
				puts "市場は休み" if pri
				return false
			end#if
		end
	end

	def weekdays(d,n,f)#日付以前(以降)のn日の平日（Dateクラス）を配列に入れて昇順で返す
		#d...Dateクラス
		#n...Integerクラス
		#f...Stringクラス"+"または"-"を指定する

#入力例と出力例がほしい

		ans = []
		i = 0
		if f == "+"
			while i < n
				if weekday?(d)
					ans << d
					d = d + 1
					i = i + 1
				else 
					d = d + 1
				end#if
			end#while
		elsif f=="-"
			while i < n
				if weekday?(d)
					ans << d
					d = d - 1
					i = i + 1
				else 
					d = d - 1
				end#if
			end#while
			ans.sort!
		else
			puts "Error in module (weekdays). The 3rd parameter is wrong.The 3rd parameter have to be \"+\" or \"-\""
			
			return nil
		end#if
		return ans
	end#def


	def weekdays_span(d1,d2)#d1からd2までの平日を昇順で与える
		#d1...Dateクラス
		#d2...Dateクラス
		#d1とd2の順番はかまわない

		if d1 > d2
			temp = d1
			d1 = d2
			d2=temp
		end#if

		ans = []

		i = d1
		while i <= d2

			if weekday?(i)
				ans << i
			end#if
			i = i + 1#１日増やす
		end#while		
		return ans
	end#def


#2016-03-07filepath更新
	###### 新形式　サイトから日付別全銘柄一覧データを取り出し、ファイル filename　に格納する
	def get_hiashi_all_new(url,filepath)
		file2 = File.open(filepath,"w")
		file2.print "コード,銘柄名,始値,高値,安値,終値,出来高,売買代金,クエリ"
		file2.puts
		open(url){|file|
		
			num=0
			while line = file.gets	
				line = line.tosjis#＊＊＊注意ｔ＊＊＊　テキストファイルはUTF-8でコーディングされていること！！
				if num = /tbody/ =~ line
puts "get_hiashi_all_new←ニューバージョン"
print "num=",num
puts
					while num = line.index("<tr>",num)
						numend = line.index("</tr>",num)
	
						num = line.index("ji",num)	#リンク処理①jikeiretsu.aspx?c=1301-T
						numend2 =line.index("T",num)	#リンク処理②
						k_query = line[num..numend2]	#リンク処理③
					
						num = line.index(">",numend2)	#コード処理①>1301-T 極洋</a
						num2 = line.index("</a",num)	#コード処理②
						text = line[num+1..num+4]	#コード処理③
						file2.print text 		#コード出力
					
						text = line[num+8..num2-1]	#銘柄名処理①
						file2.print ",",text 		#銘柄名出力
	
						num = line.index("=l>",num2)	#取引所処理①=l>東証1部</td
						num2 = line.index("</td",num)	#取引所処理②
						basho = line[num+3..num2-1]	#取引所処理③
						
						num = num2
						while num = line.index("<td>",num)	#株価処理①<td>
							if num > numend #このこの銘柄データ終了？</tr>を飛び越えたところに次の<td>が存在するから
								num2 = numend
								break
							else
								file2.print ","
							end
	
							num2 = line.index("</",num)	#株価等処理②1334</td>
							text = line[num+4..num2-1]	#株価等処理③
						
							file2.print text 		#株価等出力（等…始値or高値or安値or終値or出来高or売買代金　だから） 
	
							num = num2
						end
						#file2.print ",",k_query#この部分、やっぱり使わなくなった
						file2.print ",",basho	#取引所出力
						file2.puts
						num = num2#次の<tr>をポイントしている
	
					end
				end
			end
		}
	
		file2.close
	end #メソッド終わり







	def get_hiashi_all_from_url_old(url,filepath)

#更新履歴
#2016-03-07 $folda+file → filepathに変更
#2016-03-07 file.gets→file.read(100000)にて一括ダウンロードするように変更
#2016-03-15 read(100)を採用

#改良点
#2016-03-11このモジュールは1読み込み2構文解析3格納の３つに分割すべき

	###### 旧形式　サイトから日付別全銘柄一覧データを取り出し、ファイル filename　に格納する

		print "url=",url
		puts


		i=0
		accum = ""
		file = open(url,"r")
			while b = file.read(1000)
				accum = accum +b
				i=i+1
			end
		file.close

print "i=",i,"(get_hiashi)"
		if accum==""
			puts "Rejected by html server."
			return nil
		else
			filetext = accum.tosjis#＊＊＊注意ｔ＊＊＊　テキストファイルはUTF-8でコーディングされていること！！
		end

		file2 = File.open(filepath,"w")
		file2.print "コード,銘柄名,始値,高値,安値,終値,出来高,売買代金,クエリ"
		file2.puts

		ln_size = filetext.size
		ln_start = 0
		ln_end = 0#仮


		num=0
		#以下でwhile line = file.getsをやっている	
		while true
			if (ln_end == nil) || (ln_start > ln_size-1) then
				break
			end
			
			ln_end = /\n/ =~ filetext[ln_start .. (ln_size-1)]#例えば、""の中に"\\n"があって、これが改行と間違われても、以下の操作には関係ない
			if ln_end == nil
				line = filetext[ln_start .. ln_size-1]
			else	
				
				line = filetext[ln_start,ln_end+1]
				ln_start = ln_start + ln_end + 1
			end


# 1 #if ln_start>ln_size-300
# 1 #puts line
# 1 #end
			if num = /tbody/ =~ line
puts "get_hiashi_all_from_url←オールドバージョン"
print "2num=",num
puts
#puts line
				while num = line.index("<tr>",num)
					numend = line.index("</tr>",num)
	
					#num = line.index("ji",num)	#リンク処理①jikeiretsu.aspx?c=1301-T	# newと　ここが違う
					#numend2 =line.index("T",num)	#リンク処理②				#　
					#k_query = line[num..numend2]	#リンク処理③				#				
														#
					numend2 = line.index("href",num) #hrefまで進む				# newと　ここが違う
			
					num = line.index(">",numend2)	#コード処理①>1301-T 極洋</a
					num2 = line.index("</a",num)	#コード処理②
					text = line[num+1..num+4]	#コード処理③
					file2.print text 		#コード出力
#print text					
					text = line[num+8..num2-1]	#銘柄名処理①
					file2.print ",",text 		#銘柄名出力
#print ",",text	
					num = line.index("=\'l\'>",num2)	#取引所処理①=l>東証1部</td
					num2 = line.index("</td",num)	#取引所処理②
					basho = line[num+5..num2-1]	#取引所処理③
#print ",",basho
					num = num2
					while num = line.index("<td>",num)	#株価処理①<td>
						if num > numend #このこの銘柄データ終了？</tr>を飛び越えたところに次の<td>が存在するから
							num2 = numend
							break
						else
							file2.print ","
						end
#print ","	
						num2 = line.index("</",num)	#株価等処理②1334</td>
						text = line[num+4..num2-1]	#株価等処理③
#print text
						file2.print text 		#株価等出力（等…始値or高値or安値or終値or出来高or売買代金　だから） 

						num = num2
					end
					#file2.print ",",k_query#この部分、やっぱり使わなくなった
					file2.print ",",basho	#取引所出力
					file2.puts
					num = num2#次の<tr>をポイントしている
#puts

				end
			end
		end

	
		file2.close

puts "finished ------- get_hiashi"
	end #メソッド終わり



















	def into_array_from_file_old(filepath,test=false)

#更新履歴
#2016-03-07 filepath更新

	######### ファイルのデータをStringクラスに変換して配列に格納し返す ################
	#データファイルの中の＃で始まる行は読み込みませんコメントアウト

	#input--
		#filename.....ファイル名
	#output--
		#nil.....空配列
		#arr.....[[],[],...,[],[]](Stringクラスの配列)

print "filepath=",filepath," " if test == true
		if File.exist?(filepath)
puts "exist(into_array_from_file)" if test == true
		else
puts "non-exist(into_array_from)" if test == true
			return nil
		end#if

		arr = []#配列変数を用意
		File.open(filepath){|file|
	
			while line = file.gets
				if line.chomp == "" #空行は飛ばします
				else
					line = line.tosjis #これ、テキストファイルを読み込むときのコツ　読み込むファイルはUTF-8であること！！！
					if line[0].chr == '#'#コメントアウトは読まない
					else
						arr << line.split(/\s*,\s*/)#全てStringクラスとして格納
						n=arr.size		#配列の最後の箱には改行記号が入っているのでこれを削除する
						m=arr[n-1].size		#
						0.upto(m-1){|i|
							arr[n-1][i].chomp!	#最新！！！	
						}
					end#if2
				end#if1
			end#while
		}
		return arr
	
	end #メソッド終わり







	def readFileAtOnce(filepath)

		#filepath...String


		#ファイルを読んでsjisにしてから返す

test = false
#test = true

		puts "readFileAtOnce" if test == true
		print "filepath=",filepath if test == true
		if File.exist?(filepath)
			puts "→存在" if test == true
		else
			print "filepath=",filepath
			puts "→非存在readFileAtOnce" 
			return false
		end

		file = File.open(filepath,"r")
		  i=0
		  accum = ""
		  while true
		    b = file.read(100000)
		    if b == nil
		      break
		    else
		      i += 1
		      accum = accum << b
		    end
		  end
		file.close 
		print "i=",i if test == true ;puts if test == true
		accum.chomp!

		if accum == ""
			print "filepath =",filepath
			puts "fileは空ですreadFileAtOnce()"
			return nil		
		end		

		accum = accum.tosjis

		puts "return from readFileAtOnce()" if test==true
		return accum
	end












	def into_array_from_file(filepath,hyouji=true)

		#filepath...String


test = false
#test = true

		print "filepath=",filepath if test==false && hyouji
		p "filepath=",filepath if test==true
		if File.exist?(filepath)
			puts "→存在" if hyouji



		
			accum = readFileAtOnce(filepath)
			if accum == nil
				print filepath,"空";puts
				return nil
			end

puts accum if test == true


			temp = accum.scan(/.+/)

			arr = Array.new

			temp.each{|x|
				temp = x.split(/\s*,\s*/)

				n = temp.size
				temp[n-1].chomp!
				arr << temp
			}


			return arr
		else
			print filepath if hyouji==false
			puts "→非存在return false(into_array_from_file)"
#			ストップ
			return false
		end
	end




	def into_file_from_array(arr,filename,flag_kyouseikakikomi=false)


	#※※※　　　二重配列をわたすこと！！！！！！！！！！！！！！！！！！

	#########二重配列の中身をファイルに落とす###################


		

		if arr == nil
			puts "配列がnilです(into_file_from_array())"
			return false
		end

		n=arr.size #行の数

		if n == 0
			puts "配列が空です(into_file_from_array())"
			if flag_kyouseikakikomi
				File.open(filename,"w"){
				}
				return true
			end

			return false
		end


		flag_w = false#デフォルトは書き込まない
		flag_exist = File.exist?(filename)

		print filename
		if flag_exist
			print "→存在。"
			if flag_kyouseikakikomi
				puts "上書きしました。"
				flag_w = true
			else
				puts "書き込まない。"
				flag_w = false
			end
		else
			puts "→非存在。作成。"
			flag_w = true
		end
		

	#※※※　　　二重配列をわたすこと！！！！！！！！！！！！！！！！！！
	#※※※　　　二重配列をわたすこと！！！！！！！！！！！！！！！！！！
	#※※※　　　二重配列をわたすこと！！！！！！！！！！！！！！！！！！
	#※※※　　　二重配列をわたすこと！！！！！！！！！！！！！！！！！！
	#joinがきかなくなりますよ


		if flag_w
			f = File.open(filename,"w")
				0.upto(n-2){|i|
					f.print arr[i].join(",")
					f.puts
				}
				f.print arr[n-1].join(",")#ファイルの最後は空行にしない
			f.close
		end

		return flag_w

	end#def












	###### 新形式　サイトから日付個別銘柄データを取り出し、ファイル filename　に格納する
	###### make_file_5funashi_brand(num,day)よりコール
	def get_5funashi_brand_new(url,filepath)
		file2 = File.open(filepath,"w")
#いらない	file2.print "コード,銘柄名,始値,高値,安値,終値,出来高,売買代金(,クエリ)"#クエリいらない
#いらない	file2.puts
puts url
		open(url){|file|
	
			num=0
			while line = file.gets
				line = line.tosjis#＊＊＊注意ｔ＊＊＊　テキストファイルはUTF-8でコーディングされていること！！
				if num = /tbody/ =~ line
#puts line
					while num = line.index("<tr>",num)
						numend = line.index("</tr>",num)

						num = line.index("c>",num)
						num2 =line.index("</td",num)
						text = line[num+13..num2-1]
						file2.print text#時刻
	
						num2 = 0#ダミー
						while num = line.index("<td>",num)
							if num > numend #この銘柄データ終了？
								num2 = numend
								break
							else
								file2.print ","
							end#if

							num2 = line.index("</",num)
							text = line[num+4..num2-1]
						
							file2.print text #始値or高値or安値or終値or出来高or売買代金 
							
							num = num2
						end#while2
						file2.puts
						num = num2
	
					end#while1
				end#if
			end#while
		}
	
		file2.close
	end#def















	def get_5funashi_brand_old(url,filepath)

#更新履歴
#2016-03-08filename→filepath
#2016-03-11 file.gets→File.read()導入とlineの切り取りを追加
	###### 旧形式　サイトから日付個別銘柄データを取り出し、ファイル filename　に格納する
	###### make_file_5funashi_brand(num,day)よりコール
puts url




#新規挿入2016-03-11
		filetext = ""#型宣言
		
		i=0
		accum = ""
		file = open(url)
			while b = file.read(100)
				accum = accum +b
				i=i+1
			end
		
		file.close

print "i=",i,"(get_5~)"
puts
		if accum == ""
			puts "HPサーバにrejectされました"
			return nil
		else
			filetext = accum.tosjis#＊＊＊注意ｔ＊＊＊　テキストファイルはUTF-8でコーディングされていること！！
		end


		file2 = File.open(filepath,"w")
#いらない	file2.print "コード,銘柄名,始値,高値,安値,終値,出来高,売買代金(,クエリ)"#クエリいらない
#いらない	file2.puts

		ln_size = filetext.size
		ln_start = 0
		ln_end = 0#仮


		num=0
		#以下でwhile line = file.getsをやっている	
		while true
			if (ln_end == nil) || (ln_start > ln_size-1) then
				break
			end
			
			ln_end = /\n/ =~ filetext[ln_start .. (ln_size-1)]#例えば、""の中に"\\n"があって、これが改行と間違われても、以下の操作には関係ない
			if ln_end == nil
				line = filetext[ln_start .. ln_size-1]
			else	
				
				line = filetext[ln_start,ln_end+1]
				ln_start = ln_start + ln_end + 1
			end


# 1 #if ln_start>ln_size-300
# 1 #puts line
# 1 #end

#ここまで新規挿入2016-03-11




#新規挿入2016-03-11のためコメントアウト
#		open(url){|file|
#	
#			num=0
#			while line = file.gets
#				line = line.tosjis#＊＊＊注意ｔ＊＊＊　テキストファイルはUTF-8でコーディングされていること！！



				if num = /tbody/ =~ line
#puts line
					while num = line.index("<tr>",num)
						numend = line.index("</tr>",num)

						num = line.index("<td>",num)
						num2 =line.index("</td>",num)
						text = line[num+4..num2-1]
						file2.print text#時刻
	
						num2 = 0#ダミー
						while num = line.index("<td>",num+1)
							if num > numend #この銘柄データ終了？
								num2 = numend
								break
							else
								file2.print ","
							end#if

							num2 = line.index("</td>",num)
							text = line[num+4..num2-1]
						
							file2.print text #始値or高値or安値or終値or出来高or売買代金 
							
							num = num2
						end#while2
						file2.puts
						num = num2
	
					end#while1
				end#if
#新規挿入2016-03-11
		end#while true

#新規挿入2016-03-11のためコメントアウト
#			end#while
#		}

	
		file2.close
		return true
	end#def













				################ソートするファイルの内容が分からないので
                                ################解読できない
	def dsort(arr)#第一条件銘柄昇順　第二条件日付昇順 double sort の略

		#arr...二重配列 例：[[1,2],[1,2],[1,2],[1,2],[1,2]]
		#注意：ポインタが渡されているわけじゃないからarrをreturnしないとデータは消滅する

		n=arr.size

		for i in 0..n-1
			min=arr[i][0].to_i#桁が異なる場合があるので整数型で比較する
			for j in i+1..n-1
				comp = arr[j][0].to_i#整数型
				if min > comp #コードで入れ替え
					temp = arr[i]
					arr[i]=arr[j]
					arr[j]=temp
					min = comp
				elsif min == comp #日付で入れ替え
					if arr[i][4].chomp > arr[j][4].chomp
						temp = arr[i]
						arr[i]=arr[j]
						arr[j]=temp
						min = comp
					end#if2
				end#if1
			end#for2
		end#for1

		return arr



	end#def




	def dsort_2(arr)#第一条件二番目の値降順　第二条件銘柄番号昇順 double sort の略

		#arr...二重配列 例：[[1,2],[1,2],[1,2],[1,2],[1,2]]
		#注意：ポインタが渡されているわけじゃないからarrをreturnしないとデータは消滅する

		n=arr.size

		for i in 0..n-1
			min=arr[i][1].to_f#桁が異なる場合があるので実数整数型で比較する
			for j in i+1..n-1
				comp = arr[j][1].to_f#整数型
				if min < comp #購入株数で入れ替え
					temp = arr[i]
					arr[i]=arr[j]
					arr[j]=temp
					min = comp
				elsif min == comp #コードで入れ替え
					if arr[i][0].chomp > arr[j][0].chomp
						temp = arr[i]
						arr[i]=arr[j]
						arr[j]=temp
						min = comp
					end#if2
				end#if1
			end#for2
		end#for1

		return arr



	end#def


	def print_array(arr)
		n = arr.size
		for i in 0..n-1
			print arr[i].join(",")
			puts
		end#for
	end#def




	################################### 余分なファイルを消すメソッド######################
	### d1からd2までの日付のついたファイルを削除する
	### ファイルの中身までは削除できません　例：extract1-200000-10000.txtとか
	def delete_file(d1,d2)
	#d1…Dateクラス
	#d2…Dateクラス
		
		if d1 < d2

			d1.upto(d2){|d|
				dstring = d.to_s

				Dir::glob("./dayly"+dstring+".txt").each {|f|
					File.delete f
				}	
	
				Dir::glob("./brand*"+dstring+".txt").each {|f|
				  	File.delete f
				}
			}
		elsif d1 > d2
			d1.downto(d2){|d|
				dstring = d.to_s	
	
				Dir::glob("./dayly"+dstring+".txt").each {|f|
					File.delete f
				}	
				Dir::glob("./brand*"+dstring+".txt").each {|f|
				  	File.delete f
				}
			}
		else # d1 = d2
			dstring = d.to_s
			
			Dir::glob("./dayly"+dstring+".txt").each {|f| #全銘柄ファイル
				File.delete f
			}	
			Dir::glob("./brand*"+dstring+".txt").each {|f| #個別銘柄ファイル
			  	File.delete f
			}
		end#if
	end#def












	def file_tosjis(filepath_old,filepath_new)

		#fileの内容をSJISに変更
		
		if File.exist?(filepath_old)
			file = File.open(filepath_old,"r")
			  accum = ""
			  while true
			    b = file.read(1000)
			    if b == nil
			      break
			    else
			      accum = accum + b
			    end
			  end
			file.close
			accum=accum.tosjis
			file = File.open(filepath_new,"w")
			  file.puts accum
			file.close
		else
			print "filepath_old=",filepath_old," 存在しない";puts
		end
	end			





#---------------------- main -----------------------

#file_tosjis("./kabudata/2016-03-25/brand8918.txt","./kabudata/2016-03-25/brand8918-2.txt")





