#encoding : shift_jis

require "date"

require "kconv"
lib = ENV["RUBY_KABU_LIBRARY"].tosjis
require lib+"errorClasses.rb"
require lib+"kabu_global_variables.rb"
require lib+"kabu_modules.rb"
require lib+"kabu_filenames.rb"
require lib+"kabu_sources.rb"











#�C���X�^���X�𕡐��g���Ă����̃N���X�̈Ӗ����o�Ă���

#�C���X�^���X���������o�[�ϐ��̃f�[�^�B��������H���ĐV�����������o�����\�b�h�B�������A���o���̂��Breturn�����Ă����A���\�b�h���B
#�C���X�^���X�ɕ����̂����\�b�h�B�C���X�^���X�ɖ₢������̂����\�b�h�B

#�C���X�^���X�̐��i��\�����̂������o�[�ϐ��Ƒ�����΂����̂ł͂Ȃ����B

#�������A�����o�[�ϐ������Ȃ�A�z����������p�ӂ���Ύ������̂ł́H�C���X�^���X�����Ȃ��Ă������̂ł͂Ȃ����H
#�����b�A�֐��Ɣz��ŁA���Ƃ͑���Ă��܂��̂ł͂Ȃ����낤���B
#�I�u�W�F�N�g���g���Ӗ��͉��Ȃ̂��낤���H

#�I�u�W�F�N�g���g���ƃJ�e�S���C�Y���y�ɂȂ�̂ł͂Ȃ����낤���B
#�J�e�S���[���ƂɁA�C���X�^���X�����A���̃J�e�S���[�̐����𕪐͂��邱�Ƃ��ł���B����̓��\�b�h�ɕ����΂����B
#���\�b�h���[������΂���قǁA���̃J�e�S���[�𑽖ʓI�ɂƂ炦�邱�Ƃ��ł��A
#���̃C���X�^���X�̂���Ɣ�r���邱�Ƃɂ��A�����̍œK���ւ̕������������Ă���̂ł͂Ȃ����B

#�J�e�S���C�Y�A�܂�A�W�{�̐؂蕪�����͗l�X����B
#�ꎞ�f�[�^����J�e�S���C�Y���邱�Ƃ��������ł��邪�A�񎟏��A�O�����ɂ��J�e�S���C�Y���l������B
#�Ⴆ�΁A�u�Ǝ핪�ށv�A�u�����v�͈ꎞ���B�u������̍���v�Ȃǂ͓񎟏��B������́u���U�v�A�u���ρv�A�u�΍��v�Ȃǂ͎O�����ł���A
#���ꂼ��ɂ��āu���v�ɂ��J�e�S���C�Y���ł���B

#���āA�ǂ��܂ł��N���X�Ƃ��Ĉ����΂����̂��낤���B�ǂ�ȕ��ޕ����ɂ��K�p�ł���ėp�N���X�͑��݂���̂��낤���B

#�l�X�ȏ������o���ɂ́A�f�[�^�x�[�X�Ɍ�����悤�Ȏ�@��p����̂���ʓI���B
#�W�{�̐����̌v�Z�A�W�{�ւ̑���i��������ɂ����W�{�̐؂蕪���A��������ɂ����W�{���m�̌����j�̂悤�ȏ���I�ȑ���̌J��Ԃ��ɂ��
#���o�������������o���B�i�O���t�f�[�^�𓾂�j

#�W�{�ւ̑���́A�v���O������ł́A�C���X�^���X���m�̌�����؂蕪���Ƃ������ƂɂȂ�B
#�W�{�̐����̌v�Z�Ƃ́A�v���O������ł́A���\�b�h�ł���B

#�W�{�𕡐��ɕ�����B�Ƃ������Ƃ́A�C���X�^���X���ǂ������΂����̂��낤���B
#�C���X�^���X��30���ނ���B�����������΁A������30�̃O���[�v�ɕ�����Ƃ������Ƃ��B
#����́A�c�̑��삾�B

#���ρA���U�A�΍��͏c�̑���B

#���t���܂����Ȃ��Ă͋��߂��Ȃ�������͉��̑���B
#���t���܂����Ȃ��Ă͋��߂��Ȃ��M�p�����̎c�f�[�^�����̑���B

#�ق��ɉ������߂���H
#���Ғl�͌v�Z�ł���H���̓��v�ʂ��v�Z�ł���H�����\�z�́H���֌W���́H

#�e�Ɋp�A�c�̑���Ɖ��̑���ŁA���ׂĂ��ł��������B

#�O���t��`����������悤�B��{�ƂȂ���̖������A�����⿕������i�v�Z�A�����j�Agenre���Ƃɕ����āi�����j�Agenre���Ƃɖ����̌����v�Z�A
#�������������ƂɌv�Z�Agenre���Ƃ�rizaya�̍��v���v�Z�Agenre���Ƃɋ��߂����U����genre�ɏ�����������̐��Ŋ���A�t�@�C���ɏo�͂���B
#�����̈������\�b�h�ɂ���B�����āA�����̃��\�b�h���g�����\�b�h�����B�ׂ������̃��\�b�h�́A���̏��𓾂�̂ɂ��ė��p�ł���B





#���H�ɂ���ē���ꂽ��񂱂��A�����o�[�ϐ��ɂ��ׂ��ŁAtangen��hiashi�Ɋi�[����Ă���f�[�^�������o�[�ϐ��ɂ���͈̂Ӗ����Ȃ��B�������Ƃ��J��Ԃ��Ă��邾���B
#���H�ɂ���ē���ꂽ��������ɉ��H���āA�V���ȏ����Q�b�g���邽�߂ɁA�ǂ��N���X��݌v����̂����d�v�Ȃ̂��B

















#@@tangen��@@hiashi�Řd������̂�V����@stocks�Ɋi�[����̂��ǂ����ˁB����X�̌v�Z���x���l����ƁA@stock�Ȃ�Aif�������点��̂ł́H



	


class Kabudata

	#�S�Ă̊�{�f�[�^�������œǂݍ��ށB�����āA�N���X�ϐ��Ƃ��ė��p���Ă��炤


	GENRES = [
"���Y�E�_�ы�",
"������",
"���݋�",
"�z��",
"�@�B",
"�T�[�r�X��",
"���E�ʐM��",
"�H���i",
"�s���Y��",
"���^��",
"������",
"�@�ې��i",
"�d�C�@��",
"�K���X�E�y�ΐ��i",
"�A���p�@��",
"�Ζ��E�ΒY���i",
"���w",
"�������i",
"�p���v�E��",
"���i",
"�����@��",
"�S�����i",
"�S�|",
"��S����",
"�،��A���i�敨�����",
"��s��",
"���̑����Z��",
"�ی���",
"���̑����i",
"�q�ɁE�^�A�֘A��",
"�C�^��",
"��^��",
"�d�C�E�K�X��"
]

	def initialize(dates=[])#super()�ɑΉ����邽�߂ɁA�����ɂ̓f�t�H���g�l��ݒ肵�Ă����B
	

		#�S�Ă̖����ɑ΂����b�f�[�^
			@genresALL =Array.new#�Ǝ핪�ނ��i�[

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
						print "�������̓��t=";puts date.to_s
						����[
					end
				end
			}
			if checkGenres()
			else
				puts "�Ǝ핪�ނɐV�������O�����Ă��܂��B"
				�G���[
			end

			#�������E������
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
				genre= values2["�Ǝ핪��"]
				if GENRES.include?(genre)
				else
					puts
					puts genre,"���V�������O"
					return false
				end
			}
		}
		return true
	end


end#class Kabudata




#�����������͈̂Ӗ����Ȃ���������Ȃ����A�ׂ����ύX��������̂ɂ͍ŏ��P�ʂ������������ύX���₷�����_�͂���B
#���R�́A���\�b�h���͕ς��Ȃ��Ă������̂�����
class Stock < Kabudata
	def initialize(code)
	
		@code = code

	end#def

	def name(date)

		return @@tangen[date.to_s][@code]["������"]

	end#def

	def code()

		return @code

	end#def

	def owarine(date)

		return @@hiashi[date.to_s][@code]["�I�l"]

	end#def

	def kaerukabusuu(date,motode)

		keyDate = date.to_s
		kingaku = @@tangen[keyDate][@code]["�����P��"].to_f*@@hiashi[keyDate][@code]["�I�l"].to_f
		kazu=motode.div(kingaku)*@@tangen[keyDate][@code]["�����P��"].to_i
		return kazu


	end#def

	def kabuKazuBairitu(date0,date1)

		#date0...Date�w����Stocks��@hiduke
		#date1...Date���p��

		kabuKazuBairitu = 1.0

		if @@bunkatu[@code]
			@@bunkatu[@code].each{|hiduke,ratios|#@@bunkatu[�R�[�h][���t][�O/��]=���̐������t������������ꍇ�͂ǂ����Ă���H���Ⴄ�����|�����킹�Ă���
				date = dateFromString(hiduke)
				ratio = ratios["������"].to_f/ratios["�����O"].to_f
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
				ratio =  ratios["������"].to_f/ratios["�����O"].to_f
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

	def rizaya(date0,date1,motode)#Stock�͐e�N���X�̊�{�f�[�^���g������Ԃ�


		#date0...�w����(Stocks��@date�Ƃ�)
		#date1...���p��(each��|date|�Ƃ�

		keyDate0 = date0.to_s
		keyDate1 = date1.to_s

		if @@tangen[keyDate0]==nil
			print keyDate0+"�͋x���ł�"
			return nil
		elsif @@tangen[keyDate1]==nil
			print keyDate1+"�͋x���ł�"
			return nil
		elsif @@tangen[keyDate0][@code]==nil
			print keyDate0+"��"+@code+"�͑��݂��܂���"
			return nil
		elsif @@tangen[keyDate1][@code]==nil
			print keyDate1+"��"+@code+"�͑��݂��܂���"
			return nil
		elsif @@hiashi[keyDate0][@code]["�I�l"] == ""
			print keyDate0+"��"+@code+"�͎��������܂���ł����B"
			return nil
		elsif @@hiashi[keyDate1][@code]["�I�l"] == ""
			print keyDate1+"��"+@code+"�͎��������܂���ł����B"
			return nil
		else	
			kingaku = @@tangen[keyDate0][@code]["�����P��"].to_f*@@hiashi[keyDate0][@code]["�I�l"].to_f
			kabukazu0=motode.div(kingaku)*@@tangen[keyDate0][@code]["�����P��"].to_i
			bairitu = kabuKazuBairitu(date0,date1)
			kabukazu1=kabukazu0*bairitu
			rizaya = @@hiashi[keyDate1][@code]["�I�l"].to_f*kabukazu1 - @@hiashi[keyDate0][@code]["�I�l"].to_f*kabukazu0
			return rizaya
		end



	end#def


end#class


#�N���X�e�X�g
#date0 = Date.new(2016,9,1)#�����w��������
#stock = Stock.new("1301")
#date0.upto(Date.new(2016,9,30)){|date|#���𔄋p������
#	puts stock.rizaya(date0,date,1000000)
#}













#Stocks��s���t���܂�


#����P���̕����̖���������
class Stocks<Kabudata

	#�v�Z�̊�{�ɂȂ�����������o�[�ϐ��ɃZ�b�g����

	attr_reader :hiduke

	def initialize(date)#���̓��t�͓r���ł��悢�A�Ώۂ��ߋ��܂ł����̂ڂ��Čv�Z���邱�Ƃ�����ł��낤����

		fail(HolidayError) if !weekday?(date)

		@date = date
		@hiduke = date.to_s

		@stocks=Hash.new#@stocks[�R�[�h]=Stock������̃����o�[�ϐ� �����ŕێ����Ă��������g�����₷���Ƃ������Ƃ�Hash��I�񂾁BStock�I�u�W�F�N�g�������Ă���
		#@kabuKazu=Hash.new#���ϐ��𑝂₷�̂͊g�����ɖR����(�f�[�^������o������̂̓��\�b�h���`���������悢)&�R�[�h�Ƃ̘A�g�͂�͂�n�b�V�����g���������֐��������B
					#�ǂ���ɂ���Hash�������̂Ȃ�΁A��L�̃����o�[�ϐ���Array����Hash�ɂ��Ďg�����������������B
	
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
				print code,"��",@hiduke,"�ɂ́A���؂P���ɂ͑��݂��܂���B"
				puts
			elsif @stocks.include?(code)==true
				puts
				print code,"�͊��Ƀ����o�[�ł��B"
				puts
			else
				@stocks[code]=Stock.new(code)
			end
		}
	end


	def setAll()#�S�������Z�b�g
#print "qq" if @@tangen
#print "ww" if @date
#print "ee" if @@tangen[@hiduke]

		begin
			@@tangen[@hiduke].each{|code,values|
				@stocks[code]=Stock.new(code)
			}
		rescue => error
			print "�G���[���e :";p error.message
			print "���t",@hiduke,"�̃f�[�^������܂���B";puts
			puts "�N���X�ϐ�@@tangen���g�p������ɂ��ɂ��ď���������Ă��Ȃ��\��������܂��B"
			puts "���C���֐��ɂ�Kabudata�����������Ă�������(�_�~�[�̃C���X�^���X�����)"
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


	def filteringGenre!(genres)#@stocks�ɓ����Ă�����̂�genres�ɓ����Ă�����̂��c���Ď̂Ă�

		#genres......[]


		genres.each{|genre|
#p Kabudata::GENRES
			if Kabudata::GENRES.include?(genre)
			else
				print "genre=";p genre
				puts "�g���Ă��Ȃ��Ǝ핪�ޖ����w�肵�܂����B"
				�G���[
			end
			@stocks.each{|code,values|
				genre = @@tangen[@hiduke][code]["�Ǝ핪��"]
				if genres.include?(genre)
				else
					@stocks.delete(code)
				end
			}
		}
	end#def


	def filteringMotode!(motodes)


			#(motode1)�~�Ŕ������������(motode0)�~�Ŕ������������菜��

			@motode0 = motodes[0]
			@motode1 = motodes[1]

			@stocks.each{|code,values|
				if @@hiashi[@hiduke][code]["�I�l"]!=""
					kazu0 = @stocks[code].kaerukabusuu(@date,@motode0)
					kazu1 = @stocks[code].kaerukabusuu(@date,@motode1)

					if kazu0>0 || kazu1 == 0
						@stocks.delete(code)
					elsif kazu1 > 0 && kazu0 == 0
					else
						���肦�Ȃ�
					end
				else
					print code
					puts "--������Ȃ�"
				end
			}

	
	end#def

	def outputGenre()

		#�m�F�p�\��
		puts
		@stocks.each{|code,values|
			print "code=",code,"  ",@@tangen[@hiduke][code]["�Ǝ핪��"]
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
		#date�Ƃ̍�


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
		#date�Ƃ̍�


		rizas = Hash.new
		@stocks.each{|code,stock|
			rizas[code]=stock.rizaya(@date,date,motode)
		}
		#�m�F�̈Ӗ������߂Ă̕\��
#		@stocks.each{|code,stock|
#			begin
#				puts printf("%5s %+10.0f %s",code,rizaya(@date,date,motode),stock.name])
#			rescue
#			end
#		}

		return rizas#Hash


	end#def


end#class


##�N���X�e�X�g
#date = Date.new(2016,9,26)
#genres = ["���Y�E�_�ы�"]
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
#���ɁA�����̖��������ɂ��āA���t���܂�����rizaya�����v�Z����
