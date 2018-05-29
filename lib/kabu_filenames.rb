#encoding: shift_jis

require "open-uri"
require "kconv"
require "date"


$ruby_home = ENV["RUBY_HOME"].tosjis




#汎用性を高めるためにkabu_global_variables.rbは読まない
#require "./kabu_global_variables.rb"





#あらゆる固有名詞は$変数として定義しておくこと！！！！！
#関数の中で"test.txt"と書いてはならない！！！←今後やる

#ファイル名

$file_backuptime_kabudata = "\\backup\\kabudata\\backuptime_kabudata.txt"
$file_backuptime_scripts    = "\\backup\\scripts\\backuptime_scripts.txt"

#抽出データ　接頭辞にq_を使う(query)
$file_changesInOneDay="q_changesInOneDay.csv"
$file_CountUpDownIn7Days ="q_countUpDownIn7Days.csv"
$file_up ="q_upCanbuy.csv"
$file_down="q_downCanbuy.csv"
$file_canbuy = "q_canbuy.csv"

$file_rizayaCanbuy = "q_rizayaCanbuy.csv"

$file_downloadedHiashiAtDownloadsPrefix = "stocks_"#k-db.comからダウンロードしたやつの接頭辞
$file_downloadedHiashiAtKabudataPrefix  = "all_"#k-db.comからダウンロードしたものをkabudata/2016-03-11/に移したときはこれに接頭辞を変えます

$file_changed = "henkoujouhou.txt"#昨日と比べたときの変化情報ファイル


$file_napsac = "napsac.txt"

$file_tangenHenkou = "変更.txt"

$folda_downloads ="c:\\Users\\usaku\\Downloads\\"

$filename_Unit = "share_unit_number.csv"
$filename_Hiashi = "hiashi.csv"
$filename_Sbidata = "sbidata.csv"
$filename_SbiNoData = "brandsNoHPFromSbiHP.txt"

#注意 ファイル関係


	def makeFilepathKabuBunkatu()

		filepath = $folda_kabudata + "heigouBunkatu/bunkatu.csv"
		return filepath
	end

	def makeFilepathKabuHeigou()

		filepath = $folda_kabudata + "heigouBunkatu/heigou.csv"
		return filepath
	end



	def makeFilepathRizayaCanbuy(date)
		filepath = $folda_kabudata + date.to_s+"/" + $file_rizayaCanbuy
		return filepath
	end

	def makeFilepathCanBuy(date)

		filepath = $folda_kabudata + date.to_s+"/" + $file_canbuy
		return filepath
	end

	def makeFilepathCountUpDownIn7Days(date)
		filename = $folda_kabudata + date.to_s + "/" + $file_CountUpDownIn7Days
		return filename
	end

	def makeFilepathChangesInOneDay(date)

		filename = $folda_kabudata + date.to_s + "/" + $file_changesInOneDay
		return filename
	end

	def makeFilepathDown(date)

		filepath = $folda_kabudata + date.to_s + "/" + $file_down
		return filepath
	end

	def makeFilepathUp(date)

		filepath = $folda_kabudata + date.to_s + "/" + $file_up
		return filepath
	end
	

	def makeFilepathTangenHenkou(date)

		filepath = $folda_kabudata + date.to_s + "/" + $file_tangenHenkou
		return filepath
	end




	def makeFileBackUpTimeScripts()
		
		filepath = $folda_root + $file_backuptime_scripts
		return filepath
	end

	def makeFileBackUpTimeKabudata()
		
		filepath = $folda_root + $file_backuptime_kabudata
		return filepath
	end


	def makeFilepathNapsac(date)

		filepath = $folda_kabudata + date.to_s+"/"+$file_napsac
		return filepath
	end

	def makeFilepathUnitChange(date)

		filepath = $folda_kabudata + date.to_s + "/" + $file_changed
		return filepath
	end


	def makeFilepathHenkouNashi(date)

		filepath = $folda_kabudata+date.to_s+"/変更なし.txt"
		return filepath
	end

	def makeFilepathHenkouAri(date)

		filepath = $folda_kabudata+date.to_s+"/変更あり.txt"
		return filepath
	end



	def makeFilepathUnit(date)


		filepath = $folda_kabudata+date.to_s+"\\"+$filename_Unit

		return filepath
	end


	def makeFilepathToshoHtml(num,date)
		#num...String
		#date...Date

		filepath = $folda_kabudata+date.to_s+$foldaname_tosho+num+".htm"

		return filepath
	end




	def makeFilepathSbiClipboard(date,num)
		#date...Date
		#num....String

		filepath = $folda_kabudata+date.to_s+$foldaname_sbi+num+"sbi.txt" 		

		return filepath

	end



	def makeFilepathCodesNoDataFromSbiHP(date)
		#date...Date

		filepath = $folda_kabudata+date.to_s+$foldaname_sbi+$filename_SbiNoData

		return filepath
	end

	def makeFilepathSbiBrands(date)
		#date...Date
		
		filepath = $folda_kabudata+date.to_s+"\\"+$filename_Sbidata

		return filepath
	end



	def makeFilepathKdbCsvAtDownloads(date)

		filepath = $folda_downloads + $file_downloadedHiashiAtDownloadsPrefix + date.to_s + ".csv"

		return filepath
	end

	def makeFilepathKdbCsvAtKabudata(date)
	
		#date...Date

		filepath = $folda_kabudata+date.to_s+$foldaname_kdb+$file_downloadedHiashiAtKabudataPrefix+date.to_s+".csv"#k-db.comのcsvデータをダウンロードしたもの

		return filepath
	end

	def makeFilepathHiashi(date)
	
		#date...Date

		filepath = $folda_kabudata+date.to_s+"\\"+$filename_Hiashi

		return filepath
	end

	def makeFilepathBunri(date,numb,str)
		#date...Date
		#numb...Numeric
		#str....String

		filepath = $folda_kabudata+date.to_s+"/category"+numb.to_s+str+".txt"
	
		return filepath
	end



