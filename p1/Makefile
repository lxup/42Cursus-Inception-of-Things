# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lquehec <lquehec@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/23 12:10:04 by lquehec           #+#    #+#              #
#    Updated: 2025/10/23 14:53:48 by lquehec          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ** #
#                                     VARS                                     #
# ** #

END				=	\001\033[0m\002

# COLORS
BLACK			=	\001\033[0;30m\002
RED				=	\001\033[0;31m\002
GREEN			=	\001\033[0;32m\002
ORANGE			=	\001\033[0;33m\002
BLUE			=	\001\033[0;34m\002
PURPLE			=	\001\033[0;35m\002
CYAN			=	\001\033[0;36m\002
LIGHT_GRAY		=	\001\033[0;37m\002
DARK_GRAY		=	\001\033[1;30m\002
LIGHT_RED		=	\001\033[1;31m\002
LIGHT_GREEN		=	\001\033[1;32m\002
YELLOW			=	\001\033[1;33m\002
LIGHT_BLUE		=	\001\033[1;34m\002
LIGHT_PURPLE	=	\001\033[1;35m\002
LIGHT_CYAN		=	\001\033[1;36m\002
WHITE			=	\001\033[1;37m\002

USERNAME := $(shell whoami)

OS := $(shell uname)

# ** #
#                                    RULES                                     #
# ** #

all: up

up:
	@printf "${YELLOW}> Starting cluster... 🚀${END}\n"
	@vagrant up

down:
	@printf "${YELLOW}> Stop cluster... 🧼${END}\n"
	@vagrant destroy -f
	
clean:
	@printf "${YELLOW}> Cleaning all resources... 🧽${END}\n"
	@rm -rf ./shared

fclean: down clean

status:
	@vagrant status

re: clean all

ssh-master:
	@printf "${YELLOW}> SSH into master node... 🔐${END}\n"
	@vagrant ssh ${USERNAME}S

ssh-worker:
	@printf "${YELLOW}> SSH into worker node... 🔐${END}\n"
	@vagrant ssh ${USERNAME}SW

.PHONY: all down clean fclean status re ssh-master ssh-worker