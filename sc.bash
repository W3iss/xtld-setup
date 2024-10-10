bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
SNI="www.microsoft.com"
short_id=`openssl rand -hex 8`
client_uuid=`/usr/local/bin/xray uuid`
keys=`/usr/local/bin/xray x25519`
private_key=`echo $keys | cut -d " " -f 3`
public_key=`echo $keys | cut -d " " -f 6`
echo "Public key: ${public_key}"
echo "Short id: ${short_id}"
echo "Client uuid: ${client_uuid}"
echo "ewogICJsb2ciOiB7CiAgICAibG9nbGV2ZWwiOiAiaW5mbyIKICB9LAogICJyb3V0aW5nIjogewogICAgInJ1bGVzIjogW10sCiAgICAiZG9tYWluU3RyYXRlZ3kiOiAiQXNJcyIKICB9LAogICJpbmJvdW5kcyI6IFsKICAgIHsKICAgICAgInBvcnQiOiA0NDMsCiAgICAgICJwcm90b2NvbCI6ICJ2bGVzcyIsCiAgICAgICJ0YWciOiAidmxlc3NfdGxzIiwKICAgICAgInNldHRpbmdzIjogewogICAgICAgICJjbGllbnRzIjogWwogICAgICAgICAgewogICAgICAgICAgICAiaWQiOiAiQ0xJVVVJRCIsCiAgICAgICAgICAgICJlbWFpbCI6ICJjbGkxQGxvY2FsaG9zdCIsCiAgICAgICAgICAgICJmbG93IjogInh0bHMtcnByeC12aXNpb24iCiAgICAgICAgICB9CiAgICAgICAgXSwKICAgICAgICAiZGVjcnlwdGlvbiI6ICJub25lIgogICAgICB9LAogICAgICAic3RyZWFtU2V0dGluZ3MiOiB7CiAgICAgICAgIm5ldHdvcmsiOiAidGNwIiwKICAgICAgICAic2VjdXJpdHkiOiAicmVhbGl0eSIsCgkJInJlYWxpdHlTZXR0aW5ncyI6IHsKCQkJInNob3ciOiBmYWxzZSwKCQkJImRlc3QiOiAiRE9NQUlOOjQ0MyIsCgkJCSJ4dmVyIjogMCwKCQkJInNlcnZlck5hbWVzIjogWwoJCQkJIkRPTUFJTiIKCQkJXSwKCQkJInByaXZhdGVLZXkiOiAiUFJJVktFWSIsCgkJCSJtaW5DbGllbnRWZXIiOiAiIiwKCQkJIm1heENsaWVudFZlciI6ICIiLAoJCQkibWF4VGltZURpZmYiOiAwLAoJCQkic2hvcnRJZHMiOiBbCgkJCQkiU0hPUlRJRCIKCQkJXQoJCX0KICAgICAgfSwKICAgICAgInNuaWZmaW5nIjogewogICAgICAgICJlbmFibGVkIjogdHJ1ZSwKICAgICAgICAiZGVzdE92ZXJyaWRlIjogWwogICAgICAgICAgImh0dHAiLAogICAgICAgICAgInRscyIKICAgICAgICBdCiAgICAgIH0KICAgIH0KICBdLAogICJvdXRib3VuZHMiOiBbCiAgICB7CiAgICAgICJwcm90b2NvbCI6ICJmcmVlZG9tIiwKICAgICAgInRhZyI6ICJkaXJlY3QiCiAgICB9LAogICAgewogICAgICAicHJvdG9jb2wiOiAiYmxhY2tob2xlIiwKICAgICAgInRhZyI6ICJibG9jayIKICAgIH0KICBdCn0K" | base64 -d | sed -e "s/CLIUUID/${client_uuid}/g" -e "s/DOMAIN/${SNI}/g" -e "s/PRIVKEY/${private_key}/g" -e "s/SHORTID/${short_id}/g" > "/usr/local/etc/xray/config.json" && systemctl restart xray
