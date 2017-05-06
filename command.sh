#! /bin/sh

export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=2

inputPath=${PWD}/Data/
outputPath=${PWD}/Output/

mkdir -p ${outputPath}

# leave out S1 to be the target.  We use all the other t1 and t2 images
# to S1 to estimate the simulated T2 of S1
targetT1=${inputPath}/S1/structInSpaceOfTemplateCoronalSlice.nii.gz

commandString="antsJointFusion -d 2 -c 1 -v 1 -t $targetT1 -o ${outputPath}/simulatedS1_%02d.nii.gz -p 3x3 -s 2x2"

for i in 2 3 4 5 6 7 8 10 11 12 13 14 15 16 17 19;
  do
    t1=${inputPath}/S${i}/structInSpaceOfTemplateCoronalSlice.nii.gz
    t2=${inputPath}/S${i}/T2_structInSpaceOfTemplateCoronalSlice.nii.gz

    commandString="${commandString} -g [${t1},${t2}]"
  done
$commandString

echo ""
echo "T2 comparison:  "
echo "   Compare ${outputPath}/simulatedS2_02.nii.gz"
echo "     with ${inputPath}/S1/T2_structInSpaceOfTemplateCoronalSlice.nii.gz"
