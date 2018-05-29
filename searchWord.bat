@rem GIT_HOME is for example "set GIT_HOME=C:\Users\username\Documents\git\"
@ser LIBRARY_HOME=%GIT_HOME%searchWord\lib\

@rem SEARCH_DIRECTORY is the directory contains files to search a purpose word
@set SEARCH_DIRECTORY=.\

@rem SEARCH_WORD is the word for seaching
@set SEARCH_WORD=replace

@rem execute ruby script
@ruby -C%GIT_HOME%searchWord searchWord.rb||pause

@pause