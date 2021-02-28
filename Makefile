TARGET = write_netcdf

FC = gfortran

SRC_DIR = src
UTILS_DIR = src/utils
BUILD_DIR = obj
INC_DIR = /usr/local/include
LD_DIR = /usr/local/lib

VPATH = $(UTILS_DIR):$(SRC_DIR):$(BUILD_DIR)

FLAGS += -I$(INC_DIR) -I$(BUILD_DIR)
FLAGS += -J$(BUILD_DIR)
FLAGS += -L$(LD_DIR)

LIBS = -lnetcdf -lnetcdff

MAIN_SRC = $(addprefix $(SRC_DIR)/,write_netcdf.f90)

OBJS_FILES = checkStatus_mod.o
OBJS = $(addprefix $(BUILD_DIR)/,$(OBJS_FILES))

$(TARGET) : $(MAIN_SRC) $(OBJS)
	$(FC) -fcheck=bounds $? -o $@ $(FLAGS) $(LIBS)

$(BUILD_DIR)/%.o:$(UTILS_DIR)/%.f90 | $(BUILD_DIR)
	$(FC) -c $? -o $@ $(FLAGS)

$(BUILD_DIR) :
	@echo "Folder $< does not exist. Creating now..."
	mkdir -p $@

clean:
	rm -r $(TARGET) $(BUILD_DIR)
