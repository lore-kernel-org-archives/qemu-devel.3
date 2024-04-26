Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EB6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0IBn-0001gL-Kl; Fri, 26 Apr 2024 05:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0IBl-0001dE-NP
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:48:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0IBk-0005IS-1U
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:48:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41a0979b9aeso12903505e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714124894; x=1714729694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=730lI06Wpv6CawP2x/z5AmzOCpKWR+NYxzdLuEkncVA=;
 b=mSworYX7hD6zEqxoZd+K5EDr/E+2tp60+acJD/WsLAG6e2fo6qekyAoHBKqrKgVr2F
 RFHbJ2NDNA7NmATy78rCV4Mdxp0L+M8/gt1qdp9L18or5tfakN3KCrdWivCVZD1nYwnm
 MJfJAULb3HEN92jgImUf9dld70VuF3F3fvjnSSXqRUgVuKz05XIF8A0XjniMBjVWYhJ9
 22dfP6kd8HTZjM/JHc8Eso6SN4x+PWizP6jjCYtoJz0hTxcMOm/VzFf6zChTMlzYTlte
 iIFUf5mAN7OS4zrvoHgjfTkaluN3XRksuYg7CC4YLQynnpbxXgk5pE80Nkn/CrCIU86o
 zrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714124894; x=1714729694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=730lI06Wpv6CawP2x/z5AmzOCpKWR+NYxzdLuEkncVA=;
 b=H5N8D3FpFbzZIuOLq0utXxWMaX85BVrnd3c1XGf/WhkvCMmH7Pwf91Vh/1QkJRetXi
 OcOeDvcH5ch98rzG3KQj3Wamphb07vbkMvtQeiqwt6QdTwIUfKmfN9zuzPpgkTsDIKHL
 OMhYL8+tV21BFXYVHYa316swFdesU22mJu80m97L12wvW5k2aCE7AsEhy4+bjd7fwDJq
 oIBeSl7ZyxLIbRABOGgsomJ1qcahJdm26/Fr4gBhWjOjC2B2UbJhXT8GTbgJWudZLU/4
 h8jNvKBLzAE82K0KdjHD5TOlacOqFx4aF+Zd5IrcfVShhCBigYvUw/oEk6r3uPuu92HD
 Bd/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCWym59SG6vxmvBvx9JW1h3TvbKMhpaI5ZyHe7VmQlrtyt9CqXdEk6+RKP/CBAqBQ3IRChndHfaNfMubMpXDdRF7QmcVk=
X-Gm-Message-State: AOJu0YzAHI5OrH/Cq/QciUj4wCXh6SSL8bryX1fcZvTt1C44Squ0i4K/
 IlYmgOsq8N5ENu8QJMR3cZ8OMj2fnRpqOf1GtlnMzYO/GmGViU/XZAf37DFN888=
X-Google-Smtp-Source: AGHT+IGvmw69aU5xx44AUtPEcs/2ZKFQffas45rTKmg7XxtD8+k2UzPFUZSEmMpJ/DY5m9OOulw0Xw==
X-Received: by 2002:a05:600c:4450:b0:414:3713:e9a2 with SMTP id
 v16-20020a05600c445000b004143713e9a2mr1908947wmn.3.1714124894086; 
 Fri, 26 Apr 2024 02:48:14 -0700 (PDT)
Received: from [10.79.37.249] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c511400b0041a49b10a13sm18196130wms.11.2024.04.26.02.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 02:48:13 -0700 (PDT)
Message-ID: <11c78645-e87b-4a43-8191-a73540c364a9@linaro.org>
Date: Fri, 26 Apr 2024 11:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
To: Markus Armbruster <armbru@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
 <87v844y0ul.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87v844y0ul.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Daniil, Markus,

On 26/4/24 10:39, Markus Armbruster wrote:
> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
> 
>> This can be used to force-synchronize the time in guest after a long
>> stop-cont pause, which can be useful for serverless-type workload.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>   hw/rtc/mc146818rtc.c         | 15 +++++++++++++++
>>   include/hw/rtc/mc146818rtc.h |  1 +
>>   qapi/misc-target.json        | 16 ++++++++++++++++
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>> index f4c1869232..6980a78d5f 100644
>> --- a/hw/rtc/mc146818rtc.c
>> +++ b/hw/rtc/mc146818rtc.c
>> @@ -116,6 +116,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>       }
>>   }
>>   
>> +void qmp_rtc_notify(Error **errp)
>> +{
>> +    MC146818RtcState *s;
>> +
>> +    /*
>> +     * See:
>> +     * https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
>> +     */
>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>> +        qemu_irq_raise(s->irq);
>> +    }
>> +}
>> +
> 
> Note for later: qmp_rtc_notify() works on all realized mc146818rtc
> devices.  Other kinds of RTC devices are silently ignored.  Just like
> qmp_rtc_reset_reinjection().

IMO to avoid any future ambiguity (in heterogeneous machines), this
command must take a QOM device path (or a list of) and only notify
those.

Regards,

Phil.

