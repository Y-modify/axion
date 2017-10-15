MKDIR_P ?= mkdir -p

SRC_DIR ?= .
DIST_DIR ?= ./dist
DPI ?= 300

IMAGE_DIR := $(DIST_DIR)/images

SRCS := $(wildcard $(SRC_DIR)/*.brd) $(wildcard $(SRC_DIR)/*.sch)
IMAGES := $(SRCS:%=$(IMAGE_DIR)/%.png)

.PHONY: all clean

all: $(IMAGES)

clean:
	$(RM) -r $(DIST_DIR)

$(IMAGES): $(SRCS)
	$(MKDIR_P) $(dir $@)
	eagle $(basename $(@F)) -C "EXPORT IMAGE $@ $(DPI); QUIT" &> /dev/null || true
#	$(foreach BOARD,$(BOARDS), eagle $(BOARD) -C "EXPORT IMAGE $(IMAGE)/board-$(basename $(BOARD)).png $(DPI); QUIT" &> /dev/null || true)

# $(SIMAGES): $(SCHEMATICS)
#	$(foreach SCHEMATIC,$(SCHEMATICS), eagle $(SCHEMATIC) -C "EXPORT IMAGE $(IMAGE)/schematic-$(basename $(SCHEMATIC)).png $(DPI); QUIT" &> /dev/null || true)

# .PHONY: image
# image: $(BOARDS) $(SCHEMATICS)
# 	mkdir -p $(IMAGE)
# 	$(RM) $(IMAGE)/*
# 	$(foreach BOARD,$(BOARDS), eagle $(BOARD) -C "EXPORT IMAGE $(IMAGE)/board-$(basename $(BOARD)).png $(DPI); QUIT" &> /dev/null || true)
# 	$(foreach SCHEMATIC,$(SCHEMATICS), eagle $(SCHEMATIC) -C "EXPORT IMAGE $(IMAGE)/schematic-$(basename $(SCHEMATIC)).png $(DPI); QUIT" &> /dev/null || true)
