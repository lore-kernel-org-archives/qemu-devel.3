Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19DFC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryucC-0004vU-Eh; Mon, 22 Apr 2024 10:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryucA-0004v5-3Z
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:25:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryuc8-00083Y-BD
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:25:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41a7c7abed9so4751115e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713795946; x=1714400746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AuuKh8ZqzmYU0JMHHI7qsaQ/p6Y/iS94Rd3p5AEdLgw=;
 b=NdhYhTJSNSXuXs55vySXyUb2MTcKk062fSkz9xiyrkRP3HXvam/c65L7LxmgmKirjM
 zynqCQanWJ5UIktj46sgz9hzUQnDvX95HvGc/K04u3Nfmkg2y0sdwnZuUAd6AikU2I2Y
 96A91yMwspklK92u8jHag1q8ydmmel+JAp87kj7+dZdoJUc2CzWSg5zKyXc+1RzbGYbB
 YPq/a8TDevVuZFWVoRPWKrmlLbozK6dUVlpAt9kJRNJpAalMwc/TcLcMdGt/FLvZ1A+0
 mm16iocoyuO3HQGYBhvkwyKvpU9xzt1gT86udX5HP1FJqmQLQnrs1t80Js4/MQN8n/e1
 7cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713795946; x=1714400746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AuuKh8ZqzmYU0JMHHI7qsaQ/p6Y/iS94Rd3p5AEdLgw=;
 b=AF9D9ezMnASGQff5djWA1SpeRgevHWEazdQJiSqUNvTHJan/NkRHC8/LsMnkqYszh2
 uAgaNj7J8sNQT+96wSuFmLsxo7jSZVH56A8BIaWKC5zyYeJqaWioT1ttKZ/tBxTi2L4L
 Rb2N8JS7Nk0QlRZtqW4qwC3Z7aPmlb3c5UZLs3ffP9dDsLssF+2BU7KF/JIH6LBuPXHC
 MUM04dUWHxpWPzi1qeSYpS0IxNcP4k7TOnSN3qP7gSJqnWhHP5bMcrINNCzKP93RXsJF
 kdhgQcY6taLEoZrrM2E64p2vs8bUU/Mt2Qk7FokPQ+RKCxzXAhHxs8Mc2XbQcShdpd2C
 C3JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtDt41kQe4/zMZYEx3FvaxacgfziE4LAi0vXjxN+EnprsKZI0XCwo4bz0ElKhIXKH2vtGmG9A6Hvuk70jlx5ZMz1jt01I=
X-Gm-Message-State: AOJu0Yz3gokxGjJBGdGrKU2oVyUm7637Y39t3jV+z8sycQTbhDvf5Ox2
 mQgyQZ6CFEBchTxAazTb8LeXWCxmXj1nKkjJZz2CVvlELQkVF2rzhqC1IPpNpY8=
X-Google-Smtp-Source: AGHT+IFd6bSZyPI/iHXbYHYwu0TISpP/276GZQYCzJCjnBirw++16ezuOmbbNjdF6qZnIvZKBBiQjA==
X-Received: by 2002:a05:600c:b9a:b0:41a:968a:b2d2 with SMTP id
 fl26-20020a05600c0b9a00b0041a968ab2d2mr574842wmb.4.1713795945610; 
 Mon, 22 Apr 2024 07:25:45 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 j13-20020a05600c190d00b00418a386c17bsm20640278wmq.12.2024.04.22.07.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 07:25:45 -0700 (PDT)
Message-ID: <72a31129-616f-457d-823e-78a93d3e4b45@linaro.org>
Date: Mon, 22 Apr 2024 16:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-stable@nongnu.org
References: <20240422131355.2264-1-philmd@linaro.org>
 <ccjrh.pmmuyk4rntp2@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ccjrh.pmmuyk4rntp2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/4/24 15:45, Manos Pitsidianakis wrote:
> On Mon, 22 Apr 2024 16:13, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> Since VirtIO devices can change endianness at runtime,
>> we need to use the device endianness, not the target
>> one.
> 
> Hey Philippe, can you clarify what do you mean by they can change 
> endianness at runtime?
> 
> The target's one is used because that's the one it will be using to do 
> I/O with its kernel's audio interface.

See for example in SysemuCPUOps:

     /**
      * @virtio_is_big_endian: Callback to return %true if a CPU which
      * supports runtime configurable endianness is currently big-endian.
      * Non-configurable CPUs can use the default implementation of this
      * method.
      * This method should not be used by any callers other than the
      * pre-1.0 virtio devices.
      */
     bool (*virtio_is_big_endian)(CPUState *cpu);

and:

/**
  * cpu_virtio_is_big_endian:
  * @cpu: CPU

  * Returns %true if a CPU which supports runtime configurable endianness
  * is currently big-endian.
  */
bool cpu_virtio_is_big_endian(CPUState *cpu);

 From commit 616a655219 ("virtio: add endian-ambivalent support to 
VirtIODevice"):

     Some CPU families can dynamically change their endianness. This
     means we can have little endian ppc or big endian arm guests for
     example. This has an impact on legacy virtio data structures since
     they are target endian.
     We hence introduce a new property to track the endianness of each
     virtio device. It is reasonnably assumed that endianness won't
     change while the device is in use : we hence capture the device
     endianness when it gets reset.

> 
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/audio/virtio-snd.c | 8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>> index c80b58bf5d..82c5647660 100644
>> --- a/hw/audio/virtio-snd.c
>> +++ b/hw/audio/virtio-snd.c
>> @@ -395,13 +395,15 @@ static uint32_t 
>> virtio_snd_get_qemu_freq(uint32_t rate)
>>  * Get QEMU Audiosystem compatible audsettings from virtio based pcm 
>> stream
>>  * params.
>>  */
>> -static void virtio_snd_get_qemu_audsettings(audsettings *as,
>> +static void virtio_snd_get_qemu_audsettings(VirtIOSound *s, 
>> audsettings *as,
>>                                             virtio_snd_pcm_set_params 
>> *params)
>> {
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>> +
>>     as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
>>     as->fmt = virtio_snd_get_qemu_format(params->format);
>>     as->freq = virtio_snd_get_qemu_freq(params->rate);
>> -    as->endianness = target_words_bigendian() ? 1 : 0;
>> +    as->endianness = virtio_is_big_endian(vdev) ? 1 : 0;
>> }
>>
>> /*
>> @@ -464,7 +466,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound 
>> *s, uint32_t stream_id)
>>         s->pcm->streams[stream_id] = stream;
>>     }
>>
>> -    virtio_snd_get_qemu_audsettings(&as, params);
>> +    virtio_snd_get_qemu_audsettings(s, &as, params);
>>     stream->info.direction = stream_id < s->snd_conf.streams / 2 +
>>         (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : 
>> VIRTIO_SND_D_INPUT;
>>     stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>> -- 
>> 2.41.0
>>


