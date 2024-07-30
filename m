Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A49BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 07:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYgt9-0002N4-N2; Tue, 30 Jul 2024 03:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYgt3-0002L7-1e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 03:03:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYgt0-0006yY-VK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 03:03:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42812945633so24208685e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722322985; x=1722927785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5GFY/lfUyAuH5OvgunWn9+ug2c6lDtS9cdsH64QGOq8=;
 b=PTdHpdvtkmRRVHUH8QomnHhkBo0iYmiIXqwd1FVnLL6WbbQfgmCvQTQWa4weP7hRsv
 xASUfyNw3jZ0xPTDBYdCFHByjpnKcS9m3DqJyxUHG4pttkBvwm//qmkUwkcbSLDIcftK
 4/tVmlwF5jZ5sX32sGrHV9FYpkdt5/vV9yfw6BQAT8Rlu7qtGam6e0lI+uCCA8Ds9dtC
 EttAQEK+CCIluZoLrtFVr25EuWJD8OGqxcOObwJgiFORSj2rOlLT8Lt0UVXfPnFlqF+G
 uKAoxpmCLn+/soeGwSCszMskbFeTrn1d8VRbpPgZ6jXAgb5Xu6EQo2cY6URCXuaIOs5B
 QbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722322985; x=1722927785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5GFY/lfUyAuH5OvgunWn9+ug2c6lDtS9cdsH64QGOq8=;
 b=Ev9ed1ztqJ5uBfpbAj4mV7n97EETwv2o9OxuvyEnJW7kAdMokdsepHNo1z+AEGFCkK
 aSvwaJF5D4o/tGJZuj03of2n8QOxJ++KrH8l+THxArQ/NNOoQC9Br+Z/3G2B7zx1dfZq
 cqw7PncMBbVP4oKPJNbQfHgBZC7DcXdPRXbh7BfrXhbpbs3KAU9JuZCRFlgYLZZkMbQX
 3RnE4KCAIiHHp0JNNYav68kV9dfnM9+6vs7d2Ia37/6csgjSGJTGhgiH4Q2fEmJVmk5m
 MqnJGXnx0H+VoM08eaLXrN4q5gnPI/zJFAKIZOXi3g1qtYkcljdhDhIrYLIelYKFsFed
 V8qA==
X-Gm-Message-State: AOJu0YySubE8qHm93NVxpLlSH7foU6XKXXDZp3ArMAYqAQdzGEf8mnr+
 KDDFN7bpCk34YKyMOTUpCTVPOMpdAoulgrrkyqYkTGl+cWNKW3ZpJ4Kbzb5Pj/Q=
X-Google-Smtp-Source: AGHT+IG02DKw9h+FUUftsFXBwQBGIKTEoZPIUcPWFgBGkWkKCn5Ou2B50EwjwM0kFnfdokRMtppFIA==
X-Received: by 2002:a05:600c:154b:b0:428:1090:cfd4 with SMTP id
 5b1f17b1804b1-42811df08a0mr67088045e9.33.1722322984970; 
 Tue, 30 Jul 2024 00:03:04 -0700 (PDT)
Received: from [192.168.38.175] (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42809e4423dsm168545885e9.13.2024.07.30.00.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 00:03:04 -0700 (PDT)
Message-ID: <d5baccc9-183f-4ce8-9f1e-d7fae5d59870@linaro.org>
Date: Tue, 30 Jul 2024 09:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/misc/aspeed_hace: Fix SG Accumulative hashing
To: Alejandro Zeise <alejandro.zeise@seagate.com>, qemu-arm@nongnu.org,
 John Wang <wangzq.jn@gmail.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 berrange@redhat.com
References: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
 <20240729190035.3419649-3-alejandro.zeise@seagate.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240729190035.3419649-3-alejandro.zeise@seagate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Alejandro,

On 29/7/24 21:00, Alejandro Zeise wrote:
> Make the Aspeed HACE module use the new qcrypto accumulative hashing functions
> when in scatter-gather accumulative mode. A hash context will maintain a
> "running-hash" as each scatter-gather chunk is received.
> 
> Previously each scatter-gather "chunk" was cached
> so the hash could be computed once the final chunk was received.
> However, the cache was a shallow copy, so once the guest overwrote the
> memory provided to HACE the final hash would not be correct.
> 
> Possibly related to: https://gitlab.com/qemu-project/qemu/-/issues/1121

Likely, Cc'ing John.

Reported-by: John Wang <wangzq.jn@gmail.com>

> Buglink: https://github.com/openbmc/qemu/issues/36
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> ---
>   hw/misc/aspeed_hace.c         | 91 ++++++++++++++++++-----------------
>   include/hw/misc/aspeed_hace.h |  4 ++
>   2 files changed, 51 insertions(+), 44 deletions(-)


> @@ -252,20 +228,42 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,


> -    if (niov) {
> -        i = niov;
> -    }
> +    if (acc_mode) {
> +        if (s->qcrypto_hash_context == NULL &&
> +            qcrypto_hash_accumulate_new_ctx(algo, &s->qcrypto_hash_context, NULL)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: qcrypto failed to create hash context\n",
> +                          __func__);
> +            return;
> +        }

Using a instance_init() handler, ...

> @@ -397,6 +395,11 @@ static void aspeed_hace_reset(DeviceState *dev)
>   {
>       struct AspeedHACEState *s = ASPEED_HACE(dev);
>   
> +    if (s->qcrypto_hash_context != NULL) {
> +        qcrypto_hash_accumulate_free_ctx(s->qcrypto_hash_context, NULL);
> +        s->qcrypto_hash_context = NULL;
> +    }

... and instance_finalize() could simplify a bit.

Regards,

Phil.


