#encoding : shift_jis


require "date"

require "kconv"
lib = ENV["RUBY_KABU_LIBRARY"].tosjis
require lib+"kabu_global_variables.rb"
require lib+"kabu_modules.rb"
require lib+"kabu_filenames.rb"
require lib+"kabu_sources.rb"
require lib+"kabu_data.rb"





def outToGraph(date_start,date_end,base,filename,genres=["全て"],motode=0,flag_sort=false)
	#dates...Array []
	#base....Stocks

	members = Array.new

	if weekday?(date_start)
	else
		puts "開始日が平日ではありません。"
		エラー
	end

	dates = Array.new#初めの日date_startから終わりの日date_endまでにある平日
	date_start.upto(date_end){|date|
		if weekday?(date,false)
			dates << date
		end
	}

	stocks=Hash.new
	dates.each{|date|
		stocks[date.to_s]=Hash.new
		stocks[date.to_s]=base.eachRizayas(date,motode)#stocks[日付][コード]
	}
	names = Hash.new
	names = base.eachNames()#Array
#ここまでデータ取得


#ここからデータをグラフ用に加工して出力
	File.open(filename,"w"){|file|

		#タイトルを出力
		title = base.hiduke.to_s+"を基準とした"
		flag_genre = false
		genres.each{|genre|
			if flag_genre
				title += ","
			else
				flag_genre=true
			end
			title += genre
		}
		title += "の個別銘柄の利ざやby"+motode.to_s+"円で買える銘柄"
		file.puts title
#puts title

		#横の値を出力
		flag_date = false
		dates.each{|date|####基本になる日付を含んだ日付の表示

			if flag_date
				file.print ","
#print ","
			else
				flag_date = true
			end
			file.print date
#print date
		}
		file.puts 
#puts

		#縦の値を出力
	
		#出力したい順にするためにデータ構造を変更
		stocksNew=Hash.new

		stocks.each{|dateString,codes|#stocks[日付][コード]=利ざや
			codes.each{|code,rizaya|#どんなコードがあるのか知りたい
				if stocksNew.include?(code)
					stocksNew[code][dateString]=rizaya
				else
					stocksNew[code]=Hash.new
					stocksNew[code][dateString]=rizaya
				end
			}
		}

		#ソート
			arr=Array.new
			stocksNew.each{|code,values|
				arr << [code,values[dates[-1].to_s]]
			}
			arr = dsort_2(arr) if flag_sort	#フラグにより変わる
		
		arr.each{|code,temp|
			members << code
		}

		#値を出力
		flag_1 = false
		arr.each{|code,temp|
			if stocksNew[code]==nil
				next
			end
			if flag_1
				file.puts
#puts
			else
				flag_1 = true
			end
			file.print names[code],","
#print names[code],","
			flag_2 = false
#print "code=",code;
#puts
			stocksNew[code].each{|dateString,rizaya|
				if flag_2
					file.print ","
#print ","
				else
					flag_2 =true
				end
				file.print rizaya
#print rizaya
			}
		}
	}#File

	return members


end#def





