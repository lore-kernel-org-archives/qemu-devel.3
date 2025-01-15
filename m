Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A44C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5W2-0007Y1-95; Wed, 15 Jan 2025 10:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY5W0-0007TF-Cq
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:41:08 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY5Vu-0001PZ-Ef
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:41:07 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21619108a6bso123227455ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736955661; x=1737560461;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IGCsK0Wy95/s+m0i13TniHSDn7gxQi1tP3Nwy+slUJo=;
 b=Trk1xQUH3qE+9qUAbpF1kG0BSa+mOXy92Zty5O3ZL2u62Pq+zQVORm9xwGaJ22X3N1
 +D+QkxdsoLaWfYUjCUV6mwVQwtuvoGyrxbQ9xwpkf/N+pe+Iey5+mvL7iMW7CKvBCvNE
 VDJ090HScyBVPMyLiFvdOL5uZG3zQZxOK8tWIddQzM/0nfHL1eQxpXpeAm7EOGNYZDIb
 qk0FkkMjMO1Rw65arSyGc4Q/mf7cG+8anTRoXVPBbMg7yUnA+H/4+Mr+qYFM3mpD5wB9
 Rg0LyDJT7BdtGTOqIOMZCYS9eM4yAPRdeR5OgFOaCtHGZEqkxazWzH/pb4EZnivoD7xY
 ZTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736955661; x=1737560461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IGCsK0Wy95/s+m0i13TniHSDn7gxQi1tP3Nwy+slUJo=;
 b=a9efWBtOTWoTlknW19E3e+7TnsoyUVvDXj5BRViG+1zj/ZIq8/raqEyjVzG0QGu6E7
 HTqfvgZyRIgC7BTmGP935x6/TynKOblEasvm+5Yjs8p7jfzrJAXnoZrYIh84SOW7R/nm
 WQxnbPmsBZIhMutCPwWujrApKQP0XLNku/rsqd32RzIG4UX0FPWhR1feIJ3MzAOKtdNB
 x/lp10TJGnNDQg1ppeHtn9RlrOuhOweqnrV1sCHS6BtG9QJPakmardbFaJ1xcpjhzTKM
 agQx0RUdy9bxi/Pnlyzt7VcsoJ4BE9AHdoRMbtBzO/yh6NROGwSLM2dHGHr/r6HixBjQ
 54XQ==
X-Gm-Message-State: AOJu0YxYCG14pM6gk5Fdq5n4gwSHS/gnQWTdRVg8zQ6nRwUuQZcAw0VE
 5v0dv2+/qTT1b5ou/MN7ygwNQd8kizsUiKrC17C0+AayPO2fXTt/RLdy5M+tWZqNKTvqQ69qY3W
 1W0I=
X-Gm-Gg: ASbGnct7L9ppmlHpiIpc7hIGVaQDog4Y99GKC0VV3k1XJIICGtHZoV+FTlhOAjGw+lP
 xr2Jmhp025W5DgOq4Qy7kvirxVI9YesH0qqfFBvxIXnCaXltl8uYh4A7hTqQm8TzQauwbosu2CB
 aT+cssA1deghF5sYVuNLWHS2CC69OLzFAx2XTyPwtYjfwuDy4GxVuSwdHJt1vA2RSfOPl48T1vu
 wlwkeaHJMEaBdkUNJUFUY0j+SLzyzNcHvh2n3JXoNTz4gIfBNZiumjFVaUlapNqsKe2LfG0ZDVu
 ZPLZKtCVmQPaok61IdfZNPlDjcrUcZExKdo=
X-Google-Smtp-Source: AGHT+IFssoLyub8F4WhCaYVNRebZSDe6O/XNF4YxcjH80hkugfIWhJsZVXtivNiuPhAfQQ/3+uxCYA==
X-Received: by 2002:a17:902:f54e:b0:215:8809:b3b7 with SMTP id
 d9443c01a7336-21a83f36de7mr416371205ad.7.1736955660914; 
 Wed, 15 Jan 2025 07:41:00 -0800 (PST)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10ddbesm84849185ad.2.2025.01.15.07.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 07:41:00 -0800 (PST)
Message-ID: <b51d5be0-400c-4e4f-b90e-36cae3b09d23@daynix.com>
Date: Thu, 16 Jan 2025 00:40:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] coreaudio: Initialize the buffer for device change
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, devel@daynix.com
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
 <20250115-coreaudio-v3-2-bdb6bcb5bf9f@daynix.com> <2563327.kqX6A2vZny@silver>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <2563327.kqX6A2vZny@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/16 0:31, Christian Schoenebeck wrote:
> On Wednesday, January 15, 2025 1:06:56 PM CET Akihiko Odaki wrote:
>> Reallocate buffers when the active device change as the required buffer
>> size may differ.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   audio/audio_int.h |  2 ++
>>   audio/audio.c     | 24 ++++++++++++++++++------
>>   audio/coreaudio.m |  1 +
>>   3 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>> index 2d079d00a259..9ba4a144d571 100644
>> --- a/audio/audio_int.h
>> +++ b/audio/audio_int.h
>> @@ -187,9 +187,11 @@ struct audio_pcm_ops {
>>       void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
>>   };
>>   
>> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
>>   void audio_generic_run_buffer_in(HWVoiceIn *hw);
>>   void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
>>   void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
>> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
>>   void audio_generic_run_buffer_out(HWVoiceOut *hw);
>>   size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
>>   void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
>> diff --git a/audio/audio.c b/audio/audio.c
>> index 87b4e9b6f2f3..17c6bbd0ae9e 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)
>>   #endif
>>   }
>>   
>> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
>> +{
>> +    g_free(hw->buf_emul);
>> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> +    hw->buf_emul = g_malloc(hw->size_emul);
>> +    hw->pos_emul = hw->pending_emul = 0;
>> +}
>> +
> 
> Better something like "reinit" in the name maybe?
> 
>>   void audio_generic_run_buffer_in(HWVoiceIn *hw)
>>   {
>>       if (unlikely(!hw->buf_emul)) {
>> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> -        hw->buf_emul = g_malloc(hw->size_emul);
>> -        hw->pos_emul = hw->pending_emul = 0;
>> +        audio_generic_initialize_buffer_in(hw);
>>       }
>>   
>>       while (hw->pending_emul < hw->size_emul) {
>> @@ -1446,6 +1452,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
>>       hw->pending_emul -= size;
>>   }
>>   
>> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw)
>> +{
>> +    g_free(hw->buf_emul);
>> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> +    hw->buf_emul = g_malloc(hw->size_emul);
>> +    hw->pos_emul = hw->pending_emul = 0;
>> +}
>> +
>>   size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
>>   {
>>       if (hw->buf_emul) {
>> @@ -1477,9 +1491,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
>>   void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
>>   {
>>       if (unlikely(!hw->buf_emul)) {
>> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> -        hw->buf_emul = g_malloc(hw->size_emul);
>> -        hw->pos_emul = hw->pending_emul = 0;
>> +        audio_generic_initialize_buffer_out(hw);
>>       }
>>   
>>       *size = MIN(hw->size_emul - hw->pending_emul,
>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>> index b9e1a952ed37..72a6df0f75ee 100644
>> --- a/audio/coreaudio.m
>> +++ b/audio/coreaudio.m
>> @@ -466,6 +466,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>       core->outputDeviceID = deviceID;
>>       core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
>>       core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
>> +    audio_generic_initialize_buffer_out(&core->hw);
>>       core->ioprocid = ioprocid;
> 
> I would have probably separated this change into a separate patch, as changes
> above were more or less just refactoring, whereas this one changes behaviour.

That makes sense. I will do so if I have to respin this series.

> 
> And like my comment in the previous patch, I wonder whether that call comes
> too late. Keep in mind there are e.g. audio devices where you can't change
> certain parameters. So not every error here is a fatal error.

A function called late, AudioDeviceCreateIOProcID() is essential to make 
the output device functional so any error which triggers an early return 
before that is fatal.

