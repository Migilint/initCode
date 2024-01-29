CONDITION := $(shell quartus_sh -v dot 2> /dev/null)

SECOND_COMMAND := $(find C:/ -type d -maxdepth 3 -name quartus  2> /dev/null)

MY_VAR := $(shell find C:/ -type d -maxdepth 3 -name quartus  2> /dev/null)

QUARTUS_COMMAND_VAR := $(shell printenv QUARTUS_ROOTDIR)
QUARTUS_SH := $(MY_VAR)/bin64/quartus_sh.exe -s
IVERILOG_VAR := $(shell which iverilog)

define IVERILOG_INSTALLING
	@powershell wget https://www.bleyer.org/icarus/iverilog-v12-20220611-x64_setup.exe -Outfile ./file1_iverilog.exe
	@./file1_iverilog.exe
endef

define CTAGS_INSTALLING_64
	@powershell wget https://github.com/universal-ctags/ctags-win32/releases/download/p6.1.20240128.0/ctags-p6.1.20240128.0-x64.zip -Outfile ./file3_ctags_x64.zip 
	@unzip -p ./file3_ctags_x64.zip ctags.exe > ctags.exe 
	@mv ctags.exe $(patsubst %/iverilog,%,$(IVERILOG_VAR)) 
endef

define CTAGS_INSTALLING_86
	@powershell wget https://github.com/universal-ctags/ctags-win32/releases/download/p6.1.20240128.0/ctags-p6.1.20240128.0-x86.zip -Outfile ./file3_ctags_x86.zip 
	@unzip -p ./file3_ctags_x86.zip ctags.exe > ctags.exe 
	@mv ctags.exe $(patsubst %/iverilog,%,$(IVERILOG_VAR)) 
endef


define SVLS_INSTALLING
	@powershell wget https://github.com/dalance/svls/releases/download/v0.1.17/svls-v0.1.17-x86_64-win.zip -Outfile ./file2_svls.zip 
	@unzip -p ./file2_svls.zip target/x86_64-pc-windows-msvc/release/svls.exe > svls.exe 
	@mv svls.exe $(patsubst %/iverilog,%,$(IVERILOG_VAR))
endef


initialize_VSCODE:
	@$(if $(shell printenv QUARTUS_ROOTDIR),echo "Quartus is installed",@-explorer https://cdrdv2.intel.com/v1/dl/acceptEula/795188/795200?filename=Quartus-lite-23.1std.0.991-windows.tar 2> /dev/null)
	@-explorer https://dzen.ru/a/X0AO2-nVKSXar7bb 2> /dev/null

	@echo "This webpage is instruction for options to your vscode... (Enter)"
	@read dummy
	@echo -n "Are you want to installing the all packages from webpage? ... [y/N] " && read ans && [ $${ans:-N} = y ]

	@#echo " "
	@code --install-extension mshr-h.VerilogHDL
	@#echo " "
	@code --install-extension spmeesseman.vscode-taskexplorer
	@#echo " "
	@code --install-extension MS-CEINTL.vscode-language-pack-ru
	@#echo " "
	@code --install-extension wavetrace.wavetrace
	@#echo " "
	@code --install-extension theonekevin.icarusext
	@#echo " "
	
	
	@$(if $(shell which iverilog),@echo "iverilog is installed", @$(call IVERILOG_INSTALLING))
	@$(if $(shell which svls),@echo "svls is installed", @$(call SVLS_INSTALLING))
	@$(if $(shell which ctags),@echo "ctags is installed", @$(call CTAGS_INSTALLING_64))
	@#$(if $(shell which ctags),@echo "ctags is installed", @$(call CTAGS_INSTALLING_86))
	
	@echo "Pls, you must to option your vscode with uses the opened webpage. Goodluck!"

	

