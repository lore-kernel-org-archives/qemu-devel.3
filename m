Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2AAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Nap-0007Jn-Oe; Mon, 29 Apr 2024 05:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Nan-0007EW-UV
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:46:37 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Nal-0000Kh-VL
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:46:37 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e47843cc7so4143154a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714383993; x=1714988793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HEsVq/6SXESrBR1ikdvYoJJ3LLaRA3OzXHJS2zoCbzk=;
 b=vGl3YVfXKiWL4d4/9ytQFMmD0jE/frCmlNizK6P1XBNjlytsYmDMY8NCwCP3/ZlnJs
 3G+xu2RX39QwTYuyN3qWxoev9ciROhCsk5Z5Ngq2cwx7+YxhDaNqSjNoKENQBOmS0vYW
 U1xOoAxXpnD+9rP20sgjGUlHqCpUQYCeaQqIGnWzS/JJZamYF+p743M2yUgyEdd2mZ+e
 Ts3AqKw1XU6zREFFtS7Q1cZDKeVt0S3hZAqloCgurHlvFCQM3/mpIVBdZUJhp9YQW32o
 aMwsBMWNeNbFoym1UPi+FkBW2obMrFRGl9IDpe5c1uFcYtHnDOLdJzIOpMCD7HPxWH5c
 Sqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714383993; x=1714988793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEsVq/6SXESrBR1ikdvYoJJ3LLaRA3OzXHJS2zoCbzk=;
 b=HDFUbxcJlIJ0V4auYDXSs4ZnjcbsKrp1+TZHLErr0cmPsIMvyN6joNcG10zUzekTAF
 WXaVbcFu+5l5UZQSRZEbZANmnor9csbl21zqnm5KY7hvq2RBOvYu6+ST9rT77N+QFDjR
 e5TiiheKLK5Bgw2aNeMlRx6R4lEVaxZX0JrH7fIGVYgr/uJu7ztXas8dlP6C+ehaYn9U
 j+ceF1VDV9+metdwXk/7nNkJfOGeHt1VYBbbIfrahmTg/ub6E5UBTqDR0bmvWG62em4J
 CkyjZ31BrQx32eBRj1dxdWhYXgIOvWxEI5/To9Gx6H/LToGOlBcBNU6k7c79fUoLMGr4
 p1kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBftq4B6ju3cDX2+6GBGdrV+TSt+iXIUYP4wpSNzo1+k6DvojKZUV0h/ajfGcgmnXC4lJb8I+JqSOSk0nmIxWxgwYIGZs=
X-Gm-Message-State: AOJu0YwEuR2nD/uF/zBUSvnz9aowVPXE63qXEDEx9EyS/Hm7IIWXE1FG
 +ZAKax/YCO9q9535RSuZgvr0mHWjknSY8dg6kG5cS5pAptttU0ly97pe+SYwSb1k9yYZM0w9fxm
 04w4=
X-Google-Smtp-Source: AGHT+IFuYBnIo2KW+3s227OJSPTFpmKiMwIpIXGCyfwUWQfd/qved76eh8TPxqzCz/B1AirauA6sNg==
X-Received: by 2002:a50:cd15:0:b0:56d:c40d:b921 with SMTP id
 z21-20020a50cd15000000b0056dc40db921mr6338183edi.20.1714383993611; 
 Mon, 29 Apr 2024 02:46:33 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 et10-20020a056402378a00b005725ffd7305sm3024700edb.75.2024.04.29.02.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 02:46:33 -0700 (PDT)
Message-ID: <cf265505-0a8a-462c-8543-512062b908af@linaro.org>
Date: Mon, 29 Apr 2024 11:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240427075801.491673-1-d-tatianin@yandex-team.ru>
 <87v840mtzv.fsf@pond.sub.org>
 <4353bf37-af68-4e80-a8ff-1737603682de@yandex-team.ru>
 <b8429aa8-f5d5-4f6e-a817-e41cf090adc9@linaro.org>
 <d1568767-ee03-4fc4-a498-2143dd7b4fbe@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d1568767-ee03-4fc4-a498-2143dd7b4fbe@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 29/4/24 11:43, Daniil Tatianin wrote:
> On 4/29/24 12:40 PM, Philippe Mathieu-Daudé wrote:
> 
>> On 29/4/24 11:34, Daniil Tatianin wrote:
>>> On 4/29/24 11:51 AM, Markus Armbruster wrote:
>>>
>>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>>
>>>>> This can be used to force-synchronize the time in guest after a long
>>>>> stop-cont pause, which can be useful for serverless-type workload.
>>>>>
>>>>> Also add a comment to highlight the fact that this (and one other QMP
>>>>> command) only works for the MC146818 RTC controller.
>>>>>
>>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>>> ---
>>>>>
>>>>> Changes since v0:
>>>>> - Rename to rtc-inject-irq to match other similar API
>>>>> - Add a comment to highlight that this only works for the I386 RTC
>>>>>
>>>>> ---
>>>>>   hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>>>>   include/hw/rtc/mc146818rtc.h |  1 +
>>>>>   qapi/misc-target.json        | 16 ++++++++++++++++
>>>>>   3 files changed, 37 insertions(+)
>>>>>
>>>>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>>>> index f4c1869232..8501b55cbd 100644
>>>>> --- a/hw/rtc/mc146818rtc.c
>>>>> +++ b/hw/rtc/mc146818rtc.c
>>>>> @@ -107,6 +107,11 @@ static void 
>>>>> rtc_coalesced_timer_update(MC146818RtcState *s)
>>>>>   static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>>>>>       QLIST_HEAD_INITIALIZER(rtc_devices);
>>>>> +/*
>>>>> + * NOTE:
>>>>> + * The two QMP functions below are _only_ implemented for the 
>>>>> MC146818.
>>>>> + * All other RTC devices ignore this.
>>>>> + */
>>>>>   void qmp_rtc_reset_reinjection(Error **errp)
>>>>>   {
>>>>>       MC146818RtcState *s;
>>>>> @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>>>>       }
>>>>>   }
>>>>> +void qmp_rtc_inject_irq(Error **errp)
>>>>> +{
>>>>> +    MC146818RtcState *s;
>>>>> +
>>>>> +    /*
>>>>> +     * See:
>>>>> +     * 
>>>>> https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
>>>>> +     */
>>>>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>>>>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>>>>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>>>>> +        qemu_irq_raise(s->irq);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>   static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>>>>>   {
>>>>>       kvm_reset_irq_delivered();
>>>>> diff --git a/include/hw/rtc/mc146818rtc.h 
>>>>> b/include/hw/rtc/mc146818rtc.h
>>>>> index 97cec0b3e8..6cd9761d80 100644
>>>>> --- a/include/hw/rtc/mc146818rtc.h
>>>>> +++ b/include/hw/rtc/mc146818rtc.h
>>>>> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, 
>>>>> int base_year,
>>>>>   void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int 
>>>>> val);
>>>>>   int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>>>>   void qmp_rtc_reset_reinjection(Error **errp);
>>>>> +void qmp_rtc_inject_irq(Error **errp);
>>>>>   #endif /* HW_RTC_MC146818RTC_H */
>>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>>> index 4e0a6492a9..d84a5d07a2 100644
>>>>> --- a/qapi/misc-target.json
>>>>> +++ b/qapi/misc-target.json
>>>>> @@ -19,6 +19,22 @@
>>>>>   { 'command': 'rtc-reset-reinjection',
>>>>>     'if': 'TARGET_I386' }
>>>>> +##
>>>>> +# @rtc-inject-irq:
>>>>> +#
>>>>> +# Inject an RTC interrupt.
>>>> Your cover letter explains what this could be good for.  Would it make
>>>> sense to explain it here, too?
>>>
>>> Sure, sounds useful. I'll add a description in the next version.
>>
>> Please also see my comments on the previous patch:
>> https://lore.kernel.org/qemu-devel/11c78645-e87b-4a43-8191-a73540c364a9@linaro.org/
>>
> I think this makes sense, but there's already a similar command, which 
> doesn't do it. Should that one be changed as well then? Or do we only 
> change the interface for this one?

Better to not follow a short sighted interface. If you can, start
with a correct one. Help fixing broken interface is certainly
welcomed, but that shouldn't block adding your new command.

Regards,

Phil.

