function git_pull(){
  current_path=$(pwd)

  for pje in ~/works/*
  do
	  cd $pje && git pull origin $(git status | pyp "pp[0].split(' ')[-1]")
  done

  cd $current_path
}

function gen_android() {
    mkdir project
    echo 'addSbtPlugin("com.hanhuy.sbt" % "android-sdk-plugin" % "1.3.1")' >> project/plugins.sbt
    echo 'object Build extends android.Build' >> project/build.scala
}
