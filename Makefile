CURR_DIR = $(shell pwd)

BUILD_DIR = $(CURR_DIR)/build
BIN_DIR = $(CURR_DIR)/bin
INCLUDE_DIR = $(CURR_DIR)/include
SRC_DIR = $(CURR_DIR)/src

LIB = $(BUILD_DIR)/lib/lib_tsx_mpk.so

default_target: all

all: dirs lib_tsx_mpk tests src demo

dirs:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/lib
	mkdir -p $(BUILD_DIR)/objs
	mkdir -p $(BUILD_DIR)/artifacts
	mkdir -p $(BUILD_DIR)/tests
	mkdir -p $(BIN_DIR)
	mkdir -p $(BIN_DIR)/tests
	mkdir -p $(SRC_DIR)

.PHONY: default_target all dirs



# -------------------------------------- lib_tsx_mpk ---------------------------------------
$(LIB): $(SRC_DIR)/lib/tsx_mpk.c
	gcc -I$(INCLUDE_DIR) -shared -fPIC -o $@ $^

lib_tsx_mpk: $(BUILD_DIR)/lib/lib_tsx_mpk.so

.PHONY: lib_tsx_mpk


# --------------------------------- list_functions_pass.so -----------------------------------
$(BUILD_DIR)/lib/list_functions_pass.so: $(SRC_DIR)/llvm_pass/list_functions/list_functions_pass.cpp
	cd $(SRC_DIR)/llvm_pass/build && $(MAKE)
	cp $(SRC_DIR)/llvm_pass/build/list_functions/libListFunctionsPass.so $(BUILD_DIR)/lib/list_functions_pass.so





# --------------------------------- tsx_mpk_llvm_pass.so ---------------------------------------
$(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so: $(SRC_DIR)/llvm_pass/tsx_mpk/tsx_mpk.cpp
	cd $(SRC_DIR)/llvm_pass/build && $(MAKE)
	cp $(SRC_DIR)/llvm_pass/build/tsx_mpk/libTSX_MPK.so $(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so




# --------------------------------------- SRC --------------------------------------------------

$(BUILD_DIR)/objs/with_lock.o: $(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so $(SRC_DIR)/with_lock.c

	$(eval IR := $(BUILD_DIR)/artifacts/with_lock.ll)
	$(eval BC := $(BUILD_DIR)/artifacts/with_lock.bc)
	$(eval LLVM_PASS := $(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so)

	clang -g -S -I$(INCLUDE_DIR) -emit-llvm -o $(IR) $(SRC_DIR)/with_lock.c
	opt -load $(LLVM_PASS) -tsx_mpk $(IR) > $(BC)
	llc -filetype=obj -o $@ $(BC)

$(BIN_DIR)/with_lock: $(LIB) $(BUILD_DIR)/objs/with_lock.o
	# clang -g -o $(BIN_DIR)/with_lock $(LIB) $(BUILD_DIR)/objs/with_lock.o
	gcc -g -o $@ $^

$(BUILD_DIR)/objs/without_lock.o: $(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so $(SRC_DIR)/without_lock.c

	$(eval IR := $(BUILD_DIR)/artifacts/without_lock.ll)
	$(eval BC := $(BUILD_DIR)/artifacts/without_lock.bc)
	$(eval LLVM_PASS := $(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so)

	clang -g -S -I$(INCLUDE_DIR) -emit-llvm -o $(IR) $(SRC_DIR)/without_lock.c
	opt -load $(LLVM_PASS) -tsx_mpk $(IR) > $(BC)
	llc -filetype=obj -o $@ $(BC)

$(BIN_DIR)/without_lock: $(LIB) $(BUILD_DIR)/objs/without_lock.o
	# clang -g -o $(BIN_DIR)/without_lock $(LIB) $(BUILD_DIR)/objs/without_lock.o
	gcc -g -o $@ $^

src: $(BIN_DIR)/with_lock $(BIN_DIR)/without_lock

.PHONY: src

# --------------------------------------- Demo -------------------------------------------------

$(BUILD_DIR)/objs/bank.o: $(SRC_DIR)/bank.c
	gcc -g -I$(INCLUDE_DIR) -c -o $@ $^

$(BIN_DIR)/bank: $(BUILD_DIR)/objs/bank.o
	gcc -g -lpthread -I$(INCLUDE_DIR) -o $@ $^ $(LIB)

$(BUILD_DIR)/objs/bank_tsx_mpk.o: $(SRC_DIR)/bank.c

	$(eval IR := $(BUILD_DIR)/artifacts/bank_tsx_mpk.ll)
	$(eval BC := $(BUILD_DIR)/artifacts/bank_tsx_mpk.bc)
	$(eval LLVM_PASS := $(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so)

	clang -g -S -I$(INCLUDE_DIR) -emit-llvm -o $(IR) $(SRC_DIR)/bank.c
	opt -load $(LLVM_PASS) -tsx_mpk $(IR) > $(BC)
	llc -filetype=obj -o $@ $(BC)
	
$(BIN_DIR)/bank_tsx_mpk: $(BUILD_DIR)/objs/bank_tsx_mpk.o
	gcc -g -lpthread -o $@ $^ $(LIB)

clean_demo:
	rm $(BUILD_DIR)/objs/bank.o
	rm $(BIN_DIR)/bank
	rm $(BUILD_DIR)/objs/bank_tsx_mpk.o
	rm $(BIN_DIR)/bank_tsx_mpk

demo: $(BIN_DIR)/bank $(BIN_DIR)/bank_tsx_mpk

.PHONY: clean_demo demo

# --------------------------------------- Tests ------------------------------------------------
$(BUILD_DIR)/objs/test_tsx_mpk_llvm_pass.o: $(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so $(SRC_DIR)/tests/test_tsx_mpk_llvm_pass.c

	$(eval IR := $(BUILD_DIR)/artifacts/test_tsx_mpk_llvm_pass.ll)
	$(eval BC := $(BUILD_DIR)/artifacts/test_tsx_mpk_llvm_pass.bc)
	$(eval LLVM_PASS := $(BUILD_DIR)/lib/tsx_mpk_llvm_pass.so)

	clang -g -S -I$(INCLUDE_DIR) -emit-llvm -o $(IR) $(SRC_DIR)/tests/test_tsx_mpk_llvm_pass.c
	opt -load $(LLVM_PASS) -tsx_mpk $(IR) > $(BC)
	llc -filetype=obj -o $@ $(BC)
	
$(BIN_DIR)/tests/test_tsx_mpk_llvm_pass: $(BUILD_DIR)/objs/test_tsx_mpk_llvm_pass.o
	gcc -g -o $@ $^ $(LIB)

$(BUILD_DIR)/objs/test_pkru_inheritance.o: $(SRC_DIR)/tests/test_pkru_inheritance.c
	gcc -g -c -o $@ $^

$(BIN_DIR)/tests/test_pkru_inheritance: $(BUILD_DIR)/objs/test_pkru_inheritance.o
	gcc -g -lpthread -o $@ $^

test_list_functions_pass: $(BUILD_DIR)/lib/list_functions_pass.so $(SRC_DIR)/tests/test_list_functions_pass.c
	$(eval IR := $(BUILD_DIR)/artifacts/test_list_functions_pass.ll)
	$(eval LLVM_PASS := $(BUILD_DIR)/lib/list_functions_pass.so)

	clang -g -S -I$(INCLUDE_DIR) -emit-llvm -o $(IR) $(SRC_DIR)/tests/test_list_functions_pass.c
	opt -load $(LLVM_PASS) -list_functions $(IR) > /dev/null

tests: $(BIN_DIR)/tests/test_pkru_inheritance $(BIN_DIR)/tests/test_tsx_mpk_llvm_pass test_list_functions_pass

.PHONY: tests test_list_functions_pass


clean:
	rm -r $(BUILD_DIR)
	rm -r $(BIN_DIR)

.PHONY: clean
