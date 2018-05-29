#encoding : shift_jis

require "date"

require "kconv"
lib = ENV["RUBY_KABU_LIBRARY"].tosjis
require lib+"errorClasses.rb"
require lib+"kabu_global_variables.rb"
require lib+"kabu_modules.rb"
require lib+"kabu_filenames.rb"
require lib+"kabu_sources.rb"











#インスタンスを複数使ってこそのクラスの意味が出てくる

#インスタンスが持つメンバー変数のデータ。それを加工して新しい情報を取り出すメソッド。そうだ、取り出すのだ。returnをしてこそ、メソッドだ。
#インスタンスに聞くのがメソッド。インスタンスに問いかけるのがメソッド。

#インスタンスの性格を表すものがメンバー変数と捉えればいいのではないか。

#しかし、メンバー変数だけなら、配列をいくつか用意すれば事足りるのでは？インスタンスを作らなくてもいいのではないか？
#早い話、関数と配列で、ことは足りてしまうのではないだろうか。
#オブジェクトを使う意味は何なのだろうか？

#オブジェクトを使うとカテゴライズが楽になるのではないだろうか。
#カテゴリーごとに、インスタンスを作り、そのカテゴリーの性質を分析することができる。それはメソッドに聞けばいい。
#メソッドが充実すればするほど、そのカテゴリーを多面的にとらえることができ、
#他のインスタンスのそれと比較することにより、投資の最適化への方向性が見えてくるのではないか。

#カテゴライズ、つまり、標本の切り分け方は様々ある。
#一時データからカテゴライズすることももちろんできるが、二次情報、三次情報によるカテゴライズも考えられる。
#例えば、「業種分類」、「株価」は一時情報。「利ざやの高低」などは二次情報。利ざやの「分散」、「平均」、「偏差」などは三次情報であり、
#それぞれについて「幅」によるカテゴライズができる。

#さて、どこまでをクラスとして扱えばいいのだろうか。どんな分類分けにも適用できる汎用クラスは存在するのだろうか。

#様々な情報を取り出すには、データベースに見られるような手法を用いるのが一般的だ。
#標本の性質の計算、標本への操作（性質を基にした標本の切り分け、性質を基にした標本同士の結合）のような順列的な操作の繰り返しにより
#取り出したい情報を取り出す。（グラフデータを得る）

#標本への操作は、プログラム上では、インスタンス同士の結合や切り分けということになる。
#標本の性質の計算とは、プログラム上では、メソッドである。

#標本を複数個に分ける。ということは、インスタンスをどう扱えばいいのだろうか。
#インスタンスを30分類する。平たく言えば、銘柄を30のグループに分けるということだ。
#これは、縦の操作だ。

#平均、分散、偏差は縦の操作。

#日付をまたがなくては求められない利ざやは横の操作。
#日付をまたがなくては求められない信用売買の残データも横の操作。

#ほかに何が求められる？
#期待値は計算できる？他の統計量も計算できる？株価予想は？相関係数は？

#兎に角、縦の操作と横の操作で、すべてができそうだ。

#グラフを描く例を挙げよう。基本となる日の明側を、元手で篩分けし（計算、分割）、genreごとに分けて（分割）、genreごとに銘柄の個数を計算、
#利ざやを銘柄ごとに計算、genreごとにrizayaの合計を計算、genreごとに求めた利ザヤをgenreに所属する銘柄の数で割り、ファイルに出力する。
#これらの一つ一つをメソッドにする。そして、それらのメソッドを使うメソッドを作る。細かい方のメソッドは、他の情報を得るのにも再利用できる。





#加工によって得られた情報こそ、メンバー変数にすべきで、tangenやhiashiに格納されているデータをメンバー変数にするのは意味がない。同じことを繰り返しているだけ。
#加工によって得られた情報をさらに加工して、新たな情報をゲットするために、どうクラスを設計するのかが重要なのだ。

















#@@tangenと@@hiashiで賄えるものを新たに@stocksに格納するのもどうかね。→後々の計算速度を考えると、@stockなら、if文が減らせるのでは？



	


class Kabudata

	#全ての基本データをここで読み込む。そして、クラス変数として利用してもらう


	GENRES = [
"水産・農林業",
"卸売業",
"建設業",
"鉱業",
"機械",
"サービス業",
"情報・通信業",
"食料品",
"不動産業",
"陸運業",
"小売業",
"繊維製品",
"電気機器",
"ガラス・土石製品",
"輸送用機器",
"石油・石炭製品",
"化学",
"金属製品",
"パルプ・紙",
"医薬品",
"精密機器",
"ゴム製品",
"鉄鋼",
"非鉄金属",
"証券、商品先物取引業",
"銀行業",
"その他金融業",
"保険業",
"その他製品",
"倉庫・運輸関連業",
"海運業",
"空運業",
"電気・ガス業"
]

	def initialize(dates=[])#super()に対応するために、引数にはデフォルト値を設定しておく。
	

		#全ての銘柄に対する基礎データ
			@genresALL =Array.new#業種分類を格納

		begin
			p @@flag
		rescue 
			@@tangen = Hash.new
			@@hiashi = Hash.new
print "kabu_sources.rb dates[0]=";puts dates[0]
print "kabu_sources.rb dates[1]=";puts dates[1]
			dates[0].upto(dates[1]){|date|
				if weekday?(date,false)
					sources = Sources.new(date,true,false,true)
					if sources.flag_ready
						@@tangen[date.to_s] = sources.tangenHash
						@@hiashi[date.to_s] = sources.hiashiHash
					else
						print "処理中の日付=";puts date.to_s
						えらー
					end
				end
			}
			if checkGenres()
			else
				puts "業種分類に新しい名前がついています。"
				エラー
			end

			#株分割・株併合
			sources = Sources.new(nil,false,false,false,false,false,false,true,true)
			@@bunkatu = sources.bunkatuHash
			@@heigou = sources.heigouHash
		ensure
			@@flag=true
		end
	end

	def checkGenres()
		@@tangen.each{|keyDate,values1|
			values1.each{|code,values2|
				genre= values2["業種分類"]
				if GENRES.include?(genre)
				else
					puts
					puts genre,"→新しい名前"
					return false
				end
			}
		}
		return true
	end


end#class Kabudata




#↓こういうのは意味がないかもしれないが、細かい変更を加えるのには最小単位が小さい方が変更しやすい利点はある。
#理由は、メソッド名は変えなくてもいいのだから
class Stock < Kabudata
	def initialize(code)
	
		@code = code

	end#def

	def name(date)

		return @@tangen[date.to_s][@code]["銘柄名"]

	end#def

	def code()

		return @code

	end#def

	def owarine(date)

		return @@hiashi[date.to_s][@code]["終値"]

	end#def

	def kaerukabusuu(date,motode)

		keyDate = date.to_s
		kingaku = @@tangen[keyDate][@code]["売買単位"].to_f*@@hiashi[keyDate][@code]["終値"].to_f
		kazu=motode.div(kingaku)*@@tangen[keyDate][@code]["売買単位"].to_i
		return kazu


	end#def

	def kabuKazuBairitu(date0,date1)

		#date0...Date購入日Stocksの@hiduke
		#date1...Date売却日

		kabuKazuBairitu = 1.0

		if @@bunkatu[@code]
			@@bunkatu[@code].each{|hiduke,ratios|#@@bunkatu[コード][日付][前/後]=株の数→日付が何日もある場合はどうしている？→違う日を掛け合わせている
				date = dateFromString(hiduke)
				ratio = ratios["分割後"].to_f/ratios["分割前"].to_f
				if date1 < date && date < date0
					kabuKazuBairitu *= 1.0/ratio
				elsif date > date0 && date <date1
					kabuKazuBairitu *= ratio
				end
			}
		end
		if @@heigou[@code]
			@@heigou[@code].each{|hiduke,ratios|
				date = dateFromString(hiduke)
				ratio =  ratios["併合後"].to_f/ratios["併合前"].to_f
				if date1< date && date < date0
					kabuKazuBairitu *= 1.0/ratio
				elsif date > date0 && date1 > date
					kabuKazuBairitu *= ratio
				end
			}
		end
		#print "kabuKazuBairitu=",kabuKazuBairitu;puts

		return kabuKazuBairitu
	end#def

	def rizaya(date0,date1,motode)#Stockは親クラスの基本データを使い情報を返す


		#date0...購入日(Stocksの@dateとか)
		#date1...売却日(eachの|date|とか

		keyDate0 = date0.to_s
		keyDate1 = date1.to_s

		if @@tangen[keyDate0]==nil
			print keyDate0+"は休日です"
			return nil
		elsif @@tangen[keyDate1]==nil
			print keyDate1+"は休日です"
			return nil
		elsif @@tangen[keyDate0][@code]==nil
			print keyDate0+"に"+@code+"は存在しません"
			return nil
		elsif @@tangen[keyDate1][@code]==nil
			print keyDate1+"に"+@code+"は存在しません"
			return nil
		elsif @@hiashi[keyDate0][@code]["終値"] == ""
			print keyDate0+"に"+@code+"は取引がありませんでした。"
			return nil
		elsif @@hiashi[keyDate1][@code]["終値"] == ""
			print keyDate1+"に"+@code+"は取引がありませんでした。"
			return nil
		else	
			kingaku = @@tangen[keyDate0][@code]["売買単位"].to_f*@@hiashi[keyDate0][@code]["終値"].to_f
			kabukazu0=motode.div(kingaku)*@@tangen[keyDate0][@code]["売買単位"].to_i
			bairitu = kabuKazuBairitu(date0,date1)
			kabukazu1=kabukazu0*bairitu
			rizaya = @@hiashi[keyDate1][@code]["終値"].to_f*kabukazu1 - @@hiashi[keyDate0][@code]["終値"].to_f*kabukazu0
			return rizaya
		end



	end#def


end#class


#クラステスト
#date0 = Date.new(2016,9,1)#株を購入した日
#stock = Stock.new("1301")
#date0.upto(Date.new(2016,9,30)){|date|#株を売却した日
#	puts stock.rizaya(date0,date,1000000)
#}













#Stocks←sが付きます


#ある１日の複数の銘柄を扱う
class Stocks<Kabudata

	#計算の基本になる銘柄をメンバー変数にセットする

	attr_reader :hiduke

	def initialize(date)#この日付は途中でもよい、対象を過去までさかのぼって計算することもあるであろうから

		fail(HolidayError) if !weekday?(date)

		@date = date
		@hiduke = date.to_s

		@stocks=Hash.new#@stocks[コード]=Stock←主役のメンバー変数 ここで保持しておく情報を拡張しやすいということでHashを選んだ。Stockオブジェクトが入っている
		#@kabuKazu=Hash.new#←変数を増やすのは拡張性に乏しい(データから取り出せるものはメソッドを定義した方がよい)&コードとの連携はやはりハッシュを使う方が利便性が高い。
					#どちらにせよHashをつかうのならば、上記のメンバー変数をArrayよりもHashにして使う方が効率がいい。
	
	end

	def delete(codes)
		#codes...Array []

		codes.each{|code|
			if @stocks.include?(code)
				@stocks.delete(code)
			end
		}
	end#def


	

	def append(codes=[])
		
		codes.each{|code|
			if @@tangen[@hiduke].include?(code)==false
				puts
				print code,"は",@hiduke,"には、東証１部には存在しません。"
				puts
			elsif @stocks.include?(code)==true
				puts
				print code,"は既にメンバーです。"
				puts
			else
				@stocks[code]=Stock.new(code)
			end
		}
	end


	def setAll()#全銘柄をセット
#print "qq" if @@tangen
#print "ww" if @date
#print "ee" if @@tangen[@hiduke]

		begin
			@@tangen[@hiduke].each{|code,values|
				@stocks[code]=Stock.new(code)
			}
		rescue => error
			print "エラー内容 :";p error.message
			print "日付",@hiduke,"のデータがありません。";puts
			puts "クラス変数@@tangenが使用する日にちについて初期化されていない可能性があります。"
			puts "メイン関数にてKabudataを初期化してください(ダミーのインスタンスを作る)"
			raise error
		end
	end#def


	def reset()

		@stocks.clear
		puts puts "Stocks.reset()";
#		@stocks.each{|a,b|
#			puts a
#		}

	end#def


	def filteringGenre!(genres)#@stocksに入っているものをgenresに入っているものを残して捨てる

		#genres......[]


		genres.each{|genre|
#p Kabudata::GENRES
			if Kabudata::GENRES.include?(genre)
			else
				print "genre=";p genre
				puts "使われていない業種分類名を指定しました。"
				エラー
			end
			@stocks.each{|code,values|
				genre = @@tangen[@hiduke][code]["業種分類"]
				if genres.include?(genre)
				else
					@stocks.delete(code)
				end
			}
		}
	end#def


	def filteringMotode!(motodes)


			#(motode1)円で買える銘柄から(motode0)円で買える銘柄を取り除く

			@motode0 = motodes[0]
			@motode1 = motodes[1]

			@stocks.each{|code,values|
				if @@hiashi[@hiduke][code]["終値"]!=""
					kazu0 = @stocks[code].kaerukabusuu(@date,@motode0)
					kazu1 = @stocks[code].kaerukabusuu(@date,@motode1)

					if kazu0>0 || kazu1 == 0
						@stocks.delete(code)
					elsif kazu1 > 0 && kazu0 == 0
					else
						ありえない
					end
				else
					print code
					puts "--取引がない"
				end
			}

	
	end#def

	def outputGenre()

		#確認用表示
		puts
		@stocks.each{|code,values|
			print "code=",code,"  ",@@tangen[@hiduke][code]["業種分類"]
			puts
			
		}
		puts

	end#def

	def eachNames()

		names = Hash.new
		@stocks.each{|code,stock|
			names[code]=stock.name(@date)
		}

		return names
	end#def


	def members()
		arr = Array.new
		@stocks.each{|code,stock|
			arr << stock.code()
		}
		return arr
	end#def



	def averageKabuka()


		sum=0
		@stocks.each{|code,stock|

			sum += stock.owarine(@hiduke).to_f
		

		}
		ave = sum / @stocks.size

		return ave

	end#def

	def averageRizaya(date,motode)
		#dateとの差


		rizaya = 0

		@stocks.each{|code,stock|
			riz = stock.rizaya(@date,date,motode)
			if riz
				rizaya += riz
			end
		}

		begin
			ave = (rizaya / @stocks.size).round(0)
		rescue
			ave = nil
		end

		return ave

	end#def

	def eachRizayas(date,motode)
		#dateとの差


		rizas = Hash.new
		@stocks.each{|code,stock|
			rizas[code]=stock.rizaya(@date,date,motode)
		}
		#確認の意味も込めての表示
#		@stocks.each{|code,stock|
#			begin
#				puts printf("%5s %+10.0f %s",code,rizaya(@date,date,motode),stock.name])
#			rescue
#			end
#		}

		return rizas#Hash


	end#def


end#class


##クラステスト
#date = Date.new(2016,9,26)
#genres = ["水産・農林業"]
#motodes = [0,10000000]
#
#base = Stocks.new(date)
#base.reset()
#base.setAll()
##base.append(["1301"])
#base.filteringGenre!(genres)
#base.filteringMotode!(motodes)
#base.outputGenre()
#puts
#puts base.averageRizaya(Date.new(2016,9,29),10000000)
#puts
#base.outputEachRizaya(Date.new(2016,9,29),10000000)
#stop
#次に、これらの銘柄を元にして、日付をまたいでrizaya等を計算する
