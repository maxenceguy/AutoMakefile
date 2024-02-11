#!/bin/bash

if [ ! -z "$2" ]; then
	exit 84
fi

if [ -z "$1" ]; then
	exit 84
fi

config_file=$1

if [ ! -f "$config_file" ]; then
	exit 84
fi

SRC=()
count_src=0

while IFS=';' read -ra arr; do
	if [[ ${arr[0]} == *.c ]]; then
		SRC[$count_src]="${arr[0]}"
		echo "${SRC[$count_src]}"
		((count_src++))
	elif [ "${arr[0]}" == "NAME" ]; then
		NAME=${arr[1]}
	elif [ "${arr[0]}" == "PROJECT_DIR" ]; then
		PROJECT_DIR=${arr[1]}
	elif [ "${arr[0]}" == "CC" ]; then
		CC=${arr[1]}
	elif [ "${arr[0]}" == "SOURCES_DIRS" ]; then
		SOURCES_DIRS=${arr[1]}
	elif [ "${arr[0]}" == "CFLAGS" ]; then
		CFLAGS=${arr[1]}
	elif [ "${arr[0]}" == "HEADERS_DIR" ]; then
		HEADERS_DIR=${arr[1]}
	elif [ "${arr[0]}" == "LIBS_DIR" ]; then
		LIBS_DIR=${arr[1]}
	elif [ "${arr[0]}" == "BCK_DIR" ]; then
		BCK_DIR=${arr[1]}
	elif [ "${arr[0]}" == "ZIP" ]; then
		ZIP=${arr[1]}
	elif [ "${arr[0]}" == "ZIPFLAGS" ]; then
		ZIPFLAGS=${arr[1]}
	elif [ "${arr[0]}" == "UNZIP" ]; then
		UNZIP=${arr[1]}
	elif [ "${arr[0]}" == "UNZIPFLAGS" ]; then
		UNZIPFLAGS=${arr[1]}
	elif [ "${arr[0]}" == "AR" ]; then
		AR=${arr[1]}
	elif [ "${arr[0]}" == "DISPLAY" ]; then
		DISPLAY=${arr[1]}
	fi
done < "$config_file"

if [ -z "$PROJECT_DIR" ] || [ "$PROJECT_DIR" == "." ]; then
	exit 84
fi

src_in_line=""
for element in "${SRC[@]}"; do
	src_in_line+="$(basename -s .c $element) "
done
src_in_line="$(echo -n $src_in_line)"

if [ -z "$CC" ]; then
	CC="gcc"
fi

if [ -z "$LIB_DIR" ]; then
	lib=""
elif [ ! -z "$LIB_DIR" ]; then
	lib="-L $LIB_DIR"
fi

display_word() {
	LINE1=""
	LINE2=""
	LINE3=""
	LINE4=""
	LINE5=""
	LINE6=""
	
	local word=${DISPLAY}
	local len=${#word}

	for ((i = 1; i <= 6; i++)); do
		for ((j = 0; j < len; j++)); do
			local letter=${word:j:1}
			local lines=()

			case $letter in
				"A") lines=(" █████╗ " "██╔══██╗" "███████║" "██╔══██║" "██║  ██║" "╚═╝  ╚═╝");;
				"B") lines=("██████╗ " "██╔══██╗" "██████╔╝" "██╔══██╗" "██████╔╝" "╚═════╝ ");;
				"C") lines=(" ██████╗" "██╔════╝" "██║     " "██║     " "╚██████╗" " ╚═════╝");;
				"D") lines=("██████╗ " "██╔══██╗" "██║  ██║" "██║  ██║" "██████╔╝" "╚═════╝ ");;
				"E") lines=("███████╗" "██╔════╝" "███████╗" "██╔════╝" "███████╗" "╚══════╝");;
				"F") lines=("███████╗" "██╔════╝" "███████╗" "██╔════╝" "██║     " "╚═╝     ");;
				"G") lines=(" ██████╗ " "██╔════╝ " "██║  ███╗" "██║   ██║" "╚██████╔╝" " ╚═════╝ ");;
				"H") lines=("██╗  ██╗" "██║  ██║" "███████║" "██╔══██║" "██║  ██║" "╚═╝  ╚═╝");;
				"I") lines=("██████╗ " "╚═██╔═╝ " "  ██║   " "  ██║   " "██████╗ " "╚═════╝ ");;
				"J") lines=("     ██╗" "     ██║" "     ██║" "██   ██║" "╚█████╔╝" " ╚════╝ ");;
				"K") lines=("██╗  ██╗" "██║ ██╔╝" "█████╔╝ " "██╔═██╗ " "██║  ██╗" "╚═╝  ╚═╝");;
				"L") lines=("██╗     " "██║     " "██║     " "██║     " "███████╗" "╚══════╝");;
				"M") lines=("███╗   ███╗" "████╗ ████║" "██╔████╔██║" "██║╚██╔╝██║" "██║ ╚═╝ ██║" "╚═╝     ╚═╝");;
				"N") lines=("███╗   ██╗" "████╗  ██║" "██╔██╗ ██║" "██║╚██╗██║" "██║ ╚████║" "╚═╝  ╚═══╝");;
				"O") lines=(" █████╗ " "██╔══██╗" "██║  ██║" "██║  ██║" "╚█████╔╝" " ╚════╝ ");;
				"P") lines=("██████╗ " "██╔══██╗" "██████╔╝" "██╔═══╝ " "██║     " "╚═╝     ");;
				"Q") lines=(" █████╗   " "██╔══██╗  " "██║  ██║  " "██║  ███╗ " "╚█████╔██╗" " ╚════╝╚═╝");;
				"R") lines=("██████╗ " "██╔══██╗" "██████╔╝" "██╔═██╗ " "██║  ██╗" "╚═╝  ╚═╝");;
				"S") lines=(" ██████╗" "██╔════╝" "╚█████╗ " " ╚═══██╗" "██████╔╝" "╚═════╝ ");;
				"T") lines=("██████╗ " "╚═██╔═╝ " "  ██║   " "  ██║   " "  ██║   " "  ╚═╝   ");;
				"U") lines=("██╗  ██╗" "██║  ██║" "██║  ██║" "██║  ██║" "╚█████╔╝" " ╚════╝ ");;
				"V") lines=("██╗   ██╗" "██║   ██║" " ██║ ██╔╝" "  ████╔╝ " "   ██╔╝  " "   ╚═╝   ");;
				"W") lines=("██╗    ██╗" "██║    ██║" "██║ █╗ ██║" "██║███╗██║" "╚███╔███╔╝" " ╚══╝╚══╝ ");;
				"X") lines=("██╗  ██╗" "╚██╗██╔╝" " ╚███╔╝ " " ██╔██╗ " "██╔╝ ██╗" "╚═╝  ╚═╝");;
				"Y") lines=("██╗   ██╗" "╚██╗ ██╔╝" " ╚████╔╝ " "  ╚██╔╝  " "   ██║   " "   ╚═╝   ");;
				"Z") lines=("███████╗" "╚═══██╔╝ " "  ███╔╝  " " ██╔═╝   " "███████╗ " "╚══════╝ ");;
				*) lines=("Letter not recognized");;
			esac

			eval "LINE${i}+=\$(echo -n \"\${lines[\$i-1]}\")"
		done
	done
}


display_word

cat << EOF > "${PROJECT_DIR}/Makefile"
DEF_COLOR 	= \033[0;39m
GRAY 		= \033[0;90m
RED 		= \033[0;91m
GREEN 		= \033[0;92m
YELLOW 		= \033[0;93m
BLUE 		= \033[0;94m
MAGENTA 	= \033[0;95m
CYAN 		= \033[0;96m
WHITE 		= \033[0;97m
ORANGE		= \033[38;5;214m

BBlack		= \033[1;30m
BRed		= \033[1;31m
BGreen		= \033[1;32m
BYellow		= \033[1;33m
BBlue		= \033[1;34m
BPurple		= \033[1;35m
BCyan		= \033[1;36m
BWhite		= \033[1;37m

LINE1 = "${LINE1}"
LINE2 = "${LINE2}"
LINE3 = "${LINE3}"
LINE4 = "${LINE4}"
LINE5 = "${LINE5}"
LINE6 = "${LINE6}"

CC = ${CC}
CFLAGS = ${CFLAGS}
LDFLAGS = -L\$(LIB_DIR)
AR = ${AR}

NAME = ${NAME}

DISPLAY = ${DISPLAY}
SRC_DIR = ${SOURCES_DIRS}
OBJ_DIR = obj/
INC_DIR = ${HEADERS_DIR}
LIB_DIR = ${LIBS_DIR}
BCK_DIR = ${BCK_DIR}
ZIP = ${ZIP}
ZIPFLAGS = ${ZIPFLAGS}
UNZIP = ${UNZIP}
UNZIPFLAGS = ${UNZIPFLAGS}

SRC_FILES = ${src_in_line}
SRC = \$(foreach file,\$(SRC_FILES),\$(foreach dir,\$(SRC_DIR),\$(dir)\$(file).c))
OBJ = \$(foreach file,\$(SRC_FILES),\$(foreach dir,\$(OBJ_DIR),\$(dir)\$(file).o))


all: \$(TITLE) \$(NAME)

\$(TITLE):
	echo \$(TITLE); 

\$(NAME): \$(OBJ)
	@make -C \$(LIB_DIR) > /dev/null
	echo "\$(GREEN)  ✅ \${LIB_DIR}\$(DEF_COLOR)"
	\$(CC) \$(LDFLAGS) -o \$@ \$^ -lft
	echo "\$(BYellow)MAKE\$(DEF_COLOR)"

\$(OBJ_DIR)%.o: \$(SRC_DIR)%.c | \$(OBJ_DIR)
	\$(CC) \$(CFLAGS) -I \$(INC_DIR) -c \$< -o \$@ -g3
	echo "\$(GREEN)  ✅ $<\$(DEF_COLOR)"

\$(OBJ_DIR):
	echo "\$(ORANGE)"
	echo \$(LINE1)
	echo \$(LINE2)
	echo \$(LINE3)
	echo \$(LINE4)
	echo \$(LINE5)
	echo \$(LINE6)
	echo "\$(DEF_COLOR)"
	mkdir -p \$(OBJ_DIR)

clean:
	@make clean -C \$(LIB_DIR) > /dev/null
	echo "\$(BGreen)  🧹 \${LIB_DIR}\$(DEF_COLOR)"
	@rm -rf \$(OBJ_DIR)
	echo "\$(BBLUE)CLEAN\$(DEF_COLOR)"

fclean: clean
	@make fclean -C \$(LIB_DIR) > /dev/null
	echo "\$(BGreen)  🧹 \${LIB_DIR}\$(DEF_COLOR)"
	@rm -f \$(NAME)
	echo "\$(BBLUE)FCLEAN\$(DEF_COLOR)"

re: fclean all

archive:
	echo "Archiving the source files..."
	mkdir -p \$(BCK_DIR)
	\$(ZIP) \$(ZIPFLAGS) \$(BCK_DIR)/backup_\$(shell date +'%Y%m%d%H%M%S').tar.gz .
	echo "Archive file generated."

revert:
	\$(eval LATEST_BACKUP := \$(shell ls -1t \$(BCK_DIR)/*.tar.gz | head -n 1))
	if [ -n "\$(LATEST_BACKUP)" ]; then
		\$(UNZIP) \$(UNZIPFLAGS) "\$(LATEST_BACKUP)" -C .;
		echo "Project reverted from the backup.";
	else
		echo "No backups found.";
	fi

num:
	echo "Current version number: \$(shell ls -1 \$(BCK_DIR) | wc -l)"

delete:
	echo "Deleting the last backup..."
	\$(eval LATEST_BACKUP := \$(shell ls -1t \$(BCK_DIR)/*.tar.gz | head -n 1))
	if [ -n "\$(LATEST_BACKUP)" ]; then
		rm -f "\$(LATEST_BACKUP)";
		echo "Last backup deleted.";
	else
		rm -rf \$(BCK_DIR);
		echo "No backups found.";
	fi

.PHONY: display_word all clean fclean re archive revert num delete

.SILENT:

EOF
