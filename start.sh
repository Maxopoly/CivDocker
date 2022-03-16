function template_folder {
	source_folder=$1
	target_folder=$2
	for p in $(find "$source_folder/"); do
		#Removes up until the second '/''
		file_name=`echo $p | cut -d'/' -f3-`
		if [ -d $p ];
		then
			mkdir -p $target_folder/$file_name
		else
			cat $p | envsubst > $target_folder/$file_name
		fi
	done
}

function deploy_folder {
	source_folder=$1
	target_folder=$2
	for p in $(find "$source_folder/"); do
		file_name=`echo $p | cut -d'/' -f3-`
		if [ -d $p ];
		then
			mkdir -p $target_folder/$file_name
		else
			ln -s $p $target_folder/$file_name
		fi
	done
}

template_folder "/configs" "/paper" 

if [ -d "/secret_configs" ];
then
	template_folder "/secret_configs" "/paper" 
fi

deploy_folder "/jars" "/paper/plugins"

if [ -d "/secret_plugins" ];
then
	deploy_folder "/secret_plugins" "/paper/plugins" 
fi

byobu new-session -s "server" "java -jar ${PAPER_ARGS} paper.jar"


