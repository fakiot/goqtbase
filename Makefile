.DEFAULT_GOAL := debug

MOD=GO111MODULE=off;export GO111MODULE

debug:
	@echo Starting test...
	@$(MOD);qtdeploy test desktop 

and:
	@echo Deploying android...
	@$(MOD);qtdeploy -docker build android ./

windows32:
	@echo Deploying windows 32 bits...
	@export QT_MSYS2_ARCH=386
	@$(MOD);qtdeploy -docker build windows_32_shared

windows64:
	@echo Deploying windows 64 bits...
	@export QT_MSYS2_ARCH=amd64
	$(MOD);qtdeploy -docker build windows_64_shared

setup:
	@echo Getting cmd...
	$(MOD);go get -v github.com/therecipe/qt/cmd/... 

binding: setup
	@echo Installing binding...
	@qtsetup test 
	@qtsetup -test=false

clean:
	@echo Cleaning...
	@rm -rf deploy/*
