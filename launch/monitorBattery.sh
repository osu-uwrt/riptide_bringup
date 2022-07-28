echo "Monitoring Battery"


checkTimout=30 #seconds, thirty plus recommended
criticalVoltage="19.2" #the batteries critical voltage -  as string
saveFileName="voltageRecord.txt"

#check forever
while [ True ]
do
    stbdVoltage=20
    portVoltage=18

    #ensure filespace is clear
    rm $saveFileName

    #record voltages
    timeout $checkTimout ros2 topic echo /tempest/state/electrical > $saveFileName

    #use the python script to check voltages
    output=`python evaluateVoltages.py $criticalVoltage $saveFileName`
    

    #if battery voltage bellow critical - alert
    if [[ $output == *"Low"* ]]; then
        spd-say 'Low Battery'
        
        echo "Tempest Battery Low!"
    fi

    if [[ $output == *"WARNINGNOFIND"* ]]; then
        echo "Waiting for bringup!"
    fi 

done