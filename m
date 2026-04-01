Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12111D3516F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sZR-0008HK-EJ; Wed, 01 Apr 2026 06:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sZP-0008Gx-DE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:13:07 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sZN-0003MJ-B9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:13:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b983bb07eso3531977f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775038383; x=1775643183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dZey9uLNyS9ZOXKrxot6gGUouwPzAHYCqOqIIrCN8wY=;
 b=e5mROWWMpZPIAkppDkymvtEEorzNr96n37RUxfZ+XoxVlbteph7KWHUXXbPje8S55H
 UeoZDP2uZvetQdiBbsC3Z+5p6jMOSXAoXFts4kJ5Zy2KOuDSDld4Hqm13fGx/4C1QMHH
 uDZ2XFIk+KIW82Lw3YMNTr0otwA77eIRSbXSNRWnBvmIe4XW9igu+KiYpWRNmrmGTtA6
 LG7JGninUsLfs4gHOdHnMycB70SuWYEP9BPk5rOYQ/RfFXTTW927aom8rLGqSkT59pHq
 MzF8Dx6cmDf3x/FIe4Ks5KuZRWfriRZRZFglzC+JXaX1bL26+dJ9BB5v+YM9Y5jCWJy+
 Ce4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038383; x=1775643183;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dZey9uLNyS9ZOXKrxot6gGUouwPzAHYCqOqIIrCN8wY=;
 b=ZGDHiQHptzCcQhS6UfL3RQSTYzxy2vTXniXKYGb1Jh9lEeVXShpZxXkaWERE31c1GV
 i1EQUFtq7HtcYi/p2Hkmq/UKiwA0eSjZY5AR+n3bNenmTrTtaDsH7daN7Oy0gwCYyB0g
 sCKxUe+FpL1u33gUdUDBA0RWtE7a3s1VyCWtbyJDfm2ieoH/7vRPmJQq1udiueUIxgpM
 Bfagg9VqsR+mNOz0rUVLyL6aw5rerRosg7C2X3TvYsVw1ViWPJlTgQ2R+7xggQCwxzZZ
 vcZTemYMfEi2goCROBb6CIPKPndkQxbkRy7j5gmXBG/+oGU/uLZriBUizKwoNyIrXIWL
 SgNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGAptwdAw6WY64jMgvijed85F8mUqr6qwO+DEkwZysttPjNRG10PaKWM0/tGDzS55/Q/bdASttn99S@nongnu.org
X-Gm-Message-State: AOJu0Yzr0EUHDYtkqYtP/CV9siyDkiFcf5oVhnzeQVBAv1N9G3TGJ79j
 3xknqoG+N6r4K2vbsSGNgXV2UVFvFN/50GZaaeNo7HnYU+AJxfiwPN7NnhxvHfEEApU=
X-Gm-Gg: ATEYQzxD2/QOJyUYpN+Pxb0p/s6AdezfFWwIjjgIAYmubeWDbBGyyp5JwkPTrNHkeZV
 Nchlu9vtIjib/W4nJ/UUCh8JioJe4Xqu8osl6/P6wWr+6aQ1jOMqZBlikOWGo5pGTm9G17DE+oi
 ItHG7DFXyAkzAfuCp+8LVnNqBfzb0ioRiF4hd+wZGTLq6qgY8bYMTl9fsw+rX66ip/6EMc14dXj
 bqhHLm8d7WgO/64Vp4odi9KZRTpOe4EwkAy5pfHP3FqB0dGr53DvMeJ6drBkWL0Z/bodj6W+hTO
 Py3fpwUC65jINf3sIuUbe+Vf3y8JNOi1b3FbLtgT1ex5563+ub1MZLPvfWPRC3QlRWJ73Yy3Ot5
 hn/DksVyL5et4DmJm7wd7IU7duDwY0vI+CE4JAIMBDjcbOw1qmr2qFUvHVf8lf8ZRdQ0UfUvbt3
 NV+NOF6/Wb/gXwKWelwdE/Utyvis1L0mPCc/UOIUgvKXsizI2uY1tUN3U3lRH7+SjMG8wET62gR
 r6J
X-Received: by 2002:a05:6000:230a:b0:43b:3d83:f04f with SMTP id
 ffacd0b85a97d-43d150452e8mr5314296f8f.9.1775038382847; 
 Wed, 01 Apr 2026 03:13:02 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2580194sm32252828f8f.37.2026.04.01.03.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:13:02 -0700 (PDT)
Message-ID: <b9ae80bd-8d37-4fee-8a4e-6001b29089d0@linaro.org>
Date: Wed, 1 Apr 2026 12:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] meson.build: ignore audio drivers when
 configured with --disable-audio
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-12-heifetz@yandex-team.com>
 <ee0a3c03-75c7-49af-a3d8-2c715bd1e3e0@linaro.org>
In-Reply-To: <ee0a3c03-75c7-49af-a3d8-2c715bd1e3e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/4/26 12:10, Philippe Mathieu-Daudé wrote:
> On 15/3/26 21:16, Sergei Heifetz wrote:
>> When QEMU is configured with `--disable-audio`, we do not need to add the
>> audio drivers list to config_host_data. We also do not need to print this
>> list.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   meson.build | 80 ++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 45 insertions(+), 35 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index d05533488f9..7f71dce3ae5 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2280,46 +2280,55 @@ endif
>>   config_host_data = configuration_data()
>>   config_host_data.set('CONFIG_HAVE_RUST', have_rust)
>> -audio_drivers_selected = []
>> -if have_system
>> -  audio_drivers_available = {
>> -    'alsa': alsa.found(),
>> -    'coreaudio': coreaudio.found(),
>> -    'dsound': dsound.found(),
>> -    'jack': jack.found(),
>> -    'oss': oss.found(),
>> -    'pa': pulse.found(),
>> -    'pipewire': pipewire.found(),
>> -    'sdl': sdl.found(),
>> -    'sndio': sndio.found(),
>> -  }
>> -  foreach k, v: audio_drivers_available
>> -    config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
>> -  endforeach
>> +config_host_data.set('CONFIG_AUDIO', have_audio)
>> +if have_audio
>> +  audio_drivers_selected = []
>> +  if have_system
>> +    audio_drivers_available = {
>> +      'alsa': alsa.found(),
>> +      'coreaudio': coreaudio.found(),
>> +      'dsound': dsound.found(),
>> +      'jack': jack.found(),
>> +      'oss': oss.found(),
>> +      'pa': pulse.found(),
>> +      'pipewire': pipewire.found(),
>> +      'sdl': sdl.found(),
>> +      'sndio': sndio.found(),
>> +    }
>> +    foreach k, v: audio_drivers_available
>> +      config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
>> +    endforeach
>> -  # Default to native drivers first, OSS second, SDL third
>> -  audio_drivers_priority = \
>> -    [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
>> -    (host_os == 'linux' ? [] : [ 'sdl' ])
>> -  audio_drivers_default = []
>> -  foreach k: audio_drivers_priority
>> -    if audio_drivers_available[k]
>> -      audio_drivers_default += k
>> -    endif
>> -  endforeach
>> +    # Default to native drivers first, OSS second, SDL third
>> +    audio_drivers_priority = \
>> +      [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
>> +      (host_os == 'linux' ? [] : [ 'sdl' ])
>> +    audio_drivers_default = []
>> +    foreach k: audio_drivers_priority
>> +      if audio_drivers_available[k]
>> +        audio_drivers_default += k
>> +      endif
>> +    endforeach
>> +    foreach k: get_option('audio_drv_list')
>> +      if k == 'default'
>> +        audio_drivers_selected += audio_drivers_default
>> +      elif not audio_drivers_available[k]
>> +        error('Audio driver "@0@" not available.'.format(k))
>> +      else
>> +        audio_drivers_selected += k
>> +      endif
>> +    endforeach
>> +  endif
>> +  config_host_data.set('CONFIG_AUDIO_DRIVERS',
>> +                      '"' + '", "'.join(audio_drivers_selected) + '", ')
>> +else
>>     foreach k: get_option('audio_drv_list')
>> -    if k == 'default'
>> -      audio_drivers_selected += audio_drivers_default
>> -    elif not audio_drivers_available[k]
>> -      error('Audio driver "@0@" not available.'.format(k))
>> -    else
>> -      audio_drivers_selected += k
>> +    if k != 'default'
>> +      error('Audio drivers are not supported because audio is 
>> disabled.')
>>       endif
>>     endforeach
>>   endif
>> -config_host_data.set('CONFIG_AUDIO_DRIVERS',
>> -                     '"' + '", "'.join(audio_drivers_selected) + '", ')
>>   have_host_block_device = (host_os != 'darwin' or
>>       cc.has_header('IOKit/storage/IOMedia.h'))
>> @@ -4710,7 +4719,8 @@ if enable_modules
>>     summary_info += {'alternative module path': 
>> get_option('module_upgrades')}
>>   endif
>>   summary_info += {'fuzzing support':   get_option('fuzzing')}
>> -if have_system
>> +summary_info += {'Audio support':     have_audio}
>> +if have_audio
>>     summary_info += {'Audio drivers':     ' 
>> '.join(audio_drivers_selected)}
>>   endif
>>   summary_info += {'Trace backends':    
>> ','.join(get_option('trace_backends'))}
> 
> Shouldn't this be squashed with patch #1 as a single meson change?

Ah no otherwise we'd get link failures before the other patches.

