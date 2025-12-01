# Setup output directory for captured frames
OUTDIR="$HOME/Projects/moss/frames"
mkdir -p "$OUTDIR"

echo 1 | sudo tee /sys/module/imx296/parameters/trigger_mode >/dev/null # Make sure camera is external tirgger mode

EXPOSURES=(100 500 2000) # Exposure times in microseconds
GAIN=1

time_array_size=${#EXPOSURES[@]}
trigger_count=0 # Total number of captures taken
current_time=0 # Index into EXPOSURES array

# Capture loop: cycles through exposure times, taking F and B captures for each
while [ "$current_time" -lt "$time_array_size" ]; do
    exp_us=${EXPOSURES[$current_time]}

    # Alternate between Forward (F) and Backward (B) passes
    if [ $((trigger_count % 2)) -eq 0 ]; then
        DIR="F"  
    else
        DIR="B"
    fi

    filename="$OUTDIR/T:${exp_us}_G:${GAIN}_${DIR}.jpg" # File name

    # the one shutter time is just a place holder
    rpicam-still --immediate -n --shutter 1 --gain "$GAIN" -o "$filename"

    trigger_count=$((trigger_count + 1))

    # After both F and B captures (every 2nd trigger), move to next exposure time
    if [ $((trigger_count % 2)) -eq 0 ]; then
        current_time_index=$((current_time_index + 1))
    fi
done

echo "Capture sequence completed: $trigger_count frames captured."

# chmod +x cap.sh
# ./cap.sh
