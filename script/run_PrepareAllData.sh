#!/bin/bash



#Simple attempt to figure out the relative path to the data
if [[ $0 == "./script/run_PrepareAllData.sh" ]] 
then
	TARGETDIR=./target
else 
if [[ $0 == "./run_PrepareAllData.sh" ]]
then
	TARGETDIR=../target
else
	echo "Please run this script from within the script/ directory"
	exit
fi
fi

SUBMIT_COMMAND_TRAIN="spark-submit --class com.combient.sparkjob.tedsds.PrepareTrainData --master yarn $TARGETDIR/scala-2.10/tedsds-assembly-1.0.jar"
SUBMIT_COMMAND_TEST="spark-submit --class com.combient.sparkjob.tedsds.PrepareTestData --master yarn $TARGETDIR/scala-2.10/tedsds-assembly-1.0.jar"


hadoop fs -rm -r -f /share/tedsds/scaleddftest*

$SUBMIT_COMMAND_TEST /share/tedsds/input/test_FD001.txt /share/tedsds/input/RUL_FD001.txt /share/tedsds/scaleddftest_FD001
$SUBMIT_COMMAND_TEST  /share/tedsds/input/test_FD002.txt /share/tedsds/input/RUL_FD002.txt /share/tedsds/scaleddftest_FD002
$SUBMIT_COMMAND_TEST  /share/tedsds/input/test_FD003.txt /share/tedsds/input/RUL_FD003.txt /share/tedsds/scaleddftest_FD003
$SUBMIT_COMMAND_TEST  /share/tedsds/input/test_FD004.txt /share/tedsds/input/RUL_FD004.txt /share/tedsds/scaleddftest_FD004

$SUBMIT_COMMAND_TRAIN /share/tedsds/input/train_FD001.txt /share/tedsds/scaleddftrain_FD001
$SUBMIT_COMMAND_TRAIN /share/tedsds/input/train_FD002.txt /share/tedsds/scaleddftrain_FD002
$SUBMIT_COMMAND_TRAIN /share/tedsds/input/train_FD003.txt /share/tedsds/scaleddftrain_FD003
$SUBMIT_COMMAND_TRAIN /share/tedsds/input/train_FD004.txt /share/tedsds/scaleddftrain_FD004
