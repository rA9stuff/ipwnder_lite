IGCC		= xcrun -sdk iphoneos gcc -miphoneos-version-min=12.0
MGCC_FLAGS	= -c -I./include -I./ra1npoc/src/include -framework IOKit -framework CoreFoundation -Os -Wall $(CFLAGS) -DDEBUG
IGCC_FLAGS	= $(MGCC_FLAGS) -arch arm64 -DIPHONEOS_ARM -I. -L./CI_scripts/libs -I/Library/Developer/CommandLineTools/SDKs/MacOSX12.3.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/

SOURCE		= \
		main.c \
		src/common/payload.c \
		src/exploit/limera1n.c \
		src/exploit/s5l8950x.c \
		ra1npoc/src/io/iousb.c \
		ra1npoc/src/common/common.c \
		ra1npoc/src/exploit/checkm8_arm64.c


.PHONY: all static clean

all:
	$(IGCC) $(IGCC_FLAGS) $(SOURCE)

static:
	$(MGCC) $(MGCC_FLAGS) $(SOURCE) $(STATIC32) -o $(MOBJECT)

clean:
	-$(RM) $(MOBJECT)


.PHONY: create_libs

create_libs:
	chmod +x create_libs && ./create_libs
