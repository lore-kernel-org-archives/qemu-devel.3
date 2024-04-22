Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E9DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 21:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz0sr-0008Ha-Po; Mon, 22 Apr 2024 17:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rz0sp-0008HF-J6
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:07:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rz0sn-00060w-8D
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 17:07:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41a442c9dcbso11904465e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713820043; x=1714424843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LdyRuckcY8QBtqo6UOvmVwQ+QV2dO1G+ugfuQnbVktw=;
 b=T3lK7dEdV0/2gAbMrcmjbRzb/9Q+eBW03S17V+1NW+KbaEma3ze7NgaZ6+il7mDrSC
 EQDZRj8WnJQb5lX3UYmUKZ4R2zeBLuTOQjgMAPqPTeeQm44PvU/tbO2zX3hHATOIZzei
 czZ6t7sPo4ZqhvYpVWXuDD3mchIpWCdU9eT1YJWL/lTLwadE941rJ99pV9FoemzFa0GF
 jrPZnATjSJb8Asc0YsBNlGwdpRGRrCrn1AQheY/iJBxkLN8V+Jxeh26q1G2fq7d3Umzw
 /gIjhfpgBUSO1Mh0Clq8dSZLisIH6eTvuB/dOrDxPhoAeR1alFz87/RGQ5truTbjeO8G
 0tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713820043; x=1714424843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LdyRuckcY8QBtqo6UOvmVwQ+QV2dO1G+ugfuQnbVktw=;
 b=MSujuyhAdpwJd7iIqj08bcBLpWz1kAtynaGkElKF+enl0d9ppCENOdXtUiliF84LRz
 sRH4i+g+iqDjnYGrfFE7Cdc3kuPw33SAtqxPDyNX8D/1syGRcoMNtBBP04fcks05tOnH
 b6Hs7FxhcU0PideJdSjbQLOHjt6ehyKrs7CDDSSDeR9gYPbYcK9WnYECi/UJAF2i85ot
 dxMoiQTuYsYpcP97h0i+BvgXAlFlM8o60Tq86vxH+fiSKBDlPMHPKDZDC1zpRDDLitNf
 6uftECq+wKqRmdim2eXivZ3FdDKOEzb+jWWL3FgXEa0AfK7+W0A1dQJdPemGd3pZiUsH
 MqTg==
X-Gm-Message-State: AOJu0Ywj6du5HTxJhMOF2bG1/1AxxVbxaSm43hgYU+K0e66JdnUo1ZN5
 oho1P+bb3W4GG1EtxO0ar8juq/f3pW6yJ5bKbEuXt0IEIc2toqFG7+UxL/WS9FU=
X-Google-Smtp-Source: AGHT+IEaC8QEEu1WrtVyjHEmDN2VOM9PrneOTFjRNDhHAMQp1RQBzodvRpHkviUDUSYecoKeuCm9YA==
X-Received: by 2002:a05:600c:3d8a:b0:41a:ab78:b06f with SMTP id
 bi10-20020a05600c3d8a00b0041aab78b06fmr337770wmb.9.1713820042998; 
 Mon, 22 Apr 2024 14:07:22 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 a6-20020a05600c348600b0041aa7defa79sm693219wmq.30.2024.04.22.14.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 14:07:22 -0700 (PDT)
Message-ID: <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
Date: Mon, 22 Apr 2024 23:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-stable@nongnu.org
References: <20240422142056.3023-1-philmd@linaro.org>
 <20240422170056-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422170056-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 22/4/24 23:02, Michael S. Tsirkin wrote:
> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daudé wrote:
>> Since VirtIO devices can change endianness at runtime,
>> we need to use the device endianness, not the target
>> one.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 
> 
> This is all completely bogus. Virtio SND is from Virtio 1.0 only.
> It is unconditionally little endian.

Oh, then the fix is as simple as:

  -    as->endianness = target_words_bigendian() ? 1 : 0;
  +    as->endianness = 0; /* VIRTIO 1.0: always LE. */

> If it's not it's a guest bug pls just fix it there.
> 
> 
>> ---
>> v2: Use virtio_is_big_endian()
>> v3: Remove "hw/core/cpu.h
>> ---
>>   hw/audio/virtio-snd.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>> index c80b58bf5d..939cd78026 100644
>> --- a/hw/audio/virtio-snd.c
>> +++ b/hw/audio/virtio-snd.c
>> @@ -24,7 +24,6 @@
>>   #include "trace.h"
>>   #include "qapi/error.h"
>>   #include "hw/audio/virtio-snd.h"
>> -#include "hw/core/cpu.h"
>>   
>>   #define VIRTIO_SOUND_VM_VERSION 1
>>   #define VIRTIO_SOUND_JACK_DEFAULT 0
>> @@ -395,13 +394,15 @@ static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
>>    * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
>>    * params.
>>    */
>> -static void virtio_snd_get_qemu_audsettings(audsettings *as,
>> +static void virtio_snd_get_qemu_audsettings(VirtIOSound *s, audsettings *as,
>>                                               virtio_snd_pcm_set_params *params)
>>   {
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>> +
>>       as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
>>       as->fmt = virtio_snd_get_qemu_format(params->format);
>>       as->freq = virtio_snd_get_qemu_freq(params->rate);
>> -    as->endianness = target_words_bigendian() ? 1 : 0;
>> +    as->endianness = virtio_is_big_endian(vdev) ? 1 : 0;
>>   }
>>   
>>   /*
>> @@ -464,7 +465,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>>           s->pcm->streams[stream_id] = stream;
>>       }
>>   
>> -    virtio_snd_get_qemu_audsettings(&as, params);
>> +    virtio_snd_get_qemu_audsettings(s, &as, params);
>>       stream->info.direction = stream_id < s->snd_conf.streams / 2 +
>>           (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
>>       stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>> -- 
>> 2.41.0
> 


