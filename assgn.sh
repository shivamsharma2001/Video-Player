#! /bin/bash
#locating video files of type .mp4 ,/3gp ,.flv ,....
locate *.mp4 *.3gp *.flv *.ogv *.avi| cat > vid.txt
#getting names of all videos in file named name.txt
cat vid.txt | rev | cut -d'/' -f1 |rev | cat > name.txt
#getting path of all videos in file named path.txt
cat vid.txt | rev | cut -d'/' -f2- | rev | cat > path.txt
#appending space at the beginning in path.txt
sed -i -e 's/^/               /' path.txt
#merging file name.txt and path.txt line by line
paste  name.txt path.txt > namepath.txt
echo -e "\n\n Videos found on your System are : \n\n"
#Displaying Videos....
nl namepath.txt
echo "Enter 1-To Display all the .3gp files"
echo "Enter 2-To Display all the .mp4 files"
echo "Enter 3-To Display all the .flv files"
echo "Enter 4-To Display all the .ogv files"
echo "Enter 5-To Display all the .avi files"
read file_ext
#extracting out videos of given extension in file named ext.txt
case $file_ext in
  1)
    grep -i .3gp namepath.txt > ext.txt
  ;;
  2)
    grep -i .mp4 namepath.txt > ext.txt
  ;;
  3)
    grep -i .flv namepath.txt > ext.txt
  ;;
  4)
    grep -i .ogv namepath.txt > ext.txt
  ;;
  5)
    grep -w .avi namepath.txt > ext.txt
   ;;
  *)
    echo -e "\nNo Extensions Choosen"
    echo -e "\n***Exiting***\n"
    exit
   ;;
esac

no=$(cat ext.txt | wc -l)
#if no. of videos are greater than zero
if [ $no -gt 0 ]
then
 #displying all videos of particular type
 echo -e "\n Videos of this extension are :--->>>\n\n"
 nl ext.txt
 echo -e "\nEnter the Video No. to play :"
 read  video_no
 #getting selected line
 A=$(awk '{if(NR=='$video_no') print $0}' ext.txt)
 #getting only name of the video
 B=$(echo $A | cut -d ' ' -f1 )
 #getting the full path of the video
 C=$(locate $B)
 echo -e "\nChoose Video player :\n"
 echo "  1.VLC Media Player"
 echo  -e "  2.Totem Player\n"

 read player_id
 #playing video in specified player
 if [ $player_id -eq 1 ]
 then
   vlc  $C
 elif [ $player_id -eq 2 ]
 then
   totem $C
 else 
   echo -e "\nNo Player Choosen!"
   echo -e "\n*****Exiting*****\n"
 fi
else
  echo -e "\nNo Video of this extensions !\n"
fi
