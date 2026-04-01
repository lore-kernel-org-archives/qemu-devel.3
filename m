Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A580D3516C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sXC-0007V3-62; Wed, 01 Apr 2026 06:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sXA-0007Uv-T7
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:10:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sX9-00038C-6G
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:10:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so52689255e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775038245; x=1775643045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aEjnVdx2u//Vcm9toaoBb1/NEqOyTkyclsIXLiTEXuE=;
 b=XmrjYTDkqjipcW06kYvvIAbsT/NO4GIa+pSgdzCwh6rfJNiRBPh2JOM8Q9NOJ9hFst
 TjXdMNEipAk7QNCHox/AhBxws2+x2jsgLmxoAU28QDc/Lnlwm7rmFb0+JmbdqpGSeX5b
 s8/q67+H/cSBpnxjfS5CMQoEP54jNe08Lo4rGqZd4zYmcgSMuik3fh+qHw4ZoLdHcTFz
 QIgDOeGB2E6IrjOFvQyz/tD9ldkpHHJxj9SJ5/ej1OMyrg6Ttv2fRzN17kDKZoDEWFC4
 5jsnuEzXw+tKABp68gjpdQE6TtwNlirbA4K51SC7Zy7gNngbR3Xau57aHGAJNOyHk0NA
 JKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038245; x=1775643045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aEjnVdx2u//Vcm9toaoBb1/NEqOyTkyclsIXLiTEXuE=;
 b=opRSomtMnxedD6Na3M+ksCWQTsy+UwJ1BGrkhrNcv0/eeVMbPkrlWlaDIpFGMrVi4g
 Gln55TsXkGT3u/aW1GmCegL3Z7cTj2+ckzxPRMfbhwt9i+0h0wzkm5EPNSCxLzF8hsyn
 hbKEzpp9IsS8+z2UOPiiBm/5yWBXjvkKRIZOcEUQn4H1rznyI59mQBIJpliF5lpseQxZ
 MNBLrqQ1cGeYrOnTu72mqVnn6bzrCvnSasR5lSMv0Jx/c/v59X4KV5PYSeJ3Nck23hRw
 76c8OfeP7fmRzgSjyZviXslROr2ZgCZblfRHM7sd09Ic2CeVTC814Zz+axIXf0e2IcS3
 a0Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwOiKOmwo6oIG1IFI/txVNQPHYlD/KNxCUeAqbRinQaI3Chki3LabrXaM/eKUFY5QcG6LfP8Pseve+@nongnu.org
X-Gm-Message-State: AOJu0YxXPA9/pIzkTeMEJ9Cq9BkGfnYVl/AMJUolZshFAozIYKqSsBJ5
 KhbtmeBh4tiV4B9b3avd5lbJpAexwAs359up7SsVgo0AFSvHQCvN+vEis7ovb2kRwRQ=
X-Gm-Gg: ATEYQzyI6pcqEXc1TeIv44o4cifqFoYH0YQQmSztq0zP3rDoqMvgnrHX+pf74MQus6x
 7E5C3UjLJUedz+TH/OEqNTh3wWsVQmKktCYVhCqRmEjvmrdaSfv/+3gzZXN3IPxcXFz5rRV4ZYr
 GYWvshB+94ayNTR6TqX4pKmRalMBjw76pM+pIqNsnSVNyE6y9s9aJXZRN9EB2LvYyOs0yZeudgW
 hK5NmsCOF4b9SrXjif1IZEJJRoZPbqnLPNhZjHKnJnsdtPXqOuIl7654bF7PAp4vP8t1LP3Yz30
 UwqpqiOBHtLYLa+gGxiH2+MQoTM1VloaZ152hkDQujTYkLZoOVI4PvwpjhA9Z/BKVWchbAFqdlQ
 Ryl9VCtedhlNnEpH6JIA6Z3KA92HwFbTcsJS7ii1ssybtXUtiX3bhRGy3yphHIj3qaOM/jVMDoU
 ydjqEctHntgxGfrBPHS4YsW7jDHV1pxVlPcUVnQM/hjCN3oglaQsSOgG4x8KVyzu3ZkA==
X-Received: by 2002:a05:600c:a113:b0:485:5ba3:37d8 with SMTP id
 5b1f17b1804b1-4888355e6c8mr35930175e9.5.1775038245232; 
 Wed, 01 Apr 2026 03:10:45 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e82e262sm106556825e9.10.2026.04.01.03.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:10:44 -0700 (PDT)
Message-ID: <ee0a3c03-75c7-49af-a3d8-2c715bd1e3e0@linaro.org>
Date: Wed, 1 Apr 2026 12:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] meson.build: ignore audio drivers when
 configured with --disable-audio
Content-Language: en-US
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260315201646.96862-12-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 15/3/26 21:16, Sergei Heifetz wrote:
> When QEMU is configured with `--disable-audio`, we do not need to add the
> audio drivers list to config_host_data. We also do not need to print this
> list.
> 
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   meson.build | 80 ++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 45 insertions(+), 35 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index d05533488f9..7f71dce3ae5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2280,46 +2280,55 @@ endif
>   config_host_data = configuration_data()
>   
>   config_host_data.set('CONFIG_HAVE_RUST', have_rust)
> -audio_drivers_selected = []
> -if have_system
> -  audio_drivers_available = {
> -    'alsa': alsa.found(),
> -    'coreaudio': coreaudio.found(),
> -    'dsound': dsound.found(),
> -    'jack': jack.found(),
> -    'oss': oss.found(),
> -    'pa': pulse.found(),
> -    'pipewire': pipewire.found(),
> -    'sdl': sdl.found(),
> -    'sndio': sndio.found(),
> -  }
> -  foreach k, v: audio_drivers_available
> -    config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
> -  endforeach
> +config_host_data.set('CONFIG_AUDIO', have_audio)
> +if have_audio
> +  audio_drivers_selected = []
> +  if have_system
> +    audio_drivers_available = {
> +      'alsa': alsa.found(),
> +      'coreaudio': coreaudio.found(),
> +      'dsound': dsound.found(),
> +      'jack': jack.found(),
> +      'oss': oss.found(),
> +      'pa': pulse.found(),
> +      'pipewire': pipewire.found(),
> +      'sdl': sdl.found(),
> +      'sndio': sndio.found(),
> +    }
> +    foreach k, v: audio_drivers_available
> +      config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
> +    endforeach
>   
> -  # Default to native drivers first, OSS second, SDL third
> -  audio_drivers_priority = \
> -    [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
> -    (host_os == 'linux' ? [] : [ 'sdl' ])
> -  audio_drivers_default = []
> -  foreach k: audio_drivers_priority
> -    if audio_drivers_available[k]
> -      audio_drivers_default += k
> -    endif
> -  endforeach
> +    # Default to native drivers first, OSS second, SDL third
> +    audio_drivers_priority = \
> +      [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
> +      (host_os == 'linux' ? [] : [ 'sdl' ])
> +    audio_drivers_default = []
> +    foreach k: audio_drivers_priority
> +      if audio_drivers_available[k]
> +        audio_drivers_default += k
> +      endif
> +    endforeach
>   
> +    foreach k: get_option('audio_drv_list')
> +      if k == 'default'
> +        audio_drivers_selected += audio_drivers_default
> +      elif not audio_drivers_available[k]
> +        error('Audio driver "@0@" not available.'.format(k))
> +      else
> +        audio_drivers_selected += k
> +      endif
> +    endforeach
> +  endif
> +  config_host_data.set('CONFIG_AUDIO_DRIVERS',
> +                      '"' + '", "'.join(audio_drivers_selected) + '", ')
> +else
>     foreach k: get_option('audio_drv_list')
> -    if k == 'default'
> -      audio_drivers_selected += audio_drivers_default
> -    elif not audio_drivers_available[k]
> -      error('Audio driver "@0@" not available.'.format(k))
> -    else
> -      audio_drivers_selected += k
> +    if k != 'default'
> +      error('Audio drivers are not supported because audio is disabled.')
>       endif
>     endforeach
>   endif
> -config_host_data.set('CONFIG_AUDIO_DRIVERS',
> -                     '"' + '", "'.join(audio_drivers_selected) + '", ')
>   
>   have_host_block_device = (host_os != 'darwin' or
>       cc.has_header('IOKit/storage/IOMedia.h'))
> @@ -4710,7 +4719,8 @@ if enable_modules
>     summary_info += {'alternative module path': get_option('module_upgrades')}
>   endif
>   summary_info += {'fuzzing support':   get_option('fuzzing')}
> -if have_system
> +summary_info += {'Audio support':     have_audio}
> +if have_audio
>     summary_info += {'Audio drivers':     ' '.join(audio_drivers_selected)}
>   endif
>   summary_info += {'Trace backends':    ','.join(get_option('trace_backends'))}

Shouldn't this be squashed with patch #1 as a single meson change?

