VERSION=$(gem search -e eyes_selenium | grep eyes_selenium | grep -E -o "[0-9]+.[0-9]+.[0-9]+")
echo "$VERSION"
bundle remove eyes_selenium && bundle add eyes_selenium -v "$VERSION"