@call %RUBY_HOME%kabu2\EnvSetLibrary.bat

@set RUBY_KENSAKU_PATH=%HOME%usaku\Documents\work
@set RUBY_WORD=replace





@ruby -C%RUBY_HOME%kabu2\kensaku\ word_kensaku.rb||pause

@pause