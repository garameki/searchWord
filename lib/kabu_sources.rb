#encoding : shift_jis

require "date"

require "kconv"
lib = ENV["RUBY_KABU_LIBRARY"].tosjis
require lib+"kabu_global_variables.rb"
require lib+"kabu_modules.rb"
require lib+"kabu_filenames.rb"





	class Sources
		

#		attr :hiduke

		attr :flag_ready
		attr :tangenHash,:tangen,:tangenFields
		attr :sbidataHash,:sbidata,:sbidataFields
		attr :hiashiHash,:hiashi,:hiashiFields
		attr :canbuyHash,:canbuy,:canbuyFields
		attr :rizayaCanbuyHash,:rizayaCanbuy,:rizayaCanbuyFields
		attr :kdbHash,:kdb,:kdbFields
		attr :bunkatuHash,:bunkatu,:bunkatuFields
		attr :heigouHash,:heigou,:heigouFields

		def initialize(date,flag_tangen=false,flag_sbi=false,flag_hiashi=false,flag_canbuy=false,flag_rizayaCanbuy=false,flag_kdb=false,flag_bunkatu=false,flag_heigou=false)

			@hiduke = date
			@flag_ready=true

			if flag_tangen || flag_sbi || flag_hiashi || flag_canbuy || flag_rizayaCanbuy || flag_kdb

				if weekday?(date,false)
				else
					puts "平日ではありません。error in Source"
					fail(HolidayError)
				end
			end


			if flag_tangen

#注意				@tangenHash=Hash.new(Hash.new({}))←これは意味ない
				@tangenHash=Hash.new#これでいい。二次元めは、キーごとにHash.newする！！！
				@tangen=Array.new
				filename = makeFilepathUnit(@hiduke)
				@tangen = into_array_from_file(filename,false)
				if @tangen==false
					@flag_ready=false
				else
					@tangenFields = intoHashFromFieldsOfArray(sliceFields(@tangen))

					@tangen.each{|brand|
						@tangenHash[brand[@tangenFields["コード"]]] = Hash.new#ハッシュの二次元目はキーごとに、いちいち作る！！
						@tangenFields.each{|field,value|#←ハッシュのeachはこれに注意
							@tangenHash[brand[@tangenFields["コード"]]][field] = brand[value]
						}
					}
				end
			end#if

			if flag_sbi

				@sbidataHash=Hash.new	
				@sbidata=Array.new
				filename= makeFilepathSbiBrands(@hiduke)
				@sbidata= into_array_from_file(filename,false)
				if @sbidata==false
					@flag_ready=false
				else
					@sbidataFields = intoHashFromFieldsOfArray(sliceFields(@sbidata))
					@sbidata.each{|brand|
						@sbidataHash[brand[@sbidataFields["コード"]]] = Hash.new#ハッシュの二次元目はキーごとに、いちいち作る！！
						@sbidataFields.each{|field,value|#←ハッシュのeachはこれに注意
							@sbidataHash[brand[@sbidataFields["コード"]]][field] = brand[value]
						}
					}
				end
			end#if
				
			if flag_hiashi

				@hiashiHash=Hash.new
				@hiashi=Array.new
				filename= makeFilepathHiashi(@hiduke)
				@hiashi= into_array_from_file(filename,false)
				if @hiashi==false
					@flag_ready=false
				else
					@hiashiFields = intoHashFromFieldsOfArray(sliceFields(@hiashi))
					@hiashi.each{|brand|
						@hiashiHash[brand[@hiashiFields["コード"]]] = Hash.new#ハッシュの二次元目はキーごとに、いちいち作る！！
						@hiashiFields.each{|field,value|#←ハッシュのeachはこれに注意
							@hiashiHash[brand[@hiashiFields["コード"]]][field] = brand[value]
						}
					}
				end
			end#if

			if flag_canbuy

				@canbuyHash=Hash.new
				@canbuy=Array.new
				filename= makeFilepathCanBuy(@hiduke)
				@canbuy= into_array_from_file(filename,false)
				if @canbuy==false
					@flag_ready=false
				else
					@canbuyFields = intoHashFromFieldsOfArray(sliceFields(@canbuy))
					@canbuy.each{|brand|
						@canbuyHash[brand[@canbuyFields["コード"]]] = Hash.new#ハッシュの二次元目はキーごとに、いちいち作る！！
						@canbuyFields.each{|field,value|#←ハッシュのeachはこれに注意
							@canbuyHash[brand[@canbuyFields["コード"]]][field] = brand[value]
						}
					}
				end
			end#if

			if flag_rizayaCanbuy
				@rizayaCanbuyHash=Hash.new
				@rizayaCanbuy=Array.new
				filename= makeFilepathRizayaCanbuy(@hiduke)
				@rizayaCanbuy= into_array_from_file(filename,false)
				if @rizayaCanbuy==false
					@flag_ready=false
				else
					@rizayaCanbuyFields = intoHashFromFieldsOfArray(sliceFields(@rizayaCanbuy))
					@rizayaCanbuy.each{|brand|
						@rizayaCanbuyHash[brand[@rizayaCanbuyFields["コード"]]] = Hash.new#ハッシュの二次元目はキーごとに、いちいち作る！！
						@rizayaCanbuyFields.each{|field,value|#←ハッシュのeachはこれに注意
							@rizayaCanbuyHash[brand[@rizayaCanbuyFields["コード"]]][field] = brand[value]
						}
					}
				end
			end#if


			if flag_kdb
				#kdb.comからのファイルを読み、東証1部のデータを、日足ファイルとして保存する
				@kdb        = Array.new
				filename = makeFilepathKdbCsvAtKabudata(@hiduke)
				@kdb = into_array_from_file(filename,false)
				if @kdb==false
					@flag_ready=false
				else
					@kdbFields = intoHashFromFieldsOfArray(sliceFields(@kdb))#フィールド部分を切り取る

					@kdbHash=Hash.new
					@kdb.each{|brand|
						@kdbHash[brand[@kdbFields["コード"]]] = Hash.new#ハッシュの二次元目はキーごとに、いちいち作る！！
						@kdbFields.each{|field,value|#←ハッシュのeachはこれに注意
							@kdbHash[brand[@kdbFields["コード"]]][field] = brand[value]
						}
					}
	
					#ダウンロードしたファイルなので、フィールドの変更がいきなりされる可能性があるのでチェックする。
					fieldsNow = ["コード","銘柄名","市場","始値","高値","安値","終値","出来高","売買代金"]#今までのフィールド
					if checkFields(fieldsNow,@kdbFields)#１次元配列と、ハッシュ
					else
						print filename
						puts "→フィールドが今までと異なります。確認してください。"
						エラー
					end
				end
			end#if boolen



			if flag_bunkatu	
				#整形されたファイルを読み、株式分割された銘柄を格納する
				@bunkatu        = Array.new
				filename = makeFilepathKabuBunkatu()
				@bunkatu = into_array_from_file(filename,true)#二重配列
				if @bunkatu==false
					@flag_ready=false
				else
					@bunkatuFields = intoHashFromFieldsOfArray(sliceFields(@bunkatu))#フィールド部分を切り取る
					@bunkatuHash=Hash.new
					@bunkatu.each{|brandData|#for Array

						code = brandData[@bunkatuFields["コード"]]
						dateString = brandData[@bunkatuFields["日付"]]
						if @bunkatuHash.include?(code)
						else
							@bunkatuHash[code] = Hash.new
						end
						@bunkatuHash[code][dateString]=Hash.new#ハッシュの二次元目はキーごとに、いちいち作る！！
						@bunkatuHash[code][dateString]["分割前"]=brandData[@bunkatuFields["分割前"]]#ちなみに、１つ目の分割後と２つ目の分割後の文字を合わせる必要はない１つ目の分割後はこの変数を後で使用するコードのために用いて、２つめの分割後はソースファイルに合わせればよい。ただ、過去のソースファイルがある場合には、新しいファイルのフィールドの意味は同じだがフィールド名が変わってしまった新しいフィールド名を２つ目の分割後にあわせなくてはいけない

						@bunkatuHash[code][dateString]["分割後"]=brandData[@bunkatuFields["分割後"]]

					}

				end

			end#if boolen


			if flag_heigou	
				#整形されたファイルを読み、株式分割された銘柄を格納する
				@heigou        = Array.new
				filename = makeFilepathKabuHeigou()
				@heigou = into_array_from_file(filename,true)#二重配列
				if @heigou==false
					@flag_ready=false
				else
					@heigouFields = intoHashFromFieldsOfArray(sliceFields(@heigou))#フィールド部分を切り取る
					@heigouHash=Hash.new
					@heigou.each{|brandData|#for Array

						code = brandData[@heigouFields["コード"]]
						dateString = brandData[@heigouFields["日付"]]
						if @heigouHash.include?(code)
						else
							@heigouHash[code] = Hash.new
						end
						@heigouHash[code][dateString]=Hash.new#ハッシュの二次元目はキーごとに、いちいち作る！！
						@heigouHash[code][dateString]["併合前"]=brandData[@heigouFields["併合前"]]
						@heigouHash[code][dateString]["併合後"]=brandData[@heigouFields["併合後"]]

					}

				end

			end#if boolen


		end#def

	end#class Sources

