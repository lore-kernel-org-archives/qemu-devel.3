Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4219BCCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSxF-0002LK-2q; Wed, 22 Oct 2025 03:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBSx9-0002DD-IC
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:08:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBSx7-0001AQ-Q9
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:08:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4712c6d9495so12007185e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761116888; x=1761721688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOSDp5qQnkQ65tSJhq1PFeeSmoZ2QbjUjpF4sKIY7Ds=;
 b=J036t94HOnVvTEwTVxEO+/6jKDDqrp46Thvewm3PDi0VqopAX1a7o18TKshaswYhL7
 uYqDPKmbrUcRUtvQgnfxvPn8ca21HPqySLxnP3p2ZbHlmjfLvz7QroEmu7gZ6FDvU9n7
 55pxNss/S9jk4afEVq8B57eDpP5QlJH9yrqbfmlJRiEhuF9uFWTmbpopiVUlwvoJorCD
 bkFt/BWVG6h8WWAeKizF/lx2gN4XeBMkDUhJGv4Q7ETTFU5R6IPsdObuHdGZ6nBvfKjq
 dnKm3yGc91nq4GtfsyNdrqxEWv4aQOp+VkrA/pPsfpy7Et62K8bO45lcCz9Ilm16Bi5K
 8BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761116888; x=1761721688;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wOSDp5qQnkQ65tSJhq1PFeeSmoZ2QbjUjpF4sKIY7Ds=;
 b=RjeEivqdyG9MgJAFoykAd6YoUZCmGnWGiFUUcmN/EZ3iI64sgjuUHYsrbVIp8Sm5Co
 mXT48WdySstygxk8rVb5SRiWPDXE/8vaEs/ysA8S5j3UlFM9bXorxww2Y9JjIbPdO/oE
 ZDL3AhjlqOpkdqF2vW8HVM5Nc2UemE+Lt55Tghnw2fzkANnieIZdUmxAokNDCdtEDGgQ
 VOks2/H9NGv1Hpbnchq4rQqcsBtMniGN+K3lOhlM6pX+e/0aUSvZ4CMIZ9ke9PHMWFX5
 HpKom8olwAf/lI6+QzcC9vU05tSsMeP2LtKhfv6xKTlqw+Jass2aBmDyVAF/wtWzUktZ
 1Siw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaheudI4jcmQ+MmLb6h9TT+axktFRUs7qk3P/HiBcwh0Eu1B9cVw743auQqGiXRKN+O0dJiBYJKy4C@nongnu.org
X-Gm-Message-State: AOJu0YyL362GQ2UMHGgclMHr8v9j+A4IFwIY++ubdMg6OtHD4vw8e454
 Sic8tSAwdf/UJLAXTVy2slkMP4tbtofYb4gnqXojWSnxtJFKQEJ5uAtKmsbLcutSK4Q=
X-Gm-Gg: ASbGncvt1MFii+JXZFf7Oyisy9a2VrmXHMLWcq9zmVQHwZYHKzTkMUAsL5I/SqTKBiC
 Xt6VE5CT6OplN98qJ2ZHJPojunUry8cZzid3lZsXU1jvyFINvF4+smoK5LS2TNIxn1jmLfdIaTT
 sywQh+fWdHGKkIyDowgVNg+xh7yq6EucuCjXkK0Cj0dXCjD2C5tEm4a6wU/2qhXu5SQI9ALZUQF
 98g5En7c6+tOhaEMOWkjT82umEn4zM+pwWZY1KTBcqC8PF62KeT60qUK50UDnu8mEnhZQRrdvs4
 2FolCoQrdz2TIGArMiAqvQn2guhi1/SnJfNdaJiGELen4IFDMMLVNpMpdTnGW9lAQkW4ImDsD5p
 bNMvmRPm2gQxs9SzF84/tm3o3oaD9N9YKAp04b7jSe3GM0no3alEhyPZCQJSkjTTq7SaAu4Slbq
 Ufp6VoIQY8J/3FTi1JzVociq1ESBLfhl9QjXBgUs9ZyrQ=
X-Google-Smtp-Source: AGHT+IEWXYxjTKYhPNfWoqPikHLHBDoVpGkerT9WoOwOtpWi1p7xnR1m959nnzgFUm3jDSqZEsGrHg==
X-Received: by 2002:a05:600c:8b62:b0:45d:d97c:235e with SMTP id
 5b1f17b1804b1-47117876bcdmr140234075e9.12.1761116887893; 
 Wed, 22 Oct 2025 00:08:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342946sm28490065e9.10.2025.10.22.00.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 00:08:07 -0700 (PDT)
Message-ID: <d5f3459a-35b8-41ae-b9d3-4b38678576fa@linaro.org>
Date: Wed, 22 Oct 2025 09:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/42] audio: move internal APIs to audio_int.h
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022065640.1172785-34-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022065640.1172785-34-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/10/25 08:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h          | 21 ---------------------
>   audio/audio_int.h      | 22 ++++++++++++++++++++++
>   audio/audio-hmp-cmds.c |  2 +-
>   audio/wavcapture.c     |  2 +-
>   4 files changed, 24 insertions(+), 23 deletions(-)


> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 4a4d69f2bf..cc7a6fe087 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -29,12 +29,16 @@
>   #define FLOAT_MIXENG
>   /* #define RECIPROCAL */
>   #endif
> +#include "audio.h"
>   #include "mixeng.h"
>   
>   #ifdef CONFIG_GIO
>   #include <gio/gio.h>
>   #endif
>   
> +void AUD_vlog (const char *cap, const char *fmt, va_list ap) G_GNUC_PRINTF(2, 0);
> +void AUD_log (const char *cap, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
> +
>   struct audio_pcm_ops;
>   
>   struct audio_callback {
> @@ -187,6 +191,24 @@ struct audio_pcm_ops {
>       void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
>   };
>   
> +audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo);
> +int audioformat_bytes_per_sample(AudioFormat fmt);
> +int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
> +                        audsettings *as, int def_usecs);
> +int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
> +                         audsettings *as, int def_usecs);
> +int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
> +                       audsettings *as, int def_usecs);
> +
> +static inline void *advance (void *p, int incr)
> +{
> +    uint8_t *d = p;
> +    return (d + incr);
> +}

Modulo checkpatch.pl errors,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


