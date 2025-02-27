# 自动探测当前目录下的 Verilog 源文件，并生成对应的 CPP 文件
VERILATOR = verilator
VERILATOR_FLAGS = --trace-fst --cc --exe
VERILOG_SRC := $(wildcard *.v)
CPP_SRC := $(patsubst %.v,%.cpp,$(VERILOG_SRC))
MODULE_NAME := $(basename $(VERILOG_SRC))

# 错误检测
ifeq ($(words $(VERILOG_SRC)),0)
$(error No Verilog source(.v) found in current directory!)
endif

ifneq ($(words $(VERILOG_SRC)),1)
$(error Multiple Verilog sources detected: $(VERILOG_SRC))
endif

ifeq ($(wildcard $(CPP_SRC)),)
$(error Corresponding CPP file $(CPP_SRC) not found!)
endif

# 动态变量设置
TARGET := V$(MODULE_NAME)
SIM_WAVE = simx.fst

# 伪目标声明
.PHONY: sim clean

all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "[SIM] Building $(MODULE_NAME) with..."
	@echo "  Verilog: $(VERILOG_SRC)"
	@echo "  CPP: $(CPP_SRC)"
	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILOG_SRC) $(CPP_SRC) --Mdir obj_dir
	$(MAKE) -C obj_dir -f $(TARGET).mk
	@echo "[SIM] Running simulation..."
	obj_dir/$(TARGET)
	@echo "[SIM] Waveform generated: $(SIM_WAVE)"

clean:
	@echo "[CLEAN] Removing build artifacts..."
	rm -rf obj_dir $(SIM_WAVE)
	@echo "[CLEAN] Done"

include ../Makefile
