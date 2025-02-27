TOPNAME = top
NXDC_FILES = constr/top.nxdc
INC_PATH ?=
# 自动探测当前目录下的 Verilog 源文件，并生成对应的 CPP 文件
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
CSRCS += $(SRC_AUTO_BIND)
VERILATOR = verilator
# 生成可执行的C++
VERILATOR_CFLAGS = --cc --build \
	-O3 --x-assign fast --x-initial fast --noassert
# 生成FST波形文件
#VERILATOR_FLAGS += --trace-fst
# 以调试模式启动
#VERILATOR_FLAGS += --debug

# 生成的可执行文件
BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

default: $(BIN)

$(shell mkdir -p $(BUILD_DIR))

# 端口约束文件
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_bind.cpp)
$(SRC_AUTO_BIND): $(NXDC_FILES)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

CPPSRCS += $(SRC_AUTO_BIND)


include $(NVBOARD_HOME)/scripts/nvboard.mk

INCFLAGS = $(addprefix -I, $(INC_PATH))
CXXFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(TOPNAME)\""
LDFLAGS += -lSDL2 -lSDL2_image

$(BIN): $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CXXFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))

all:default
	@echo "[commit] git_commit : sim RTL"
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "[commit] git_commit : sim RTL Done"

sim:all
	@$(BIN)

clean:
	@echo "[CLEAN] Removing build artifacts..."
	rm -rf $(OBJ_DIR) $(SRC_AUTO_BIND)
	@echo "[CLEAN] Done"

.PHONY: all clean run default

include ../Makefile
