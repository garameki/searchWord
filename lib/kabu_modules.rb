#encoding: shift_jis

require "open-uri"
require "kconv"
require "date"

#���� �����̓��W���[���Ȃ̂Ŕėp�������߂邽�߁A�O���[�o���ϐ��A�ÓI�ȕϐ��͎g��Ȃ��B�ł́A���ϐ��͂ǂ��Ȃ́H




	#�t�H���_���ړ�����
	def moveFile(path_old,path_new)
		#path_old.....String �ړ����̃t�@�C���̃t���l�[��
		#path_new...String �ړ���̃t�@�C���̃t���l�[��

		#����true
		#���sfalse
		

		print path_new
		if File.exist?(path_new)
			puts "�����݁B�ړ��y�ђu�����������Ȃ�"
		else
			puts "���񑶍݁B���s�B"
	
			print path_old
			if File.exist?(path_old)
				puts "�����݁B�ړ����܂�"

				if File.rename(path_old,path_new)
				else
					puts "�t�@�C���̈ړ��Ɏ��s���܂���"
					print "�ړ��O:",path_old;puts
					print "�ړ���:",path_new;puts				
					return false
				end
			else
				puts "���񑶍݁B�ړ���������܂���B"
				return false
			end
		end

		return true
	end#def





	#�t�B�[���h���ω����Ă��Ȃ����`�F�b�N����
	def checkFields(fieldsUpToNow,fields)
		#fieldsUpToNow.....�ꎟ���z��[String,.....]
		#fields........................�n�b�V��

		flag = true
		fieldsUpToNow.each{|x|
			if fields.include?(x)
			else
				print "���܂ł������t�B�[���h�������݂��܂���",x;puts
				flag = false
			end
		}
		fields.each{|name,value|#fields�̓n�b�V���ł�
			if fieldsUpToNow.include?(name)
			else
				print "���܂łɂȂ������t�B�[���h�������݂��܂���",name;puts
				flag = false
			end
		}

		return flag

	end#def





	#�o�b�`�t�@�C���̃��_�C���N�V������p�����p�C�v���g���āA�W�����͂�����t����荞��tangen.bat�Ȃǂ��Q�Ƃ��Ă��������B
	def gets_hiduke()

		if ENV["RUBY_REDIRECT"]=="on"
			print "���_�C���N�g������t��ǂ݂܂��B�t�@�C�����F";puts ENV["RUBY_FILENAME"]

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
			puts "�蓮�œ��͂��܂�"

			flag_te = true
		end


		while true
			if !flag_te
				begin
print "���t�̕]���F�@"
					date = Date.new(y,m,d)
				rescue
					print y,"�N",m,"��",d,"��";puts "�����͂��ꂽ���t���K���ł͂���܂���B�m�F���Ă��������B"
					y = nil
					m = nil
	
					d = nil

				else
puts "ok�B���^�[����"
					return date
				end
			end
print "wwwwwwwwwwwwww y=====";p y
			print  y,"wwww�N" if y!=nil
			print m,"wwww��" if m!=nil
			print d,"wwww��" if d!=nil
			puts
		
			if y==nil
				print "�N ?  "
				y = gets.to_i
			end
			if m==nil
				print "�̉��� ?  "
				m = gets.to_i
			end
			if d==nil
				print "�̉��� ?  "
				d = gets.to_i
			end
			flag_te = false#�����ݒ�⃊�_�C���N�V�����œǂݍ��񂾂̂Ɠ�����ԂɂȂ������Ƃ�����
		end#while true
	end#def




	#2016-06-09 04:55:28 +0900��Time�N���X�ɂ���

	def timeFromString(string)

		a = /(?<year>[0-9][0-9][0-9][0-9])-(?<month>[0-9][0-9])-(?<day>[0-9][0-9]).(?<hour>[0-9][0-9]):(?<min>[0-9][0-9]):(?<sec>[0-9][0-9]).(?<hh>[+,-][0-9][0-9])(?<mm>[0-9][0-9])/.match(string)
		if a == nil
			print "string="
			p string
			puts "string�̍\�����Ԉ���Ă��܂��B"
			puts "��������F\"2016-06-09 04:55:28 +0900\""
			fail(StandardError)
		end
		time = Time.new(a["year"],a["month"],a["day"],a["hour"],a["min"],a["sec"],a["hh"]+":"+a["mm"])

		return time

	end#def


	#2016-06-09 ��Date�N���X�ɂ���

	def dateFromString(string)

		a = /(?<year>[0-9][0-9][0-9][0-9])-(?<month>[0-9][0-9])-(?<day>[0-9][0-9])/.match(string)
		if a == nil
			puts
			print string,"�͓��t��String�ł͂���܂���"
			�G���[
		end
		date = Date::new(a["year"].to_i,a["month"].to_i,a["day"].to_i)

		return date

	end#def








	#������̑O�̉c�Ɠ����A��
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
		#table1....Array 	@hiashi�����t�@�C���f�[�^
		#n1........Numeric 	�R�[�h�̗�ԍ��i�v�f�ԍ��j
		#table2....Array 	@tangen�P���t�@�C���f�[�^
		#n2........Numeric 	�R�[�h�̗�ԍ��i�v�f�ԍ��j
		#members...Array 	�R�[�h���������z�񁨍ŏ��W��

		#�R�[�h���L�[�Ƃ�������������Ԃ�

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
				�G���[�ł��B�R�[�h�����݂��܂���B
			end
			keys << [x,n_table1,n_table2,j]
		}
print "keys=";p keys
		return keys

	end#def


	def intoHashFromFieldsOfArray(arr)#�t�B�[���h�����z��ԍ���Ԃ����߂̏���
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
		#arr...[][] �񎟌�
		
		#return []


		#�P�s�ڂɃt�B�[���h���������炻���Ԃ�
		#�t�B�[���h�����͔z�񂩂��菜�����
		
		if /[0-9][0-9][0-9][0-9]/=~arr[0][0]
			#�P�s�P��ڂ��R�[�h�̏ꍇ
			puts "�t�B�[���h���Ȃ�"
			�X�g�b�v
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
		wdays = ["��","��","��","��","��","��","�y","��"]
		print "������",tdy.to_s,"(",wdays[tdy_time.wday],")�ł��B";puts
	end


	def check_wday(ddd,flag_print=true)#���t��ǂݍ���ŏj�����`�F�b�N####################################
		#input
			#ddd...Date�N���X

		#output
			#false...ddd��shukujitu�ɓ����Ă�ꍇ
			#true....����ȊO�̏ꍇ


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
					[6,[16,17]],#����
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



#�@����2014�N�S����4,5,6,7,8�͏��񋟃T�C�g�̂����œǂݍ��߂Ȃ��Ȃ�܂����B
#  ����2014�N�U��16,17�̓~�X�ɂ��ʖ�����ǂݍ���ł��܂���B
		yy = ddd.year
		mm = ddd.month
		dd = ddd.day

		shukujitsu.each{|x|#�e�N�ɂ���
			if x[0].to_i==yy
				x[1].each{|y|#�e���ɂ���
					if y[0].to_i==mm
						y[1].each{|z|#���̌��̏j���ɂ���
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


	def weekday?(ddd,pri = true)#���t��ǂݍ���Ŏs�ꂪ����Ă��邩�ǂ����𔻒f����##############################
		#input--
		#ddd...Date�N���X
		        #�j���f�[�^�͎���͂ł��B
	
		#output--
			#true.....����
			#flase....�y���j�Փ�

		print ddd.to_s," " if pri
		f = ddd.wday	
		if f == 0 || f == 6 #���j��or�y�j�� �̏ꍇ
			puts "�s��͋x��" if pri
			return false
		else
			if check_wday(ddd,pri) #�j���ł͂Ȃ��ꍇ
				puts "����" if pri
				return true
			else
				puts "�s��͋x��" if pri
				return false
			end#if
		end
	end

	def weekdays(d,n,f)#���t�ȑO(�ȍ~)��n���̕����iDate�N���X�j��z��ɓ���ď����ŕԂ�
		#d...Date�N���X
		#n...Integer�N���X
		#f...String�N���X"+"�܂���"-"���w�肷��

#���͗�Əo�͗Ⴊ�ق���

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


	def weekdays_span(d1,d2)#d1����d2�܂ł̕����������ŗ^����
		#d1...Date�N���X
		#d2...Date�N���X
		#d1��d2�̏��Ԃ͂��܂�Ȃ�

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
			i = i + 1#�P�����₷
		end#while		
		return ans
	end#def


#2016-03-07filepath�X�V
	###### �V�`���@�T�C�g������t�ʑS�����ꗗ�f�[�^�����o���A�t�@�C�� filename�@�Ɋi�[����
	def get_hiashi_all_new(url,filepath)
		file2 = File.open(filepath,"w")
		file2.print "�R�[�h,������,�n�l,���l,���l,�I�l,�o����,�������,�N�G��"
		file2.puts
		open(url){|file|
		
			num=0
			while line = file.gets	
				line = line.tosjis#���������ӂ��������@�e�L�X�g�t�@�C����UTF-8�ŃR�[�f�B���O����Ă��邱�ƁI�I
				if num = /tbody/ =~ line
puts "get_hiashi_all_new���j���[�o�[�W����"
print "num=",num
puts
					while num = line.index("<tr>",num)
						numend = line.index("</tr>",num)
	
						num = line.index("ji",num)	#�����N�����@jikeiretsu.aspx?c=1301-T
						numend2 =line.index("T",num)	#�����N�����A
						k_query = line[num..numend2]	#�����N�����B
					
						num = line.index(">",numend2)	#�R�[�h�����@>1301-T �ɗm</a
						num2 = line.index("</a",num)	#�R�[�h�����A
						text = line[num+1..num+4]	#�R�[�h�����B
						file2.print text 		#�R�[�h�o��
					
						text = line[num+8..num2-1]	#�����������@
						file2.print ",",text 		#�������o��
	
						num = line.index("=l>",num2)	#����������@=l>����1��</td
						num2 = line.index("</td",num)	#����������A
						basho = line[num+3..num2-1]	#����������B
						
						num = num2
						while num = line.index("<td>",num)	#���������@<td>
							if num > numend #���̂��̖����f�[�^�I���H</tr>���щz�����Ƃ���Ɏ���<td>�����݂��邩��
								num2 = numend
								break
							else
								file2.print ","
							end
	
							num2 = line.index("</",num)	#�����������A1334</td>
							text = line[num+4..num2-1]	#�����������B
						
							file2.print text 		#�������o�́i���c�n�lor���lor���lor�I�lor�o����or��������@������j 
	
							num = num2
						end
						#file2.print ",",k_query#���̕����A����ς�g��Ȃ��Ȃ���
						file2.print ",",basho	#������o��
						file2.puts
						num = num2#����<tr>���|�C���g���Ă���
	
					end
				end
			end
		}
	
		file2.close
	end #���\�b�h�I���







	def get_hiashi_all_from_url_old(url,filepath)

#�X�V����
#2016-03-07 $folda+file �� filepath�ɕύX
#2016-03-07 file.gets��file.read(100000)�ɂĈꊇ�_�E�����[�h����悤�ɕύX
#2016-03-15 read(100)���̗p

#���Ǔ_
#2016-03-11���̃��W���[����1�ǂݍ���2�\�����3�i�[�̂R�ɕ������ׂ�

	###### ���`���@�T�C�g������t�ʑS�����ꗗ�f�[�^�����o���A�t�@�C�� filename�@�Ɋi�[����

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
			filetext = accum.tosjis#���������ӂ��������@�e�L�X�g�t�@�C����UTF-8�ŃR�[�f�B���O����Ă��邱�ƁI�I
		end

		file2 = File.open(filepath,"w")
		file2.print "�R�[�h,������,�n�l,���l,���l,�I�l,�o����,�������,�N�G��"
		file2.puts

		ln_size = filetext.size
		ln_start = 0
		ln_end = 0#��


		num=0
		#�ȉ���while line = file.gets������Ă���	
		while true
			if (ln_end == nil) || (ln_start > ln_size-1) then
				break
			end
			
			ln_end = /\n/ =~ filetext[ln_start .. (ln_size-1)]#�Ⴆ�΁A""�̒���"\\n"�������āA���ꂪ���s�ƊԈ���Ă��A�ȉ��̑���ɂ͊֌W�Ȃ�
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
puts "get_hiashi_all_from_url���I�[���h�o�[�W����"
print "2num=",num
puts
#puts line
				while num = line.index("<tr>",num)
					numend = line.index("</tr>",num)
	
					#num = line.index("ji",num)	#�����N�����@jikeiretsu.aspx?c=1301-T	# new�Ɓ@�������Ⴄ
					#numend2 =line.index("T",num)	#�����N�����A				#�@
					#k_query = line[num..numend2]	#�����N�����B				#				
														#
					numend2 = line.index("href",num) #href�܂Ői��				# new�Ɓ@�������Ⴄ
			
					num = line.index(">",numend2)	#�R�[�h�����@>1301-T �ɗm</a
					num2 = line.index("</a",num)	#�R�[�h�����A
					text = line[num+1..num+4]	#�R�[�h�����B
					file2.print text 		#�R�[�h�o��
#print text					
					text = line[num+8..num2-1]	#�����������@
					file2.print ",",text 		#�������o��
#print ",",text	
					num = line.index("=\'l\'>",num2)	#����������@=l>����1��</td
					num2 = line.index("</td",num)	#����������A
					basho = line[num+5..num2-1]	#����������B
#print ",",basho
					num = num2
					while num = line.index("<td>",num)	#���������@<td>
						if num > numend #���̂��̖����f�[�^�I���H</tr>���щz�����Ƃ���Ɏ���<td>�����݂��邩��
							num2 = numend
							break
						else
							file2.print ","
						end
#print ","	
						num2 = line.index("</",num)	#�����������A1334</td>
						text = line[num+4..num2-1]	#�����������B
#print text
						file2.print text 		#�������o�́i���c�n�lor���lor���lor�I�lor�o����or��������@������j 

						num = num2
					end
					#file2.print ",",k_query#���̕����A����ς�g��Ȃ��Ȃ���
					file2.print ",",basho	#������o��
					file2.puts
					num = num2#����<tr>���|�C���g���Ă���
#puts

				end
			end
		end

	
		file2.close

puts "finished ------- get_hiashi"
	end #���\�b�h�I���



















	def into_array_from_file_old(filepath,test=false)

#�X�V����
#2016-03-07 filepath�X�V

	######### �t�@�C���̃f�[�^��String�N���X�ɕϊ����Ĕz��Ɋi�[���Ԃ� ################
	#�f�[�^�t�@�C���̒��́��Ŏn�܂�s�͓ǂݍ��݂܂���R�����g�A�E�g

	#input--
		#filename.....�t�@�C����
	#output--
		#nil.....��z��
		#arr.....[[],[],...,[],[]](String�N���X�̔z��)

print "filepath=",filepath," " if test == true
		if File.exist?(filepath)
puts "exist(into_array_from_file)" if test == true
		else
puts "non-exist(into_array_from)" if test == true
			return nil
		end#if

		arr = []#�z��ϐ���p��
		File.open(filepath){|file|
	
			while line = file.gets
				if line.chomp == "" #��s�͔�΂��܂�
				else
					line = line.tosjis #����A�e�L�X�g�t�@�C����ǂݍ��ނƂ��̃R�c�@�ǂݍ��ރt�@�C����UTF-8�ł��邱�ƁI�I�I
					if line[0].chr == '#'#�R�����g�A�E�g�͓ǂ܂Ȃ�
					else
						arr << line.split(/\s*,\s*/)#�S��String�N���X�Ƃ��Ċi�[
						n=arr.size		#�z��̍Ō�̔��ɂ͉��s�L���������Ă���̂ł�����폜����
						m=arr[n-1].size		#
						0.upto(m-1){|i|
							arr[n-1][i].chomp!	#�ŐV�I�I�I	
						}
					end#if2
				end#if1
			end#while
		}
		return arr
	
	end #���\�b�h�I���







	def readFileAtOnce(filepath)

		#filepath...String


		#�t�@�C����ǂ��sjis�ɂ��Ă���Ԃ�

test = false
#test = true

		puts "readFileAtOnce" if test == true
		print "filepath=",filepath if test == true
		if File.exist?(filepath)
			puts "������" if test == true
		else
			print "filepath=",filepath
			puts "���񑶍�readFileAtOnce" 
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
			puts "file�͋�ł�readFileAtOnce()"
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
			puts "������" if hyouji



		
			accum = readFileAtOnce(filepath)
			if accum == nil
				print filepath,"��";puts
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
			puts "���񑶍�return false(into_array_from_file)"
#			�X�g�b�v
			return false
		end
	end




	def into_file_from_array(arr,filename,flag_kyouseikakikomi=false)


	#�������@�@�@��d�z����킽�����ƁI�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I

	#########��d�z��̒��g���t�@�C���ɗ��Ƃ�###################


		

		if arr == nil
			puts "�z��nil�ł�(into_file_from_array())"
			return false
		end

		n=arr.size #�s�̐�

		if n == 0
			puts "�z�񂪋�ł�(into_file_from_array())"
			if flag_kyouseikakikomi
				File.open(filename,"w"){
				}
				return true
			end

			return false
		end


		flag_w = false#�f�t�H���g�͏������܂Ȃ�
		flag_exist = File.exist?(filename)

		print filename
		if flag_exist
			print "�����݁B"
			if flag_kyouseikakikomi
				puts "�㏑�����܂����B"
				flag_w = true
			else
				puts "�������܂Ȃ��B"
				flag_w = false
			end
		else
			puts "���񑶍݁B�쐬�B"
			flag_w = true
		end
		

	#�������@�@�@��d�z����킽�����ƁI�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I
	#�������@�@�@��d�z����킽�����ƁI�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I
	#�������@�@�@��d�z����킽�����ƁI�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I
	#�������@�@�@��d�z����킽�����ƁI�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I
	#join�������Ȃ��Ȃ�܂���


		if flag_w
			f = File.open(filename,"w")
				0.upto(n-2){|i|
					f.print arr[i].join(",")
					f.puts
				}
				f.print arr[n-1].join(",")#�t�@�C���̍Ō�͋�s�ɂ��Ȃ�
			f.close
		end

		return flag_w

	end#def












	###### �V�`���@�T�C�g������t�ʖ����f�[�^�����o���A�t�@�C�� filename�@�Ɋi�[����
	###### make_file_5funashi_brand(num,day)���R�[��
	def get_5funashi_brand_new(url,filepath)
		file2 = File.open(filepath,"w")
#����Ȃ�	file2.print "�R�[�h,������,�n�l,���l,���l,�I�l,�o����,�������(,�N�G��)"#�N�G������Ȃ�
#����Ȃ�	file2.puts
puts url
		open(url){|file|
	
			num=0
			while line = file.gets
				line = line.tosjis#���������ӂ��������@�e�L�X�g�t�@�C����UTF-8�ŃR�[�f�B���O����Ă��邱�ƁI�I
				if num = /tbody/ =~ line
#puts line
					while num = line.index("<tr>",num)
						numend = line.index("</tr>",num)

						num = line.index("c>",num)
						num2 =line.index("</td",num)
						text = line[num+13..num2-1]
						file2.print text#����
	
						num2 = 0#�_�~�[
						while num = line.index("<td>",num)
							if num > numend #���̖����f�[�^�I���H
								num2 = numend
								break
							else
								file2.print ","
							end#if

							num2 = line.index("</",num)
							text = line[num+4..num2-1]
						
							file2.print text #�n�lor���lor���lor�I�lor�o����or������� 
							
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

#�X�V����
#2016-03-08filename��filepath
#2016-03-11 file.gets��File.read()������line�̐؂����ǉ�
	###### ���`���@�T�C�g������t�ʖ����f�[�^�����o���A�t�@�C�� filename�@�Ɋi�[����
	###### make_file_5funashi_brand(num,day)���R�[��
puts url




#�V�K�}��2016-03-11
		filetext = ""#�^�錾
		
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
			puts "HP�T�[�o��reject����܂���"
			return nil
		else
			filetext = accum.tosjis#���������ӂ��������@�e�L�X�g�t�@�C����UTF-8�ŃR�[�f�B���O����Ă��邱�ƁI�I
		end


		file2 = File.open(filepath,"w")
#����Ȃ�	file2.print "�R�[�h,������,�n�l,���l,���l,�I�l,�o����,�������(,�N�G��)"#�N�G������Ȃ�
#����Ȃ�	file2.puts

		ln_size = filetext.size
		ln_start = 0
		ln_end = 0#��


		num=0
		#�ȉ���while line = file.gets������Ă���	
		while true
			if (ln_end == nil) || (ln_start > ln_size-1) then
				break
			end
			
			ln_end = /\n/ =~ filetext[ln_start .. (ln_size-1)]#�Ⴆ�΁A""�̒���"\\n"�������āA���ꂪ���s�ƊԈ���Ă��A�ȉ��̑���ɂ͊֌W�Ȃ�
			if ln_end == nil
				line = filetext[ln_start .. ln_size-1]
			else	
				
				line = filetext[ln_start,ln_end+1]
				ln_start = ln_start + ln_end + 1
			end


# 1 #if ln_start>ln_size-300
# 1 #puts line
# 1 #end

#�����܂ŐV�K�}��2016-03-11




#�V�K�}��2016-03-11�̂��߃R�����g�A�E�g
#		open(url){|file|
#	
#			num=0
#			while line = file.gets
#				line = line.tosjis#���������ӂ��������@�e�L�X�g�t�@�C����UTF-8�ŃR�[�f�B���O����Ă��邱�ƁI�I



				if num = /tbody/ =~ line
#puts line
					while num = line.index("<tr>",num)
						numend = line.index("</tr>",num)

						num = line.index("<td>",num)
						num2 =line.index("</td>",num)
						text = line[num+4..num2-1]
						file2.print text#����
	
						num2 = 0#�_�~�[
						while num = line.index("<td>",num+1)
							if num > numend #���̖����f�[�^�I���H
								num2 = numend
								break
							else
								file2.print ","
							end#if

							num2 = line.index("</td>",num)
							text = line[num+4..num2-1]
						
							file2.print text #�n�lor���lor���lor�I�lor�o����or������� 
							
							num = num2
						end#while2
						file2.puts
						num = num2
	
					end#while1
				end#if
#�V�K�}��2016-03-11
		end#while true

#�V�K�}��2016-03-11�̂��߃R�����g�A�E�g
#			end#while
#		}

	
		file2.close
		return true
	end#def













				################�\�[�g����t�@�C���̓��e��������Ȃ��̂�
                                ################��ǂł��Ȃ�
	def dsort(arr)#���������������@���������t���� double sort �̗�

		#arr...��d�z�� ��F[[1,2],[1,2],[1,2],[1,2],[1,2]]
		#���ӁF�|�C���^���n����Ă���킯����Ȃ�����arr��return���Ȃ��ƃf�[�^�͏��ł���

		n=arr.size

		for i in 0..n-1
			min=arr[i][0].to_i#�����قȂ�ꍇ������̂Ő����^�Ŕ�r����
			for j in i+1..n-1
				comp = arr[j][0].to_i#�����^
				if min > comp #�R�[�h�œ���ւ�
					temp = arr[i]
					arr[i]=arr[j]
					arr[j]=temp
					min = comp
				elsif min == comp #���t�œ���ւ�
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




	def dsort_2(arr)#��������Ԗڂ̒l�~���@�����������ԍ����� double sort �̗�

		#arr...��d�z�� ��F[[1,2],[1,2],[1,2],[1,2],[1,2]]
		#���ӁF�|�C���^���n����Ă���킯����Ȃ�����arr��return���Ȃ��ƃf�[�^�͏��ł���

		n=arr.size

		for i in 0..n-1
			min=arr[i][1].to_f#�����قȂ�ꍇ������̂Ŏ��������^�Ŕ�r����
			for j in i+1..n-1
				comp = arr[j][1].to_f#�����^
				if min < comp #�w�������œ���ւ�
					temp = arr[i]
					arr[i]=arr[j]
					arr[j]=temp
					min = comp
				elsif min == comp #�R�[�h�œ���ւ�
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




	################################### �]���ȃt�@�C�����������\�b�h######################
	### d1����d2�܂ł̓��t�̂����t�@�C�����폜����
	### �t�@�C���̒��g�܂ł͍폜�ł��܂���@��Fextract1-200000-10000.txt�Ƃ�
	def delete_file(d1,d2)
	#d1�cDate�N���X
	#d2�cDate�N���X
		
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
			
			Dir::glob("./dayly"+dstring+".txt").each {|f| #�S�����t�@�C��
				File.delete f
			}	
			Dir::glob("./brand*"+dstring+".txt").each {|f| #�ʖ����t�@�C��
			  	File.delete f
			}
		end#if
	end#def












	def file_tosjis(filepath_old,filepath_new)

		#file�̓��e��SJIS�ɕύX
		
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
			print "filepath_old=",filepath_old," ���݂��Ȃ�";puts
		end
	end			





#---------------------- main -----------------------

#file_tosjis("./kabudata/2016-03-25/brand8918.txt","./kabudata/2016-03-25/brand8918-2.txt")





