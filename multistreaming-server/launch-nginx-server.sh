#!/usr/bin/env sh
export DOLLAR='$'

# construct the nginx.conf based on environment variable definitions

envsubst < nginx-conf-prefix.txt >  /usr/local/nginx/conf/nginx.conf

if [ $MULTISTREAMING_KEY_FACEBOOK1 ]; then
	envsubst < nginx-conf-facebook1.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_FACEBOOK_MARKER1##//g" -i /usr/local/nginx/conf/nginx.conf
	/usr/bin/stunnel &
fi

if [ $MULTISTREAMING_KEY_FACEBOOK2 ]; then
	envsubst < nginx-conf-facebook2.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_FACEBOOK_MARKER2##//g" -i /usr/local/nginx/conf/nginx.conf
	/usr/bin/stunnel &
fi

if [ $MULTISTREAMING_KEY_INSTAGRAM1 ]; then
	envsubst < nginx-conf-instagram1.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_INSTAGRAM_MARKER1##//g" -i /usr/local/nginx/conf/nginx.conf
	/usr/bin/stunnel &
fi

if [ $MULTISTREAMING_KEY_INSTAGRAM2 ]; then
	envsubst < nginx-conf-instagram2.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_INSTAGRAM_MARKER2##//g" -i /usr/local/nginx/conf/nginx.conf
	/usr/bin/stunnel &
fi

if [ $MULTISTREAMING_KEY_TWITCH1 ]; then
	envsubst < nginx-conf-twitch1.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_TWITCH_MARKER1##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_TWITCH2 ]; then
	envsubst < nginx-conf-twitch2.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_TWITCH_MARKER2##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_YOUTUBE1 ]; then
	envsubst < nginx-conf-youtube1.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_YOUTUBE_MARKER1##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_YOUTUBE2 ]; then
	envsubst < nginx-conf-youtube2.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_YOUTUBE_MARKER2##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_PERISCOPE1 ]; then
	if [ !$PERISCOPE_REGION_ID1 ]; then
		export PERISCOPE_REGION_ID1=va
	fi
	envsubst < nginx-conf-periscope1.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_PERISCOPE_MARKER1##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_PERISCOPE2 ]; then
	if [ !$PERISCOPE_REGION_ID2 ]; then
		export PERISCOPE_REGION_ID2=va
	fi
	envsubst < nginx-conf-periscope2.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_PERISCOPE_MARKER2##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_CUSTOM1 ]; then
	envsubst < nginx-conf-custom1.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_CUSTOM_MARKER1##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_CUSTOM2 ]; then
	envsubst < nginx-conf-custom2.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_CUSTOM_MARKER2##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_MICROSOFTSTREAM1 ]; then
	export MICROSOFTSTREAMRTMP1=${MULTISTREAMING_KEY_MICROSOFTSTREAM1%/live/*}
	export MICROSOFTSTREAMAPPNAME1=live/${MULTISTREAMING_KEY_MICROSOFTSTREAM1#*/live/}
	envsubst < nginx-conf-microsoftstream1.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_MICROSOFTSTREAM_MARKER1##//g" -i /usr/local/nginx/conf/nginx.conf
fi

if [ $MULTISTREAMING_KEY_MICROSOFTSTREAM2 ]; then
	export MICROSOFTSTREAMRTMP2=${MULTISTREAMING_KEY_MICROSOFTSTREAM2%/live/*}
	export MICROSOFTSTREAMAPPNAME2=live/${MULTISTREAMING_KEY_MICROSOFTSTREAM2#*/live/}
	envsubst < nginx-conf-microsoftstream2.txt >>  /usr/local/nginx/conf/nginx.conf
	sed -e "s/##PUSH_MICROSOFTSTREAM_MARKER2##//g" -i /usr/local/nginx/conf/nginx.conf
fi

envsubst < nginx-conf-suffix.txt >>  /usr/local/nginx/conf/nginx.conf

# finally, launch nginx
/usr/local/nginx/sbin/nginx -g "daemon off;"
