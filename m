Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06016C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLCv-00046n-7B; Wed, 29 May 2024 11:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLCt-000447-Th
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:27:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLCr-00037Y-S6
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:27:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42121d27861so11180525e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716996432; x=1717601232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KL6/48lMKMyM88/740NKIvrmdIpcIj8sipweUnjEcM4=;
 b=zlYE8X2gFU0/gyolTaHqskdcW2xcd5N01+8QkDPXNYM6m3gr/5mYYvf/haEg+MHlEW
 FzpAzZURgKzLLtrha0QtkEf4+fJe+dJHqad1zFdQ2OY9ymVP46JM3HugU0Mtao0xAjdo
 qhubNEgrs3zf80XkAaxOKmBdW5VCN+dshSWCV9hV6/3EInrpbEdQjelUc7RBXAoZAmkq
 dSgPDgjOf0jeA2nREecAQ5dGA9JG5Wnqmm+/ekhXdYnvhWnBqPM9koCVzT8zbDg1oqe6
 usFoaMoE3fc0Guf5BVkNJDWMmr4Xdppp3bkJr75yMx+ZVNucMGU/egpuWKd3lHsj08uM
 4OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716996432; x=1717601232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KL6/48lMKMyM88/740NKIvrmdIpcIj8sipweUnjEcM4=;
 b=oPG6GYl4k434zLwNtLpYQU6C/KkaEfioZmzEGdKxEedXO6IH1brl369+sdVo5I7UwI
 MPr1iJK6kMDskskKxwyHWvLwlZtrpaD6Vp6ox1koFZV9F45mlhQc7Z7E5nt0D/tTGHe0
 9wQZF+qXNQ/sEc+Xwa6yE/ikJpfT19ick3Hl4REyu8eCiuwkbQlUB8R5svyimEQM9vkS
 M1CZXIANVDMiytltG99NYfLqynxiMqAHBUFrKnTrimctEUHVLUJX7ktcV7f9tEXF5Ezb
 Gc7OO78a0yOR1PKIIyD6ilrDtD3F9m1DYaGHxmUj1U38DuE2bw4HYe4E/lYvPVlaYmQv
 xJow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCdEm/evHHQaOtmJ0tisC4Hv4xzKmRYF9q1CZa5ceV+yX9OqWI8TAbzAaIxN9bXC5+0qbpOn+BESxketMYpyPgaD8iNtk=
X-Gm-Message-State: AOJu0Yyg/sOB2PJV4seI9oFMgwX8NaCeC/QWCyfmQTuKR8dsuFn41ZD7
 xgKmMAWljaLGoVx1PljPshJIzCTThTNItAOz3scHMiX+POO19VneEnZwHx7VpQg=
X-Google-Smtp-Source: AGHT+IHdBCyTGwAufLUD7w+2KDKF7+36MUndKRTBPCZUQftC/O5k+6hcyw+yk6FRLyfGqaMUnDGxog==
X-Received: by 2002:a05:600c:3ba1:b0:41b:e4dd:e320 with SMTP id
 5b1f17b1804b1-42108a1fa58mr120408935e9.26.1716996431812; 
 Wed, 29 May 2024 08:27:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089708edsm183819665e9.16.2024.05.29.08.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 08:27:11 -0700 (PDT)
Message-ID: <a585832f-87ff-4416-be3c-9f5513e99876@linaro.org>
Date: Wed, 29 May 2024 17:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: Markus Armbruster <armbru@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240528072242.493056-1-d-tatianin@yandex-team.ru>
 <87mso8n7tw.fsf@pond.sub.org>
 <9a4ae973-5ad0-4dd1-9818-489833352936@linaro.org>
 <c8ef6f8f-411d-4f25-bfec-d9f2dfa4b55d@yandex-team.ru>
 <079a43b9-52db-4428-9ae4-52a31fbf5e74@linaro.org>
 <bbe49906-26b5-4443-9be1-c621a76c53d8@yandex-team.ru>
 <874jaglm9x.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <874jaglm9x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/5/24 16:34, Markus Armbruster wrote:
> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
> 
>> On 5/29/24 4:39 PM, Philippe Mathieu-Daudé wrote:
>>
>>> On 29/5/24 14:43, Daniil Tatianin wrote:
>>>> On 5/29/24 3:36 PM, Philippe Mathieu-Daudé wrote:
>>>>
>>>>> On 29/5/24 14:03, Markus Armbruster wrote:
>>>>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>>>>
>>>>>>> This can be used to force-synchronize the time in guest after a long
>>>>>>> stop-cont pause, which can be useful for serverless-type workload.
>>>>>>>
>>>>>>> Also add a comment to highlight the fact that this (and one other QMP
>>>>>>> command) only works for the MC146818 RTC controller.
>>>>>>>
>>>>>>> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes since v0:
>>>>>>> - Rename to rtc-inject-irq to match other similar API
>>>>>>> - Add a comment to highlight that this only works for the I386 RTC
>>>>>>>
>>>>>>> Changes since v1:
>>>>>>> - Added a description below the QMP command to explain how it can be
>>>>>>>     used and what it does.
>>>>>>>
>>>>>>> Changes since v2:
>>>>>>> - Add a 'broadcast' suffix.
>>>>>>> - Change the comments to explain the flags we're setting.
>>>>>>> - Change the command description to fix styling & explain that it's a broadcast command.
>>>>>>>
>>>>>>> Changes since v3:
>>>>>>> - Fix checkpatch complaints about usage of C99 comments
>>>>>>>
>>>>>>> ---
>>>>>>>    hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>>>>>>    include/hw/rtc/mc146818rtc.h |  1 +
>>>>>>>    qapi/misc-target.json        | 19 +++++++++++++++++++
>>>>>>>    3 files changed, 40 insertions(+)
>>>
>>>
>>>>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>>>>> index 4e0a6492a9..7d388a3753 100644
>>>>>>> --- a/qapi/misc-target.json
>>>>>>> +++ b/qapi/misc-target.json
>>>>>>> @@ -19,6 +19,25 @@
>>>>>>>    { 'command': 'rtc-reset-reinjection',
>>>>>>>      'if': 'TARGET_I386' }
>>>>>>>    +##
>>>>>>> +# @rtc-inject-irq-broadcast:
>>>>>>> +#
>>>>>>> +# Inject an RTC interrupt for all existing RTCs on the system.
>>>>>>> +# The interrupt forces the guest to synchronize the time with RTC.
>>>>>>> +# This is useful after a long stop-cont pause, which is common for
>>>>>>> +# serverless-type workload.
>>>>>
>>>>> In previous version you said:
>>>>>
>>>>>    > This isn't really related to migration though. Serverless is based
>>>>>    > on constantly stopping and resuming the VM on e.g. every HTTP
>>>>>    > request to an endpoint.
>>>>>
>>>>> Which made some sense. Maybe mention HTTP? And point to that use case
>>>>> (possibly with QMP commands) in the commit description?
>>>>
>>>> Hmm, maybe it would be helpful for people who don't know what serverless means.
>>>>
>>>> How about:
>>>>       This is useful after a long stop-const pause, which is common for serverless-type workloads,
>>>>       e.g. stopping/resuming the VM on every HTTP request to an endpoint, which might involve
>>>>       a long pause in between the requests, causing time drift in the guest.
>>>
>>> Please help me understand your workflow. Your management layer call
>>> @stop and @cont QMP commands, is that right?
>>
>> Yes, that is correct.
>>
>>> @cont will emit a @RESUME event.
>>>
>>> If we could listen to QAPI events from C code, we could have the
>>> mc146818rtc device automatically sync on VM resume, and no need for
>>> this async command.
>>
>> Perhaps? I'm not sure how that would be implemented, but let's see what Markus has to say.
> 
> You can't listen on an event in QEMU itself.  You can only hook into the
> place that generates the event.

Apparently "qemu/notify.h" could be use for QAPI events (currently
only used by migration). Big change, to be discussed later.

> The RESUME event is sent from vm_prepare_start() in system/cpus.c.

Good spot, it is where we call synchronize_pre_resume() for vCPUs,
which is exactly what Daniil wants for RTC devices.

I'd rather we call here rtc_synchronize_pre_resume(), which would
mostly be qmp_rtc_inject_irq_broadcast() content, without using QMP
at all.

But for back-compat we need some CLI option "sync-rtc-on-resume"
default to false. Preferably a mc146818rtc property to KISS.

That would solve Daniil problem and make Markus/myself happier.

Paolo, any objection?

Regards,

Phil.

