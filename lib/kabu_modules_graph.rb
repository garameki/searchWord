#encoding : shift_jis


require "date"

require "kconv"
lib = ENV["RUBY_KABU_LIBRARY"].tosjis
require lib+"kabu_global_variables.rb"
require lib+"kabu_modules.rb"
require lib+"kabu_filenames.rb"
require lib+"kabu_sources.rb"
require lib+"kabu_data.rb"





def outToGraph(date_start,date_end,base,filename,genres=["�S��"],motode=0,flag_sort=false)
	#dates...Array []
	#base....Stocks

	members = Array.new

	if weekday?(date_start)
	else
		puts "�J�n���������ł͂���܂���B"
		�G���[
	end

	dates = Array.new#���߂̓�date_start����I���̓�date_end�܂łɂ��镽��
	date_start.upto(date_end){|date|
		if weekday?(date,false)
			dates << date
		end
	}

	stocks=Hash.new
	dates.each{|date|
		stocks[date.to_s]=Hash.new
		stocks[date.to_s]=base.eachRizayas(date,motode)#stocks[���t][�R�[�h]
	}
	names = Hash.new
	names = base.eachNames()#Array
#�����܂Ńf�[�^�擾


#��������f�[�^���O���t�p�ɉ��H���ďo��
	File.open(filename,"w"){|file|

		#�^�C�g�����o��
		title = base.hiduke.to_s+"����Ƃ���"
		flag_genre = false
		genres.each{|genre|
			if flag_genre
				title += ","
			else
				flag_genre=true
			end
			title += genre
		}
		title += "�̌ʖ����̗�����by"+motode.to_s+"�~�Ŕ��������"
		file.puts title
#puts title

		#���̒l���o��
		flag_date = false
		dates.each{|date|####��{�ɂȂ���t���܂񂾓��t�̕\��

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

		#�c�̒l���o��
	
		#�o�͂��������ɂ��邽�߂Ƀf�[�^�\����ύX
		stocksNew=Hash.new

		stocks.each{|dateString,codes|#stocks[���t][�R�[�h]=������
			codes.each{|code,rizaya|#�ǂ�ȃR�[�h������̂��m�肽��
				if stocksNew.include?(code)
					stocksNew[code][dateString]=rizaya
				else
					stocksNew[code]=Hash.new
					stocksNew[code][dateString]=rizaya
				end
			}
		}

		#�\�[�g
			arr=Array.new
			stocksNew.each{|code,values|
				arr << [code,values[dates[-1].to_s]]
			}
			arr = dsort_2(arr) if flag_sort	#�t���O�ɂ��ς��
		
		arr.each{|code,temp|
			members << code
		}

		#�l���o��
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





