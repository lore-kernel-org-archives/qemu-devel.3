Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEDAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LpO-0008Do-2r; Fri, 26 Apr 2024 09:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0LpJ-00088y-3g
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:41:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0Lp3-0008OK-Sb
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:41:19 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a559b919303so281626666b.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714138862; x=1714743662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9d1v76W9YlKbYNjbplkeshWLMVq0Czwi1rWFOBXIq3U=;
 b=rTX+tsUTPmB40pqbkt3tWUsgtZBPz7hJ9g/IblkwS5Jyl3UHEVDLej7n+RF7H4Sa/3
 7w/yBBpRbEvzYZBcmW0qqRnMJX59x1fRrC8m1wxDsPpYvSFwQH54l59J6fIrNMsIpM6n
 b+PQOAebZb7kyxRA+QH3Dm0G/ldDrNf9AnTm733mkLSuG+kMZXrbeLB3zaFcvRWOUQgx
 IP3UsKvaOHXLR6KG/VzIgGCAvk9kgwTd6c2jA/IfzrMfr6cFLakZt9Af0Nh/y2/fFp00
 ulEKI9grHlCJdoaWn6A9QjgQh09IvOfvYfPaMr/gr0ZaK0vGi+mDfBxK4ii+AOMdww86
 Kssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714138862; x=1714743662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9d1v76W9YlKbYNjbplkeshWLMVq0Czwi1rWFOBXIq3U=;
 b=j5Wr5V3mzv2Qy71NKliLc7pNtHpZ57l5GxI4U/DRTQrA2yUKDz3o59GTioBogjxvXj
 F4j5h+4dvg9SNNPicAcn3xSKO/n34+ryA3pCelvDh1XrV+MDwkQpjxaKnC4WLcj8Zcqo
 lQ8/Z0Cwmq71Mv8hejXvSZvlVf06jR9St6Cvjqt8DUuaJBq2WoHWZMwWbTiijMsn8NqG
 i7mVDB286gjwidIR/xeHGqBJ3YzOvu5Rx0DscgJOk3AT0FytGVFG/5VTsD9KvOGeqqLe
 F0Or6mfE15EmVewfx5uvnGAuOhAL7gqslYk3iylV58MkAqxvGOwBhS7+GGeA4k0cVfv0
 4wVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMigmsT5bgVWR8titv+JmOMn/6kHfz6J8bUUpcmiEKn6SDE8IZwBNfMf1a62pFM/fvJsvcJvbN8DYif0vYXIHr3kgyfIM=
X-Gm-Message-State: AOJu0YwoRjDuycaJkTeU/mPP3DLsfedDd437SeNiOqwQyhqrJeERffsX
 t5TiE7FA0yYdWoZmDqTCzdMyafW3k9x9+qiftFQF5hfkZrK/sIja4XyVL7YyNM8=
X-Google-Smtp-Source: AGHT+IHCd4fMBLOnD9NdP71knPxoAFHd/OSl+1gP1QNc5AUEfkQ+Lxoa2Uo4NsJY8iReEXNz02vv1w==
X-Received: by 2002:a17:906:34c3:b0:a58:d7d8:2f4d with SMTP id
 h3-20020a17090634c300b00a58d7d82f4dmr986007ejb.61.1714138862016; 
 Fri, 26 Apr 2024 06:41:02 -0700 (PDT)
Received: from [192.168.69.100] (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 m12-20020a1709062b8c00b00a58d438ed2esm519056ejg.139.2024.04.26.06.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 06:41:01 -0700 (PDT)
Message-ID: <fa4a0f09-a5f1-481a-8f2b-20a4df1eff59@linaro.org>
Date: Fri, 26 Apr 2024 15:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/watchdog/sbsa_gwdt: Make watchdog timer
 frequency a QOM property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240426122913.3427983-1-peter.maydell@linaro.org>
 <20240426122913.3427983-4-peter.maydell@linaro.org>
 <36b9a714-44ff-4b60-a23d-89672a98f46e@linaro.org>
 <CAFEAcA-ajhEXq4wJW-qp_scL0JqfJXCzZNvtmHtQEJLcRhj7-A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-ajhEXq4wJW-qp_scL0JqfJXCzZNvtmHtQEJLcRhj7-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 26/4/24 15:28, Peter Maydell wrote:
> On Fri, 26 Apr 2024 at 13:46, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 26/4/24 14:29, Peter Maydell wrote:
>>> Currently the sbsa_gdwt watchdog device hardcodes its frequency at
>>> 62.5MHz. In real hardware, this watchdog is supposed to be driven
>>> from the system counter, which also drives the CPU generic timers.
>>> Newer CPU types (in particular from Armv8.6) should have a CPU
>>> generic timer frequency of 1GHz, so we can't leave the watchdog
>>> on the old QEMU default of 62.5GHz.
>>>
>>> Make the frequency a QOM property so it can be set by the board,
>>> and have our only board that uses this device set that frequency
>>> to the same value it sets the CPU frequency.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    include/hw/watchdog/sbsa_gwdt.h |  3 +--
>>>    hw/arm/sbsa-ref.c               |  1 +
>>>    hw/watchdog/sbsa_gwdt.c         | 15 ++++++++++++++-
>>>    3 files changed, 16 insertions(+), 3 deletions(-)
>>
>>
>>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
>>> index 36f6f717b4b..57c337fd92a 100644
>>> --- a/hw/arm/sbsa-ref.c
>>> +++ b/hw/arm/sbsa-ref.c
>>> @@ -543,6 +543,7 @@ static void create_wdt(const SBSAMachineState *sms)
>>>        SysBusDevice *s = SYS_BUS_DEVICE(dev);
>>>        int irq = sbsa_ref_irqmap[SBSA_GWDT_WS0];
>>>
>>> +    qdev_prop_set_uint64(dev, "clock-frequency", SBSA_GTIMER_HZ);
>>
>> Since we have access to the CPU and its generic timer, what about
>> just keep the wdg in sync, as smth like:
>>
>>     qdev_prop_set_uint64(dev, "clock-frequency",
>>                          object_property_get_uint(OBJECT(some_cpu),
>>                                                   "cntfrq", errp));
> 
> That introduces an implicit ordering requirement that
> the CPU has been created before the watchdog, which I'm
> not super enthusiastic about. "The platform knows the
> frequency and sets it on the devices that care" seems
> more straightforward to me.
> 
> (The really-follow-the-hardware approach here would be to
> model the memory mapped system counter and then wire that
> up to both the CPUs and the watchdog, but that's a lot
> of extra work. I have some half-baked patches in that
> direction but for the moment I figure doing the simple
> thing is all we need.)

Yeah, since the clock is fixed, the current patch is
good enough.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


