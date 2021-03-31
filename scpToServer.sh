tryplanet(){
  ssh "$2" "mkdir -p daniejoh"
  scp "$1" "$2:daniejoh"
  ssh "$2" 
  ssh "$2" "rm -rf daniejoh"
}