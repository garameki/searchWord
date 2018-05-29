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
					puts "�����ł͂���܂���Berror in Source"
					fail(HolidayError)
				end
			end


			if flag_tangen

#����				@tangenHash=Hash.new(Hash.new({}))������͈Ӗ��Ȃ�
				@tangenHash=Hash.new#����ł����B�񎟌��߂́A�L�[���Ƃ�Hash.new����I�I�I
				@tangen=Array.new
				filename = makeFilepathUnit(@hiduke)
				@tangen = into_array_from_file(filename,false)
				if @tangen==false
					@flag_ready=false
				else
					@tangenFields = intoHashFromFieldsOfArray(sliceFields(@tangen))

					@tangen.each{|brand|
						@tangenHash[brand[@tangenFields["�R�[�h"]]] = Hash.new#�n�b�V���̓񎟌��ڂ̓L�[���ƂɁA�����������I�I
						@tangenFields.each{|field,value|#���n�b�V����each�͂���ɒ���
							@tangenHash[brand[@tangenFields["�R�[�h"]]][field] = brand[value]
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
						@sbidataHash[brand[@sbidataFields["�R�[�h"]]] = Hash.new#�n�b�V���̓񎟌��ڂ̓L�[���ƂɁA�����������I�I
						@sbidataFields.each{|field,value|#���n�b�V����each�͂���ɒ���
							@sbidataHash[brand[@sbidataFields["�R�[�h"]]][field] = brand[value]
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
						@hiashiHash[brand[@hiashiFields["�R�[�h"]]] = Hash.new#�n�b�V���̓񎟌��ڂ̓L�[���ƂɁA�����������I�I
						@hiashiFields.each{|field,value|#���n�b�V����each�͂���ɒ���
							@hiashiHash[brand[@hiashiFields["�R�[�h"]]][field] = brand[value]
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
						@canbuyHash[brand[@canbuyFields["�R�[�h"]]] = Hash.new#�n�b�V���̓񎟌��ڂ̓L�[���ƂɁA�����������I�I
						@canbuyFields.each{|field,value|#���n�b�V����each�͂���ɒ���
							@canbuyHash[brand[@canbuyFields["�R�[�h"]]][field] = brand[value]
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
						@rizayaCanbuyHash[brand[@rizayaCanbuyFields["�R�[�h"]]] = Hash.new#�n�b�V���̓񎟌��ڂ̓L�[���ƂɁA�����������I�I
						@rizayaCanbuyFields.each{|field,value|#���n�b�V����each�͂���ɒ���
							@rizayaCanbuyHash[brand[@rizayaCanbuyFields["�R�[�h"]]][field] = brand[value]
						}
					}
				end
			end#if


			if flag_kdb
				#kdb.com����̃t�@�C����ǂ݁A����1���̃f�[�^���A�����t�@�C���Ƃ��ĕۑ�����
				@kdb        = Array.new
				filename = makeFilepathKdbCsvAtKabudata(@hiduke)
				@kdb = into_array_from_file(filename,false)
				if @kdb==false
					@flag_ready=false
				else
					@kdbFields = intoHashFromFieldsOfArray(sliceFields(@kdb))#�t�B�[���h������؂���

					@kdbHash=Hash.new
					@kdb.each{|brand|
						@kdbHash[brand[@kdbFields["�R�[�h"]]] = Hash.new#�n�b�V���̓񎟌��ڂ̓L�[���ƂɁA�����������I�I
						@kdbFields.each{|field,value|#���n�b�V����each�͂���ɒ���
							@kdbHash[brand[@kdbFields["�R�[�h"]]][field] = brand[value]
						}
					}
	
					#�_�E�����[�h�����t�@�C���Ȃ̂ŁA�t�B�[���h�̕ύX�������Ȃ肳���\��������̂Ń`�F�b�N����B
					fieldsNow = ["�R�[�h","������","�s��","�n�l","���l","���l","�I�l","�o����","�������"]#���܂ł̃t�B�[���h
					if checkFields(fieldsNow,@kdbFields)#�P�����z��ƁA�n�b�V��
					else
						print filename
						puts "���t�B�[���h�����܂łƈقȂ�܂��B�m�F���Ă��������B"
						�G���[
					end
				end
			end#if boolen



			if flag_bunkatu	
				#���`���ꂽ�t�@�C����ǂ݁A�����������ꂽ�������i�[����
				@bunkatu        = Array.new
				filename = makeFilepathKabuBunkatu()
				@bunkatu = into_array_from_file(filename,true)#��d�z��
				if @bunkatu==false
					@flag_ready=false
				else
					@bunkatuFields = intoHashFromFieldsOfArray(sliceFields(@bunkatu))#�t�B�[���h������؂���
					@bunkatuHash=Hash.new
					@bunkatu.each{|brandData|#for Array

						code = brandData[@bunkatuFields["�R�[�h"]]
						dateString = brandData[@bunkatuFields["���t"]]
						if @bunkatuHash.include?(code)
						else
							@bunkatuHash[code] = Hash.new
						end
						@bunkatuHash[code][dateString]=Hash.new#�n�b�V���̓񎟌��ڂ̓L�[���ƂɁA�����������I�I
						@bunkatuHash[code][dateString]["�����O"]=brandData[@bunkatuFields["�����O"]]#���Ȃ݂ɁA�P�ڂ̕�����ƂQ�ڂ̕�����̕��������킹��K�v�͂Ȃ��P�ڂ̕�����͂��̕ϐ�����Ŏg�p����R�[�h�̂��߂ɗp���āA�Q�߂̕�����̓\�[�X�t�@�C���ɍ��킹��΂悢�B�����A�ߋ��̃\�[�X�t�@�C��������ꍇ�ɂ́A�V�����t�@�C���̃t�B�[���h�̈Ӗ��͓��������t�B�[���h�����ς���Ă��܂����V�����t�B�[���h�����Q�ڂ̕�����ɂ��킹�Ȃ��Ă͂����Ȃ�

						@bunkatuHash[code][dateString]["������"]=brandData[@bunkatuFields["������"]]

					}

				end

			end#if boolen


			if flag_heigou	
				#���`���ꂽ�t�@�C����ǂ݁A�����������ꂽ�������i�[����
				@heigou        = Array.new
				filename = makeFilepathKabuHeigou()
				@heigou = into_array_from_file(filename,true)#��d�z��
				if @heigou==false
					@flag_ready=false
				else
					@heigouFields = intoHashFromFieldsOfArray(sliceFields(@heigou))#�t�B�[���h������؂���
					@heigouHash=Hash.new
					@heigou.each{|brandData|#for Array

						code = brandData[@heigouFields["�R�[�h"]]
						dateString = brandData[@heigouFields["���t"]]
						if @heigouHash.include?(code)
						else
							@heigouHash[code] = Hash.new
						end
						@heigouHash[code][dateString]=Hash.new#�n�b�V���̓񎟌��ڂ̓L�[���ƂɁA�����������I�I
						@heigouHash[code][dateString]["�����O"]=brandData[@heigouFields["�����O"]]
						@heigouHash[code][dateString]["������"]=brandData[@heigouFields["������"]]

					}

				end

			end#if boolen


		end#def

	end#class Sources

