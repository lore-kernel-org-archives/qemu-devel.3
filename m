Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDDDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NVW-0003Fb-AW; Mon, 29 Apr 2024 05:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NVS-0003Au-E0
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:41:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NVO-0007ht-6T
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:41:06 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-343e46ec237so3616992f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714383660; x=1714988460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sGaIVQmz4eN/hEOxsrdqz1/waqWj6ugK3+JW2eF6zNw=;
 b=rH8NNps1YISe1TXAwtqo2/G7BFulUDl4io0UlG2gztdVwm7d3K3h7b4vmNz6J5i/1B
 rSjhHuZPieR7uQnG0i2r4VpmPW3Cmwz8y/cchMXaN0+WYqyDx5YHJlC0gLhdYE4Mw6IN
 q4ZeCi0XgIZ/5K8kalWTcppICR212J/bnCefoPwvnHbv+RAQqWxmZ5CV1HoyGsWHyzOR
 rqdClTIXTlwiEzwU8sJu8T9sIlaSWCvGeJPBAVsn+h6T2vUou20ukKc1LETSY/vxl28k
 QnQlARjgy/zUS5JSKEcD1LsdBzm24UmUHDU47Mc7Hj1/LCWEL1CZRKkz9ard+8B6tsD6
 gwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714383660; x=1714988460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sGaIVQmz4eN/hEOxsrdqz1/waqWj6ugK3+JW2eF6zNw=;
 b=t3vylwJWwQjydgow+NxBcC+KJzGDScgtfF3T4+RUypt8EpLvVRbga3qDgmywFNyRIo
 n/M650U+y/bboZFNTVrWW15uLzh+egufDAynkPLcqiTyilwf4zLonPdivhfTZnz+HMp6
 +zpSCKIP39bz0EVNSbr+swDBvVbPUDrSu/IeHrwFhoaLlkpRbrgFyp6tpQ9KwsuivsdK
 ydF2LqWWXlc/4mo5Xe9n5S8o7fhNeIj65PqueTHdi5p9XD1JEE2F+600dfffkQZUh0mk
 6w+/pVkgA6njLyzV/JBl6OpCkU/pIx7Dfx7ZL3yGLCiEOQA7lJAWPMJ5ugx5qnio+Q6U
 1ocA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwB0ShgcpcBVlb3Qt1JsXUF3m8u0jlYjJofkj6tBM9DkUYsxlLppVy+k9IMgtM7Uvto/wLSpg0az1UvF7bM/yOBuZDCkU=
X-Gm-Message-State: AOJu0YwmtcNDx0LhzMueMrDZjv3XlRQraZWhtrBRHvocbMypq3tZD0QF
 OLVYAiWfUP9h6jNFTgppBWcBUPT5nfFAg7ytBNgwCIvszbkdDv/Cm5csJse+Jkc=
X-Google-Smtp-Source: AGHT+IFEa+LPd4/mGwtDvc0QMSgajYjfDg8uIU1Y0kW5ngfAE37HFpJHXx3bfYrL1wYQcuRXLCzv7A==
X-Received: by 2002:a5d:4292:0:b0:34c:d17a:ab7c with SMTP id
 k18-20020a5d4292000000b0034cd17aab7cmr2553765wrq.29.1714383660498; 
 Mon, 29 Apr 2024 02:41:00 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a5d6b45000000b003472489d26fsm29056672wrw.19.2024.04.29.02.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 02:41:00 -0700 (PDT)
Message-ID: <b8429aa8-f5d5-4f6e-a817-e41cf090adc9@linaro.org>
Date: Mon, 29 Apr 2024 11:40:59 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4353bf37-af68-4e80-a8ff-1737603682de@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 29/4/24 11:34, Daniil Tatianin wrote:
> On 4/29/24 11:51 AM, Markus Armbruster wrote:
> 
>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>
>>> This can be used to force-synchronize the time in guest after a long
>>> stop-cont pause, which can be useful for serverless-type workload.
>>>
>>> Also add a comment to highlight the fact that this (and one other QMP
>>> command) only works for the MC146818 RTC controller.
>>>
>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>> ---
>>>
>>> Changes since v0:
>>> - Rename to rtc-inject-irq to match other similar API
>>> - Add a comment to highlight that this only works for the I386 RTC
>>>
>>> ---
>>>   hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>>   include/hw/rtc/mc146818rtc.h |  1 +
>>>   qapi/misc-target.json        | 16 ++++++++++++++++
>>>   3 files changed, 37 insertions(+)
>>>
>>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>> index f4c1869232..8501b55cbd 100644
>>> --- a/hw/rtc/mc146818rtc.c
>>> +++ b/hw/rtc/mc146818rtc.c
>>> @@ -107,6 +107,11 @@ static void 
>>> rtc_coalesced_timer_update(MC146818RtcState *s)
>>>   static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>>>       QLIST_HEAD_INITIALIZER(rtc_devices);
>>> +/*
>>> + * NOTE:
>>> + * The two QMP functions below are _only_ implemented for the MC146818.
>>> + * All other RTC devices ignore this.
>>> + */
>>>   void qmp_rtc_reset_reinjection(Error **errp)
>>>   {
>>>       MC146818RtcState *s;
>>> @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>>       }
>>>   }
>>> +void qmp_rtc_inject_irq(Error **errp)
>>> +{
>>> +    MC146818RtcState *s;
>>> +
>>> +    /*
>>> +     * See:
>>> +     * 
>>> https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
>>> +     */
>>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>>> +        qemu_irq_raise(s->irq);
>>> +    }
>>> +}
>>> +
>>>   static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>>>   {
>>>       kvm_reset_irq_delivered();
>>> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
>>> index 97cec0b3e8..6cd9761d80 100644
>>> --- a/include/hw/rtc/mc146818rtc.h
>>> +++ b/include/hw/rtc/mc146818rtc.h
>>> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, 
>>> int base_year,
>>>   void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int 
>>> val);
>>>   int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>>>   void qmp_rtc_reset_reinjection(Error **errp);
>>> +void qmp_rtc_inject_irq(Error **errp);
>>>   #endif /* HW_RTC_MC146818RTC_H */
>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>> index 4e0a6492a9..d84a5d07a2 100644
>>> --- a/qapi/misc-target.json
>>> +++ b/qapi/misc-target.json
>>> @@ -19,6 +19,22 @@
>>>   { 'command': 'rtc-reset-reinjection',
>>>     'if': 'TARGET_I386' }
>>> +##
>>> +# @rtc-inject-irq:
>>> +#
>>> +# Inject an RTC interrupt.
>> Your cover letter explains what this could be good for.  Would it make
>> sense to explain it here, too?
> 
> Sure, sounds useful. I'll add a description in the next version.

Please also see my comments on the previous patch:
https://lore.kernel.org/qemu-devel/11c78645-e87b-4a43-8191-a73540c364a9@linaro.org/


